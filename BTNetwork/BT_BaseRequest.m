//
//  BT_BaseRequest.m
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import "BT_BaseRequest.h"
#import "BT_RequestManager.h"

@interface BT_BaseRequest ()
@property (nonatomic, copy) BTResponseCompletionBlock completed;
@end
@implementation BT_BaseRequest
+ (instancetype)requestWithUrl:(NSString *)url {
    return [self requestWithUrl:url requestType:BTRequestGET];
}
+ (instancetype)requestWithUrl:(NSString *)url requestType:(BTRequestType)requestType {
    BT_BaseRequest *request = [[[self class] alloc] init];
    request.url = url;
    request.requestType = requestType;
    return request;
}

- (void)sendWithCompleted:(BTResponseCompletionBlock)completed {
    _completed = completed;
    
    if (_requestType == BTRequestGET) {
        [BT_RequestManager GET:_url parameters:_parameters success:^(BTSessionTask *task, id responseObject) {
            [self handleTask:task responseObject:responseObject error:nil];
        } fail:^(BTSessionTask *task, NSError *error) {
            [self handleTask:task responseObject:nil error:error];
        }];
    } else if (_requestType == BTRequestPOST) {
        [BT_RequestManager POST:_url parameters:_parameters success:^(BTSessionTask *task, id responseObject) {
            [self handleTask:task responseObject:responseObject error:nil];
        } fail:^(BTSessionTask *task, NSError *error) {
            [self handleTask:task responseObject:nil error:error];
        }];
    } else if (_requestType == BTRequestMultipartPOST) {
        [BT_RequestManager POST:_url parameters:_parameters bodyFormData:_formData success:^(BTSessionTask *task, id responseObject) {
            [self handleTask:task responseObject:responseObject error:nil];
        } fail:^(BTSessionTask *task, NSError *error) {
            [self handleTask:task responseObject:nil error:error];
        }];
    }
    
}

#pragma mark - 解析数据
- (void)handleTask:(BTSessionTask *)task responseObject:(id)responseObject error:(NSError *)error  {
    
    /** 响应状态吗 */
    NSInteger statusCode = [(NSHTTPURLResponse *)task.response statusCode];
    /** 响应数据 */
    id responseData = nil;
    /** 响应String */
    id responseString = nil;
    /** 响应JSON */
    id responseJSON = nil;
    if (responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseData = responseObject;
        } else {
            responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        }
        if (responseData) {
            responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        }
        if (responseData) {
            responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        }
    }
    
    BT_BaseResponse *response = [[BT_BaseResponse alloc] initWithStatusCode:statusCode responseData:responseData responseString:responseString responseJSON:responseJSON error:error];
    _response = response;
    
    if (self.completed) {
        self.completed(response);
    }
    self.completed = nil;
    
}

- (void)cancel {
    [BT_RequestManager cancelTaskWithUrl:self.url];
}
@end
