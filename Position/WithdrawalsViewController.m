//
//  WithdrawalsViewController.m
//  futures
//
//  Created by apple on 17/9/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WithdrawalsViewController.h"
#import "LoginViewController.h"
#import "AddBankViewController.h"

@interface WithdrawalsViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property(nonatomic,strong)UIAlertView * alert;
@end

@implementation WithdrawalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH-64)];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.label1];
    [self.tableView addSubview:self.label2];
    [self.tableView addSubview:self.label3];
    [self.tableView addSubview:self.label4];
    [self.tableView addSubview:self.grayLabel1];
    [self.tableView addSubview:self.rechTextFile];
    [self.tableView addSubview:self.grayLabel2];
    [self.tableView addSubview:self.label5];
    [self.tableView addSubview:self.button1];
//    [self.tableView addSubview:self.label6];
    [self getHData];
    [self getHDataOne];
}
-(void)getHData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
    NSString * url1 = [NSString stringWithFormat:@"%@/api/money/payment.json",codeUrl4];
    
    NSDictionary * dict = @{@"type":@"2"};
    
    //3.请求
    [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * NsCode = responseObject[@"code"];
        
        
        NSLog(@"%@",responseObject);
        
        
        if ([NsCode isEqualToString:@"0"]) {
            
            //          self.label5.text = @"6.5297";
             self.label5.text = [NSString stringWithFormat:@"当前汇率：1美元=%@人民币",responseObject[@"data"][@"payment"]];
           
            
        }else if ([NsCode isEqualToString:@"1"]){
            
            
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"======%@", error);
        
        
    }];
    
    
}
-(void)getHDataOne{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
    NSString * url1 = [NSString stringWithFormat:@"%@/api/money/withdrawMoney.json",codeUrl4];
    
    NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY]};
    
    //3.请求
    [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * NsCode = responseObject[@"code"];
        
        
        NSLog(@"%@",responseObject);
        
        
        if ([NsCode isEqualToString:@"0"]) {
            
            //          self.label5.text = @"6.5297";
          
            self.label2.text = [NSString stringWithFormat:@"$%@",responseObject[@"data"][@"amount"]];
            
        }else if ([NsCode isEqualToString:@"1"]){
            self.label2.text = [NSString stringWithFormat:@"$%@",@"0.00"];
//            UIWindow * window = [UIApplication sharedApplication].keyWindow;
//            
//            [WKProgressHUD popMessage:responseObject[@"errMsg"] inView:window duration:1.0 animated:YES];
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"======%@", error);
        
        
    }];
    
    
}
-(UILabel *)label1{
    
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.frame = CGRectMake(15, 0, 100, 80);
        _label1.text = @"提现账户";
        _label1.font = [UIFont systemFontOfSize:15];
        _label1.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label1;
}
-(UILabel *)label2{
    
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.frame = CGRectMake(99, 20, 150, 20);
        _label2.text = @"$--";
        _label2.font = [UIFont systemFontOfSize:18];
        _label2.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label2;
}
-(UILabel *)label3{
    
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.frame = CGRectMake(99, 40, 175, 20);
        _label3.text = @"当前可提现总额";
        _label3.font = [UIFont systemFontOfSize:12];
        _label3.textColor = UIColorFromRGB(0x999999);
    }
    
    return _label3;
}
-(UILabel *)grayLabel1{
    
    if (!_grayLabel1) {
        _grayLabel1 = [[UILabel alloc] init];
        _grayLabel1.frame = CGRectMake(0, 80, screenW, 1);
        _grayLabel1.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _grayLabel1;
}
-(UILabel *)label4{
    
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        _label4.frame = CGRectMake(15, CGRectGetMaxY(self.grayLabel1.frame), 100, 80);
        _label4.text = @"提现金额      $";
        _label4.font = [UIFont systemFontOfSize:15];
        _label4.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label4;
}
-(UITextField *)rechTextFile{
    
    if (!_rechTextFile) {
        _rechTextFile = [[UITextField alloc] init];
        _rechTextFile.frame = CGRectMake(115, CGRectGetMaxY(self.grayLabel1.frame), 200, 80);
        _rechTextFile.font = [UIFont systemFontOfSize:15];
        _rechTextFile.textColor = UIColorFromRGB(0x727171);
        //        _telTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _rechTextFile.placeholder = @"最低20.0美元";
        _rechTextFile.returnKeyType = UIReturnKeyNext;
        _rechTextFile.keyboardType = UIKeyboardTypeNumberPad;
        
        // 2、设置成为代理
        _rechTextFile.delegate = self;
    }
    return _rechTextFile;
}
-(UILabel *)grayLabel2{
    
    if (!_grayLabel2) {
        _grayLabel2 = [[UILabel alloc] init];
        _grayLabel2.frame = CGRectMake(0, CGRectGetMaxY(self.rechTextFile.frame), screenW, 1);
        _grayLabel2.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _grayLabel2;
}
-(UILabel *)label5{
    if (!_label5) {
        _label5 = [[UILabel alloc] init];
        _label5.frame = CGRectMake(15, CGRectGetMaxY(self.grayLabel2.frame), 200, 40);
        _label5.text = @"当前汇率：1美元=6.5297人民币";
        _label5.font = [UIFont systemFontOfSize:12];
        _label5.textColor = UIColorFromRGB(0xcccccc);
    }
    
    return _label5;
    
}
-(UIButton *)button1{
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button1.frame = CGRectMake(15, CGRectGetMaxY(self.label5.frame)+20, screenW-30, 50);
        _button1.backgroundColor = UIColorFromRGB(0xeaeaea);
        [_button1 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [_button1 setTitle:@"下一步" forState:0];
        _button1.userInteractionEnabled = NO;
        [_button1.layer setMasksToBounds:YES];
        _button1.layer.cornerRadius = 2;
        [_button1 addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _button1;
}
-(UILabel *)label6{
    if (!_label6) {
        _label6 = [[UILabel alloc] init];
        _label6.frame = CGRectMake(15, screenH-64-60-50, screenW-30, 50);
        _label6.text = @"提示：手机端充值最低限额$50.00，每天最高限额$7000.00，充值成功后，到账时间约10分钟，请耐心等待。";
        _label6.font = [UIFont systemFontOfSize:12];
        _label6.textColor = UIColorFromRGB(0xcccccc);
        _label6.numberOfLines = 2;
    }
    
    return _label6;
    
}
-(void)loginButtonClick:(UIButton *)button{
    if ([_rechTextFile.text intValue] >= 20) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:USER_NAME_KEY] == nil) {
            LoginViewController * DSV = [[LoginViewController alloc] init];
            
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:DSV];
            
            //        DSV.bj = @"1";
            [self presentViewController:nav animated:YES completion:nil];
            
        }else{
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
            NSString * url1 = [NSString stringWithFormat:@"%@/api/money/getBankInfo.json",codeUrl4];
            
            NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY]};
            
            //3.请求
            [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString * NsCode = responseObject[@"code"];
                
                
                NSLog(@"%@",responseObject);
                
                NSDictionary * dic = responseObject[@"data"];
                if ([NsCode isEqualToString:@"0"]) {
                    
                    if (dic.count == 0) {
                        
                        
                        _alert = [[UIAlertView alloc] initWithTitle:@"添加银行卡信息即可提现" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"添加" ,nil];
                        [_alert show];
                        
                      
                       
                        
                    }else{
                        
                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
                        NSString * url1 = [NSString stringWithFormat:@"%@/api/money/withdraw.json",codeUrl4];
                        
                        NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY],@"bankName":responseObject[@"data"][@"bank_name"],@"bankAddr":responseObject[@"data"][@"bank_addr"],@"card":responseObject[@"data"][@"card_no"],@"province":responseObject[@"data"][@"province"],@"city":responseObject[@"data"][@"city"],@"amount":_rechTextFile.text};
                        
                        NSLog(@"%@",dict);
                        
                        //3.请求
                        [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            NSString * NsCode = responseObject[@"code"];
                            
                            
                            NSLog(@"%@",responseObject);
                            
                            
                            if ([NsCode isEqualToString:@"0"]) {
                                
//                                UIWindow * window = [UIApplication sharedApplication].keyWindow;
//                                [WKProgressHUD popMessage:@"提现成功" inView:window duration:1.0 animated:YES];
                         UIAlertView * alerView =  [[UIAlertView alloc] initWithTitle:@"提现申请已提交" message:@"请稍后留意您的银行到账情况" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                [alerView show];
                            }else if ([NsCode isEqualToString:@"1"]){
                                UIWindow * window = [UIApplication sharedApplication].keyWindow;
                                [WKProgressHUD popMessage:responseObject[@"errMsg"] inView:window duration:1.0 animated:YES];
                                
                            }
                            
                        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"======%@", error);
                            
                            
                        }];
                       
                        
                    
                    }
                    
                }else if ([NsCode isEqualToString:@"1"]){
                    UIWindow * window = [UIApplication sharedApplication].keyWindow;
                    [WKProgressHUD popMessage:responseObject[@"errMsg"] inView:window duration:1.0 animated:YES];
                    
                }
                
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"======%@", error);
                
                
            }];
        }
        
        
    }else{
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [WKProgressHUD popMessage:@"最少提现金额为$20.00" inView:window duration:1.0 animated:YES];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (alertView == _alert) {
        
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            AddBankViewController * addbank = [[AddBankViewController alloc] init];
            addbank.hidesBottomBarWhenPushed = YES;
            addbank.type = @"1";
            [self.navigationController pushViewController:addbank animated:YES];
        }
        
    }
}
#pragma mark - 限制输入框输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    
    //   限制手机号为11位
    if (textField == _rechTextFile) {
        NSMutableString *mStr = [[NSMutableString alloc] initWithString:_rechTextFile.text];
        [mStr insertString:string atIndex:range.location];
        // mStr这里是已经更新的数据(屏幕中所看到的数据)
        if (mStr.length > 5) {
            return NO;
        }
        if (mStr.length > 1) {
            [_button1 setBackgroundColor:UIColorFromRGB(0xfc5662)];
            [_button1 setTitleColor:UIColorFromRGB(0xffffff) forState:0];
            _button1.userInteractionEnabled = YES;
        }else{
            //            [_loginButton setBackgroundColor:UIColorFromRGB(0x8c94a1)];
            //            _loginButton.userInteractionEnabled = NO;
            
        }
        
    }
    
    
    
    
    return YES;
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

