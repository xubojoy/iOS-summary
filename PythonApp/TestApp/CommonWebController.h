//
//  CommonWebController.h
//  TestApp
//
//  Created by xubojoy on 2017/5/15.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface CommonWebController : UIViewController<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic ,strong) WKWebView *wkwebView;

@end
