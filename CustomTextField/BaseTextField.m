//
//  CCBaseTextField.m
//  CCFin
//
//  Created by Cain on 2017/11/6.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "BaseTextField.h"
#import "MoneyTextField.h"
#import "PhoneTextField.h"
#import "VecodeTextField.h"

@implementation BaseTextField

+ (instancetype)textFieldWithType:(BaseTextFieldType)textFieldType
{
    BaseTextField *textField;
    switch (textFieldType) {
        case BaseTextFieldTypeMoney:
            textField = [[MoneyTextField alloc] init];
            break;
        case BaseTextFieldTypePhone:
            textField = [[PhoneTextField alloc] init];
            break;
        case BaseTextFieldTypeVecode:
            textField = [[VecodeTextField alloc] init];
            break;
    }
    [textField prepareTextFieldWithDefaultSetting];
    return textField;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareTextFieldWithDefaultSetting];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self prepareTextFieldWithDefaultSetting];
}

- (void)prepareTextFieldWithDefaultSetting
{
    
}

@end
