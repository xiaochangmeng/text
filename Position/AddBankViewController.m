//
//  AddBankViewController.m
//  futures
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddBankViewController.h"
#import "AddBankOneViewController.h"
@interface AddBankViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation AddBankViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNator];
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
     [self.tableView addSubview:self.label5];
    [self.tableView addSubview:self.rechTextFile];
    [self.tableView addSubview:self.grayLabel2];
   
    [self.tableView addSubview:self.button1];
//    [self.tableView addSubview:self.label6];
}
#pragma mark - 创建导航栏
-(void)createNator{
    //    登陆label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    if ([_type isEqualToString:@"1"]) {
        label.text = @"添加银行卡";
    }else{
         label.text = @"修改银行卡";
    }
    
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
-(UILabel *)label1{
    
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.frame = CGRectMake(15, 30, 200, 25);
        if ([_type isEqualToString:@"1"]) {
           _label1.text = @"添加银行卡";
        }else{
             _label1.text = @"修改银行卡";
        }
       
        _label1.font = [UIFont boldSystemFontOfSize:23];
        _label1.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label1;
}
-(UILabel *)label2{
    
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.frame = CGRectMake(15, 65, screenW-30, 20);
        _label2.text = @"为了您的账户安全，只能绑定持卡人的银行卡";
        _label2.font = [UIFont systemFontOfSize:12];
        _label2.textColor = UIColorFromRGB(0x999999);
    }
    
    return _label2;
}
-(UILabel *)label3{
    
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.frame = CGRectMake(15, CGRectGetMaxY(self.label2.frame)+30, 90, 60);
        _label3.text = @"持卡人";
        _label3.font = [UIFont systemFontOfSize:15];
        _label3.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label3;
}
-(UILabel *)label5{
    if (!_label5) {
        _label5 = [[UILabel alloc] init];
        _label5.frame = CGRectMake(105, CGRectGetMaxY(self.label2.frame)+30, 90, 60);
//        _label5.text = @"小可";
         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _label5.text = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:USER_NAME_KEY_REAL]];
        _label5.font = [UIFont systemFontOfSize:15];
        _label5.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label5;
    
}
-(UILabel *)grayLabel1{
    
    if (!_grayLabel1) {
        _grayLabel1 = [[UILabel alloc] init];
        _grayLabel1.frame = CGRectMake(15, CGRectGetMaxY(self.label5.frame), screenW, 1);
        _grayLabel1.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _grayLabel1;
}
-(UILabel *)label4{
    
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        _label4.frame = CGRectMake(15, CGRectGetMaxY(self.grayLabel1.frame), 100, 60);
        _label4.text = @"银行卡号";
        _label4.font = [UIFont systemFontOfSize:15];
        _label4.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label4;
}
-(UITextField *)rechTextFile{
    
    if (!_rechTextFile) {
        _rechTextFile = [[UITextField alloc] init];
        _rechTextFile.frame = CGRectMake(105, CGRectGetMaxY(self.grayLabel1.frame), 200, 60);
        _rechTextFile.font = [UIFont systemFontOfSize:15];
        _rechTextFile.textColor = UIColorFromRGB(0x727171);
        //        _telTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _rechTextFile.placeholder = @"请填写银行卡号";
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

-(UIButton *)button1{
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button1.frame = CGRectMake(15, screenH-25-64-40-50,screenW-30 , 50);
        _button1.backgroundColor = UIColorFromRGB(0xeaeaea);
        [_button1 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [_button1 setTitle:@"下一步" forState:0];
//        _button1.userInteractionEnabled = NO;
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
    
    if (self.rechTextFile.text.length > 14) {
        AddBankOneViewController * addOne = [[AddBankOneViewController alloc] init];
        addOne.hidesBottomBarWhenPushed = YES;
        addOne.cardNo = self.rechTextFile.text;
        addOne.type = _type;
        [self.navigationController pushViewController:addOne animated:YES];

    }else{
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [WKProgressHUD popMessage:@"请输入正确的银行卡号" inView:window duration:1.0 animated:YES];
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
        if (mStr.length > 20) {
            return NO;
        }
        if (mStr.length > 14) {
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
