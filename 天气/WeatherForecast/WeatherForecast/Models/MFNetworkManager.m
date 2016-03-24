//
//  MFNetworkManager.m
//  Demo1-AFNetworking
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFNetworkManager.h"
#import "AFNetworking.h"
@implementation MFNetworkManager

+(void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)paramDic success:(successBlock)sucess failure:(failureBlock)failure{
    //和ADNetworking相关调用
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //服务器成功返回；reponseObject回传控制器
        //相当于函数
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //服务器失败返回；error回传控制器
        //相当于函数
        failure(error);
    }];
}



















@end
