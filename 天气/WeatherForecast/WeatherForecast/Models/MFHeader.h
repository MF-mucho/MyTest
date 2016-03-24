//
//  MFHeader.h
//  WeatherForecast
//
//  Created by tarena on 16/1/23.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFHeader : NSObject
@property(nonatomic,strong) NSString *cityName;
//天气图标url对应string
@property(nonatomic,strong) NSString *iconUrlStr;
//当前天气的描述
@property(nonatomic,strong) NSString *weatherDesc;

@property(nonatomic,strong) NSString *weatherTemp;

@property(nonatomic,strong) NSString *maxTemp;

@property(nonatomic,strong) NSString *minTemp;

+ (MFHeader *)getHeaderData:(id)responseObject;
    

@end
