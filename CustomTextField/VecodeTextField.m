//
//  VecodeTextField.m
//  CustomControl
//
//  Created by Cain on 2017/9/5.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "VecodeTextField.h"

//缓存代理响应方法的结构体
struct{
    BOOL clickVecodeButton;
    BOOL isCountDown;
} vecodeDelegateCache;

@interface VecodeTextField ()

//重获验证码按钮
@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)NSTimer *timer;

@property (nonatomic, assign)int currentSecond;

@end

@implementation VecodeTextField

- (instancetype)initWithFrame:(CGRect)frame rightView:(UIView *)rightView second:(int)second
{
    if (self = [super initWithFrame:frame]) {
        self.rightView = rightView;
        self.maxSecond = second;
        self.currentSecond = second;
        [self findButtonWithView:self.rightView];
    }
    return self;
}

- (void)prepareTextFieldWithDefaultSetting
{
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setMaxSecond:(int)maxSecond
{
    _maxSecond = maxSecond;
    self.currentSecond = maxSecond;
    [self findButtonWithView:self.rightView];
}

- (void)setRightView:(UIView *)rightView
{
    [super setRightView:rightView];
    [self findButtonWithView:self.rightView];
}

//MARK: -
//MARK: -- 只需要判断一次是否响应代理方法(将结果缓存)
- (void)setVecodeDelegate:(id<VecodeTextFieldDelegate>)vecodeDelegate
{
    _vecodeDelegate = vecodeDelegate;
    vecodeDelegateCache.clickVecodeButton = [vecodeDelegate respondsToSelector:@selector(clickButtonWithTextField:button:)];
    vecodeDelegateCache.isCountDown = [vecodeDelegate respondsToSelector:@selector(vecodeTextField:isCountDown:button:)];
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
    if (vecodeDelegateCache.clickVecodeButton) {
        [_vecodeDelegate clickButtonWithTextField:self button:sender];
    }
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)countdown
{
    self.currentSecond--;
    if (vecodeDelegateCache.isCountDown) {
        [self.vecodeDelegate vecodeTextField:self isCountDown:self.currentSecond button:self.button];
    }
    if (self.currentSecond < 0) {
        [self reset];
    }
}

- (void)reset
{
    [self.button setTitle:@"重获验证码" forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = nil;
    self.currentSecond = self.maxSecond;
    self.button.enabled = YES;
}

//MARK: -
//MARK: -- 防止循环引用
- (void)removeFromSuperview
{
    [self reset];
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"%s", __func__);
#endif
}

@end
