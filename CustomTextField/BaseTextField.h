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


/**
 构造方法

 @param frame 位置
 @param placeholder 占位字符
 @param color 边框色
 @param target <#target description#>
 @param selector 编辑时接受消息的函数名
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder borderColor:(UIColor *)color target:(id)target selector:(SEL)selector;

@end
