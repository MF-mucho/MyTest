//
//  MFCityGroup.h
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFCityGroup : NSObject
//模型类中的属性名称要和字典的key一模一样
@property(nonatomic,strong) NSArray *cities;
@property(nonatomic,strong) NSString *title;
@end
