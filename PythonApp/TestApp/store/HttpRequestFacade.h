//
//  HttpRequestFacade.h
//  TestApp
//
//  Created by xubojoy on 2017/5/12.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequestFacade : NSObject
-(void)             get:(NSString *)urlStr
        completionBlock:(void (^)(id json, NSError *err))completionBlock
                refresh:(BOOL)refresh
  useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail;

-(void)           doGet:(NSURL *)url
        completionBlock:(void (^)(id json, NSError *err))completionBlock
                refresh:(BOOL)refresh
  useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail;

-(void)           doIOSGet:(NSURL *)url
           completionBlock:(void (^)(id json, NSError *err))completionBlock
                   refresh:(BOOL)refresh
     useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail;


-(void)          post:(NSString *)urlStr
      completionBlock:(void (^)(id json, NSError *err))completionBlock
         commonParams:(NSDictionary *)params;

-(void)          post:(NSString *)urlStr
      completionBlock:(void (^)(id json, NSError *err))comletionBlock
               params:(NSDictionary *)params;

-(void)          post:(NSString *)urlStr
      completionBlock:(void (^)(id json, NSError *err))completionBlock
           jsonString:(NSDictionary *)jsonString;

-(void)        delete:(NSString *)urlStr
completionBlock:(void (^)(id json, NSError *err))completionBlock
param:(NSDictionary *)param;

-(void)        put:(NSString *)urlStr
   completionBlock:(void (^)(id json, NSError *err))completionBlock;

-(void)        put:(NSString *)urlStr
   completionBlock:(void (^)(id json, NSError *err))completionBlock
            params:(NSDictionary *)params;


+(HttpRequestFacade *)sharedInstance;
@end
