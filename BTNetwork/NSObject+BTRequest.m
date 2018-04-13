//
//  NSObject+BTRequest.m
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//

#import "NSObject+BTRequest.h"

@implementation NSObject (BTRequest)
/** tag 1.0.7 */
- (MessageSendHandle)GET {
    MessageSendHandle handle = ^BTMessage * (NSString *url) {
        return [self sendMessage:url type:BTRequestGET];
    };
    return handle;
}
- (MessageSendHandle)POST {
    MessageSendHandle handle = ^BTMessage * (NSString *url) {
        return [self sendMessage:url type:BTRequestPOST];
    };
    return handle;
}

- (BTMessage *)sendMessage:(NSString *)url type:(BTRequestType)type {
    BTMessage *message = [BTMessage new];
    message.request.url = url;
    message.request.requestType = type;
    return message;
}

- (MessageCancelHandle)CANCEL {
    MessageCancelHandle handle = ^(NSString *url) {
        BTMessage *message = [self sendMessage:url type:BTRequestGET];
        [message.request cancel];
    };
    return handle;
}
@end

@implementation BTMessage

- (BT_BaseRequest *)request {
    if (!_request) {
        _request = [BT_BaseRequest new];
    }
    return _request;
}

- (MessageParamsHandle)PARAM {
    MessageParamsHandle handle = ^BTMessage * (NSDictionary *params) {
        self.request.parameters = params;
        return self;
    };
    return handle;
}

- (void)SEND:(void (^)(BT_BaseResponse *))completion {
    [self.request sendWithCompletion:completion];
}
@end
