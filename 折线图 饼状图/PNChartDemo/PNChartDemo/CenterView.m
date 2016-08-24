//
//  CenterView.m
//  EDailyPay
//
//  Created by FredChen on 15/12/14.
//  Copyright © 2015年 FrederickChen. All rights reserved.
//

#import "CenterView.h"

#define kFitValue 10
@interface CenterView ()

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *lastLabel;

@end

@implementation CenterView



- (instancetype)initWithFrame:(CGRect)frame
               firstLabelText:(NSString *)firstLabelText
                LastLabelText:(NSString *)lastLabelText
{
    self = [super initWithFrame:frame];
    if (self) {
//        // 添加第二个Label
//        self.lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.5 - kFitValue)];
//        _lastLabel.center = CGPointMake(self.center.x, self.center.y / 2 * 3 - kFitValue);
//        _lastLabel.text = lastLabelText;
////        _lastLabel.backgroundColor = [UIColor blueColor];
//        _lastLabel.textAlignment = NSTextAlignmentCenter;
//        _lastLabel.font = [UIFont systemFontOfSize:15.0f];
//        _lastLabel.textColor = [UIColor darkGrayColor];
//        [self addSubview:_lastLabel];
//        
//        // 添加第一个Label
//        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.5 - kFitValue)];
//        _firstLabel.center = CGPointMake(self.center.x, self.center.y / 2 + kFitValue);
//        _firstLabel.text = firstLabelText;
////        _firstLabel.backgroundColor = [UIColor redColor];
//        _firstLabel.textAlignment = NSTextAlignmentCenter;
//        _firstLabel.font = [UIFont boldSystemFontOfSize:20.0f];
//        _firstLabel.textColor = [UIColor grayColor];
//        [self addSubview:_firstLabel];
        
        UIImageView *centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"saver"]];
        centerImageView.frame = CGRectMake(0, 0, frame.size.width * 0.5, frame.size.height * 0.5);
        centerImageView.center = self.center;
        [self addSubview:centerImageView];
        
        
    }
    return self;
}


@end
