//
//  ViewController.m
//  ios_test_01
//
//  Created by xubojoy on 2017/3/31.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "NextViewController.h"
#import "NavBarTestController.h"
#import "AppStatus.h"
#import "XBbutton.h"
#import "NSString+NumberOfs.h"
//#import <JavaScriptCore/JavaScriptCore.h>
//#import "AppStatus.h"
//@protocol JSObjcDelegate<JSExport>//(此处为尖括号)
//- (void)callCamera;
//- (void)share:(NSString *)shareString;
//
//@end、
//JSObjcDelegate
@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
//@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@">>>>>>>>读取数据>>>>>>%@",[AppStatus sharedInstance].name);
    
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *strPath = [documentPath stringByAppendingPathComponent:@"str.plist"];
//    
//    [NSKeyedArchiver archiveRootObject:[AppStatus sharedInstance] toFile:strPath];
    
    

//
//    [name writeToFile:strPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@">>>>>>>>>>>%@",strPath);
//    
//    NSString *tmpStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@">>>>>tmpStr>>>>>>%@",tmpStr);
//    
//    
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    //写入
//    [userdefault setBool:YES forKey:@"isLogined"];
//    [userdefault synchronize];
//    
//    //读取
//    BOOL loginStatus = [userdefault boolForKey:@"isLogined"];
//    NSLog(@">>>>>loginStatus>>>>>>%@",(loginStatus==1)?@"YES":@"NO");
    
//    XBbutton *btn = [XBbutton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(50, 100, 100, 100);
////    btn.backgroundColor = [UIColor cyanColor];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    
    
//    int integerNum = 1/2;
//    int remandNum = 1%2;
//    
//    NSLog(@">>>>>>>>>>>%d-----%d",integerNum,remandNum);
    
//    NSString *nameStr = @"徐，黄世仁，王五，黄晓，阿里，黄，徐莉莉莉莉莉莉";
//    NSArray *nameArray = [nameStr componentsSeparatedByString:@"，"];
//    NSArray *result = [nameArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
////        NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
//        return [obj1 compare:obj2]; //升序
//    }];
//    
//    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@",obj);
//    }];
//    
    

    
//    int num = [self test:10];
//    NSLog(@">>>>>>没有>>>>>>>%d",num);
    
//    NSString *timeStr = @"2015-04-10";
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd";
////    formatter.timeZone = [NSTimeZone defaultTimeZone];
//    formatter.locale = [NSLocale currentLocale];
//    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
//    NSDate *date = [formatter dateFromString:timeStr];
//    // 2015-04-09 16:00:00 +0000
//    
//    
////    [NSThread exit];
////    [NSThread sleepForTimeInterval:6];
//    @synchronized (date) {
//        NSLog(@"%@", date);
//    }
//    NSThread *threed = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    [threed start];
//    [self initWebView];
    
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        
//    });
//    
//    dispatch_queue_t current = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_sync(current, ^{
//        
//    });
    
    dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(myQueue, ^{
        NSLog(@"123");
    });
    
    dispatch_async(myQueue, ^{
        NSLog(@"456");
    });
    
    dispatch_barrier_async(myQueue, ^{
        NSLog(@"789");
    });
    
    dispatch_async(myQueue, ^{
        NSLog(@"10");
    });
    
    
    
//    字符串反转
    
    
    NSString *str = @"abcdefg";
    
    NSString *fz = [NSString reverseString:str];
    NSLog(@"_________________%@",fz);
    
    
    NSString *abcd = @"abcde";
    NSMutableString *dcba = [[NSMutableString alloc] initWithCapacity:abcd.length];
    
    for (int i = (int)(abcd.length)-1 ; i >= 0 ; i--) {
        [dcba appendFormat:@"%c", [abcd characterAtIndex:i]];//注意这里返回的是char
    }
    NSLog(@"dcbae is %@", dcba);
    
    
    
    
//    NSArray *numDataArray = [str componentsSeparatedByString:@""];
//    NSLog(@"numDataArray %@", numDataArray);
//    
//    NSArray *arr = [[numDataArray reverseObjectEnumerator] allObjects];
//    
//    NSLog(@"arr %@", arr);
    
    NSInteger result = [self FibSequence2:3];
    NSLog(@"___________result_________%ld",result);
    
    
//    int total = [self totalCount:6];
    
//    NSLog(@"total-----%d",total);
    [self totalCount:4];
}

//递归实现斐波那契数列
- (NSInteger)FibSequence:(NSInteger)n {
    if (n < 2) {
        return n == 0 ? 0 : 1;
    }else {
        return [self FibSequence:n - 1] + [self FibSequence:n -2];
    }
}
//非递归实现斐波那契数列
- (NSInteger)FibSequence2:(NSInteger)n {
    if (n < 2) {
        return n == 0 ? 0 : 1;
    }else {
        NSInteger a = 0,b = 1,c = 0;
        for (int i = 0; i < n - 1; i++) {
            c = a + b;
            a = b;
            b = c;
        }
        return c;
    }
}

//按规则每次只能跨1，2，3步，下楼梯的方式
- (void)totalCount:(int)n{
    
    NSArray *array = @[@1,@2,@4];
    NSMutableArray *bigArray = [NSMutableArray new];
    [bigArray addObjectsFromArray:array];
    if (n > 3) {
        int sum = 0;
        for (NSInteger i = 0; i < n; i ++) {
            int m = (int)bigArray.count;
            if (m < n) {
                sum = [bigArray[(m-1)] intValue]+[bigArray[m-2] intValue]+[bigArray[m-3] intValue];
                [bigArray addObject:@(sum)];
            }
        }
    }
    NSLog(@">>>>>>>>bigArray>>>>>>%@",bigArray);
}


-(void) initWebView{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64)];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    self.webView.scrollView.decelerationRate = 0.8;
    
    [self.webView setDelegate:self];
    NSURL *nsurl =[NSURL URLWithString:@"http://test.golfd.cn/admin/testPay.jsp"];
    NSURLRequest *request =[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
  NSString *content = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('test').value"];
    
    NSLog(@">>>>>>>>>>>>>获取的值>>>>>>>>>>>%@",content);
    
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)inRequest   navigationType:(UIWebViewNavigationType)inType
{
    NSLog(@">>>>> to:%@", inRequest.URL);
    NSString *shareUrl = [NSString stringWithFormat:@"%@",inRequest.URL];
    NSLog(@">>>>> 结果:%@", shareUrl);
    if ([shareUrl containsString:@"weixin://wap/pay"]) {
        [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin"]];
        
    }
    
   
    return YES;
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@">>>> web load error:%@", webView.request.URL);
    
}


//- (void)btnClick{
//    NavBarTestController *nvc = [[NavBarTestController alloc] init];
//    [self.navigationController pushViewController:nvc animated:YES];
//}
//
//- (int)test:(int)num
//{
//    while (num >= 10) {
//        num = num/10 + num%10;
//    }
//    return num;
//}


//- (void)run{
//
//    NSLog(@">>>>>>>>>>线程执行");
//    NextViewController *nextvc = [[NextViewController alloc] init];
//    [self.navigationController pushViewController:nextvc animated:YES];
//}

//- (void)initWebView{
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,screen_width,screen_height)];
//    [self.webView setBackgroundColor:[UIColor purpleColor]];
//    [self.webView setOpaque:NO];
//    self.webView.scrollView.decelerationRate = 0.8;
//    [self.webView setDelegate:self];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
//    [self.view addSubview:self.webView];
//}
//
//#pragma mark - UIWebViewDelegate
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    // 获取当前页面的title
////    JSValue *shareCallback = self.jsContext[@"shareCallback"];
////    NSString *js = @"document.getElementById('shareContent').innerHTML";
////    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:js];
////    NSLog(@">>>>>>>title>>>>>>%@",title);
//    
//    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    self.jsContext[@"Toyun"] = self;
////    JSContext *content = self.jsContext;
////    NSLog(@">>>>>>>title>>>>>>%@",content);
//    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
//        context.exception = exceptionValue;
//        NSLog(@"异常信息：%@", exceptionValue);
//    };
//    
//    
//}
//
//#pragma mark - JSObjcDelegate
//
//- (void)callCamera {
//    NSLog(@"callCamera");
//    // 获取到照片之后在回调js的方法picCallback把图片传出去
//    JSValue *picCallback = self.jsContext[@"picCallback"];
//    [picCallback callWithArguments:@[@"photos"]];
//}
//
//- (void)share:(NSString *)shareString {
//    NSLog(@"share:%@", shareString);
//    // 分享成功回调js的方法shareCallback
//    JSValue *shareCallback = self.jsContext[@"shareCallback"];
//    [shareCallback callWithArguments:nil];
//}



@end
