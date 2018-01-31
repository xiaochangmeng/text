//
//  BankCardViewController.m
//  futures
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BankCardViewController.h"
#import "AddBankCardViewController.h"
#import "AddBankViewController.h"
@interface BankCardViewController ()

@end

@implementation BankCardViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNator];
    [self.view addSubview:self.bankCardButton];
}
#pragma mark - 创建导航栏
-(void)createNator{
    //    登陆label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"银行卡";
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    //    设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nabg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    //    导航栏左边按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    添加点击事件
    [leftButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, 22, 22);
    UIBarButtonItem *leftItemCustom = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItemCustom;
    
    
    
    
    
    
}
-(void)buttonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)bankCardButton{

    if (!_bankCardButton) {
        _bankCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _bankCardButton.frame = CGRectMake(15, 15, screenW-30, (screenW-30)*0.6);
        [_bankCardButton setBackgroundImage:[UIImage imageNamed:@"9-银行卡-未添加"] forState:0];
        [_bankCardButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bankCardButton;
}
-(void)buttonClick:(UIButton *)button{
//    AddBankCardViewController * addBank = [[AddBankCardViewController alloc] init];
//    addBank.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:addBank animated:YES];
    AddBankViewController * addbank = [[AddBankViewController alloc] init];
    addbank.hidesBottomBarWhenPushed = YES;
    addbank.type = @"1";
    [self.navigationController pushViewController:addbank animated:YES];

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
