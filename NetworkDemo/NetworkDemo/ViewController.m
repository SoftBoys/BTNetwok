//
//  ViewController.m
//  NetworkDemo
//
//  Created by dfhb@rdd on 2017/12/11.
//  Copyright © 2017年 f2b2b. All rights reserved.
//

#import "ViewController.h"

#import "NSObject+BTRequest.h"
#import "BT_BaseRequestGroup.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 多个请求
    [self requestWithGroup];
    
    [self singleRequest];
    
}
- (void)requestWithGroup {
    
    // 请求1
    NSString *url1 = @"http://116.211.167.106/api/live/aggregation";
    NSDictionary *param1 = @{@"uid":@"133825214",
                             @"interest":@"1",
                             @"count":@(20)};
    // 请求2
    NSString *url2 = @"https://m.vvgong.cn/linggb-ws/ws/0.1/adpic/getPicByType_v2";
    NSDictionary *param2 = @{@"type":@2, @"picFlag":@2, @"picLevel":@0};
    
    // 请求3
    NSString *url3 = @"https://m.vvgong.cn/linggb-ws/ws/0.1/common/locationAndDataCode";
    NSDictionary *param3 = nil;
    
    BT_BaseRequest *request1 = [BT_BaseRequest requestWithUrl:url1];
    request1.parameters = param1;
    
    
    BT_BaseRequest *request2 = [BT_BaseRequest requestWithUrl:url2];
    request2.parameters = param2;
    
    
    BT_BaseRequest *request3 = [BT_BaseRequest requestWithUrl:url3];
    request3.parameters = param3;
    
    BT_BaseRequestGroup *group = [BT_BaseRequestGroup alloc];
    [group sendRequestGroup:@[request1, request2, request3] singleCompletion:^(BT_BaseRequest *request) {
        NSLog(@"========BEGIN========");
        NSLog(@"url:%@", request.url);
        NSLog(@"statusCode:%@", @(request.response.statusCode));
        NSLog(@"========END========");
    } completed:^{
        NSLog(@"completion");
    }];
    
}

- (void)singleRequest {
    
    // 请求
    NSString *url = @"http://116.211.167.106/api/live/aggregation";
    NSDictionary *param = @{@"uid":@"133825214",
                             @"interest":@"1",
                             @"count":@(20)};
    self.CANCEL(url);
    [self.GET(url).PARAM(param) SEND:^(BT_BaseResponse *response) {
        
    }];
    
}

@end
