//
//  BT_RequestManager.m
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import "BT_RequestManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#import "BT_BaseResponse.h"

static NSString *_HostUrl = nil;


@interface AFHTTPSessionManager (Share)
+ (instancetype)shareInstance;
@end

@implementation AFHTTPSessionManager (Share)

+ (instancetype)shareInstance {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:_HostUrl]];
        
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //#warning 有可能会不起作用
        manager.requestSerializer.timeoutInterval = 30.0;
        
        manager.operationQueue.maxConcurrentOperationCount = 4;
        
        // 设置支持接收类型
        NSSet *contentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"]];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
        
    });
    return manager;
}

@end

@implementation BT_RequestManager

+ (void)setHostUrl:(NSString *)hostUrl {
    _HostUrl = hostUrl;
}
#pragma mark -
+ (BTSessionTask *)GET:(NSString *)URLString parameters:(id)parameters completion:(BT_ResponseCompletionBlock)completion {
    return [self requestWithUrl:URLString parameters:parameters method:1 completion:completion];
}
+ (BTSessionTask *)POST:(NSString *)URLString parameters:(id)parameters completion:(BT_ResponseCompletionBlock)completion {
    return [self requestWithUrl:URLString parameters:parameters method:2 completion:completion];
}
+ (BTSessionTask *)requestWithUrl:(NSString *)URLString parameters:(id)parameters method:(NSInteger)method completion:(BT_ResponseCompletionBlock)completion {
    
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareInstance];
    BTSessionTask *sessionTask = nil;
    if (method == 1) {
        sessionTask = [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleTask:task responseObject:responseObject error:nil completion:completion];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleTask:task responseObject:nil error:error completion:completion];
        }];
    } else if (method == 2) {
        sessionTask = [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleTask:task responseObject:responseObject error:nil completion:completion];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleTask:task responseObject:nil error:error completion:completion];
        }];
    }
    
    return sessionTask;
    
}
+ (BTSessionTask *)UPLOAD:(NSString *)URLString parameters:(id)parameters formData:(id<BT_MultipartFormData>)formData progress:(void (^)(NSProgress *))uploadProgress completion:(BT_ResponseCompletionBlock)completion {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareInstance];
    BTSessionTask *sessionTask = nil;
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull afFormData) {
        if (formData && [formData conformsToProtocol:@protocol(BT_MultipartFormData)]) {        
            [afFormData appendPartWithFileData:formData.fileData name:formData.name fileName:formData.fileName mimeType:formData.mimeType];
        }
    } progress:^(NSProgress * _Nonnull progress) {
        if (uploadProgress) {
            uploadProgress(progress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleTask:task responseObject:responseObject error:nil completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleTask:task responseObject:nil error:error completion:completion];
    }];
    return sessionTask;
}

#pragma mark - 解析数据
+ (void)handleTask:(BTSessionTask *)task responseObject:(id)responseObject error:(NSError *)error completion:(BT_ResponseCompletionBlock)completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BT_BaseResponse *response = [self responseWithTask:task responseObject:responseObject error:error];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion(response);
            }
        });
    });
    
}
+ (BT_BaseResponse *)responseWithTask:(BTSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
    BT_BaseResponse *response = [BT_BaseResponse new];
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        response.statusCode = httpResponse.statusCode;
        
        response.headers = [httpResponse.allHeaderFields mutableCopy];
    }
    
    if (responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            response.responseData = responseObject;
        } else {
            response.responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        }
        
        if (response.responseData) {
            response.responseString = [[NSString alloc] initWithData:response.responseData encoding:NSUTF8StringEncoding];
            response.responseJSON = [NSJSONSerialization JSONObjectWithData:response.responseData options:0 error:nil];
        }
        
    }
    
    if (error) {
        response.error = error;
    }
    return response;
}
#pragma mark -

+ (void)cancelTaskWithUrl:(NSString *)url {
    if (url == nil) {
        return;
    }
    for (BTSessionTask *task in [self allTask]) {
        if ([task.currentRequest.URL.absoluteString hasPrefix:url]) {
            [task cancel];
        }
    }
}
+ (void)cancelTask:(BTSessionTask *)task {
    [self cancelTaskId:task.taskIdentifier];
}
+ (void)cancelTaskId:(NSInteger)taskId {
    for (BTSessionTask *task in [self allTask]) {
        if (taskId == task.taskIdentifier) {
            [task cancel];
        }
    }
}
+ (void)cancelAllTask {
    
}
+ (NSArray<BTSessionTask *> *)allTask {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareInstance];
    NSArray <BTSessionTask *> *dataTasks = manager.dataTasks;
    return dataTasks;
}


@end
