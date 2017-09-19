//
//  ViewController.m
//  zhuanpan
//
//  Created by xubojoy on 2017/8/29.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "ViewController.h"
#import "PointView.h"
#define kScreenRect   [[UIScreen mainScreen] bounds]
#define screen_width          [UIScreen mainScreen].bounds.size.width
#define screen_height          [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, strong) PointView *pointView;
@property (nonatomic, strong) NSMutableArray *turnViewModelArray;

@property (nonatomic, strong) UIView *xuanzhuanView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.turnViewModelArray = [NSMutableArray new];
//    [self initBGView];
//    
    
//    self.xuanzhuanView = [[UIView alloc] initWithFrame:CGRectMake((screen_width-50)/2, (screen_height-100)/2, 50, 100)];
//    self.xuanzhuanView.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:self.xuanzhuanView];
//    [self rotationAnimation];
    
    self.pointView = [[PointView alloc] initWithFrame:CGRectMake(0, 0, 120, 130)];
    self.pointView.center = CGPointMake(screen_width/2, screen_height/2);
    self.pointView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.pointView];
    [self rotationAnimation];
    
}


-(void)rotationAnimation{
    /* 旋转 */
    
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定动画选项
    animation.duration = 1; // 持续时间
    animation.repeatCount = 3; // 重复次数
    
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:6 * M_PI]; // 终止角度
    
    // 添加动画
    [self.pointView.layer addAnimation:animation forKey:@"rotate-layer"];
    
}

- (void)initBGView{

    UIImageView *zhaunpanImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-(628/2))/2, 50, 628/2, 657/2)];
    zhaunpanImgView.image = [UIImage imageNamed:@"dial"];
    zhaunpanImgView.userInteractionEnabled = YES;
    [self.view addSubview:zhaunpanImgView];
    
    NSArray *numberArray = @[@"5元",@"谢谢\n参与",@"10元",@"20元",@"50元",@"谢谢\n参与",@"100元",@"500元"];
    
    for (int i = 0; i < 8; i ++) {
        TurnViewModel *model = [[TurnViewModel alloc] init];
        model.title = [NSString stringWithFormat:@"%@", numberArray[i]];
        model.index = i+1;
        [self.turnViewModelArray addObject:model];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * 314/8,
                                                                  314/2+30)];
        label.layer.anchorPoint = CGPointMake(0.5, 1);
        label.center = CGPointMake(314/2, 314/2);
        if ((i == 1) || (i == 5)) {
            label.text = [NSString stringWithFormat:@"%@", numberArray[i]];
        }else{
            label.text = [NSString stringWithFormat:@"%@", numberArray[i]];
        }
        CGFloat angle = M_PI * 2 / 8 * i;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        label.transform = CGAffineTransformMakeRotation(angle);
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        [zhaunpanImgView addSubview:label];
        
    }
    self.pointView.luckyItemArray = self.turnViewModelArray;
    
    self.pointView = [[PointView alloc] initWithFrame:CGRectMake(0, 0, 240/2, 260/2)];
    self.pointView.center = CGPointMake(screen_width/2, 314/2+50);
    self.pointView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.pointView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((screen_width-60)/2, 50+(314-60)/2, 60, 60);
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)btnClick{
    NSLog(@">>>>>>>>>>点击");
//    - ((360.0 / count)/2 )* index + (360.0 / count) / 2
    NSInteger index = arc4random() % 8 + 1;
    NSLog(@">>>>index>>>>>%d",(int)index);
    if (index >=1 && index <= self.turnViewModelArray.count) {
        CGFloat count = self.turnViewModelArray.count;
        CGFloat angle4Rotate = (360 + 270)+90 + (360/count)*(index-1);// 以 π*3/2 为终点, 加多一圈以防反转, 默认顺时针
        if (angle4Rotate > 360){
            angle4Rotate -= 360;
        }
        NSLog(@">>>>angle4Rotate>>>>>%f",angle4Rotate);
        CGFloat radians = D2R(angle4Rotate);
        CGFloat startRadians = D2R(360+270);
        NSLog(@">>>>radians>>>>>%f",radians);
        [self.pointView startRotationWithEndValue:radians startValue:startRadians round:3];
    }
    
    

}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
