//
//  MFHeaderView.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFHeaderView.h"
//左右边界
static CGFloat inset = 20;
//label高
static CGFloat labelHeight = 40;
//温度的label高
static CGFloat tempLabelHeight = 110;

@implementation MFHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //button的frame
        CGRect menuButtonFrame = CGRectMake(10, inset, labelHeight, labelHeight);
        self.menuButton = [[UIButton alloc]initWithFrame:menuButtonFrame];
        [self.menuButton setImage:[UIImage imageNamed:@"IconHome"] forState:UIControlStateNormal];
        //添加
        [self addSubview:self.menuButton];
       
        
        CGRect cityLabelFrame = CGRectMake(10+self.menuButton.frame.size.width, inset, SCREEN_WIDTH-2*labelHeight,labelHeight );
        self.cityLabel = [[UILabel alloc]initWithFrame:cityLabelFrame];
        self.cityLabel.textAlignment = NSTextAlignmentCenter;
       // self.cityLabel.text = @"loading...";
        self.cityLabel.textColor = [UIColor whiteColor];
        [self addSubview: self.cityLabel];
        
        
        CGRect iconViewFrame = CGRectMake(inset, SCREEN_HEIGHT-tempLabelHeight-2*labelHeight, labelHeight, labelHeight);
        self.iconView = [[UIImageView alloc]initWithFrame:iconViewFrame];
        self.iconView.image = [UIImage imageNamed:@"placeholder"];
        [self addSubview:self.iconView];
        
        CGRect conditionsLabelFrame = CGRectMake(inset+self.iconView.bounds.size.width, SCREEN_HEIGHT-2*labelHeight-tempLabelHeight, 2*tempLabelHeight-self.iconView.bounds.size.width, labelHeight);
        self.conditionsLabel = [[UILabel alloc]initWithFrame:conditionsLabelFrame];
        self.conditionsLabel.textAlignment = NSTextAlignmentLeft;
       // self.conditionsLabel.text =@"Clear";
        self.conditionsLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.conditionsLabel];
        
        CGRect temperatureLabelFrame = CGRectMake(inset, SCREEN_HEIGHT-tempLabelHeight-labelHeight, tempLabelHeight*2, tempLabelHeight);
        self.temperatureLabel = [[UILabel alloc]initWithFrame:temperatureLabelFrame];
        self.temperatureLabel.textAlignment = NSTextAlignmentLeft;
        //self.temperatureLabel.text = @"0°";
        self.temperatureLabel.font = [UIFont systemFontOfSize:80];
        self.temperatureLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.temperatureLabel];
        
        CGRect hiloLabelFrame = CGRectMake(inset,SCREEN_HEIGHT-labelHeight, 2*tempLabelHeight, labelHeight);
        self.hiloLabel = [[UILabel alloc]initWithFrame:hiloLabelFrame];
        self.hiloLabel.textAlignment = NSTextAlignmentLeft;
       // self.hiloLabel.text = @"0°/0°";
        self.hiloLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.hiloLabel];
    }
    return self;
}





@end
