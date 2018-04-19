//
//  BT_RequestManager.h
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "BT_MultipartFormData.h"

@class BT_BaseResponse;
typedef NSURLSessionTask BTSessionTask;

typedef void(^BT_ResponseCompletionBlock)(BT_BaseResponse *response);

@protocol BT_MultipartFormData;
@interface BT_RequestManager : NSObject

/** 配置BaseURL */
+ (void)setBaseURL:(NSString *)baseUrl;
/** 配置HTTP请求头参数 */
+ (void)configHTTPHeaders:(NSDictionary *)httpHeaders;
/**
 发起GET请求
 
 @param URLString 请求URL
 @param parameters 请求参数
 @param completion 完成回调
 @return 请求任务
 */
+ (BTSessionTask *)GET:(NSString *)URLString parameters:(id)parameters completion:(BT_ResponseCompletionBlock)completion;
/**
 发起POST请求
 
 @param URLString 请求URL
 @param parameters 请求参数
 @param completion 完成回调
 @return 请求任务
 */
+ (BTSessionTask *)POST:(NSString *)URLString parameters:(id)parameters completion:(BT_ResponseCompletionBlock)completion;

/**
 发起POST请求 (multipart 参数以body形式传递)
 
 @param URLString 请求URL
 @param parameters 请求参数
 @param formData 文件参数
 @param uploadProgress 进度条回调
 @param completion 完成回调
 @return 请求任务
 */
+ (BTSessionTask *)UPLOAD:(NSString *)URLString
               parameters:(id)parameters
                 formData:(id<BT_MultipartFormData>)formData
                 progress:(void (^)(NSProgress *))uploadProgress
                  completion:(BT_ResponseCompletionBlock)completion;


/** 根据url取消网络请求 */
+ (void)cancelTaskWithUrl:(NSString *)url;
+ (void)cancelTask:(BTSessionTask *)task;
+ (void)cancelTaskId:(NSInteger)taskId;
+ (void)cancelAllTask;
@end




