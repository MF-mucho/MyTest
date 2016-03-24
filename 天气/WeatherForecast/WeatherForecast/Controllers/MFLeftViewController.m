//
//  MFLeftViewController.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "MFLeftViewController.h"
#import "MFCityGroupTableViewController.h"
@interface MFLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

CGFloat cellHeight = 50;


@implementation MFLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //创建tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-cellHeight*2)/2, SCREEN_WIDTH, cellHeight*2)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    //seperator线的设置
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableView];
}
#pragma mark - UITableView Delegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"menucell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSArray *titles = @[@"切换城市",@"其他"];
    NSArray *images = @[@"IconSettings",@"IconProfile"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
   //选中看不出来
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
   //选中看不出来
    //cell.selectedBackgroundView = [UIView new];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //创建城市视图控制器对象（navController）
        MFCityGroupTableViewController *cityGroupViewController = [MFCityGroupTableViewController new];
        UINavigationController *nacController = [[UINavigationController alloc]initWithRootViewController:cityGroupViewController];
        //显示
        [self presentViewController:nacController animated:YES completion:nil];
    }
   }

@end
