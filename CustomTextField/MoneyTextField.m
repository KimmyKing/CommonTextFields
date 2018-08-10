//
//  CCMoneyTextField.m
//  CCFin
//
//  Created by Cain on 2017/11/20.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "MoneyTextField.h"

@interface MoneyTextField() <UITextFieldDelegate>

@end

@implementation MoneyTextField

- (void)prepareTextFieldWithDefaultSetting
{
    self.delegate = self;
    self.keyboardType = UIKeyboardTypeDecimalPad;
}

//MARK: -
//MARK: --UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *myDotNumbers = @"0123456789.\n";
    NSString *myNumbers = @"0123456789\n";
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        NSCharacterSet *characterSet;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        
        // 判断字符串中是否有小数点，并且小数点不在第一位
        
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        
        if (dotLocation == NSNotFound && range.location != 0) {
            
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            
            /*
             [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            characterSet = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
            if (range.location >= 9) {
                NSLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == 9) {
                    return YES;
                }
                return NO;
            }
            
        }else {
            
            characterSet = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
            
        }
        // 按characterSet分离出数组,数组按@""分离出字符串
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if (!basicTest) {
            
            NSLog(@"只能输入数字和小数点");
            
            return NO;
            
        }
        
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            
            NSLog(@"小数点后最多两位");
            
            return NO;
        }
        if (textField.text.length > 11) {
            
            return NO;
            
        }
    }
    return YES;
}


@end
