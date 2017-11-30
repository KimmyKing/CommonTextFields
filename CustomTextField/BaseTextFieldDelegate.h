//
//  BaseTextFieldDelegate.h
//  CustomTextField
//
//  Created by Cain on 2017/11/22.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseTextFieldDelegate <NSObject>


/**
 进行默认配置
 */
- (void)prepareTextFieldWithDefaultSetting;

@end
