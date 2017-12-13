## BTNetwork

##### `BTNetwork `是一款基于`AFNetworking `的网络库，以`block`方式调用，支持队列组请求

#### 版本
- 最新版本 `v1.0.8`


## 安装
#### 使用CocoaPods
	pod 'BTNetwork'
#### 手动导入
- 将`BTNetwork`文件夹拖拽到项目中
- 引入头文件 `#import "NSObject+BTRequest.h"`

## 使用方法
	NSString *url = @"http://116.211.167.106/api/live/aggregation";
    NSDictionary *param = @{@"uid":@"133825214",
                            @"interest":@"1",
                            @"count":@(20)};
                             
    self.CANCEL(url);
    [self.GET(url).PARAM(param) SEND:^(BT_BaseResponse *response) {
        if (response.statusCode == 200) {
            NSLog(@"wancheng");
        }
    }];
	

## 证书
`BTNetwork `基于 `MIT`证书协议
