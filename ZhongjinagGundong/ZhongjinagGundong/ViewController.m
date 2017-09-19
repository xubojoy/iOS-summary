//
//  ViewController.m
//  ZhongjinagGundong
//
//  Created by xubojoy on 2017/9/13.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) CADisplayLink *displayLink;


@property (assign,nonatomic) int count;

@property (strong,nonatomic) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    //self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
   // [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                         //  forMode:NSDefaultRunLoopMode];
    [self startAnimation];
    self.dataArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    
}

- (void)startAnimation{
    NSTimeInterval period = 1.0; //设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        //在这里执行事件
        self.count ++;
        NSLog(@"----------self.count---------%d",self.count);
        //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
        //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,5秒执行一个循环则调用次数为 300,没1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
        [self.tableView setContentOffset:CGPointMake(0, ((9*50 / 600.0) * (float)self.count)) animated:NO];
        if (self.count >= 600) {
            self.count = 0;
        }
        
    });
    
    dispatch_resume(_timer);

}



//CADisplayLink 定时器 系统默认每秒调用60次
- (void) tick:(CADisplayLink *)displayLink {
    
    self.count ++;
    NSLog(@"----------self.count---------%d",self.count);
    //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
    //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,5秒执行一个循环则调用次数为 300,没1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
    [self.tableView setContentOffset:CGPointMake(0, ((9*50 / 600.0) * (float)self.count)) animated:NO];
    if (self.count >= 600) {
        self.count = 0;
    }
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width,100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *loadingIdentifier = @"loadingIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadingIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadingIdentifier];
        
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)dealloc {
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
