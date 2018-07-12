//
//  ViewController.m
//  Test
//
//  Created by Cain on 2017/11/22.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "ViewController.h"
#import "CustomTextField.h"

@interface ViewController ()<VecodeTextFieldDelegate>

@property (weak, nonatomic) IBOutlet BaseTextField *baseTF;

@property (weak, nonatomic) IBOutlet MoneyTextField *moneyTF;

@property (weak, nonatomic) IBOutlet PhoneTextField *phoneTF;

@property (weak, nonatomic) IBOutlet VecodeTextField *vecodeTF;

@property (nonatomic , assign)SEL reenableButton;

@property (nonatomic , strong)VecodeTextField *vecodeTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 21)];
    line.backgroundColor = UIColor.redColor;
    [rightView addSubview:line];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 14)];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightView addSubview:btn];
    
    self.vecodeTF.rightView = rightView;
    self.vecodeTF.vecodeDelegate = self;
    
    [self.view addSubview:self.vecodeTextField];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)checkPhoneNumber:(id)sender {
    
    if ([self.phoneTF isCorrectPhoneNumber]) {
        NSLog(@"This is a correct phone number");
    }else{
        NSLog(@"This is a error phone number");
    }
    
}

//MARK: -
//MARK: --VecodeTFDelegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)clickButtonWithTextField:(VecodeTextField *)textField startTimer:(SEL)startTimer reenableButton:(SEL)reenableButton
{
    //开始倒计时
    if ([textField respondsToSelector:startTimer]) {
        [textField performSelector:startTimer];
    }
    self.reenableButton = reenableButton;
}

- (IBAction)stopTimer:(id)sender {
    
    if ([self.vecodeTF respondsToSelector:self.reenableButton]) {
        [self.vecodeTF performSelector:self.reenableButton];
    }
    
    if ([self.vecodeTextField respondsToSelector:self.reenableButton]) {
        [self.vecodeTextField performSelector:self.reenableButton];
    }
}
#pragma clang diagnostic pop

- (void)vecodeTextField:(VecodeTextField *)textField isCountDown:(int)second button:(UIButton *)button
{
    [button setTitle:[NSString stringWithFormat:@"重新获取%ds", second] forState:UIControlStateNormal];
}

- (VecodeTextField *)vecodeTextField
{
    if (!_vecodeTextField) {
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 21)];
        line.backgroundColor = UIColor.redColor;
        [rightView addSubview:line];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 14)];
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightView addSubview:btn];
        
        _vecodeTextField = [[VecodeTextField alloc] initWithFrame:CGRectMake(0, 500, 375, 30) rightView:rightView];
        _vecodeTextField.placeholder = @"通过代码加载的vecodeTextField";
        _vecodeTextField.vecodeDelegate = self;
    }
    return _vecodeTextField;
}

@end
