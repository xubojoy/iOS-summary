//
//  TestStore.m
//  TestApp
//
//  Created by xubojoy on 2017/5/12.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "TestStore.h"
#import "HttpRequestFacade.h"
#import "AppStatus.h"
@implementation TestStore
+ (void)getTestData:(void(^)(NSDictionary *flagDict ,NSError *error))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    
    NSString *url = [NSString stringWithFormat:@"%@/snippets/",[AppStatus sharedInstance].apiUrl];
    
    NSString *encoded = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *urlStr = [NSURL URLWithString:encoded];
    [request doIOSGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>>测试json：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            completionBlock(jsonDict, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}
@end
