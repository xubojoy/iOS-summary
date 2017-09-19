//
//  PointView.m
//  Golf
//
//  Created by xubojoy on 2017/8/29.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "PointView.h"
@import CoreGraphics;

@implementation TurnViewModel
@end

@interface PointView ()<CAAnimationDelegate>
@property (nonatomic, assign) CGFloat startValue;//default = 0

@end

//static CGPoint pointAroundCircumference(CGPoint center, CGFloat radius, CGFloat theta);

@implementation PointView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetups];
    }
    return self;
}

#pragma mark - Preparations

// 这些可当做属性设置 也可以 IB_DESIGNABLE 这里就没做了
- (void)defaultSetups{
//    UIImageView *image_start = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start_lottery"]];
//    image_start.frame = CGRectMake(0, 0, 120, 130);
//    image_start.userInteractionEnabled = YES;
//    [self addSubview:image_start];
}

- (void)setLuckyItemArray:(NSArray<TurnViewModel *> *)luckyItemArray{
    
    _luckyItemArray = luckyItemArray;
    [self setNeedsDisplay];
}

#pragma mark - Public Methods

- (void)startRotationWithEndValue:(CGFloat)endValue{
    
//    [self startRotationWithEndValue:endValue round:0];
}

- (void)startRotationWithEndValue:(CGFloat)endValue startValue:(CGFloat)startValue round:(NSInteger)round{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.delegate = self;
    
//    animation.fromValue = @(startValue);
    animation.toValue = @(endValue);// default is 6 * M_PI
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"rotate-layer"];
//    _startValue = round ? (endValue - 2*M_PI*round) : 0;
}


-(void)rotationAnimation{
    /* 旋转 */
    
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定动画选项
    animation.duration = 2.5; // 持续时间
    animation.repeatCount = 3; // 重复次数
    
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:6 * M_PI]; // 终止角度
    
    // 添加动画
    [self.layer addAnimation:animation forKey:@"rotate-layer"];

}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@">>>>>>>>>>>>>旋转停止");
//    [self backToStartPosition];
}

/**
 指针返回初始位置
 */
- (void)backToStartPosition {
    CABasicAnimation *layer = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    layer.toValue = @(0);
    layer.duration = 0.01;
    layer.removedOnCompletion = NO;
    layer.fillMode = kCAFillModeForwards;
    layer.beginTime = CACurrentMediaTime() + 2; //延迟1S后执行
    
    [self.layer addAnimation:layer forKey:nil];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
