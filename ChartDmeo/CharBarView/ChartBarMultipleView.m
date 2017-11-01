//
//  ChartBarMultipleView.m
//  ChartDmeo
//
//  Created by 沈增光 on 2017/10/31.
//  Copyright © 2017年 沈增光. All rights reserved.
//

#import "ChartBarMultipleView.h"
#import "Charts-Swift.h"
#import "IntAxisValueFormatter.h"


#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height

@interface ChartBarMultipleView ()<ChartViewDelegate,IChartAxisValueFormatter>

@property (nonatomic, strong) BarChartView *chartView;

@end

@implementation ChartBarMultipleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
        [self uiConfig];
    }
    return self;
}


- (void)uiConfig {
    
    
    _chartView = [[BarChartView alloc] init];
    _chartView.backgroundColor = [UIColor whiteColor];
    _chartView.frame = CGRectMake(0, 10, kSelfWidth, kSelfHeight - 20);
    _chartView.delegate = self;
    _chartView.chartDescription.enabled = NO;
    _chartView.dragYEnabled = NO;
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
  
    
    ChartLegend *legend = _chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = YES;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8.f];
    legend.yOffset = 10.0;
    legend.xOffset = 10.0;
    legend.yEntrySpace = 0.0;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xAxis.granularity = 1.f;
    xAxis.gridLineDashLengths = @[@5.f, @5.f];
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.valueFormatter = [[IntAxisValueFormatter alloc] init];
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
    xAxis.labelCount = 20;
    //    xAxis.valueFormatter = self;//自定义格式
    
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.maximumFractionDigits = 1;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    //    leftAxis.valueFormatter = self;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.spaceTop = 0.35;
    leftAxis.axisMinimum = 0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    [self addSubview:_chartView];
    
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"班级平均线"];
    limitLine.valueFont = [UIFont systemFontOfSize:10.0];
    limitLine.valueTextColor = [UIColor colorWithRed:241/255.0 green: 196/255.0 blue: 15/255.0 alpha: 1.0];
    limitLine.lineWidth = 2;
    limitLine.lineColor = [UIColor colorWithRed:241/255.0 green: 196/255.0 blue: 15/255.0 alpha: 1.0];
    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
    [leftAxis addLimitLine:limitLine];//添加到Y轴上
    leftAxis.drawLimitLinesBehindDataEnabled = NO;//设置限制线绘制在柱形图的后面
    
    _chartView.rightAxis.enabled = NO;
    
//    _sliderX.value = 10.0;
//    _sliderY.value = 100.0;
//    [self slidersValueChanged:nil];
  
}

//- (void)updateChartData
//{
//    if (self.shouldHideData)
//    {
//        _chartView.data = nil;
//        return;
//    }
    
//    [self setDataCount:_sliderX.value range:_sliderY.value];
//}


-(void)setStatistics:(NSArray *)statistics{
    
    _statistics = statistics;
    
//    if (self.shouldHideData)
//    {
//        _chartView.data = nil;
//        return;
//    }
    
   [self setDataCount:_statistics.count range:100];
    
}


- (void)setDataCount:(NSInteger)count range:(double)range
{
    float groupSpace = 0.08f;
    float barSpace = 0.03f;
    float barWidth = 0.2f;
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals4 = [[NSMutableArray alloc] init];
    
    
    for (NSInteger i = 0; i < count; i++)
    {
        for (NSInteger j = 0; j < 4; i ++) {
            
            [yVals1 addObject:[[BarChartDataEntry alloc]
                               initWithX:i
                               y:20]];
            
            [yVals2 addObject:[[BarChartDataEntry alloc]
                               initWithX:i
                               y:40]];
            
            [yVals3 addObject:[[BarChartDataEntry alloc]
                               initWithX:i
                               y:60]];
            
            [yVals4 addObject:[[BarChartDataEntry alloc]
                               initWithX:i
                               y:80]];
        }
    }
    
    BarChartDataSet *set1 = nil, *set2 = nil, *set3 = nil, *set4 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set2 = (BarChartDataSet *)_chartView.data.dataSets[1];
        set3 = (BarChartDataSet *)_chartView.data.dataSets[2];
        set4 = (BarChartDataSet *)_chartView.data.dataSets[3];
        set1.values = yVals1;
        set2.values = yVals2;
        set3.values = yVals3;
        set4.values = yVals4;
        
        BarChartData *data = _chartView.barData;
        
        _chartView.xAxis.axisMinimum = 0;
        _chartView.xAxis.axisMaximum = [data groupWidthWithGroupSpace:groupSpace barSpace: barSpace] * _statistics.count ;
        [data groupBarsFromX: 0 groupSpace: groupSpace barSpace: barSpace];
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals1 label:@"听"];
        [set1 setColor:[UIColor colorWithRed:104/255.f green:241/255.f blue:175/255.f alpha:1.f]];
        
        set2 = [[BarChartDataSet alloc] initWithValues:yVals2 label:@"说"];
        [set2 setColor:[UIColor colorWithRed:164/255.f green:228/255.f blue:251/255.f alpha:1.f]];
        
        set3 = [[BarChartDataSet alloc] initWithValues:yVals3 label:@"读"];
        [set3 setColor:[UIColor colorWithRed:242/255.f green:247/255.f blue:158/255.f alpha:1.f]];
        
        set4 = [[BarChartDataSet alloc] initWithValues:yVals4 label:@"写"];
        [set4 setColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:0/255.f alpha:1.f]];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        [dataSets addObject:set3];
        [dataSets addObject:set4];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        //        [data setValueFormatter:[[LargeValueFormatter alloc] init]];
        
        // specify the width each bar should have
        data.barWidth = barWidth;
        
        // restrict the x-axis range
        _chartView.xAxis.axisMinimum = 0;
        
        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        _chartView.xAxis.axisMaximum = 0 + [data groupWidthWithGroupSpace:groupSpace barSpace: barSpace] * _statistics.count;
        
        [data groupBarsFromX: 0 groupSpace: groupSpace barSpace: barSpace];
        
        _chartView.data = data;
    }
}

//- (void)optionTapped:(NSString *)key
//{
//    [self handleOption:key forChartView:_chartView];
//}

#pragma mark - Actions

//- (IBAction)slidersValueChanged:(id)sender
//{
//    int startYear = 1980;
//    int endYear = startYear + _sliderX.value;
//    
//    _sliderTextX.text = [NSString stringWithFormat:@"%d-%d", startYear, endYear];
//    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
//    [self updateChartData];
//}

//- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
//    return @"100";
//}
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

//
//#pragma mark - Common option actions
//
//- (void)handleOption:(NSString *)key forChartView:(ChartViewBase *)chartView
//{
//    if ([key isEqualToString:@"toggleValues"])
//    {
//        for (id<IChartDataSet> set in chartView.data.dataSets)
//        {
//            set.drawValuesEnabled = !set.isDrawValuesEnabled;
//        }
//        
//        [chartView setNeedsDisplay];
//    }
//    
//    if ([key isEqualToString:@"toggleIcons"])
//    {
//        for (id<IChartDataSet> set in chartView.data.dataSets)
//        {
//            set.drawIconsEnabled = !set.isDrawIconsEnabled;
//        }
//        
//        [chartView setNeedsDisplay];
//    }
//    
//    if ([key isEqualToString:@"toggleHighlight"])
//    {
//        chartView.data.highlightEnabled = !chartView.data.isHighlightEnabled;
//        [chartView setNeedsDisplay];
//    }
//    
//    if ([key isEqualToString:@"animateX"])
//    {
//        [chartView animateWithXAxisDuration:3.0];
//    }
//    
//    if ([key isEqualToString:@"animateY"])
//    {
//        [chartView animateWithYAxisDuration:3.0];
//    }
//    
//    if ([key isEqualToString:@"animateXY"])
//    {
//        [chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
//    }
//    
//    if ([key isEqualToString:@"saveToGallery"])
//    {
//        UIImageWriteToSavedPhotosAlbum([chartView getChartImageWithTransparent:NO], nil, nil, nil);
//    }
//    
//    if ([key isEqualToString:@"togglePinchZoom"])
//    {
//        BarLineChartViewBase *barLineChart = (BarLineChartViewBase *)chartView;
//        barLineChart.pinchZoomEnabled = !barLineChart.isPinchZoomEnabled;
//        
//        [chartView setNeedsDisplay];
//    }
//    
//    if ([key isEqualToString:@"toggleAutoScaleMinMax"])
//    {
//        BarLineChartViewBase *barLineChart = (BarLineChartViewBase *)chartView;
//        barLineChart.autoScaleMinMaxEnabled = !barLineChart.isAutoScaleMinMaxEnabled;
//        
//        [chartView notifyDataSetChanged];
//    }
//    
//    if ([key isEqualToString:@"toggleData"])
//    {
//        _shouldHideData = !_shouldHideData;
//        [self updateChartData];
//    }
//    
//    if ([key isEqualToString:@"toggleBarBorders"])
//    {
//        for (id<IBarChartDataSet, NSObject> set in chartView.data.dataSets)
//        {
//            if ([set conformsToProtocol:@protocol(IBarChartDataSet)])
//            {
//                set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0;
//            }
//        }
//        
//        [chartView setNeedsDisplay];
//    }
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
