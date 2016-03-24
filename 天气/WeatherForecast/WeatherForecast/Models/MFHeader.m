//
//  MFHeader.m
//  WeatherForecast
//
//  Created by tarena on 16/1/23.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFHeader.h"
#import "MFDataManager.h"

@implementation MFHeader

+ (MFHeader *)getHeaderData:(id)responseObject{
    return [[self alloc] getHeaderData:responseObject];
}

- (MFHeader *)getHeaderData:(id)responseObject{
    NSString *currentTemp = responseObject[@"data"][@"current_condition"][0][@"temp_C"];
    self.weatherTemp = [NSString stringWithFormat:@"%@",currentTemp];
    self.weatherDesc = responseObject[@"data"][@"current_condition"][0][@"weatherDesc"][0][@"value"];

    
#warning 此处使用本地图片
    NSString *url = responseObject[@"data"][@"current_condition"][0][@"weatherIconUrl"][0][@"value"];
    self.iconUrlStr = [MFDataManager imageMap][url];
    
    self.maxTemp  = responseObject[@"data"][@"weather"][0][@"maxtempC"];
    self.minTemp  = responseObject[@"data"][@"weather"][0][@"mintempC"];
    self.cityName = responseObject[@"data"][@"request"][0][@"query"];
    
    return self;
}

@end
