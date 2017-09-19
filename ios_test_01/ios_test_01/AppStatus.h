//
//  AppStatus.h
//  ios_test_01
//
//  Created by xubojoy on 2017/3/31.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStatus : NSObject<NSCoding>

@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,assign) int age;
+ (AppStatus *)sharedInstance;
+ (void)saveAppStatus;
@end
