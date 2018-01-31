//
//  PrepaidCashWithdrawalViewController.m
//  futures
//
//  Created by apple on 17/9/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PrepaidCashWithdrawalViewController.h"
#import "RechargeViewController.h"
#import "WithdrawalsViewController.h"
#import "BankCardViewController.h"
#import "BankCardViewController.h"
#import "AddBankCardViewController.h"
@interface PrepaidCashWithdrawalViewController ()
{
    
    RechargeViewController *_oneVC;
    WithdrawalsViewController *_twoVC;
    
}
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation PrepaidCashWithdrawalViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNator];
  
    _oneVC = [[RechargeViewController alloc] init];
    _oneVC.view.frame = CGRectMake(0, 0, screenW, screenH);
    
    //    _oneVC.sign = @"1";
    //    _oneVC.view.backgroundColor = [UIColor redColor];
    _twoVC = [[WithdrawalsViewController alloc] init];
    _twoVC.view.frame = CGRectMake(0, 0, screenW, screenH);
    
    [self addChildViewController:_oneVC];
    [self addChildViewController:_twoVC];
    
    if ([_type isEqualToString:@"1"]) {
        [_button1 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [_button2 setTitleColor:UIColorFromRGB(0x222222) forState:0];
        self.label1.hidden = YES;
        self.label2.hidden = NO;
    [self.view addSubview:_twoVC.view];
    }else{
        [_button1 setTitleColor:UIColorFromRGB(0x222222) forState:0];
        [_button2 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        self.label1.hidden = NO;
        self.label2.hidden = YES;
     [self.view addSubview:_oneVC.view];
    }
   
   
}
#pragma mark - 创建导航栏
-(void)createNator{
    //    登陆label
    
    self.navigationItem.titleView = self.bglabel;
 
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
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"银行卡"] forState:UIControlStateNormal];
    //    添加点击事件
    [rightButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 22, 15);
    UIBarButtonItem *rightItemCustom = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItemCustom;
    
    
    [self.bglabel addSubview:self.button1];
    [self.bglabel addSubview:self.button2];
    [self.button1 addSubview:self.label1];
    [self.button2 addSubview:self.label2];
    
    
}
-(void)buttonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)buttonAction{
//    BankCardViewController * bank = [[BankCardViewController alloc] init];
//    bank.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:bank animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
    NSString * url1 = [NSString stringWithFormat:@"%@/api/money/getBankInfo.json",codeUrl4];
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY]};
    
    //3.请求
    [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * NsCode = responseObject[@"code"];
        
        
        NSLog(@"%@",responseObject);
        
        NSDictionary * dic = responseObject[@"data"];
        if ([NsCode isEqualToString:@"0"]) {
            
            if (dic.count == 0) {
                
                BankCardViewController * ban = [[BankCardViewController alloc] init];
                ban.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ban animated:YES];
                
                
            }else{
                
              
                AddBankCardViewController * ban = [[AddBankCardViewController alloc] init];
                ban.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ban animated:YES];
                
                
            }
            
        }else if ([NsCode isEqualToString:@"1"]){
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            [WKProgressHUD popMessage:responseObject[@"errMsg"] inView:window duration:1.0 animated:YES];
            
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"======%@", error);
        
        
    }];

}
-(UIImageView *)bglabel{

    if (!_bglabel) {
        _bglabel = [[UIImageView alloc] init];
        _bglabel.frame = CGRectMake(0, 0, 200, 42);
        _bglabel.backgroundColor = [UIColor whiteColor];
        _bglabel.userInteractionEnabled = YES;
    }
    
    return _bglabel;
}
-(UIButton *)button1{

    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button1.frame = CGRectMake(0, 0, 100, 42);
        [_button1 setTitle:@"充值" forState:0];
        [_button1 setTitleColor:UIColorFromRGB(0x222222) forState:0];
        [_button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _button1.titleLabel.font = [UIFont systemFontOfSize:18];
        
    }
    
    return _button1;
}
-(UIButton *)button2{
    
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button2.frame = CGRectMake(100, 0, 100, 42);
        [_button2 setTitle:@"提现" forState:0];
        [_button2 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [_button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
         _button2.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _button2;
}
-(UILabel *)label1{

    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.frame = CGRectMake(30, 39, 40, 3);
        _label1.backgroundColor = UIColorFromRGB(0x222222);
        _label1.hidden = NO;
    }
    
    return _label1;
}
-(UILabel *)label2{
    
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.frame = CGRectMake(30, 39, 40, 3);
        _label2.backgroundColor = UIColorFromRGB(0x222222);
        _label2.hidden = YES;
    }
    
    return _label2;
}
-(void)buttonClick:(UIButton *)button{
    
    if (button == self.button1) {
       [_button1 setTitleColor:UIColorFromRGB(0x222222) forState:0];
         [_button2 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        self.label1.hidden = NO;
        self.label2.hidden = YES;
        [self.view addSubview:_oneVC.view];
        [_twoVC.view removeFromSuperview];
    }else if (button == self.button2){
        [_button1 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [_button2 setTitleColor:UIColorFromRGB(0x222222) forState:0];
        self.label1.hidden = YES;
        self.label2.hidden = NO;
        [self.view addSubview:_twoVC.view];
        [_oneVC.view removeFromSuperview];
    
    }


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
