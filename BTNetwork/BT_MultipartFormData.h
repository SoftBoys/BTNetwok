//
//  BT_MultipartFormData.h
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//  

#import <Foundation/Foundation.h>

@protocol BT_MultipartFormData <NSObject>

@property (nonatomic, strong, readonly) NSData *fileData;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *fileName;
@property (nonatomic, copy, readonly) NSString *mimeType;

@end
