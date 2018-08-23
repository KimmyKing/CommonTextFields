//
//  NextViewController.m
//  Test
//
//  Created by Cain on 2018/8/14.
//  Copyright © 2018年 Goldian. All rights reserved.
//

#import "NextViewController.h"
#import "CustomTextField.h"

@interface NextViewController ()<VecodeTextFieldDelegate>

@property (nonatomic, strong)VecodeTextField *vecodeTF1;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 21)];
    line.backgroundColor = UIColor.redColor;
    [rightView addSubview:line];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 100, 14)];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightView addSubview:btn];
    
    self.vecodeTF1 = [[VecodeTextField alloc] initWithFrame:CGRectMake(0, 240, 300, 30) rightView:rightView second:10];
    self.vecodeTF1.placeholder = @"请输入验证码";
    self.vecodeTF1.vecodeDelegate = self;
    [self.view addSubview:self.vecodeTF1];
}

//MARK: -
//MARK: --VecodeTFDelegate
- (void)clickButtonWithTextField:(VecodeTextField *)textField button:(UIButton *)button
{
    button.enabled = NO;
    //开始倒计时
    [textField startTimer];
}

- (void)vecodeTextField:(VecodeTextField *)textField isCountDown:(int)second button:(UIButton *)button
{
    [button setTitle:[NSString stringWithFormat:@"重新获取%ds", second] forState:UIControlStateNormal];
}

- (void)dealloc
{    
    NSLog(@"%s", __func__);
}

@end
