//
//  ViewController.m
//  Test
//
//  Created by Cain on 2017/11/22.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "ViewController.h"
#import "CustomTextField.h"
#import "NextViewController.h"

@interface ViewController ()<VecodeTextFieldDelegate>

@property (weak, nonatomic) IBOutlet MoneyTextField *moneyTF;

@property (weak, nonatomic) IBOutlet PhoneTextField *phoneTF;
@property (nonatomic, strong)PhoneTextField *phoneTF1;
@property (nonatomic, strong)PhoneTextField *phoneTF2;

@property (weak, nonatomic) IBOutlet VecodeTextField *vecodeTF;
@property (nonatomic, strong)VecodeTextField *vecodeTF1;
@property (nonatomic, strong)VecodeTextField *vecodeTF2;

@property (nonatomic, assign)SEL startTimer;

@property (nonatomic , assign)SEL reenableButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MoneyTextField *moneyTF1 = [MoneyTextField textFieldWithType:BaseTextFieldTypeMoney];
    moneyTF1.frame = CGRectMake(0, 100, 200, 30);
    moneyTF1.placeholder = @"只能输入金额";
    [self.view addSubview:moneyTF1];
   
    MoneyTextField *moneyTF2 = [[MoneyTextField alloc] init];
    moneyTF2.frame = CGRectMake(0, 140, 200, 30);
    moneyTF2.placeholder = @"只能输入金额";
    [self.view addSubview:moneyTF2];
    
    self.phoneTF1 = [PhoneTextField textFieldWithType:BaseTextFieldTypePhone];
    self.phoneTF1.frame = CGRectMake(0, 170, 200, 30);
    self.phoneTF1.placeholder = @"只能输入手机号";
    [self.view addSubview:self.phoneTF1];
    
    self.phoneTF2 = [[PhoneTextField alloc] init];
    self.phoneTF2.frame = CGRectMake(0, 210, 200, 30);
    self.phoneTF2.placeholder = @"只能输入手机号";
    [self.view addSubview:self.phoneTF2];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 21)];
    line.backgroundColor = UIColor.redColor;
    [rightView addSubview:line];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 100, 14)];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightView addSubview:btn];
    
    self.vecodeTF.maxSecond = 20;
    self.vecodeTF.rightView = rightView;
    self.vecodeTF.vecodeDelegate = self;

//    self.vecodeTF1 = [[VecodeTextField alloc] initWithFrame:CGRectMake(0, 240, 300, 30) rightView:rightView second:10];
//    self.vecodeTF1.placeholder = @"请输入验证码";
//    self.vecodeTF1.vecodeDelegate = self;
//    [self.view addSubview:self.vecodeTF1];
    
//    self.vecodeTF2 = [[VecodeTextField alloc] initWithFrame:CGRectMake(0, 240, 300, 30)];
//    self.vecodeTF2.maxSecond = 10;
//    self.vecodeTF2.rightView = rightView;
//    self.vecodeTF2.placeholder = @"请输入验证码";
//    self.vecodeTF2.vecodeDelegate = self;
//    [self.view addSubview:self.vecodeTF2];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    NextViewController *vc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)checkPhoneNumber:(id)sender {
    
    if (self.phoneTF.isCorrectPhoneNumber || self.phoneTF1.isCorrectPhoneNumber || self.phoneTF2.isCorrectPhoneNumber) {
        NSLog(@"This is a correct phone number");
    }else{
        NSLog(@"This is a error phone number");
    }
    
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

- (IBAction)clickButton:(id)sender
{
    NextViewController *vc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)stopTimer:(id)sender
{
    [self.vecodeTF reset];
    [self.vecodeTF1 reset];
    [self.vecodeTF2 reset];
}

@end
