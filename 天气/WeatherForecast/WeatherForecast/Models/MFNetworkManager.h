//
//  MFNetworkManager.h
//  Demo1-AFNetworking
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <Foundation/Foundation.h>
//block分类：没有传参/没有返回值；有传参/没有返回值。。。四类
//方式二
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

@interface MFNetworkManager : NSObject
//方式一（block使用copy）
//@property(nonatomic,strong) void (^successBlock)(id responseObjict);


+ (void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)paramDic success:(successBlock)sucess failure:(failureBlock)failure;
@end
