//
//  PositionViewController.h
//  futures
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionViewController : UIViewController
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,strong)UILabel * label;

@property(nonatomic,strong)UILabel * AvailableFunds;
@property(nonatomic,strong)UILabel * AvailableAmount;
@property(nonatomic,strong)UILabel * GrayLabel;
@property(nonatomic,strong)UILabel * NetAssets;
@property(nonatomic,strong)UILabel * NetAmount;
@property(nonatomic,strong)UILabel * differencePrice;
@property(nonatomic,strong)UILabel * differencePriceAmount;
@property(nonatomic,strong)UILabel * NetAssetsOne;
@property(nonatomic,strong)UILabel * NetAmountOne;
@property(nonatomic,strong)UILabel * differencePriceOne;
@property(nonatomic,strong)UILabel * differencePriceAmountOne;
@property(nonatomic,strong)UILabel * OrderRecord;
@property(nonatomic,strong)UILabel * OrderRecordAmount;
@property(nonatomic,strong)UILabel * GrayLabelOne;

//@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong)UIButton * buttonOne;
@property(nonatomic,strong)UIButton * buttonTwo;

@property(nonatomic,strong)UIImageView * bgImageOne;
@property(nonatomic,strong)UIButton * bgImageTwo;
@property(nonatomic,strong)UIImageView * imageOne;
@property(nonatomic,strong)UILabel * closeRate;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * balance;
@property(nonatomic,copy)NSString * credit;
@property(nonatomic,assign)float  profit;
@property(nonatomic,assign)float  profitOne;
@property(nonatomic,assign)float  profitTwo;
@end
