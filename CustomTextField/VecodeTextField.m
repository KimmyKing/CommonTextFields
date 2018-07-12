//
//  VecodeTextField.m
//  CustomControl
//
//  Created by Cain on 2017/9/5.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "VecodeTextField.h"

@interface VecodeTextField ()

//重获验证码按钮
@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)NSTimer *timer;

@property (nonatomic , assign)int second;

@end

@implementation VecodeTextField

- (instancetype)initWithFrame:(CGRect)frame rightView:(UIView *)rightView
{
    if (self = [super initWithFrame:frame]) {
        
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.rightView = rightView;
        [self findButtonWithView:rightView];
        
    }
    return self;
}

- (void)prepareTextFieldWithDefaultSetting
{
    [super prepareTextFieldWithDefaultSetting];
    
    [self findButtonWithView:self.rightView];
}

- (void)setRightView:(UIView *)rightView
{
    [super setRightView:rightView];
    self.rightViewMode = UITextFieldViewModeAlways;
    [self findButtonWithView:rightView];
}

- (void)findButtonWithView:(UIView *)view
{
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:UIButton.class]) {
            self.button = obj;
            [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            *stop = YES;
        }
    }];
}

//MARK: -
//MARK: -- 点击获取验证码按钮
- (void)clickButton:(UIButton *)sender
{
    sender.enabled = NO;
    _second = 60;
    
    if ([_vecodeDelegate respondsToSelector:@selector(clickButtonWithTextField:startTimer:reenableButton:)]) {
        [_vecodeDelegate clickButtonWithTextField:self startTimer:@selector(startTimer) reenableButton:@selector(reenableButton)];
    }
}

- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

- (void)reenableButton
{
    [self resetTextField];
}

- (void)countdown
{
    _second--;
    
    if ([self.vecodeDelegate respondsToSelector:@selector(vecodeTextField:isCountDown:button:)]) {
        [self.vecodeDelegate vecodeTextField:self isCountDown:_second button:self.button];
    }
    
    if (_second < 0) {
        [self resetTextField];
    }
}

- (void)resetTextField
{
    [_button setTitle:@"重获验证码" forState:UIControlStateNormal];
    [_timer invalidate];
    _second = 60;
    _button.enabled = YES;
}

@end
