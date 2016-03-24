//
//  MFHeaderView.h
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFHeaderView : UIView
//button
@property(nonatomic,strong) UIButton *menuButton;
//城市label
@property(nonatomic,strong) UILabel *cityLabel;
//iconView
@property(nonatomic,strong) UIImageView *iconView;
//当前天气条件label
@property(nonatomic,strong) UILabel *conditionsLabel;
//当前的天气温度
@property(nonatomic,strong) UILabel *temperatureLabel;
//最高和最低温
@property(nonatomic,strong) UILabel *hiloLabel;

@end
