//
//  AppStatus.h
//  styler
//
//  Created by System Administrator on 13-5-13.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface AppStatus : NSObject<NSCoding>

@property (nonatomic, strong) NSString *currentLocation;
@property AFNetworkReachabilityStatus networkStatus;
@property (nonatomic, strong) NSString *deviceToken;
@property double lastLat;//纬度
@property double lastLng;//经度
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic ,strong) NSString *targetNum;
@property (nonatomic, strong) NSString *apiUrl;
@property (nonatomic, retain) NSString *searcherUrl;
@property (nonatomic, retain) NSString *cmsUrl;
@property (nonatomic, strong) NSString *wxpubUrl;
@property (nonatomic ,strong) NSString *hostUrl;
@property (nonatomic, retain) NSString *env;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gameBlockIds;

@property (nonatomic ,strong) NSString *remarkDataStr;
@property (nonatomic ,strong) NSString *acupointName;

@property (nonatomic ,strong) NSString *recommendAcupointTime;

@property (nonatomic ,assign) BOOL noRemind;
@property (nonatomic ,assign) BOOL isComplete;

@property (nonatomic, assign) BOOL defaultSwitch;
@property (nonatomic, assign) BOOL customSwitch;

@property (nonatomic, strong) NSString *umengAppKey;
@property (nonatomic, strong) NSString *paymentUrl;
@property (nonatomic, strong) NSString *umengPushAppKey;

@property (nonatomic, strong) NSDate *saveDate;

@property (nonatomic, assign) int didIndexPathRow;

@property (nonatomic ,strong) NSMutableArray *recentCityArray;
@property (nonatomic ,strong) NSMutableDictionary *recentCityDicy;

@property (nonatomic ,strong) NSMutableDictionary *meridianDict;


@property (nonatomic, retain) NSMutableSet *hasReadArticleIds;


-(BOOL) isConnetInternet;
-(float) iosVersion;
-(NSString *) appVersion;
-(BOOL) logined;

+(void) saveAppStatus;

-(void) removeCrazyDoctorUA;
-(void) setCrazyDoctorUA;

+ (AppStatus *) sharedInstance;

+ (NSString *) savedPath;

-(NSString *) ua;
-(void) initBaseData;

-(float) getLastLat;
-(float) getLastLng;

- (void)addRecentCity:(NSString *)recentCity;
- (BOOL)hasAddRecentCity:(NSString *)recentCity;
-(void) removeRecentCity:(NSString *)city;


- (void)addRecentCityArray:(NSString *)recentCity;
-(void) removeRecentCityArray:(NSString *)city;
- (BOOL)hasAddRecentCityArray:(NSString *)recentCity;



-(void) addHasReadArticle:(int)recommendId;
-(BOOL) hasReadAddArticle:(int)recommendId;


@end
