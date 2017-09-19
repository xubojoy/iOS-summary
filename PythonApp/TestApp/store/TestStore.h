//
//  TestStore.h
//  TestApp
//
//  Created by xubojoy on 2017/5/12.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSInteger, CYLSex){
//    CYLSexMan,
//    CYLSexWoman
//};

typedef enum : NSUInteger {
    CYLSexMan,
    CYLSexWoman,
} CYLSex;

@interface TestStore : NSObject
+ (void)getTestData:(void(^)(NSDictionary *flagDict ,NSError *error))completionBlock;
@end
