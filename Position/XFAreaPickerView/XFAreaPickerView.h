//
//  XFAreaPickerView.h
//  SCPay
//
//  Created by weihongfang on 2017/7/6.
//  Copyright © 2017年 weihongfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFAreaPickerView;

@protocol XFAreaPickerViewDelegate <NSObject>

- (void)areaPickerView:(XFAreaPickerView *)areaPickerView didSelectArea:(NSString *)area;

@end

@interface XFAreaPickerView : UIView

//+ (XFAreaPickerView *)newAreaPicker;

@property(nonatomic, assign) BOOL isHidden;
@property(nonatomic, assign) id<XFAreaPickerViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<XFAreaPickerViewDelegate>)delegate;

@end
