//
//  MFHourly.m
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFHourly.h"

@implementation MFHourly
+ (MFHourly *)parseHourlyJson:(NSDictionary *)dic{
    return [[self alloc] parseHourlyJson:dic];
}
- (MFHourly *)parseHourlyJson:(NSDictionary *)dic{

    self.iconUrl = dic[@"weatherIconUrl"][0][@"value"];
    int time = [dic[@"time"] intValue] / 100;
    self.time = [NSString stringWithFormat:@"%d:00",time];
    self.tempC = [NSString stringWithFormat:@"%@˚",dic[@"tempC"]];
    return self;
    
}
@end
