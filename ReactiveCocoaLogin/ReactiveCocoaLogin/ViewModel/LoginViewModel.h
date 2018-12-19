//
//  LoginViewModel.h
//  ReactiveCocoaLogin
//
//  Created by 周凌宇 on 16/5/20.
//  Copyright © 2016年 周凌宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString   *userName;
@property (nonatomic, strong) NSString   *password;
// 成功信号
@property (nonatomic, strong) RACSubject *successSubject;
// 失败信号
@property (nonatomic, strong) RACSubject *failureSubject;
// 错误信号
@property (nonatomic, strong) RACSubject *errorSubject;

/**
 *  按钮是否可点信息
 *
 *  @return
 */
- (RACSignal *)validSignal;
/**
 *  登陆操作
 */
- (void)login;

@end
