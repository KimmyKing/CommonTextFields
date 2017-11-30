//
//  VecodeTextField.h
//  CustomControl
//
//  Created by Cain on 2017/9/5.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "BaseTextField.h"

@class VecodeTextField;

@protocol VecodeTFDelegate <NSObject>


/**
 点击重获验证码按钮

 @param textField 当前的文本输入框
 @param startTimer 提供外部的方法:开始计时器
 @param executeButton 提供外部的方法,解禁按钮
 */
- (void)clickButtonWithTextField:(VecodeTextField *)textField startTimer:(SEL)startTimer executeButton:(SEL)executeButton;

@end

@interface VecodeTextField : BaseTextField

@property (nonatomic , weak)id <VecodeTFDelegate>vecodeDelegate;

//重获验证码按钮
@property (nonatomic , strong)UIButton *button;

@end
