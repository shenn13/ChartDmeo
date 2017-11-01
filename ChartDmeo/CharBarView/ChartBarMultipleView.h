//
//  ChartBarMultipleView.h
//  ChartDmeo
//
//  Created by 沈增光 on 2017/10/31.
//  Copyright © 2017年 沈增光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartBarMultipleView : UIView

/**所有的学生数据源*/
@property (strong, nonatomic) NSArray *xValues;

/**所有的学生听说读写值 数据源*/
@property (strong, nonatomic) NSArray *statistics;
/**类型*/
@property (strong, nonatomic) NSString *typeText;

@end
