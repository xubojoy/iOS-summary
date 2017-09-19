//
//  XBbutton.m
//  ios_test_01
//
//  Created by xubojoy on 2017/4/21.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "XBbutton.h"

@implementation XBbutton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10,10)];
    
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 0.5;
    
    [path stroke];
}


@end
