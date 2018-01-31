//
//  AddBankOneViewController.m
//  futures
//
//  Created by apple on 17/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddBankOneViewController.h"
#import "XFAreaPickerView/XFAreaPickerView.h"
#import "LTPickerView.h"
@interface AddBankOneViewController ()<UITextFieldDelegate,XFAreaPickerViewDelegate>
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation AddBankOneViewController

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
    [self.tableView addSubview:self.TextFile1];
    [self.tableView addSubview:self.label4];
    [self.tableView addSubview:self.grayLabel1];
//    [self.tableView addSubview:self.label5];
    [self.tableView addSubview:self.rechTextFile];
    [self.tableView addSubview:self.grayLabel2];
    
    [self.tableView addSubview:self.button1];
        [self.tableView addSubview:self.label6];
    [self.tableView addSubview:self.TextFile2];
    [self.tableView addSubview:self.grayLabel3];
    [self.tableView addSubview:self.label7];
    [self.tableView addSubview:self.TextFile3];
    [self.tableView addSubview:self.grayLabel4];
    [self.tableView addSubview:self.button2];
    [self.tableView addSubview:self.button3];
    [self.tableView addSubview:self.button4];
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
//    label.text = @"添加银行卡";
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
        _label2.text = @"请完善银行卡信息";
        _label2.font = [UIFont systemFontOfSize:12];
        _label2.textColor = UIColorFromRGB(0x999999);
    }
    
    return _label2;
}
-(UILabel *)label3{
    
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.frame = CGRectMake(15, CGRectGetMaxY(self.label2.frame)+30, 90, 60);
        _label3.text = @"银行名称";
        _label3.font = [UIFont systemFontOfSize:15];
        _label3.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label3;
}
-(UITextField *)TextFile1{
    
    if (!_TextFile1) {
        _TextFile1 = [[UITextField alloc] init];
        _TextFile1.frame = CGRectMake(105, CGRectGetMaxY(self.label2.frame)+30, 200, 60);
        _TextFile1.font = [UIFont systemFontOfSize:15];
        _TextFile1.textColor = UIColorFromRGB(0x222222);
        //        _telTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _TextFile1.text = @"请选择银行";
        _TextFile1.returnKeyType = UIReturnKeyNext;
//        _TextFile1.keyboardType = UIKeyboardTypeNumberPad;
        _TextFile1.userInteractionEnabled = NO;
        // 2、设置成为代理
        _TextFile1.delegate = self;
    }
    return _TextFile1;
}
-(UIButton *)button2{

    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button2.frame = CGRectMake(105, CGRectGetMaxY(self.label2.frame)+30, screenW-105, 60);
        [_button2 addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button2;
}
-(UILabel *)label5{
    if (!_label5) {
        _label5 = [[UILabel alloc] init];
        _label5.frame = CGRectMake(105, CGRectGetMaxY(self.label2.frame)+30, 90, 60);
        _label5.text = @"小可";
        _label5.font = [UIFont systemFontOfSize:15];
        _label5.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label5;
    
}
-(UILabel *)grayLabel1{
    
    if (!_grayLabel1) {
        _grayLabel1 = [[UILabel alloc] init];
        _grayLabel1.frame = CGRectMake(15, CGRectGetMaxY(self.label3.frame), screenW, 1);
        _grayLabel1.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _grayLabel1;
}
-(UILabel *)label4{
    
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        _label4.frame = CGRectMake(15, CGRectGetMaxY(self.grayLabel1.frame), 100, 60);
        _label4.text = @"支行名称";
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
        _rechTextFile.textColor = UIColorFromRGB(0x222222);
        //        _telTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _rechTextFile.placeholder = @"请填写支行名称";
        _rechTextFile.returnKeyType = UIReturnKeyNext;
//        _rechTextFile.keyboardType = UIKeyboardTypeNumberPad;
        
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
-(UILabel *)label6{
    if (!_label6) {
        _label6 = [[UILabel alloc] init];
        _label6.frame = CGRectMake(15, CGRectGetMaxY(self.grayLabel2.frame), 100, 60);
        _label6.text = @"开户省份";
        _label6.font = [UIFont systemFontOfSize:15];
        _label6.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label6;
    
}
-(UITextField *)TextFile2{
    
    if (!_TextFile2) {
        _TextFile2 = [[UITextField alloc] init];
        _TextFile2.frame = CGRectMake(105, CGRectGetMaxY(self.grayLabel2.frame), 200, 60);
        _TextFile2.font = [UIFont systemFontOfSize:15];
        _TextFile2.textColor = UIColorFromRGB(0x222222);
        //        _telTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _TextFile2.placeholder = @"请输入您的开户省份";
        _TextFile2.returnKeyType = UIReturnKeyNext;
        //        _TextFile1.keyboardType = UIKeyboardTypeNumberPad;
        _TextFile2.userInteractionEnabled = NO;
        // 2、设置成为代理
        _TextFile2.delegate = self;
    }
    return _TextFile2;
}
-(UIButton *)button3{
    
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button3.frame = CGRectMake(105, CGRectGetMaxY(self.grayLabel2.frame), 200, 60);
        [_button3 addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button3;
}
-(UILabel *)grayLabel3{
    
    if (!_grayLabel3) {
        _grayLabel3 = [[UILabel alloc] init];
        _grayLabel3.frame = CGRectMake(0, CGRectGetMaxY(self.TextFile2.frame), screenW, 1);
        _grayLabel3.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _grayLabel3;
}
-(UILabel *)label7{
    if (!_label7) {
        _label7 = [[UILabel alloc] init];
        _label7.frame = CGRectMake(15, CGRectGetMaxY(self.grayLabel3.frame), 100, 60);
        _label7.text = @"开户城市";
        _label7.font = [UIFont systemFontOfSize:15];
        _label7.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label7;
    
}
-(UITextField *)TextFile3{
    
    if (!_TextFile3) {
        _TextFile3 = [[UITextField alloc] init];
        _TextFile3.frame = CGRectMake(105, CGRectGetMaxY(self.grayLabel3.frame), 200, 60);
        _TextFile3.font = [UIFont systemFontOfSize:15];
        _TextFile3.textColor = UIColorFromRGB(0x222222);
        //        _telTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _TextFile3.placeholder = @"请输入您的开户城市";
        _TextFile3.returnKeyType = UIReturnKeyNext;
        //        _TextFile1.keyboardType = UIKeyboardTypeNumberPad;
        _TextFile3.userInteractionEnabled = NO;
        // 2、设置成为代理
        _TextFile3.delegate = self;
    }
    return _TextFile3;
}
-(UIButton *)button4{
    
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button4.frame = CGRectMake(105, CGRectGetMaxY(self.grayLabel3.frame), 200, 60);
        [_button4 addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button4;
}
-(UILabel *)grayLabel4{
    
    if (!_grayLabel4) {
        _grayLabel4 = [[UILabel alloc] init];
        _grayLabel4.frame = CGRectMake(0, CGRectGetMaxY(self.TextFile3.frame), screenW, 1);
        _grayLabel4.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _grayLabel4;
}
-(UIButton *)button1{
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button1.frame = CGRectMake(15, screenH-25-64-40-50,screenW-30 , 50);
        _button1.backgroundColor = UIColorFromRGB(0xeaeaea);
        [_button1 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [_button1 setTitle:@"提交" forState:0];
        //        _button1.userInteractionEnabled = NO;
        [_button1.layer setMasksToBounds:YES];
        _button1.layer.cornerRadius = 2;
        [_button1 setBackgroundColor:UIColorFromRGB(0xfc5662)];
        [_button1 setTitleColor:UIColorFromRGB(0xffffff) forState:0];
        _button1.userInteractionEnabled = YES;
        [_button1 addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _button1;
}

-(void)loginButtonClick:(UIButton *)button{
    
    if (button == _button2) {
        [self.rechTextFile resignFirstResponder];
        _SmallMoneyArray = @[@"中国工商银行",
                                      @"中国建设银行",
                                      @"招商银行",
                                      @"中国农业银行",
                                      @"浦发银行",
                                      @"华夏银行",
                                      @"中国光大银行",
                                      @"中国银行",
                                      @"中国邮政储蓄银行",
                                      @"交通银行",
                                      @"中国民生银行",
                                      @"广发银行",
                                      @"兴业银行",
                                      @"中信银行",
                                      @"平安银行",
                                      @"浙商银行",
                                      @"北京银行",
                                      @"南京银行",
                                      @"包商银行",
                                      @"北京农村商业银行",
                                      @"韩亚银行",
                                      @"渤海银行",
                                      @"天津银行",
                                      @"天津农商银行",
                                      @"外换银行（中国）有限公司",
                                      @"深圳农商行",
                                      @"东莞农村商业银行",
                                      @"广州银行",
                                      @"广州农村商业银行",
                                      @"新韩银行中国",
                                      @"东莞银行",
                                      @"顺德农村商业银行",
                                      @"安徽省农村信用联合社",
                                      @"厦门银行",
                                      @"广西北部湾银行",
                                      @"长沙银行",
                                      @"昆山农村商业银行",
                                      @"苏州银行",
                                      @"张家港农村商业银行",
                                      @"南昌银行",
                                      @"上饶银行",
                                      @"东营市商业银行",
                                      @"济宁银行",
                                      @"莱商银行",
                                      @"临商银行",
                                      @"齐商银行",
                                      @"青岛银行",
                                      @"日照银行",
                                      @"泰安市商业银行",
                                      @"威海市商业银行",
                                      @"烟台银行",
                                      @"大连银行",
                                      @"锦州银行",
                                      @"鞍山市商业银行",
                                      @"葫芦岛银行",
                                      @"上海农村商业银行",
                                      @"上海银行",
                                      @"浙江稠州商业银行",
                                      @"杭州银行",
                                      @"湖州银行",
                                      @"宁波银行",
                                      @"浙江泰隆商业银行",
                                      @"温州银行",
                                      @"鄞州银行",
                                      @"黄河农村商业银行"];
        _SmallMoneyArrayOne = @[@"icbc",
                                         @"ccb",
                                         @"cmb",
                                         @"abc",
                                         @"spdb",
                                         @"hxb",
                                         @"ceb",
                                         @"boc",
                                         @"psbc",
                                         @"bcm",
                                         @"cmbc",
                                         @"gdb",
                                         @"cib",
                                         @"citic",
                                         @"pab",
                                         @"czbank",
                                         @"bob",
                                         @"bon",
                                         @"bsb",
                                         @"bjrcb",
                                         @"keb",
                                         @"bhb",
                                         @"tccb",
                                         @"tjrcb",
                                         @"cneb",
                                         @"szrcb",
                                         @"dgrcb",
                                         @"gzcb",
                                         @"gzrcb",
                                         @"xhb",
                                         @"dgb",
                                         @"sdrcb",
                                         @"ahrcu",
                                         @"xmccb",
                                         @"bbgb",
                                         @"cscb",
                                         @"ksrcb",
                                         @"szb",
                                         @"zrcb",
                                         @"ncb",
                                         @"srbank",
                                         @"dyccb",
                                         @"jnb",
                                         @"laisb",
                                         @"linsb",
                                         @"qsb",
                                         @"qdccb",
                                         @"rzb",
                                         @"tarcb",
                                         @"whrcb",
                                         @"ytb",
                                         @"dlb",
                                         @"jzb",
                                         @"asrcb",
                                         @"hldb",
                                         @"shrcb",
                                         @"bosc",
                                         @"zjczrcb",
                                         @"hzb",
                                         @"hzccb",
                                         @"nbcb",
                                         @"zjtlrcb",
                                         @"wzcb",
                                         @"beeb",
                                         @"hhrcb"];
        LTPickerView* pickerView1 = [LTPickerView new];
        pickerView1.dataSource = _SmallMoneyArray;//设置要显示的数据
        pickerView1.defaultStr = @"中国工商银行";//默认选择的数据
        [pickerView1 show];//显示
        //回调block
        pickerView1.block = ^(LTPickerView* obj,NSString* str,int num){
            self.TextFile1.text = str;
//            PrepaidBankFiled.text = str;
            _numStr = _SmallMoneyArray[num];
            
            
        };
    }else if (button == _button3){
        [self.rechTextFile resignFirstResponder];
       
        XFAreaPickerView *areaPicker = [[XFAreaPickerView alloc]initWithDelegate:self];
        areaPicker.isHidden = NO;
    }else if (button == _button4){
        [self.rechTextFile resignFirstResponder];
        XFAreaPickerView *areaPicker = [[XFAreaPickerView alloc]initWithDelegate:self];
        areaPicker.isHidden = NO;
    
    }else if (button == _button1){
    
        if ([self.TextFile1.text isEqualToString:@"请选择银行"]) {
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            [WKProgressHUD popMessage:@"请选择银行" inView:window duration:1.0 animated:YES];
        }else{
        
            if (self.rechTextFile.text.length > 0) {
                
                if (self.TextFile3.text.length > 0) {
                    
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
                    NSString * url1 = [NSString stringWithFormat:@"%@/api/money/setBankInfo.json",codeUrl4];
                    
                    NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY],@"bankName":_numStr,@"bankAddr":self.rechTextFile.text,@"cardNo":_cardNo,@"province":self.TextFile2.text,@"city":self.TextFile3.text};
                    
        
                    //3.请求
                    [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        NSString * NsCode = responseObject[@"code"];
                        
                        
                        NSLog(@"%@",responseObject);
                        
                        
                        if ([NsCode isEqualToString:@"0"]) {
                          
                            UIWindow * window = [UIApplication sharedApplication].keyWindow;
                            [WKProgressHUD popMessage:@"添加银行卡成功" inView:window duration:1.0 animated:YES];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
                        }else if ([NsCode isEqualToString:@"1"]){
                            UIWindow * window = [UIApplication sharedApplication].keyWindow;
                            [WKProgressHUD popMessage:responseObject[@"errMsg"] inView:window duration:1.0 animated:YES];
                            
                        }
                        
                    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"======%@", error);
                        
                        
                    }];
                    
                }else{
                    UIWindow * window = [UIApplication sharedApplication].keyWindow;
                    [WKProgressHUD popMessage:@"请输选择省份城市" inView:window duration:1.0 animated:YES];
                }
                
                
            }else{
                UIWindow * window = [UIApplication sharedApplication].keyWindow;
                [WKProgressHUD popMessage:@"请输入支行名称" inView:window duration:1.0 animated:YES];
            
            }
        
        }
        
    
    }
  
    
}
- (void)areaPickerView:(XFAreaPickerView *)areaPickerView didSelectArea:(NSString *)area
{
    //    _txt.text = area;
//    self.codeTextFild.text = area;
    
    NSArray * array = [area componentsSeparatedByString:@" "];
    if (array.count > 2) {
        self.TextFile2.text = array[0];
        self.TextFile3.text = array[1];
//        _county = array[2];
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
