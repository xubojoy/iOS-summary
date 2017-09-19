//
//  HttpRequestFacade.m
//  TestApp
//
//  Created by xubojoy on 2017/5/12.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "HttpRequestFacade.h"
#import "AppStatus.h"
#import "AFNetworking.h"
#define network_timeout     10

@implementation HttpRequestFacade
-(void)get:(NSString *)urlStr completionBlock:(void (^)(id json, NSError *err))completionBlock refresh:(BOOL)refresh useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [AppStatus sharedInstance].apiUrl, urlStr]];
    NSLog(@">>>>>>>>>>请求的URL>-------%@>>>>>%@",[AppStatus sharedInstance].apiUrl,url);
    [self doGet:url completionBlock:^(id json, NSError *err) {
        completionBlock(json , err);
    } refresh:refresh useCacheIfNetworkFail:useCacheIfNetworkFail];
}

-(void)doGet:(NSURL *)url completionBlock:(void (^)(id json, NSError *err))completionBlock refresh:(BOOL)refresh useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail{
    NSString *urlstr=[NSString stringWithFormat:@"%@",url];
    NSLog(@">>>>>>>>>>请求的URL>>>>>>%@",urlstr);
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua] forHTTPHeaderField:@"User-Agent"];
    if([[AppStatus sharedInstance] logined]){
        //        [operation.requestSerializer setValue:[NSString stringWithFormat:@"%@",[AppStatus sharedInstance].user.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    if (refresh) {
        [operation.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData | NSURLRequestReturnCacheDataDontLoad];
    }
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-www-form-urlencoded",@"text/html;charset=utf-8", nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    NSLog(@"请求网址  %@",urlstr);
    [operation.reachabilityManager isReachable];
    [operation GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"请求返回值——————————  %ld",(long)response.statusCode);
        int statusCode = (int)response.statusCode;
        if([self isRequestFail:statusCode]){
            completionBlock(nil, responseObject);
        }
        else{
            completionBlock(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        int statusCode = (int)response.statusCode;
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"doctor exception:%@---------------%d----%d", errorResponse,statusCode,(int)error.code);
        completionBlock(nil, error);
    }];
}

-(void)           doIOSGet:(NSURL *)url
           completionBlock:(void (^)(id json, NSError *err))completionBlock
                   refresh:(BOOL)refresh
     useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail{
    NSString *urlstr=[NSString stringWithFormat:@"%@",url];
    NSLog(@">>>>>>>>>>请求的URL>>>>>>%@",urlstr);
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua]forHTTPHeaderField:@"User-Agent"];
    if (refresh) {
        [operation.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData | NSURLRequestReturnCacheDataDontLoad];
    }
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-www-form-urlencoded",@"text/html;charset=utf-8", nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    NSLog(@"请求网址  %@",urlstr);
    [operation.reachabilityManager isReachable];
    [operation GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"请求返回值——————————  %ld",(long)response.statusCode);
        int statusCode = (int)response.statusCode;
        if([self isRequestFail:statusCode]){
            completionBlock(nil, responseObject);
        }
        else{
            completionBlock(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        completionBlock(nil,error);
        
    }];
}


-(void)post:(NSString *)urlStr completionBlock:(void (^)(id json, NSError *err))completionBlock commonParams:(NSDictionary *)params{
    //组装url
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    NSLog(@"请求网址________  %@",urlStr);
    NSLog(@"请求参数  %@",params);
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua] forHTTPHeaderField:@"User-Agent"];
    if([[AppStatus sharedInstance] logined]){
        //        [operation.requestSerializer setValue:[NSString stringWithFormat:@"%@",[AppStatus sharedInstance].user.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"multipart/form-data",@"Content-Type",@"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html", nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    [operation POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"请求成功：%ld---%@",(long)response.statusCode,responseObject);
        int statusCode = (int)response.statusCode;
        if([self isRequestFail:statusCode]){
            completionBlock(nil, responseObject);
        }
        else{
            completionBlock(responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        int statusCode = (int)response.statusCode;
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"doctor exception:%@---------------%d----%d", errorResponse,statusCode,(int)error.code);
        
        completionBlock(nil,error);
        
    }];
}

-(void)post:(NSString *)urlStr completionBlock:(void (^)(id json, NSError *err))completionBlock params:(NSDictionary *)params{
    //组装url
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    NSLog(@"请求网址________  %@",urlStr);
    NSLog(@"请求参数  %@",params);
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua] forHTTPHeaderField:@"User-Agent"];
    if([[AppStatus sharedInstance] logined]){
        //        [operation.requestSerializer setValue:[NSString stringWithFormat:@"%@",[AppStatus sharedInstance].user.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"multipart/form-data",@"Content-Type",@"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html", nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    [operation POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int paramsCount = 0;
        if(params != nil){
            NSArray *keys = [params allKeys];
            paramsCount = (int)[keys count];
            for (int i = 0 ; i < paramsCount; i++) {
                NSString *key = [keys objectAtIndex:i];
                NSLog(@"post %@:%@", key, [params objectForKey:key]);
                if([[params objectForKey:key] class] == [UIImage class]){
                    NSData *imageData = UIImageJPEGRepresentation([params objectForKey:key],0.5);
                    NSLog(@"post %@:%@---%@", key, [params objectForKey:key],imageData);
                    [formData appendPartWithFileData:imageData name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpeg"];
                }
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"请求成功：%ld",(long)response.statusCode);
        int statusCode = (int)response.statusCode;
        if([self isRequestFail:statusCode]){
            completionBlock(nil, responseObject);
        }
        else{
            completionBlock(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        //        int statusCode = (int)response.statusCode;
//        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        completionBlock(nil, error);
        
    }];
}

-(void)post:(NSString *)urlStr completionBlock:(void (^)(id json, NSError *err))completionBlock jsonString:(NSDictionary *)jsonString {
    
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua] forHTTPHeaderField:@"User-Agent"];
    if([[AppStatus sharedInstance] logined]){
        //        [operation.requestSerializer setValue:[NSString stringWithFormat:@"%@",[AppStatus sharedInstance].user.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"请求网址________  %@",urlStr);
    NSLog(@"请求参数  %@",jsonString);
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"multipart/form-data",@"Content-Type",@"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html", nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    [operation POST:urlStr parameters:jsonString progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"请求返回值——————————  %ld",(long)response.statusCode);
        int statusCode = (int)response.statusCode;
        if([self isRequestFail:statusCode]){
            
            completionBlock(nil, responseObject);
        }
        else{
            completionBlock(responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        //        int statusCode = (int)response.statusCode;
//        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        completionBlock(nil, error);
        
    }];
}

-(void)delete:(NSString *)urlStr completionBlock:(void (^)(id json, NSError *err))completionBlock param:(NSDictionary *)param{
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",[AppStatus sharedInstance].apiUrl,urlStr];
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    NSLog(@"请求网址  %@",urlstr);
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua] forHTTPHeaderField:@"User-Agent"];
    if([[AppStatus sharedInstance] logined]){
        //        [operation.requestSerializer setValue:[NSString stringWithFormat:@"%@",[AppStatus sharedInstance].user.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"multipart/form-data",@"Content-Type",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    [operation DELETE:urlstr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"请求返回值——————————  %ld",(long)response.statusCode);
        
        int statusCode = (int)response.statusCode;
        if([self isRequestFail:statusCode]){
            NSLog(@"doctor exception:%@", responseObject);
            
            completionBlock(nil, responseObject);
        }else{
            completionBlock(responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //        int statusCode = (int)response.statusCode;
//        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        completionBlock(nil, error);
    }];
}

-(void)put:(NSString *)urlStr completionBlock:(void (^)(id json, NSError *err))completionBlock{
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    NSLog(@"请求网址  %@",urlStr);
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua] forHTTPHeaderField:@"User-Agent"];
    if([[AppStatus sharedInstance] logined]){
        //        [operation.requestSerializer setValue:[NSString stringWithFormat:@"%@",[AppStatus sharedInstance].user.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"multipart/form-data",@"Content-Type",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    [operation PUT:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//        int statusCode = (int)response.statusCode;
//        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        completionBlock(nil, error);
        
    }];
}

-(void)put:(NSString *)urlStr completionBlock:(void (^)(id json, NSError *err))completionBlock params:(NSDictionary *)params{
    //组装url
    AFHTTPSessionManager *operation=[AFHTTPSessionManager manager];
    NSLog(@"请求网址________  %@",urlStr);
    NSLog(@"请求参数  %@",params);
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.requestSerializer.timeoutInterval = network_timeout;
    [operation.requestSerializer setValue:[[AppStatus sharedInstance] ua] forHTTPHeaderField:@"User-Agent"];
    if([[AppStatus sharedInstance] logined]){
        //        [operation.requestSerializer setValue:[NSString stringWithFormat:@"%@",[AppStatus sharedInstance].user.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    operation.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"multipart/form-data",@"Content-Type",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operation setResponseSerializer:responseSerializer];
    [operation PUT:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"请求返回值—————%@—————  %ld",task.response,(long)response.statusCode);
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //        int statusCode = (int)response.statusCode;
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        completionBlock(nil, errorResponse);
        
    }];
}

-(BOOL)isRequestFail:(int)statusCode{
    return (statusCode != 200 && statusCode != 201 && statusCode != 204 && statusCode != 304);
}

-(BOOL)isRequestStatusCode:(int)statusCode{
    return (statusCode == 401 || statusCode == 40001);
}

+(HttpRequestFacade *)sharedInstance{
    static HttpRequestFacade *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[super allocWithZone:nil] init];
    }
    return sharedInstance;
}

+(id) allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}


@end
