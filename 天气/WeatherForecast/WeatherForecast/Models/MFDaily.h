//
//  MFDaily.h
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFDaily : NSObject

//日期
@property(nonatomic,strong) NSString *date;

//最高气温
@property(nonatomic,strong) NSString *maxtempC;
//最低气温
@property(nonatomic,strong) NSString *mintempC;
//图片url
@property(nonatomic,strong) NSString *iconUrl;


//给定每天字典，返回MFDaily
+ (MFDaily *)parseDailyJson:(NSDictionary *)dic;





@end
