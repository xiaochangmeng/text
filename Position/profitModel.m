//
//  profitModel.m
//  futures
//
//  Created by apple on 17/9/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "profitModel.h"

@implementation profitModel
+(instancetype)model;
{
    static dispatch_once_t onceToken;
    static profitModel * model;
    dispatch_once(&onceToken, ^{
        model = [[profitModel alloc] init];
    });
    return model;
}
@end
