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
//@property (nonatomic, copy) BTResponseCompletionBlock completed;
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

- (void)sendWithCompletion:(void (^)(BT_BaseResponse *))completion {

    if (_requestType == BTRequestGET) {
        [BT_RequestManager GET:_url parameters:_parameters completion:^(BT_BaseResponse *response) {
            _response = response;
            if (completion) {
                completion(response);
            }
        }];
    } else if (_requestType == BTRequestPOST) {
        [BT_RequestManager POST:_url parameters:_parameters completion:^(BT_BaseResponse *response) {
            _response = response;
            if (completion) {
                completion(response);
            }
        }];
    }
}

- (void)cancel {
    [BT_RequestManager cancelTaskWithUrl:self.url];
}
@end
