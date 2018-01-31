//
//  AddBankCardViewController.m
//  futures
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "AddBankViewController.h"
@interface AddBankCardViewController ()

@end

@implementation AddBankCardViewController
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
    [self.bankCardButton addSubview:self.label1];
    [self.bankCardButton addSubview:self.label2];
    [self.bankCardButton addSubview:self.label3];
    [self.bankCardButton addSubview:self.label1];
    [self.bankCardButton addSubview:self.label2];
    [self.bankCardButton addSubview:self.label3];
    [self.view addSubview:self.button1];
    [self getData];
}
-(void)getData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
    NSString * url1 = [NSString stringWithFormat:@"%@/api/money/getBankInfo.json",codeUrl4];
    
    NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY]};
    
    //3.请求
    [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * NsCode = responseObject[@"code"];
        
        
        NSLog(@"%@",responseObject);
        
        
        if ([NsCode isEqualToString:@"0"]) {
            NSString * string = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bank_name"]];
            self.label1.text = [NSString stringWithFormat:@"%@",string];
            NSString * string1 = [NSString stringWithFormat:@"********%@",responseObject[@"data"][@"card_no"]];
            
          string1 = [string1 substringFromIndex:string1.length - 4];
            self.label3.text = [NSString stringWithFormat:@"**** **** **** %@",string1];
            
            
        }else if ([NsCode isEqualToString:@"1"]){
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            [WKProgressHUD popMessage:responseObject[@"errMsg"] inView:window duration:1.0 animated:YES];
            
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"======%@", error);
        
        
    }];

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
-(UIButton *)bankCardButton{
    
    if (!_bankCardButton) {
        _bankCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _bankCardButton.frame = CGRectMake(15, 15, screenW-30, (screenW-30)*0.6);
        [_bankCardButton setBackgroundImage:[UIImage imageNamed:@"已添加"] forState:0];
//        [_bankCardButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _bankCardButton.userInteractionEnabled = NO;
    }
    
    return _bankCardButton;
}

-(void)buttonClick:(UIButton *)button{
    AddBankViewController * addbank = [[AddBankViewController alloc] init];
    addbank.hidesBottomBarWhenPushed = YES;
    addbank.type = @"2";
    [self.navigationController pushViewController:addbank animated:YES];
    
    
}
-(UILabel *)label1{

    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.frame = CGRectMake(25, 20, screenW-40, 20);
//        _label1.text = @"中国工商银行";
        _label1.textColor = UIColorFromRGB(0xffffff);
        _label1.font = [UIFont systemFontOfSize:18];
    }
    
    return _label1;
}
-(UILabel *)label2{
    
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.frame = CGRectMake(25, 50, screenW-40, 20);
        _label2.text = @"储蓄卡";
        _label2.textColor = UIColorFromRGB(0xc5bee3);
        _label2.font = [UIFont systemFontOfSize:14];
    }
    
    return _label2;
}
-(UILabel *)label3{
    
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.frame = CGRectMake(25, 120, screenW-40, 20);
        _label3.text = @"**** **** **** 1234";
        _label3.textColor = UIColorFromRGB(0xffffff);
        _label3.font = [UIFont systemFontOfSize:20];
    }
    
    return _label3;
}
-(UIButton *)button1{
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button1.frame = CGRectMake(15, screenH-10-64-40-50,screenW-30 , 50);
        [_button1 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        _button1.backgroundColor = [UIColor clearColor];
        [_button1 setTitle:@"修改银行卡" forState:0];
        [_button1.layer setMasksToBounds:YES];
        _button1.layer.cornerRadius = 6;
        _button1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button1;
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
