//
//  ViewController.m
//  ChartDmeo
//
//  Created by 沈增光 on 2017/10/31.
//  Copyright © 2017年 沈增光. All rights reserved.
//

#import "ViewController.h"
#import "Charts-Swift.h"
#import "ChartBarMultipleView.h"

/**屏幕宽度*/
#define TPWidth [UIScreen mainScreen].bounds.size.width
/**屏幕宽度*/
#define TPHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"测试";
    self.view.backgroundColor = [UIColor whiteColor];
  
    
    

    ChartBarMultipleView *chartView1 = [[ChartBarMultipleView alloc] initWithFrame:CGRectMake(0, 64, TPWidth, TPHeight/2)];
    chartView1.xValues = @[@"王二",@"三麻子",@"四老头"];
    chartView1.statistics = @[@[@40,@60,@80,@90],@[@40,@60,@80,@90],@[@40,@60,@80,@90]];
    chartView1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:chartView1];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
