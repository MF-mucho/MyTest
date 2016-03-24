//
//  MFHourly.h
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFHourly : NSObject
//每小时
@property(nonatomic,strong) NSString *iconUrl;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *tempC;


//给定每小时字典，返回MFHourly
+ (MFHourly *)parseHourlyJson:(NSDictionary *)dic;
@end
