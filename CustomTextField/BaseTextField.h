//
//  CCBaseTextField.h
//  CCFin
//
//  Created by Cain on 2017/11/6.
//  Copyright © 2017年 Goldian. All rights reserved.
//


/*
 !!!: 开始编辑的位置自带空格 
 */
#import <UIKit/UIKit.h>
#import "BaseTextFieldDelegate.h"

@interface BaseTextField : UITextField <BaseTextFieldDelegate>

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder borderColor:(UIColor *)color target:(id)target selector:(SEL)selector;

@end
