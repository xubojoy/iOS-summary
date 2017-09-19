//
//  ViewController.m
//  TestApp
//
//  Created by xubojoy on 2017/5/12.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "ViewController.h"
#import "TestStore.h"
#import "CommonWebController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self testData];
    [self initBtn];
    
    
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@89,@2,@22,@95,@88,@66,@43,@31,@57, nil];
    
    [self sortingForBubblingWithArray:array];
}


- (void)sortingForBubblingWithArray:(NSMutableArray *)array{
    for (int i = 0; i < array.count-1; i++) {
        for (int j = 0; j < array.count-1-i; j++) {
            if (array[j] < array[j+1]) {
//                id string = array[j];
//                array[j] = array[j+1];
//                array[j+1] = string;
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",array);
}






- (void)initBtn{
    UIButton *bigRetryBut = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 130)];
    bigRetryBut.backgroundColor = [UIColor clearColor];
    [bigRetryBut setTitle:@"数据加载" forState:UIControlStateNormal];
    [bigRetryBut.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [bigRetryBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bigRetryBut setTitleEdgeInsets:UIEdgeInsetsMake(100, -110, 0, 0)];
    [bigRetryBut setImageEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    [bigRetryBut addTarget:self action:@selector(pushWebBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bigRetryBut];
    

}

- (void)pushWebBtn{
    CommonWebController *comvc = [[CommonWebController alloc] init];
    [self.navigationController pushViewController:comvc animated:YES];
}


- (void)testData{
    [TestStore getTestData:^(NSDictionary *flagDict, NSError *error) {
        NSLog(@">>>>>>>>测试数据>>>>>>>>>%@",flagDict);
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
