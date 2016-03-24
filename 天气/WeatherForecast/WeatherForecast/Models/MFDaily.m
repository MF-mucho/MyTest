//
//  MFDaily.m
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFDaily.h"

@implementation MFDaily
+ (MFDaily *)parseDailyJson:(NSDictionary *)dic{
    return [[self alloc] parseDeilyJson:dic];
}
//第三方库（解析/赋值/嵌套。。YYModel/MJExtention）
- (MFDaily *)parseDeilyJson:(NSDictionary *)dic{
    self.date = dic[@"date"];
    self.maxtempC = [NSString stringWithFormat:@"%@˚",dic[@"maxtempC"]];
    self.mintempC = [NSString stringWithFormat:@"%@˚",dic[@"mintempC"]];
    self.iconUrl = dic[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
    return self;
}


@end
