//
//  CCBaseTextField.m
//  CCFin
//
//  Created by Cain on 2017/11/6.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

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

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder borderColor:(UIColor *)color target:(id)target selector:(SEL)selector
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = placeholder;
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self addTarget:target action:selector forControlEvents:UIControlEventEditingChanged];
        [self prepareTextFieldWithDefaultSetting];
    }
    return self;
}

- (void)prepareTextFieldWithDefaultSetting
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
