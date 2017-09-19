//
//  NextViewController.m
//  ios_test_01
//
//  Created by xubojoy on 2017/4/10.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "NextViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSObjcDelegate<JSExport>//(此处为尖括号)
- (void)callCamera;
- (void)share:(NSString *)shareString;

@end
@interface NextViewController ()<UIWebViewDelegate,JSObjcDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation NextViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        debugMethod();
    }
    return self;
}

- (void)loadView{
    [super loadView];
    debugMethod();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    debugMethod();
    [self initWebView];
}

- (void)initWebView{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,screen_width,screen_height)];
    [self.webView setBackgroundColor:[UIColor purpleColor]];
    [self.webView setOpaque:NO];
    self.webView.scrollView.decelerationRate = 0.8;
    [self.webView setDelegate:self];
    [self.view addSubview:self.webView];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    self.jsContext[@"Toyun"] = self;
//    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
//        context.exception = exceptionValue;
//        NSLog(@"异常信息：%@", exceptionValue);
//    };
    
}

#pragma mark - JSObjcDelegate

- (void)callCamera {
    NSLog(@"callCamera");
    // 获取到照片之后在回调js的方法picCallback把图片传出去
    JSValue *picCallback = self.jsContext[@"picCallback"];
    [picCallback callWithArguments:@[@"photos"]];
}

- (void)share:(NSString *)shareString {
    NSLog(@"share:%@", shareString);
    // 分享成功回调js的方法shareCallback
    JSValue *shareCallback = self.jsContext[@"shareCallback"];
    [shareCallback callWithArguments:nil];
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    debugMethod();
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    debugMethod();
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    debugMethod();
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    debugMethod();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    debugMethod();
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
