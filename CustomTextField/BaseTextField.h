//
//  CCBaseTextField.h
//  CCFin
//
//  Created by Cain on 2017/11/6.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextFieldDelegate.h"

typedef enum : NSUInteger {
    BaseTextFieldTypeMoney,
    BaseTextFieldTypePhone,
    BaseTextFieldTypeVecode,
} BaseTextFieldType;

@interface BaseTextField : UITextField <BaseTextFieldDelegate>

/**
  类族模式的构造方法

 @param textFieldType 输入框类型
 @return 对应的输入框
 */
+ (instancetype)textFieldWithType:(BaseTextFieldType)textFieldType;

@end
