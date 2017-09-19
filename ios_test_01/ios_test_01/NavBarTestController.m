//
//  NavBarTestController.m
//  ios_test_01
//
//  Created by xubojoy on 2017/4/14.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "NavBarTestController.h"
#import "HFStretchableTableHeaderView.h"
//#import "DLUserPageNavBar.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "DLUserHeaderView.h"
//DLUserPageNavBarDelegate
@interface NavBarTestController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property (strong, nonatomic) UITableView *tableView;
//下拉头部放大控件
@property (strong, nonatomic) HFStretchableTableHeaderView* stretchableTableHeaderView;
//导航栏的背景view
//@property (strong, nonatomic) DLUserPageNavBar *userPageNavBar;

@property (strong, nonatomic) UIView *navView;
@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation NavBarTestController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTableView];
    
}

- (void)initTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, screen_width, screen_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    self.navView.backgroundColor = [UIColor purpleColor];
    self.navView.alpha = 0;
    [self.view addSubview:self.navView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.navView addSubview:self.nameLabel];
    
    
    DLUserHeaderView *headerView = [DLUserHeaderView userHeaderView];
    headerView.frame = CGRectMake(0, 0, screen_width, screen_width  / 1.34 );
    _stretchableTableHeaderView = [HFStretchableTableHeaderView new];
    [_stretchableTableHeaderView stretchHeaderForTableView:self.tableView withView:headerView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //要减去导航栏 状态栏 以及 sectionheader的高度
    return self.view.frame.size.height-64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //下拉放大 必须实现
    [_stretchableTableHeaderView scrollViewDidScroll:scrollView];
    
    //计算导航栏的透明度
    CGFloat minAlphaOffset = 0;
    CGFloat maxAlphaOffset = screen_width  / 1.34 - 64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.navView.alpha = alpha;
    
    //根据导航栏透明度设置title
    if (alpha > 0.5) {
        self.nameLabel.text = @"name";
    } else {
        self.nameLabel.text = @"";
    }

}

#pragma mark - DLUserPageNavBarDelegate
//-(void)userPagNavBar:(DLUserPageNavBar *)navBar didClickButton:(DLUserPageButtonType)buttonType
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

//下拉放大必须实现
- (void)viewDidLayoutSubviews {
    [_stretchableTableHeaderView resizeView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
