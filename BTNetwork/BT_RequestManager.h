//
//  BT_RequestManager.h
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "BT_MultipartFormData.h"

typedef NSURLSessionTask BTSessionTask;
typedef void(^BT_ResponseSuccessBlock)(BTSessionTask *task, id responseObject);
typedef void(^BT_ResponseFailBlock)(BTSessionTask *task, NSError *error);

@protocol BTMultipartFormData;
@interface BT_RequestManager : NSObject

/** 配置请求头 */
+ (void)setHostUrl:(NSString *)hostUrl;
/**
 发起GET请求
 
 @param URLString 请求URL
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 @return 请求任务
 */
+ (BTSessionTask *)GET:(NSString *)URLString parameters:(id)parameters success:(BT_ResponseSuccessBlock)success fail:(BT_ResponseFailBlock)fail;
/**
 发起POST请求
 
 @param URLString 请求URL
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 @return 请求任务
 */
+ (BTSessionTask *)POST:(NSString *)URLString parameters:(id)parameters success:(BT_ResponseSuccessBlock)success fail:(BT_ResponseFailBlock)fail;

/**
 发起POST请求 (multipart 参数以body形式传递)
 
 @param URLString 请求URL
 @param parameters 请求参数
 @param formData 上传的文件
 @param success 成功回调
 @param fail 失败回调
 @return 请求任务
 */
+ (BTSessionTask *)POST:(NSString *)URLString
             parameters:(id)parameters
           bodyFormData:(id<BT_MultipartFormData>)formData
                success:(BT_ResponseSuccessBlock)success
                   fail:(BT_ResponseFailBlock)fail;


/** 根据url取消网络请求 */
+ (void)cancelTaskWithUrl:(NSString *)url;
+ (void)cancelTask:(BTSessionTask *)task;
+ (void)cancelTaskId:(NSInteger)taskId;
+ (void)cancelAllTask;

@end




