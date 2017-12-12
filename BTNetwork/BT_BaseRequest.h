//
//  BT_BaseRequest.h
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BT_BaseResponse.h"
#import "BT_MultipartFormData.h"

typedef NS_ENUM(NSUInteger, BTRequestType) {
    BTRequestGET,
    BTRequestPOST,
    BTRequestMultipartPOST
};

@class BT_BaseResponse;
typedef void(^BTResponseCompletionBlock)(BT_BaseResponse *response);

@interface BT_BaseRequest : NSObject

/** 请求Url */
@property (nonatomic, copy) NSString *url;
/** 请求参数 */
@property (nonatomic, copy) NSDictionary *parameters;
/** 请求类型 */
@property (nonatomic, assign) BTRequestType requestType;
/** form 表单 参数 */
@property (nonatomic, strong) id<BT_MultipartFormData> formData;

/** 创建网络请求 */
+ (instancetype)requestWithUrl:(NSString *)url;
+ (instancetype)requestWithUrl:(NSString *)url requestType:(BTRequestType)requestType;
- (void)sendWithCompleted:(BTResponseCompletionBlock)completed;

- (void)cancel;

@property (nonatomic, strong, readonly) BT_BaseResponse *response;

@end
