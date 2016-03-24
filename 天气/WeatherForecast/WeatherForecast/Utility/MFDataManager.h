//
//  MFDataManager.h
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFDataManager : NSObject

//返回所有城市数组（MFCityGroup）
+ (NSArray *)getAllCityGroups;
//返回所有每天数组（MFdaily）
+ (NSArray *)getAllDailyData:(id)responseObject;
//返回所有每小时数组
+ (NSArray *)getAllHourlyData:(id)responseObject;
//返回一个已经对应好得字典
+ (NSDictionary *)imageMap;
@end
