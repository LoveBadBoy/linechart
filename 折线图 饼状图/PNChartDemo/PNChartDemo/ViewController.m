//
//  ViewController.m
//  PNChartDemo
//
//  Created by FredChen on 16/5/4.
//  Copyright © 2016年 FrederickChen. All rights reserved.
//

#import "ViewController.h"
#import "PNChart.h"
#import "UIColor+Hex.h"
#import "CenterView.h"

@interface ViewController ()<PNChartDelegate>

@property (nonatomic) PNPieChart *pieChart; // 饼状图
@property (nonatomic) PNLineChart * lineChart;
@property (nonatomic) UIView *lineChartBGView; // 折线图背景视图
@property (nonatomic, retain) NSArray *lineChartDataArray; // 折线图数据数组
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建饼状图
    [self setMyPieChart];
    
    // 设置折线图数据
    [self setMyLineChart];
}


#pragma mark -- 创建饼状图
- (void)setMyPieChart
{
    NSArray *items = @[
                       [PNPieChartDataItem dataItemWithValue:20 color:[UIColor colorWithHexString:@"ed6c00"] description:@"支出" titleImage:[UIImage imageNamed:@"amount_yellow"]],
                       [PNPieChartDataItem dataItemWithValue:30 color:[UIColor colorWithHexString:@"f37f06"] description:@"收入" titleImage:[UIImage imageNamed:@"general－income－2_03"]],
                       [PNPieChartDataItem dataItemWithValue:30 color:[UIColor colorWithHexString:@"f39839"] description:@"利息" titleImage:[UIImage imageNamed:@"interest－2_03"]]
                       ];
    
    CGSize iOSDeviceScreenSize = [UIScreen mainScreen].bounds.size;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if (iOSDeviceScreenSize.height == 667) { // iphone 6/6s
            self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 100, 28, 200, 200) items:items];
        } else if (iOSDeviceScreenSize.height == 736) { // iphone 6p
            self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 120, 30, 240, 240) items:items];
        } else if (iOSDeviceScreenSize.height == 568) { // iphone 5/5s
            self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 90, 20, 180, 180) items:items];
        } else if (iOSDeviceScreenSize.height == 480) { // iphone 4/4s
            self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 85, 10, 170, 170) items:items];
        }
    }
    
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    self.pieChart.shouldHighlightSectorOnTouch = YES;
    self.pieChart.showImageView = YES;
    self.pieChart.transformAnimation = YES;
    
    [self.pieChart strokeChart];
    // 设置代理
    self.pieChart.delegate = self;
    [self.view addSubview:self.pieChart];
    

}

#pragma mark -- 饼状图点击代理方法
- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex
{
    NSLog(@"============%ld", (long)pieIndex);
}


#pragma mark -- 创建折线图
- (void)setMyLineChart
{
    self.lineChartBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 300)];
    [self.view addSubview:self.lineChartBGView];
    
    CGSize iOSDeviceScreenSize = [UIScreen mainScreen].bounds.size;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if (iOSDeviceScreenSize.height == 667) { // iphone 6/6s
            self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(-20, 20, SCREEN_WIDTH, self.lineChartBGView.frame.size.height)];
        } else if (iOSDeviceScreenSize.height == 736) { // iphone 6p
            self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(-10, 20, SCREEN_WIDTH, self.lineChartBGView.frame.size.height)];
        } else if (iOSDeviceScreenSize.height == 568) { // iphone 5/5s
            self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(-10, 20, SCREEN_WIDTH, self.lineChartBGView.frame.size.height)];
        } else if (iOSDeviceScreenSize.height == 480) { // iphone 4/4s
            self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(-10, 20, SCREEN_WIDTH, self.lineChartBGView.frame.size.height)];
        }
    }
    
    //    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    self.lineChart.showCoordinateAxis = YES;
    self.lineChart.yLabelColor = [UIColor colorWithHexString:@"#313131"];
    self.lineChart.axisColor = [UIColor colorWithHexString:@"#959595"];
    self.lineChart.shadowColor = YES;
    self.lineChart.shadowColorArray = @[[UIColor yellowColor],
                                        [UIColor redColor],
                                        [UIColor blueColor]
                                        ];
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    self.lineChartDataArray = @[@"212", @"345", @"34", @"32", @"58", @"21", @"90"
                                ];
    NSArray *trueArray = [self getTrueArrayWithArray:self.lineChartDataArray];
    NSArray *YLabelsTitleArray = [self getYLabelsTitleArrayWithArray:self.lineChartDataArray];
    
    [self.lineChart setYLabels:YLabelsTitleArray];
    self.lineChart.yFixedValueMax = [[self getMaxValueWithArray:YLabelsTitleArray] floatValue];
    self.lineChart.yFixedValueMin = 0.0f;
    
    // Line Chart #1 设置波线数据
    NSArray * data01Array = [NSArray arrayWithArray:trueArray];
    // 终点数值
    self.lineChart.lastPointValue = [NSString stringWithFormat:@"%.0f", [[NSString stringWithFormat:@"%@", self.lineChartDataArray.lastObject] floatValue]];
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor colorWithRed:255./255.f green:97./255.f blue:0 alpha:1];
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleNone;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01];
    [self.lineChart strokeChart];
    // 设置代理
    self.lineChart.delegate = self;
    [self.lineChartBGView addSubview:self.lineChart];
    
}

- (NSString *)getMaxValueWithArray:(NSArray *)array
{
    /*
     //block比较方法，数组中可以是NSInteger，NSString（需要转换）
     NSComparator finderSort = ^(id string1,id string2){
     
     if ([string1 integerValue] > [string2 integerValue]) {
     return (NSComparisonResult)NSOrderedDescending;
     }else if ([string1 integerValue] < [string2 integerValue]){
     return (NSComparisonResult)NSOrderedAscending;
     }
     else
     return (NSComparisonResult)NSOrderedSame;
     };
     //数组排序
     NSArray *resultArray = [array sortedArrayUsingComparator:finderSort];
     NSString *maxStr = resultArray.lastObject;
     // 判断位数
     CGFloat flt = [maxStr floatValue];
     //    NSLog(@"原数值: %f", flt1);
     int count = 0;
     while (flt > 10.0) {
     count = count + 1;
     flt = flt / 10;
     }
     
     int fitCount = 0;
     switch (count) {
     case 0:
     fitCount = 0;
     break;
     case 1:
     fitCount = 0;
     break;
     case 2:
     fitCount = 0;
     break;
     case 3:
     fitCount = 3;
     break;
     default:
     fitCount = 0;
     break;
     }
     NSMutableArray *minArray = [NSMutableArray array];
     for (NSString *item in array) {
     CGFloat flt = [item floatValue] / pow(10, fitCount);
     NSString *string = [NSString stringWithFormat:@"%.2f",flt];
     [minArray addObject:string];
     }
     // 转换后数组排序
     NSArray *minResultArray = [minArray sortedArrayUsingComparator:finderSort];
     NSString *maxString = [NSString stringWithFormat:@"%@", minResultArray.lastObject];
     return maxString;
     */
    
    if ([array.lastObject rangeOfString:@"k"].location != NSNotFound) {
        NSArray *cutArray = [array.lastObject componentsSeparatedByString:@"k"];
        return cutArray.firstObject;
    } else {
        return array.lastObject;
    }
    
}

- (NSArray *)getTrueArrayWithArray:(NSArray *)array
{
    //block比较方法，数组中可以是NSInteger，NSString（需要转换）
    NSComparator finderSort = ^(id string1,id string2){
        
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    //数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:finderSort];
    NSString *maxStr = resultArray.lastObject;
    // 判断位数
    CGFloat flt = [maxStr floatValue];
    //    NSLog(@"原数值: %f", flt1);
    int count = 0;
    while (flt > 10.0) {
        count = count + 1;
        flt = flt / 10;
    }
    //    NSLog(@"位数: %d", count);
    /*
     //    switch (count) {
     //        case 0: {
     //            return array;
     //            break;
     //        }
     //        case 1: {
     //            return array;
     //            break;
     //        }
     //        case 2: {
     //            return array;
     //            break;
     //        }
     //        case 3: {
     //            for (<#type *object#> in <#collection#>) {
     //                <#statements#>
     //            }
     //            return array;
     //            break;
     //        }
     //        default: {
     //            return array;
     //            break;
     //        }
     //    }
     */
    
    int fitCount = 0;
    switch (count) {
        case 0:
            fitCount = 0;
            break;
        case 1:
            fitCount = 0;
            break;
        case 2:
            fitCount = 0;
            break;
        case 3:
            fitCount = 3;
            break;
        default:
            fitCount = 0;
            break;
    }
    NSMutableArray *minArray = [NSMutableArray array];
    for (NSString *item in array) {
        CGFloat flt = [item floatValue] / pow(10, fitCount);
        NSString *string = [NSString stringWithFormat:@"%.2f",flt];
        [minArray addObject:string];
    }
    return minArray;
    
}


- (NSArray *)getYLabelsTitleArrayWithArray:(NSArray *)array
{
    //block比较方法，数组中可以是NSInteger，NSString（需要转换）
    NSComparator finderSort = ^(id string1,id string2){
        
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    //数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:finderSort];
    NSString *maxStr = resultArray.lastObject;
    // 判断位数
    CGFloat flt = [maxStr floatValue];
    //    NSLog(@"最大值:  %f", flt);
    if (flt > 10000.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"10k", @"20k", @"30k", @"40k", @"50k"];
        return YLabelsTitleArray;
    } else if (5000.f < flt && flt <= 10000.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"2k", @"4k", @"6k", @"8k", @"10k"];
        return YLabelsTitleArray;
    } else if (1000.f < flt && flt <= 5000.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"1k", @"2k", @"3k", @"4k", @"5k"];
        return YLabelsTitleArray;
    } else if (500.f < flt && flt <= 1000.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"200", @"400", @"600", @"800", @"1000"];
        return YLabelsTitleArray;
    } else if (100.f < flt && flt <= 500.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"100", @"200", @"300", @"400", @"500"];
        return YLabelsTitleArray;
    } else if (50.f < flt && flt <= 100.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"20", @"40", @"60", @"80", @"100"];
        return YLabelsTitleArray;
    } else if (10.f < flt && flt <= 50.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"10", @"20", @"30", @"40", @"50"];
        return YLabelsTitleArray;
    } else if (0.f < flt && flt <= 10.f) {
        NSArray *YLabelsTitleArray = @[@"0", @"2", @"4", @"6", @"8", @"10"];
        return YLabelsTitleArray;
    } else {
        NSArray *YLabelsTitleArray = @[@"0", @"", @"", @"", @"", @""];
        return YLabelsTitleArray;
    }
    
}
#pragma mark -- 波线图线点击代理事件
- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}
#pragma mark -- 波线图折点点击代理事件
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}




@end
