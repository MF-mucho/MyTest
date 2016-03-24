//
//  MFLocationManager.h
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface MFLocationManager : NSObject

+(void)getUserLocation:(void (^)(double lat,double lon))locationBlock;


@end
