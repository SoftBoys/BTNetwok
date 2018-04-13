//
//  BT_BaseResponse.h
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import <Foundation/Foundation.h>

@interface BT_BaseResponse : NSObject

/** 响应码 */
@property (nonatomic, assign) NSInteger statusCode;
/** 响应头 */
@property (nonatomic, strong) NSMutableDictionary *headers;
/** 响应Data */
@property (nonatomic, strong) NSData *responseData;
/** 响应字符串 */
@property (nonatomic, copy) NSString *responseString;
/** JSON */
@property (nonatomic, strong) id responseJSON;
@property (nonatomic, strong) NSError *error;

@end
