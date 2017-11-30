//
//  ViewController.m
//  Test
//
//  Created by Cain on 2017/11/22.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "ViewController.h"
#import "CustomTextField.h"


@interface ViewController ()

@property (nonatomic , strong)PhoneTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField = [[PhoneTextField alloc] initWithFrame:CGRectMake(50, 100, 300, 40)];
    _textField.backgroundColor = [UIColor redColor];
    _textField.placeholder = @"input your phone number";
    [self.view addSubview:_textField];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([_textField isCorrectPhoneNumber]) {
        NSLog(@"correct number");
    }else{
        NSLog(@"error number");
    }
}


@end
