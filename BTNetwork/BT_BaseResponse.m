//
//  BT_BaseResponse.m
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//

#import "BT_BaseResponse.h"

@implementation BT_BaseResponse

- (instancetype)initWithStatusCode:(NSInteger)statusCode responseData:(NSData *)responseData responseString:(NSString *)responseString responseJSON:(id)responseJSON error:(NSError *)error {
    if (self = [super init]) {
        
        _statusCode = statusCode;
        _responseData = responseData;
        _responseString = responseString;
        _responseJSON = responseJSON;
        _error = error;
        
        if (_error) {
//            NSData *data = _error.userInfo[@"com.alamofire.serialization.response.error.data"];
//            id jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _responseJSON];
}

@end
