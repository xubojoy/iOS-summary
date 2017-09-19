//
//  PointView.h
//  Golf
//
//  Created by xubojoy on 2017/8/29.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define D2R(degrees) ((M_PI * degrees) / 180)

@interface TurnViewModel : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *title;

@end
@interface PointView : UIView

@property (nonatomic, strong) NSArray<TurnViewModel *> *luckyItemArray;

-(void)rotationAnimation;

- (void)startRotationWithEndValue:(CGFloat)endValue startValue:(CGFloat)startValue round:(NSInteger)round;

@end
