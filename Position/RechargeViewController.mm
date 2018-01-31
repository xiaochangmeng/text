//
//  RechargeViewController.m
//  futures
//
//  Created by apple on 17/9/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RechargeViewController.h"
#import "LoginViewController.h"
#import "UnionPayRequest.h"
#import "UnionPayProgressViewHUD.h"
#import "UnionPayHmacmd5AndDescrypt.h"
#import "UnionPayOrderInfo.h"
#import "PayEaseControl.h"
//下单
#define kBaseIP @"https://api.yizhifubj.com"

#define   kOrderUrl    [NSString stringWithFormat:@"%@%@", kBaseIP, @"/customer/gb/pay_mobile_payment_direct.jsp"]
@interface RechargeViewController ()<UITextFieldDelegate,UnionPayRequestDelegate>
{
    UITextField *_amountTextField;
    UITextField *_midTextFiled;
    UITextField *_userrefTextField;
    NSMutableString *_requestString;
    NSString *_orderMd5Info;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UnionPayRequest *orderRequest;
@property (nonatomic, strong) UnionPayProgressViewHUD *progressHUD;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _amountTextField = [self creatTextFiledWithTitle:@"金额:" text:@"0.01" originX:100];
    _midTextFiled = [self creatTextFiledWithTitle:@"商户号:" text:@"12492" originX:150];
//    _userrefTextField = [self creatTextFiledWithTitle:@"唯一标识:" text:@"201503286452AllPay01" originX:200];
    _userrefTextField = [self creatTextFiledWithTitle:@"唯一标识:" text:@"201503286452AllPay01" originX:200];
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH-64)];
//    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.label4];
    [self.view addSubview:self.grayLabel1];
    [self.view addSubview:self.rechTextFile];
    [self.view addSubview:self.grayLabel2];
    [self.view addSubview:self.label5];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.label6];
    
    [self getHData];
}
-(void)getHData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
    NSString * url1 = [NSString stringWithFormat:@"%@/api/money/payment.json",codeUrl4];
    
    NSDictionary * dict = @{@"type":@"1"};
    
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
-(UILabel *)label1{

    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.frame = CGRectMake(15, 0, 100, 80);
        _label1.text = @"支付方式";
        _label1.font = [UIFont systemFontOfSize:15];
        _label1.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label1;
}
-(UILabel *)label2{
    
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.frame = CGRectMake(99, 20, 150, 20);
        _label2.text = @"网银支付";
        _label2.font = [UIFont systemFontOfSize:18];
        _label2.textColor = UIColorFromRGB(0x222222);
    }
    
    return _label2;
}
-(UILabel *)label3{
    
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.frame = CGRectMake(99, 40, 175, 20);
        _label3.text = @"单日交易限额以银行规定为准";
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
        _label4.text = @"充值金额      $";
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
        _rechTextFile.textColor = UIColorFromRGB(0x222222);
        //        _telTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _rechTextFile.placeholder = @"最低50.0美元";
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
       
        _label5.font = [UIFont systemFontOfSize:12];
        _label5.textColor = UIColorFromRGB(0x999999);
    }
    
    return _label5;

}
-(UIButton *)button1{

    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button1.frame = CGRectMake(15, CGRectGetMaxY(self.label5.frame)+20, screenW-30, 50);
        _button1.backgroundColor = UIColorFromRGB(0xeaeaea);
        [_button1 setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [_button1 setTitle:@"确认充值" forState:0];
        _button1.userInteractionEnabled = YES;
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
- (UITextField *) creatTextFiledWithTitle:(NSString *)title text:(NSString *)text originX:(CGFloat)originX
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor clearColor];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    textField.center = CGPointMake(self.view.center.x, originX);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.delegate = self;
    textField.leftView = titleLabel;
    textField.text = text;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}
-(void)loginButtonClick:(UIButton *)button{
   
    if ([_rechTextFile.text intValue] >= 50) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:USER_NAME_KEY] == nil) {
            LoginViewController * DSV = [[LoginViewController alloc] init];
            
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:DSV];
            
            //        DSV.bj = @"1";
            [self presentViewController:nav animated:YES completion:nil];
            
        }else{
             _button1.userInteractionEnabled = NO;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
            NSString * url1 = [NSString stringWithFormat:@"%@/api/money/rechage.json",codeUrl4];
            
            NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY],@"amount":self.rechTextFile.text};
            
            //3.请求
            [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString * NsCode = responseObject[@"code"];
                
                
                NSLog(@"%@",responseObject);
                
                
                if ([NsCode isEqualToString:@"0"]) {
                     _button1.userInteractionEnabled = YES;
                    NSString * payType = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"payType"]];
                    if ([payType isEqualToString:@"2"]) {
                        ZTWebViewController * zeweb = [[ZTWebViewController alloc] init];
                        zeweb.hidesBottomBarWhenPushed = YES;
                        zeweb.string = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"url"]];
                        
                        [self.navigationController pushViewController:zeweb animated:YES];
                    }else{
                        _dic = responseObject[@"data"];
                     self.progressHUD = [UnionPayProgressViewHUD UPProgressViewHUDWithTitle:@"请稍候..." toView:self.view];
                        if (!_orderRequest) {
                            _orderRequest = [[UnionPayRequest alloc] init];
                            [_orderRequest setDelegate:self];
                        }
                        [self payForNormal];
                        NSString *_utfString = [_requestString stringByRemovingPercentEncoding];
                        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                        NSData *requestData = [_utfString dataUsingEncoding:enc];
                        [_orderRequest sendPOSTRequest:kOrderUrl parametersData:requestData withTag:@""];
                        _button1.userInteractionEnabled = YES;
                    }
                    
                  
                    
                }else if ([NsCode isEqualToString:@"1"]){
                    
                    _button1.userInteractionEnabled = YES;
                }
                
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"======%@", error);
                _button1.userInteractionEnabled = YES;
                
            }];
        }
        
        
    }else{
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [WKProgressHUD popMessage:@"手机端充值最低限额$50.00" inView:window duration:1.0 animated:YES];
    }

}
- (void) payForNormal
{
    //1 商户号
    NSString  *v_mid = _midTextFiled.text;
    //2 订单生成日期
    NSString *str2 = [NSString stringWithFormat:@"%@",_dic[@"order_time"]];
    NSArray *temp=[str2 componentsSeparatedByString:@" "];
    NSString * str4 = temp[0];
    NSArray * tep1 = [str4 componentsSeparatedByString:@"-"];
    
    
    NSString  *v_ymd = [NSString stringWithFormat:@"%@%@%@",tep1[0],tep1[1],tep1[2]];
    //3 订单编号
//    int x = arc4random() % 100;
//    int y = arc4random() % 100;
    NSString * str3 = [NSString stringWithFormat:@"%@",_dic[@"order_no"]];
    NSString *v_oid = [NSString stringWithFormat:@"%@-%@-%@",v_ymd,v_mid,str3];
    
    NSLog(@"%@",v_oid);
    //4 订单总金额
    NSString *v_amount = [NSString stringWithFormat:@"%.2f", [_dic[@"rmb_amount"] floatValue]];
    //5 币种  0人民币 1美元
    NSString *v_moneytype = @"0";
    
    //6 客户证件类型  01 身份证 02 护照 03 军人证  04 台胞证 05 港澳居民通行证
    NSString  *v_idtype =  @"00";
    //7 客户证件号码,长度不超过20位字符
    NSString  *v_idnumber = @"000000000000000";
    UIDevice* curDev = [UIDevice currentDevice];
     NSString * string = curDev.identifierForVendor.UUIDString;
    //8 终端机编号
    NSString *v_rcvname = string;
    //9 收货人地址
    NSString  *v_rcvaddr = v_mid;
    //10 收货人电话 13600000000
    NSString  *v_rcvtel = @"00000000";
    //11 收货人邮编
    NSString  *v_rcvpost = @"123456";
    
    //12 订货人邮箱
    NSString  *v_ordmail = @"";
    //13 下单终端类型  0client 1：wap
    NSString  *v_orderstatus = @"0" ;
    //14 订货人姓名,总长不超过64个字符 掌中付用于客户验证码，统一采用:0000
    NSString  *v_ordername = @"0000";
    
    //15 返回商户页面地址
    NSString  *v_url = @"http://www.beijing.com.cn";
    //16 商户自定义参数，传操作员编号
    NSString  *v_merdata = @"admin";
    
    //17 订单数字指纹
    NSString *plainTest = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",v_moneytype,v_ymd,v_amount,v_rcvname,v_oid,v_mid,v_url];
    _orderMd5Info = [UnionPayHmacmd5AndDescrypt HMACMD5WithKey:@"02Fq3UYefbwJ23ZV" andData:plainTest];
    
    _requestString = [NSMutableString stringWithFormat:@"v_mid=%@&v_oid=%@&v_rcvname=%@&v_rcvaddr=%@&v_rcvtel=%@&v_rcvpost=%@&v_ordmail=%@&v_idtype=%@&v_idnumber=%@&v_amount=%@&v_ymd=%@&v_orderstatus=%@&v_ordername=%@&v_moneytype=%@&v_url=%@&v_merdata=%@&v_md5info=%@",v_mid,v_oid,v_rcvname,v_rcvaddr,v_rcvtel,v_rcvpost,v_ordmail,v_idtype,v_idnumber,v_amount,v_ymd,v_orderstatus,v_ordername,v_moneytype,v_url,v_merdata,_orderMd5Info];
    
     NSLog(@"%@",_requestString);
    
    
//    //1 商户号
//    NSString  *v_mid = _midTextFiled.text;
//    //2 订单生成日期
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formmater = [[NSDateFormatter alloc] init];
//    formmater.dateFormat = @"yyyyMMdd";
//    NSString  *v_ymd = [formmater stringFromDate:date];
//    //3 订单编号
//    int x = arc4random() % 100;
//    int y = arc4random() % 100;
//    NSString *v_oid = [NSString stringWithFormat:@"%@-%@-%d%d",v_ymd,v_mid,x,y];
//    
//    NSLog(@"%@",v_oid);
//    
//    //4 订单总金额
//    NSString *v_amount = [NSString stringWithFormat:@"%.2f", [_amountTextField.text floatValue]];
//    //5 币种  0人民币 1美元
//    NSString *v_moneytype = @"0";
//    
//    //6 客户证件类型  01 身份证 02 护照 03 军人证  04 台胞证 05 港澳居民通行证
//    NSString  *v_idtype =  @"00";
//    //7 客户证件号码,长度不超过20位字符
//    NSString  *v_idnumber = @"000000000000000";
//    
//    //8 终端机编号
//    NSString *v_rcvname = @"陈斐";
//    //9 收货人地址
//    NSString  *v_rcvaddr = v_mid;
//    //10 收货人电话 13600000000
//    NSString  *v_rcvtel = @"00000000";
//    //11 收货人邮编
//    NSString  *v_rcvpost = @"123456";
//    
//    //12 订货人邮箱
//    NSString  *v_ordmail = @"";
//    //13 下单终端类型  0client 1：wap
//    NSString  *v_orderstatus = @"0" ;
//    //14 订货人姓名,总长不超过64个字符 掌中付用于客户验证码，统一采用:0000
//    NSString  *v_ordername = @"0000";
//    
//    //15 返回商户页面地址
//    NSString  *v_url = @"http://www.beijing.com.cn";
//    //16 商户自定义参数，传操作员编号
//    NSString  *v_merdata = @"admin";
//    
//    //17 订单数字指纹
//    NSString *plainTest = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",v_moneytype,v_ymd,v_amount,v_rcvname,v_oid,v_mid,v_url];
//    _orderMd5Info = [UnionPayHmacmd5AndDescrypt HMACMD5WithKey:@"test" andData:plainTest];
//    
//    _requestString = [NSMutableString stringWithFormat:@"v_mid=%@&v_oid=%@&v_rcvname=%@&v_rcvaddr=%@&v_rcvtel=%@&v_rcvpost=%@&v_ordmail=%@&v_idtype=%@&v_idnumber=%@&v_amount=%@&v_ymd=%@&v_orderstatus=%@&v_ordername=%@&v_moneytype=%@&v_url=%@&v_merdata=%@&v_md5info=%@",v_mid,v_oid,v_rcvname,v_rcvaddr,v_rcvtel,v_rcvpost,v_ordmail,v_idtype,v_idnumber,v_amount,v_ymd,v_orderstatus,v_ordername,v_moneytype,v_url,v_merdata,_orderMd5Info];
//    
//    NSLog(@"%@",_requestString);
    
    
    
   
    
    
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
#pragma mark 送货信息
- (void) payWithDeliveryInfo
{
    // 参数中的汉字使用该编码
    NSString  *v_shipstreet = @"长城路";
    NSString  *v_shipcity = @"222";
    NSString  *v_shipstate = @"AP";
    NSString  *v_shippost = @"222222";
    NSString  *v_shipcountry = @"840";
    NSString  *v_shipphone = @"13051727888";
    NSString  *v_shipemail = @"393577226@qq.com";
    [_requestString appendFormat:@"&v_shipstreet=%@&v_shipcity=%@&v_shipstate=%@&v_shippost=%@&v_shipcountry=%@&v_shipphone=%@&v_shipemail=%@", v_shipstreet, v_shipcity, v_shipstate, v_shippost, v_shipcountry, v_shipphone, v_shipemail];
}
#pragma mark 账单信息
- (void) payWithBillInfo
{
    NSString  *v_billstreet = @"sskk";
    NSString  *v_billcity = @"MountainView";
    NSString  *v_billstate = @"CA";
    NSString  *v_billpost = @"94043";
    NSString  *v_billcountry = @"henan";
    NSString  *v_billphone = @"14158123237";
    NSString  *v_billemail = @"null@cybersource.com";
    
    [_requestString appendFormat:@"&v_billstreet=%@&v_billcity=%@&v_billstate=%@&v_billpost=%@&v_billcountry=%@&v_billphone=%@&v_billemail=%@", v_billstreet, v_billcity, v_billstate, v_billpost, v_billcountry, v_billphone, v_billemail];
}
#pragma mark 航空信息
- (void) payWithTravelInfo
{
    NSString  *v_traveltype = @"ssss";
    NSString  *v_traveldeparttime = @"Mountain View";
    NSString  *v_travelroute = @"CA";
    
    [_requestString appendFormat:@"&v_traveltype=%@&v_traveldeparttime=%@&v_travelroute=%@", v_traveltype, v_traveldeparttime, v_travelroute];
}
#pragma mark 跨境信息
- (void) payWithCrossBorderInfo
{
    // 客户姓名，注意：这里必须使用和证件号码相对应的真实的姓名
    NSString  *v_idname = @"none";
    // 客户国籍
    NSString  *v_idcountry = @"156";
    // 客户联系地址，
    NSString  *v_idaddress = @"北京";
    // 客户证件类型 + 客户证件号码 在标准支付的时候也需要拼接
    
    // 客户唯一标识
    NSString  *v_userref = _userrefTextField.text;
    // 产品类型
    NSString  *v_producttype = @"支付";
    // 产品名称
    NSString *v_merdata5 = @"产品名称";
    // 产品编码
    NSString *v_merdata8 = @"123";
    // 产品数量
    NSString *v_itemquantity = @"3||4";
    //产品单价
    NSString *v_itemunitprice = @"2.00||3.00";
    
    [_requestString appendFormat:@"&v_idname=%@&v_idcountry=%@&v_idaddress=%@&v_producttype=%@&v_userref=%@&v_merdata5=%@&v_merdata8=%@&v_itemquantity=%@&v_itemunitprice=%@", v_idname, v_idcountry, v_idaddress, v_producttype, v_userref, v_merdata5, v_merdata8, v_itemquantity, v_itemunitprice];
}
#pragma mark - OrderRequestDelegate
-(void)request:(UnionPayRequest *)request failed:(NSString *)errorMessage
{
    [self.progressHUD hide];
    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                         message:errorMessage
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
    [alertView show];
}
- (void)request:(UnionPayRequest *)request success:(id)XMLData
{
    [self.progressHUD hide];
    
    UnionPayOrderInfo *OrderInfo = [[UnionPayOrderInfo alloc] initWithData:XMLData];
    if ([OrderInfo.status isEqualToString:@"0"]) {
        [[PayEaseControl defaultControl] sendDataWithParentController:self OrderID:OrderInfo.oid MerchantID:OrderInfo.mid OrderMd5Info:_orderMd5Info URLScheme:@"PayEaseDemo"];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:OrderInfo.statusdesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UITextField  delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(pickerDoneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    textField.inputAccessoryView = keyboardDoneButtonView;
    return YES;
}
- (void)pickerDoneClicked:(id)sender {
    [self.view endEditing:YES];
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
