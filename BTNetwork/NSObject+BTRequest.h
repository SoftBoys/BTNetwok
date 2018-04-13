//
//  NSObject+BTRequest.h
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "BT_BaseRequest.h"

@class BTMessage;

typedef void(^MessageCancelHandle)(NSString *url);
typedef BTMessage* (^MessageSendHandle)(NSString *url);
typedef BTMessage* (^MessageParamsHandle)(NSDictionary *params);
typedef BTMessage* (^MessageFormDataHandle)(id<BT_MultipartFormData> formData);

@interface NSObject (BTRequest)
@property (nonatomic, copy, readonly) MessageSendHandle GET;
@property (nonatomic, copy, readonly) MessageSendHandle POST;

@property (nonatomic, copy, readonly) MessageCancelHandle CANCEL;
@end

@interface BTMessage : NSObject

@property (nonatomic, strong) BT_BaseRequest *request;

@property (nonatomic, copy, readonly) MessageParamsHandle PARAM;

- (void)SEND:(void(^)(BT_BaseResponse *response))completion;

@end
