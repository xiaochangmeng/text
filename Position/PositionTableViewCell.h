//
//  PositionTableViewCell.h
//  futures
//
//  Created by apple on 17/9/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SecondViewControllerDelegate <NSObject>

// 协议方法
// 只声明不实现
// (即通知代理去做哪件事)

- (void)secondViewControllerChangeBgid:(NSString *)str;
- (void)InterruptTimer:(NSString *)str;

@end
@interface PositionTableViewCell : UITableViewCell
@property (nonatomic,weak) id<SecondViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *bglabel;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;

@property (weak, nonatomic) IBOutlet UILabel *label9;

@property (weak, nonatomic) IBOutlet UILabel *label10;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UILabel *label11;

@property (nonatomic,copy)NSString * strId;
@property (nonatomic,copy)NSString * CPId;
@property (nonatomic,strong)UILabel * closeRate;
@property (nonatomic,strong)UIImageView * MYimageView;



@property(nonatomic,strong)UILabel * tcLabel1;
@property(nonatomic,strong)UILabel * tcLabel2;
@property(nonatomic,strong)UILabel * tcLabel3;
@property(nonatomic,strong)UILabel * tcLabel4;
@property(nonatomic,strong)UILabel * tcLabel5;
@property(nonatomic,strong)UILabel * tcLabel6;

@property(nonatomic,strong)NSDictionary * dic;
-(void)setCellWithDict:(NSDictionary *)dict;


@end
