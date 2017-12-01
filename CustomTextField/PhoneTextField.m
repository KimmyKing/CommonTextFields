//
//  PhoneTextField.m
//  CustomControl
//
//  Created by Cain on 2017/9/5.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "PhoneTextField.h"
@interface PhoneTextField ()<UITextFieldDelegate>

//上次输入的字符
@property (nonatomic , copy)NSString *lastText;
//当前光标位置
@property (nonatomic , strong)UITextRange *currentTextRange;

@end

@implementation PhoneTextField

- (void)prepareTextFieldWithDefaultSetting
{
    [super prepareTextFieldWithDefaultSetting];
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.delegate = self;
    [self addTarget:self action:@selector(actionEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}

//MARK: -
//MARK: --输入框的文本改变时
- (void)actionEditingChanged:(PhoneTextField *)textField
{
    //当前光标位置
    NSInteger currentPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    
    NSString *onlyNumberString = [self getOnlyNumberStringFromString:textField.text position:&currentPosition];
    
    //限制字数
    if (onlyNumberString.length > 11) {
        textField.text = _lastText;
        textField.selectedTextRange = _currentTextRange;
        return;
    }
    
    NSString *phoneResultString = [self getPhoneResultFromSourceString:onlyNumberString position:&currentPosition];
    textField.text = phoneResultString;
    
    UITextPosition *targetPosition = [textField positionFromPosition:textField.beginningOfDocument offset:currentPosition];
    UITextRange *range = [textField textRangeFromPosition:targetPosition toPosition:targetPosition];
    textField.selectedTextRange = range;
    
}


/**
 剔除非阿拉伯数字的函数
 
 @param sourceString 需要校验的字符串
 @param position 当前的光标位置
 @return 处理后只包含阿拉伯数字的字符串
 */
- (NSString *)getOnlyNumberStringFromString:(NSString *)sourceString position:(NSInteger *)position
{
    NSMutableString *mstr = [NSMutableString string];
    NSInteger tempPosition = *position;
    
    for (int i = 0 ; i < sourceString.length; i++) {
        
        unichar character = [sourceString characterAtIndex:i];
        
        //isdigit:检查参数c是否为阿拉伯数字0到9
        if (isdigit(character)) {
            //将unichar转为NSString
            NSString *numberString = [NSString stringWithCharacters:&character length:1];
            [mstr appendString:numberString];
            
        }else{
            
            //检测到非阿拉伯数字时,且遍历到的下标小于 当前光标位置,需要将当前光标的位置-1(计算纯阿拉伯数字的下标)
            if (i < tempPosition) {
                (*position)--;
            }
            
        }
    }
    return mstr.copy;
}


/**
 指定位置添加分隔符号
 
 @param soureceString 需要校验的字符串
 @param position 当前的光标位置
 @return 添加符号后的电话号码
 */
- (NSString *)getPhoneResultFromSourceString:(NSString *)soureceString position:(NSInteger *)position
{
    NSMutableString *mstr = [NSMutableString string];
    NSInteger tempPosition = *position;
    
    for (int i = 0; i < soureceString.length; i++) {
        
        if (i == 3 || i == 7) {
            
            [mstr appendString:@"-"];
            if (i < tempPosition) {
                (*position)++;
            }
        }
        
        unichar character = [soureceString characterAtIndex:i];
        NSString *str = [NSString stringWithCharacters:&character length:1];
        [mstr appendString:str];
        
    }
    
    return mstr.copy;
}

//MARK: - UITextFieldDelegate
//MARK: --输入框开始编辑时
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _lastText = textField.text;
    _currentTextRange = textField.selectedTextRange;
    return YES;
}

//MARK: -
//MARK: --检测手机号码是否正确
- (BOOL)isCorrectPhoneNumber
{
    [self resignFirstResponder];
    
    //正则表达式(匹配手机号3-4-4格式)
    NSString *pattren = @"^1[3578]+\\d-\\d{4}-\\d{4}";
    //SELF MATCHES:匹配正则表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattren];
    //评估输入的手机号是否匹配
    return [predicate evaluateWithObject:self.text];
}

@end
