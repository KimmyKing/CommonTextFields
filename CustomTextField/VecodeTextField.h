//
//  VecodeTextField.h
//  CustomControl
//
//  Created by Cain on 2017/9/5.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "BaseTextField.h"

@class VecodeTextField;

@protocol VecodeTextFieldDelegate <NSObject>


/**
 点击重获验证码按钮

 @param textField 当前的文本输入框
 @param button 点击的按钮
 @param startTimer 提供外部的方法:开始计时器
 @param reenableButto 提供外部的方法,解禁按钮
 */
- (void)clickButtonWithTextField:(VecodeTextField *)textField button:(UIButton *)button startTimer:(SEL)startTimer reenableButton:(SEL)reenableButto;

/**
 正在倒计时
 
 @param textField 当前的文本输入框
 @param second 倒计时的秒数
 @param button 获取验证码按钮
 */
- (void)vecodeTextField:(VecodeTextField *)textField isCountDown:(int)second button:(UIButton *)button;

@end

@interface VecodeTextField : BaseTextField

@property (nonatomic , weak)id <VecodeTextFieldDelegate>vecodeDelegate;

/**
 构造方法:

 @param frame <#frame description#>
 @param rightView rightView有且只能包含一个button
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame rightView:(UIView *)rightView;

@end
