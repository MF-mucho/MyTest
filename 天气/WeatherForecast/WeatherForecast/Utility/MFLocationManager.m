//
//  MFLocationManager.m
//  WeatherForecast
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFLocationManager.h"
#import <UIKit/UIKit.h>
@interface MFLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,copy) void (^saveLocationBlock)(double lat,double lon);
@end

@implementation MFLocationManager
//懒加载方式初始化
//单例：一个类的唯一一个实例对象
+ (id)shareLocationManager{
    static MFLocationManager *locationManager = nil;
    if (!locationManager) {
        locationManager = [[MFLocationManager alloc]init];
    }
    return locationManager;
}

//重写init方法初始化manager对象/征求用户同意
- (instancetype)init{
    if (self = [super init]) {
        self.manager = [CLLocationManager new];
        //判断iOS版本
        if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0) {
            //Info.plist添加key
            [self.manager requestAlwaysAuthorization];
        }
        self.manager.delegate = self;
    }
    return self;
}

+ (void)getUserLocation:(void (^)(double, double))locationBlock{
    MFLocationManager *locationManager = [MFLocationManager shareLocationManager];
    [locationManager getUserLocations:locationBlock];
}

- (void)getUserLocations:(void (^)(double, double))locationBlock{
    //用户没有同意/没有开启定位功能
    if (![CLLocationManager locationServicesEnabled]) {
        //告诉用户消息无法定位
        return;
    }
    // 将saveLocationBlock赋值给LocationBlock
    _saveLocationBlock = [locationBlock copy];
    
    
    //设定经度（调用频率）
    self.manager.distanceFilter = 500;
    
    //同意/开启 -> 开始定位
    [self.manager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //防止调用多次
    //经纬度
    CLLocation *location = [locations lastObject];
    //NSLog(@"%g %g",location.coordinate.latitude,location.coordinate.longitude);
    //block传参数
    _saveLocationBlock(location.coordinate.latitude,location.coordinate.longitude);
}

@end
