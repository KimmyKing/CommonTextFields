//
//  ViewController.m
//  Test
//
//  Created by Cain on 2017/11/22.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "ViewController.h"
#import "CustomTextField.h"

@interface ViewController ()<VecodeTFDelegate>

@property (weak, nonatomic) IBOutlet BaseTextField *baseTF;

@property (weak, nonatomic) IBOutlet MoneyTextField *moneyTF;

@property (weak, nonatomic) IBOutlet PhoneTextField *phoneTF;

@property (weak, nonatomic) IBOutlet VecodeTextField *vecodeTF;

@property (nonatomic , assign)SEL reenableButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.vecodeTF.vecodeDelegate = self;
    
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
}
#pragma clang diagnostic pop

@end
