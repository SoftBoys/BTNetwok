//
//  BT_BaseRequestGroup.m
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import "BT_BaseRequestGroup.h"

@implementation BT_BaseRequestGroup
- (void)sendRequestGroup:(NSArray<BT_BaseRequest *> *)groupArray completion:(BTGroupCompletionBlock)completion {
    [self sendRequestGroup:groupArray singleCompletion:nil completion:completion];
}
- (void)sendRequestGroup:(NSArray<BT_BaseRequest *> *)groupArray singleCompletion:(BTSingleRequestCompletionBlock)singleCompletion completion:(BTGroupCompletionBlock)completion {
    
    _groupArray = groupArray;
    
    dispatch_group_t group = dispatch_group_create();
    
    [groupArray enumerateObjectsUsingBlock:^(BT_BaseRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_enter(group);
        
        [obj sendWithCompletion:^(BT_BaseResponse *response) {
            if (singleCompletion) {
                singleCompletion(obj);
            }
            dispatch_group_leave(group);
        }];
        
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
    
}

@end
