//
//  BT_BaseRequestGroup.h
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "BT_BaseRequest.h"


typedef void(^BTSingleRequestCompletionBlock)(BT_BaseRequest *request);
typedef void(^BTGroupCompletionBlock)(void);

@interface BT_BaseRequestGroup : NSObject

@property (nonatomic, copy) NSArray <BT_BaseRequest*> *groupArray;

- (void)sendRequestGroup:(NSArray <BT_BaseRequest *>*)groupArray completion:(BTGroupCompletionBlock)completion;
- (void)sendRequestGroup:(NSArray <BT_BaseRequest *>*)groupArray singleCompletion:(BTSingleRequestCompletionBlock)singleCompletion completion:(BTGroupCompletionBlock)completion;

@end
