//
//  MFMainViewController.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFMainViewController.h"
#import "MFHeaderView.h"
#import "RESideMenu.h"
#import "MFDataManager.h"
#import "MFLocationManager.h"
#import "MFNetworkManager.h"
#import "TSMessage.h"
#import "MFDaily.h"
#import "MFHourly.h"
#import "UIImageView+WebCache.h"
#import "MFHeader.h"
#import "MJRefresh.h"


@interface MFMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
//保存用户位置
@property(nonatomic,strong) CLLocation *userLocation;
//每小时数据
@property(nonatomic,strong) NSArray *hourlyArray;
//每天数据
@property(nonatomic,strong) NSArray *dailyArray;
//地理编码
@property(nonatomic,strong) CLGeocoder *geocoder;

@property(nonatomic,strong) MFHeaderView *headerView;


@end

@implementation MFMainViewController
- (MFHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MFHeaderView alloc]init];
    }
    return _headerView;
}
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [CLGeocoder new];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //监听通知
    [self listenNotification];
    
    
    //验证城市组是否可以转换
   // NSArray *array = [MFDataManager getAllCityGroups];

    
    //创建背景视图
//   [self creatBackgroundView];
   //创建tableView。
    [self creatTableView];
    //创建头部视图
    [self creatHeaderView];
    
     //获取用户位置并发送请求
    [self getLocationAndSendRequest];
    //创建下拉刷新
    [self createRefreshControl];
    [self.tableView addSubview:self.headerView];
}
- (void)listenNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenChangeCity:) name:@"DidCityChange" object:nil];
}
- (void)listenChangeCity:(NSNotification *)notifacation{
    //获取传过来的参数
    NSString *cityName = notifacation.userInfo[@"CityName"];
    self.headerView.cityLabel.text = cityName;
    NSLog(@"城市名字：%@",cityName);
    //地理编码获取城市拼音
   [self.geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       CLPlacemark *placemark = [placemarks lastObject];
       //将服务器返回地标中location赋值self.userLocation(!!!!)
       self.userLocation = placemark.location;
       NSString *cityStr = placemark.addressDictionary[@"City"];
       //更新城市label
       //self.headerView.cityLabel.text = cityStr;
       NSLog(@"城市拼音：%@;000--%f",cityStr,self.userLocation.coordinate.latitude);
   }];

    //发送请求
    [self sendRequestToServer];
    
}



#pragma mark - 界面相关方法
- (void)parseAndUpdateHeaderView:(id)responseObject{
    //解析jsonDic（模型层/子线程）
    MFHeader *header = [MFHeader getHeaderData:responseObject];
    NSLog(@"%@",header.weatherTemp);
    if (self.userLocation) {
        [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (!error) {
                //反地理编码成功
                CLPlacemark *placemark = [placemarks firstObject];
                //城市名称
                self.headerView.cityLabel.text = placemark.addressDictionary[@"City"];
            }
        }];
    }
    //更新头部视图控件（4个UILabel）
    self.headerView.temperatureLabel.text = header.weatherTemp;
    NSLog(@"----%@",self.headerView.temperatureLabel.text);
    //最高、最低温度
    self.headerView.hiloLabel.text = [NSString stringWithFormat:@"%@ / %@",header.minTemp,header.maxTemp];
#warning 此处使用本地图片
    self.headerView.iconView.image = [UIImage imageNamed:header.iconUrlStr];
    //天气描述
    self.headerView.conditionsLabel.text = header.weatherDesc;
}

- (void)createRefreshControl{
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequestToServer)];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //马上进入刷新状态
    [header beginRefreshing];
    //设置header
     self.tableView.mj_header = header;
}
- (void)creatHeaderView{
    MFHeaderView *view = [[MFHeaderView alloc]initWithFrame:SCREEN_BOUNDS];
    [view.menuButton addTarget:self action:@selector(clickMenuButton) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = view;
}
//#pragma mark  -  创建背景视图
//-(void)creatBackgroundView{
//    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Stars"]];
//    backgroundImageView.frame = SCREEN_BOUNDS;
//    //[self.view addSubview:backgroundImageView];
//}
//
#pragma  mark - 请求相关方法




- (void)getLocationAndSendRequest{
     [MFLocationManager getUserLocation:^(double lat, double lon) {
   
         CLLocation *location = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
         //赋值
         self.userLocation = location;
        [self sendRequestToServer];
     }];
}

- (void)sendRequestToServer{
    //设置TSMessage默认控制器
    [TSMessage setDefaultViewController:self];
    
    //URL
    NSString *urlStr = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=4&key=d6b5616b65c56f28d400b0e6c303e"
,self.userLocation.coordinate.latitude,self.userLocation.coordinate.longitude];
    //NetworkManger
    [MFNetworkManager sendGetRequestWithUrl:urlStr parameters:nil success:^(id responseObject) {
        [self parseAndUpdateHeaderView:responseObject];
        //调用MFDataManager中的getAllDailyData
        self.dailyArray = [MFDataManager getAllDailyData:responseObject];
        
        
      //  NSLog(@"%@",self.dailyArray);
        //调用MFDataManager中的getAllHourlyData
        self.hourlyArray = [MFDataManager getAllHourlyData:responseObject];

       // NSLog(@"服务器返回的json数据：%@",responseObject);
        //因为表格构建与数据更新为异步执行。在数据再次更新完之前表格的数据还是上一次的。所以要用reloadData方法重新构建表格。达到tableView界面数据更新的目的。
        
        
        [self.tableView reloadData];
        //拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"服务器请求失败：%@",error.userInfo);
         //显示通知给用户
        [TSMessage showNotificationWithTitle:@"提示" subtitle:@"请稍后再试" type:TSMessageNotificationTypeWarning];
        //拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    }];
   
   
    
}



#pragma mark  - 按钮触发方法
- (void)clickMenuButton{
    //显示左边控制器
    [self.sideMenuViewController presentLeftMenuViewController];
}


#pragma mark - UITableView相关方法
- (void)creatTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = SCREEN_BOUNDS;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.pagingEnabled = YES;
    
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //需求：不想随着tableView的滚动而滚动
    // self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ssss"]];
    
    //添加
    [self.view addSubview:self.tableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return section == 0? self.hourlyArray.count + 1 : self.dailyArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    //设置cell属性
    cell.backgroundColor  = [UIColor clearColor];
    cell.textLabel.textColor  = [UIColor whiteColor];
    //设置cell不可点中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Hourly Forecast Info.";
            cell.detailTextLabel.text = nil;
            cell.imageView.image = nil;
        }else{
            MFHourly *hourly = self.hourlyArray[indexPath.row - 1];
          cell.textLabel.text = hourly.time;
             cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",hourly.tempC];
            //下载图片（耗时：子线程下载；回到主线程更新cell）
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hourly.iconUrl] placeholderImage:nil];
        }
    }else{
        if (indexPath.row == 0) {
           cell.textLabel.text = @"Daily Forecast Info.";
            cell.detailTextLabel.text = nil;
            cell.imageView.image = nil;
        }else{
            MFDaily *daily = self.dailyArray[indexPath.row - 1];
          cell.textLabel.text = daily.date;
           
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ / %@",daily.mintempC,daily.maxtempC];
            //下载图片
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:daily.iconUrl] placeholderImage:nil];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取每个section的行数
    NSInteger rowCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return SCREEN_HEIGHT / rowCount;
}
- (void)configFirstCell:(UITableViewCell *)cell withText:(NSString *)text {
    cell.textLabel.text = text;
    cell.detailTextLabel.text = nil;
    cell.imageView.image = nil;
    
}

@end
