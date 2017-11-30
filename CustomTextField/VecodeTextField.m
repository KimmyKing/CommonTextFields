//
//  VecodeTextField.m
//  CustomControl
//
//  Created by Cain on 2017/9/5.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "VecodeTextField.h"

@interface VecodeTextField ()

@property (nonatomic , strong)NSTimer *timer;

@property (nonatomic , assign)int second;

@end

@implementation VecodeTextField

- (void)prepareTextFieldWithDefaultSetting
{
    self.rightViewMode = UITextFieldViewModeAlways;
    
    //重获验证码按钮
    _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    _button.backgroundColor = [UIColor whiteColor];
    _button.titleLabel.font = [UIFont systemFontOfSize:12];
    _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = _button;
}

//MARK: -
//MARK: -- 点击按钮
- (void)clickButton:(UIButton *)sender
{
    sender.enabled = NO;
    _second = 60;
    
    if ([_vecodeDelegate respondsToSelector:@selector(clickButtonWithTextField:startTimer:executeButton:)]) {
        [_vecodeDelegate clickButtonWithTextField:self startTimer:@selector(startTimer) executeButton:@selector(executeButton)];
    }
}

- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

- (void)executeButton
{
    _button.enabled = YES;
}

- (void)countdown
{
    _second--;
    [self.button setTitle:[NSString stringWithFormat:@"%d",_second] forState:UIControlStateNormal];
    
    if (_second < 0) {
        [_button setTitle:@"重获验证码" forState:UIControlStateNormal];
        [_timer invalidate];
        _second = 60;
        _button.enabled = YES;
    }
}

@end
