//
//  AppStatus.m
//  ios_test_01
//
//  Created by xubojoy on 2017/3/31.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "AppStatus.h"

@implementation AppStatus
static AppStatus *sharedInstance = nil;
+ (AppStatus *)sharedInstance{
    NSString *path = [AppStatus savePath];
    sharedInstance = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInt:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntForKey:@"age"];
    }
    return self;
}

+ (void)saveAppStatus{
    NSLog(@">>>>>>>数据存储>>>>>>>%@",[AppStatus sharedInstance].description);
    [NSKeyedArchiver archiveRootObject:[AppStatus sharedInstance] toFile:[AppStatus savePath]];
}

+ (NSString *)savePath{

    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *strpath = [document stringByAppendingPathComponent:@"user.plist"];
    NSLog(@">>>>>>>>>>>>>>%@",strpath);
    return strpath;
    
}

@end
