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
 */
- (void)clickButtonWithTextField:(VecodeTextField *)textField button:(UIButton *)button;

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

@property (nonatomic, assign)int maxSecond;

/**
 开启计时器
 */
- (void)startTimer;


/**
 重置
 */
- (void)reset;

/**
 全能构造方法

 @param frame <#frame description#>
  @param rightView rightView有且只能包含一个button
 @param second 倒计时时间
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame rightView:(UIView *)rightView second:(int)second;

@end
