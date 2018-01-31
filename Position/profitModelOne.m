//
//  profitModelOne.m
//  futures
//
//  Created by apple on 17/9/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "profitModelOne.h"

@implementation profitModelOne
+(instancetype)model;
{
    static dispatch_once_t onceToken;
    static profitModelOne * model;
    dispatch_once(&onceToken, ^{
        model = [[profitModelOne alloc] init];
    });
    return model;
}
@end
