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

@property (weak, nonatomic) IBOutlet MoneyTextField *moneyTF;

@property (weak, nonatomic) IBOutlet PhoneTextField *phoneTF;

@property (weak, nonatomic) IBOutlet VecodeTextField *vecodeTF;

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
    
    PhoneTextField *phoneTF1 = [PhoneTextField textFieldWithType:BaseTextFieldTypePhone];
    phoneTF1.frame = CGRectMake(0, 170, 200, 30);
    phoneTF1.placeholder = @"只能输入手机号";
    [self.view addSubview:phoneTF1];
    
    PhoneTextField *phoneTF2 = [[PhoneTextField alloc] init];
    phoneTF2.frame = CGRectMake(0, 210, 200, 30);
    phoneTF2.placeholder = @"只能输入手机号";
    [self.view addSubview:phoneTF2];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 21)];
    line.backgroundColor = UIColor.redColor;
    [rightView addSubview:line];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 100, 14)];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightView addSubview:btn];
    
//    self.vecodeTF.rightView = rightView;
//    self.vecodeTF.vecodeDelegate = self;

//    VecodeTextField *vecodeTF1 = [[VecodeTextField alloc] initWithFrame:CGRectMake(0, 240, 300, 30) rightView:rightView];
//    vecodeTF1.placeholder = @"请输入验证码";
//    vecodeTF1.vecodeDelegate = self;
//    [self.view addSubview:vecodeTF1];
    
    VecodeTextField *vecodeTF2 = [[VecodeTextField alloc] initWithFrame:CGRectMake(0, 240, 300, 30)];
    vecodeTF2.rightView = rightView;
    vecodeTF2.placeholder = @"请输入验证码";
    vecodeTF2.vecodeDelegate = self;
    [self.view addSubview:vecodeTF2];

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
- (void)clickButtonWithTextField:(VecodeTextField *)textField button:(UIButton *)button startTimer:(SEL)startTimer reenableButton:(SEL)reenableButton
{
    button.enabled = NO;
    //开始倒计时
    if ([textField respondsToSelector:startTimer]) {
        [textField performSelector:startTimer];
    }
    self.startTimer = startTimer;
    self.reenableButton = reenableButton;
}

- (IBAction)startTimer:(id)sender {
    if ([self.vecodeTF respondsToSelector:self.startTimer]) {
        [self.vecodeTF performSelector:self.startTimer];
    }
}

- (IBAction)stopTimer:(id)sender {
    
    if ([self.vecodeTF respondsToSelector:self.reenableButton]) {
        [self.vecodeTF performSelector:self.reenableButton];
    }
}
#pragma clang diagnostic pop

- (void)vecodeTextField:(VecodeTextField *)textField isCountDown:(int)second button:(UIButton *)button
{
    [button setTitle:[NSString stringWithFormat:@"重新获取%ds", second] forState:UIControlStateNormal];
}

@end
