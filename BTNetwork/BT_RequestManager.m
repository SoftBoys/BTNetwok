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
+ (BTSessionTask *)GET:(NSString *)URLString parameters:(id)parameters success:(BT_ResponseSuccessBlock)success fail:(BT_ResponseFailBlock)fail {
    return [self requestWithUrl:URLString parameters:parameters method:1 success:success fail:fail];
}
+ (BTSessionTask *)POST:(NSString *)URLString parameters:(id)parameters success:(BT_ResponseSuccessBlock)success fail:(BT_ResponseFailBlock)fail {
    return [self requestWithUrl:URLString parameters:parameters method:2 success:success fail:fail];
}
+ (BTSessionTask *)requestWithUrl:(NSString *)URLString parameters:(id)parameters method:(NSInteger)method success:(BT_ResponseSuccessBlock)success fail:(BT_ResponseFailBlock)fail {
    
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareInstance];
    BTSessionTask *sessionTask = nil;
    if (method == 1) {
        sessionTask = [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(task, error);
            }
        }];
    } else if (method == 2) {
        sessionTask = [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(task, error);
            }
        }];
    }
    
    return sessionTask;
    
}

+ (BTSessionTask *)POST:(NSString *)URLString parameters:(id)parameters bodyFormData:(id<BT_MultipartFormData>)formData success:(BT_ResponseSuccessBlock)success fail:(BT_ResponseFailBlock)fail {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareInstance];
    BTSessionTask *sessionTask = nil;
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull afFormData) {
        if (formData) {        
            [afFormData appendPartWithFileData:formData.fileData name:formData.name fileName:formData.fileName mimeType:formData.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(task, error);
        }
    }];
    
    return sessionTask;
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
