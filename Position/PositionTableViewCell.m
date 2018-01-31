//
//  PositionTableViewCell.m
//  futures
//
//  Created by apple on 17/9/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PositionTableViewCell.h"
#import "YBAlertView.h"
#import "WKProgressHUD.h"
#import "MBProgressHUD+MJ.h"
@interface PositionTableViewCell()<UIAlertViewDelegate>
{
    UIAlertView * BackhandTipsAlert;
//    NSMutableAttributedString *strr1;
    
}
@property(nonatomic,strong)YBAlertView *alertView;
@property(nonatomic,strong)YBAlertView *BackhandPositionAlertView;

@end
@implementation PositionTableViewCell
-(void)setCellWithDict:(NSDictionary *)dict{
    _dic = dict;
    NSString * cmd = dict[@"cmd"];
    if ([cmd isEqualToString:@"0"]) {
        _image2.image = [UIImage imageNamed:@"涨icon"];
    }else{
     _image2.image = [UIImage imageNamed:@"跌icon-0"];
    }

    self.label1.text = [NSString stringWithFormat:@"%@",dict[@"symbol_cn"]];
    self.label11.text = [NSString stringWithFormat:@"%@",dict[@"symbol"]];
    
    self.label2.text = [NSString stringWithFormat:@"%@",dict[@"profit"]];
    
    self.label4.text = [NSString stringWithFormat:@"%@",dict[@"volume"]];
    
    self.label6.text = [NSString stringWithFormat:@"$%@",dict[@"margin"]];
    
    self.label8.text = [NSString stringWithFormat:@"%@",dict[@"open_price"]];
    
    
    
   
   
    
    
    if ([dict[@"symbol"] rangeOfString:@"EURUSD"].location != NSNotFound){
      [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(EURUSDPntf:) name:@"EURUSDPntf" object:nil];
    
    }else if ([dict[@"symbol"] rangeOfString:@"GBPUSD"].location != NSNotFound){
       [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(GBPUSDntf:) name:@"GBPUSDntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"USDCHF"].location != NSNotFound){
            [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(USDCHFntf:) name:@"USDCHFntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"AUDUSD"].location != NSNotFound){
            [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(AUDUSDntf:) name:@"AUDUSDntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"NZDUSD"].location != NSNotFound){
            [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(NZDUSDntf:) name:@"NZDUSDntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"USDJPY"].location != NSNotFound){
              [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(USDJPYntf:) name:@"USDJPYntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"EURGBP"].location != NSNotFound){
             [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(EURGBPntf:) name:@"EURGBPntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"USDCNH"].location != NSNotFound){
            [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(USDCNHntf:) name:@"USDCNHntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"XAGUSD"].location != NSNotFound){
         [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(XAGUSDntf:) name:@"XAGUSDntf" object:nil];
    }else if ([dict[@"symbol"] rangeOfString:@"XAUUSD"].location != NSNotFound){
          [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(XAUUSDntf:) name:@"XAUUSDntf" object:nil];
    }
  
 
    
    
  
    
}
-(void)XAUUSDntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100;
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100;
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
        //        profitModel * promode = [profitModel model];
        //        promode.profit1 = profit1;
        //
        //        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
        //            [self.delegate InterruptTimer:@"1"];
        //        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
        
    }
    
}
-(void)XAGUSDntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 5000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 5000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
        //        profitModel * promode = [profitModel model];
        //        promode.profit1 = profit1;
        //
        //        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
        //            [self.delegate InterruptTimer:@"1"];
        //        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
        
    }
    
}
-(void)EURUSDPntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
      
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
             profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000;
             self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);

        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
//        profitModel * promode = [profitModel model];
//        promode.profit1 = profit1;
//        
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
        
    }
    
}
-(void)GBPUSDntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
        
//        profitModel * promode = [profitModel model];
//        promode.profit2 = profit1;
//        
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
    }
    
}
-(void)USDCHFntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000/[array[2] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000/[array[1] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        
//        NSString * cmd = _dic[@"cmd"];
//        if ([cmd isEqualToString:@"0"]) {
//            profit = (profit1 - profit2) * profit3 * 100000/[array[1] floatValue];
//        }else{
//            profit = (profit2 - profit1) * profit3 * 100000/[array[0] floatValue];
//        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
//        profitModel * promode = [profitModel model];
//        promode.profit3 = profit1;
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
    }
    
}
-(void)AUDUSDntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
//        profitModel * promode = [profitModel model];
//        promode.profit4 = profit1;
//        
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
    }
    
}
-(void)NZDUSDntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000;
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
//         profitModel * promode = [profitModel model];
//        promode.profit5 = profit1;
//        
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
    }
    
}
-(void)USDJPYntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000/[array[2] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000/[array[1] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
//         profitModel * promode = [profitModel model];
//         promode.profit6 = profit1;
//        
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
    }
    
}
-(void)EURGBPntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
//        NSString * cmd = _dic[@"cmd"];
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000*[array[2] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000*[array[1] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
         self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
//        profitModel * promode = [profitModel model];
//        promode.profit7 = profit1;
//        
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
    }
    
}
-(void)USDCNHntf:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        float profit1;
        float profit2 = [_dic[@"open_price"] floatValue];
        
        float profit3 = [_dic[@"volume"] floatValue];
        
        float profit;
        
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            profit1 = [array[2] floatValue];
            profit = (profit1 - profit2) * profit3 * 100000/[array[2] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[2]];
        }else{
            profit1 = [array[1] floatValue];
            profit = (profit2 - profit1) * profit3 * 100000/[array[1] floatValue];
            self.label10.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        if (profit >= 0) {
            self.label2.textColor = UIColorFromRGB(0xfc5662);
            self.tcLabel6.textColor = UIColorFromRGB(0xfc5662);
        }else{
            self.label2.textColor = UIColorFromRGB(0x25c991);
            self.tcLabel6.textColor = UIColorFromRGB(0x25c991);
            
        }
        self.label2.text = [NSString stringWithFormat:@"$%.2f",profit];
//        profitModel * promode = [profitModel model];
//        promode.profit8 = profit1;
//        
//        if ([self.delegate respondsToSelector:@selector(InterruptTimer:)]) {
//            [self.delegate InterruptTimer:@"1"];
//        }
        self.tcLabel4.text = [NSString stringWithFormat:@"%f",profit1];
        self.tcLabel6.text = [NSString stringWithFormat:@"%.2f",profit];
    }
    
}

- (void)awakeFromNib {
    _image1.backgroundColor = UIColorFromRGB(0xf7f7f7);
    _label1.textColor = UIColorFromRGB(0x222222);
    _label11.textColor = UIColorFromRGB(0x999999);
    _label2.textColor = UIColorFromRGB(0xfc5662);
    
    _bglabel.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    _label3.textColor = UIColorFromRGB(0x999999);
    _label4.textColor = UIColorFromRGB(0x222222);
    
    _label5.textColor = UIColorFromRGB(0x999999);
    _label6.textColor = UIColorFromRGB(0x222222);
    
    _label7.textColor = UIColorFromRGB(0x999999);
    _label8.textColor = UIColorFromRGB(0x222222);
    
    _label9.textColor = UIColorFromRGB(0x999999);
    _label10.textColor = UIColorFromRGB(0x222222);
    
    [_button1 setTitleColor:UIColorFromRGB(0xffffff) forState:0];
    [_button1 setTitle:@"平仓" forState:0];
    _button1.backgroundColor = UIColorFromRGB(0x4d93e9);
}
- (IBAction)buttonClick:(id)sender {
    
    [MBProgressHUD showMessage:@"处理中请稍后..."];
    
    [MBProgressHUD hideHUD];
    _alertView = [[YBAlertView alloc] initWithFrame:CGRectMake((screenW-280)/2, (screenH-315)/2, 280, 315)];
    
    [_alertView addSubview:self.MYimageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 32, 180, 30)];
    titleLabel.textColor = UIColorFromRGB(0x222222);
    titleLabel.font = [UIFont boldSystemFontOfSize:23];
    titleLabel.text = [NSString stringWithFormat:@"%@",_dic[@"symbol_cn"]];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:titleLabel];
    
 
    self.closeRate.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+5, _alertView.width, 20);

    self.closeRate.textColor = UIColorFromRGB(0x999999);
 
    self.closeRate.text = [NSString stringWithFormat:@"%@",_dic[@"symbol"]];
    [_alertView addSubview:self.closeRate];
    
    [_alertView addSubview:self.tcLabel1];
    [_alertView addSubview:self.tcLabel2];
    [_alertView addSubview:self.tcLabel3];
    [_alertView addSubview:self.tcLabel4];
    [_alertView addSubview:self.tcLabel5];
    [_alertView addSubview:self.tcLabel6];
    
    UILabel *titleLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 267, _alertView.width, 1)];
    titleLabel6.backgroundColor = UIColorFromRGB(0xe5e5e5);
    
    [_alertView addSubview:titleLabel6];
    UILabel *titleLabel7 = [[UILabel alloc] initWithFrame:CGRectMake(140, 267, 1, 47)];
    titleLabel7.backgroundColor = UIColorFromRGB(0xe5e5e5);
    
    [_alertView addSubview:titleLabel7];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(titleLabel6.frame), _alertView.width/2, 47);
    [cancelBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:UIColorFromRGB(0x9fa0a0) forState:UIControlStateNormal];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_alertView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(titleLabel6.frame) , _alertView.width/2, 47);
    [confirmBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
//    confirmBtn.backgroundColor = UIColorFromRGB(0x2a90d8);
    [confirmBtn setTitleColor:UIColorFromRGB(0x2a90d8) forState:UIControlStateNormal];
    [_alertView addSubview:confirmBtn];
    
    [_alertView show];
    
    
}
- (void)cancelClick:(UIButton *)btn
{
     [btn.superview performSelector:@selector(close)];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [[CustomHua sharedInstance]startloaddata:window withString:@"平仓中请稍后..."];
    
//    [MBProgressHUD showMessage:@"平仓中"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userId = [userDefaults objectForKey:USER_NAME_KEY];
    
 
    //  如果没有登录userId则设置为空
    if (userId == nil) {
        userId = @"";
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString * url = [NSString stringWithFormat:@"%@/tiger/trade/close.json",codeUrl4];
    
    
    NSDictionary * dict = @{@"user_id":userId,@"ticket":_dic[@"ticket"],@"price_record":_dic[@"close_price"]};
    
    
    
    //3.请求
    [manager POST:url parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * NsCode = responseObject[@"code"];
        
        if ([NsCode isEqualToString:@"0"]) {
            [MBProgressHUD hideHUD];
              [[CustomHua sharedInstance]stoploaddata:window];
            [btn.superview performSelector:@selector(close)];
            
            
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            
            [WKProgressHUD popMessage:@"平仓成功" inView:window duration:1.0 animated:YES];
            if ([self.delegate respondsToSelector:@selector(secondViewControllerChangeBgid:)]) {
                [self.delegate secondViewControllerChangeBgid:@"1"];
            }
            
        }else if([NsCode isEqualToString:@"1"]){
            [[CustomHua sharedInstance]stoploaddata:window];
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            [WKProgressHUD popMessage:responseObject[@"errMsg"] inView:window duration:1.0 animated:YES];
            
        }else if ([NsCode isEqualToString:@"666"]){
          [[CustomHua sharedInstance]stoploaddata:window];
            
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [WKProgressHUD popMessage:@"服务器内部错误，请稍后重试！" inView:window duration:1.0 animated:YES];
        [[CustomHua sharedInstance]stoploaddata:window];
    }];
    
    
}
-(UILabel *)closeRate{
    
    if (!_closeRate) {
        _closeRate = [[UILabel alloc] init];
        
        
        _closeRate.frame = CGRectMake(0, 65, _alertView.width, 20);
        
        _closeRate.font = [UIFont systemFontOfSize:12];
        _closeRate.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _closeRate;
}
-(UIImageView *)MYimageView{

    if (!_MYimageView) {
        _MYimageView = [[UIImageView alloc] init];
        _MYimageView.frame = CGRectMake(90, 35, 23, 23);
//        _MYimageView.backgroundColor = [UIColor redColor];
        NSString * cmd = _dic[@"cmd"];
        if ([cmd isEqualToString:@"0"]) {
            _MYimageView.image = [UIImage imageNamed:@"涨icon"];
        }else{
            _MYimageView.image = [UIImage imageNamed:@"跌icon-0"];
        }
//        _MYimageView.image
    }
    
    
    return _MYimageView;
}
-(UILabel *)tcLabel1{

    if (!_tcLabel1) {
        _tcLabel1 = [[UILabel alloc] init];
        _tcLabel1.frame = CGRectMake(0, CGRectGetMaxY(self.closeRate.frame)+30, 140, 20);
        _tcLabel1.text = @"建仓价格";
        _tcLabel1.textColor = UIColorFromRGB(0x999999);
        _tcLabel1.font = [UIFont systemFontOfSize:18];
        _tcLabel1.textAlignment = NSTextAlignmentCenter;
    }

    return _tcLabel1;
}
-(UILabel *)tcLabel2{
    
    if (!_tcLabel2) {
        _tcLabel2 = [[UILabel alloc] init];
        _tcLabel2.frame = CGRectMake(140, CGRectGetMaxY(self.closeRate.frame)+30, 140, 20);
        _tcLabel2.text = [NSString stringWithFormat:@"%@",_dic[@"open_price"]];
        _tcLabel2.textColor = UIColorFromRGB(0x222222);
        _tcLabel2.font = [UIFont systemFontOfSize:18];
        _tcLabel2.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tcLabel2;
}
-(UILabel *)tcLabel3{
    
    if (!_tcLabel3) {
        _tcLabel3 = [[UILabel alloc] init];
        _tcLabel3.frame = CGRectMake(0, CGRectGetMaxY(self.tcLabel1.frame)+20, 140, 20);
        _tcLabel3.text = @"当前价格";
        _tcLabel3.textColor = UIColorFromRGB(0x999999);
        _tcLabel3.font = [UIFont systemFontOfSize:18];
        _tcLabel3.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tcLabel3;
}
-(UILabel *)tcLabel4{
    
    if (!_tcLabel4) {
        _tcLabel4 = [[UILabel alloc] init];
        _tcLabel4.frame = CGRectMake(140, CGRectGetMaxY(self.tcLabel2.frame)+20, 140, 20);
       
        _tcLabel4.textColor = UIColorFromRGB(0x222222);
        _tcLabel4.font = [UIFont systemFontOfSize:18];
        _tcLabel4.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tcLabel4;
}
-(UILabel *)tcLabel5{
    
    if (!_tcLabel5) {
        _tcLabel5 = [[UILabel alloc] init];
        _tcLabel5.frame = CGRectMake(0, CGRectGetMaxY(self.tcLabel3.frame)+20, 140, 20);
        _tcLabel5.text = @"浮动盈亏";
        _tcLabel5.textColor = UIColorFromRGB(0x999999);
        _tcLabel5.font = [UIFont systemFontOfSize:18];
        _tcLabel5.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tcLabel5;
}
-(UILabel *)tcLabel6{
    
    if (!_tcLabel6) {
        _tcLabel6 = [[UILabel alloc] init];
        _tcLabel6.frame = CGRectMake(140, CGRectGetMaxY(self.tcLabel4.frame)+20, 140, 20);
        
        _tcLabel6.textColor = UIColorFromRGB(0x222222);
        _tcLabel6.font = [UIFont systemFontOfSize:18];
        _tcLabel6.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tcLabel6;
}
-  (void)confirmClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
