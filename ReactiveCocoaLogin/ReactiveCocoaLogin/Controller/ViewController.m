//
//  ViewController.m
//  ReactiveCocoaLogin
//
//  Created by 周凌宇 on 16/5/20.
//  Copyright © 2016年 周凌宇. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "LoginViewModel.h"
#import "User.h"

@interface ViewController ()
@property (nonatomic, strong) LoginViewModel *viewModel;
@property (weak, nonatomic  ) IBOutlet UITextField    *tfUserName;
@property (weak, nonatomic  ) IBOutlet UITextField    *tfPassword;
@property (weak, nonatomic  ) IBOutlet UIButton       *btLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindModel];
}

/**
 *  绑定Model中的各种事件
 */
- (void)bindModel {
    self.viewModel = [[LoginViewModel alloc] init];
    RAC(self.viewModel, userName) = self.tfUserName.rac_textSignal;
    RAC(self.viewModel, password) = self.tfPassword.rac_textSignal;
    RAC(self.btLogin, enabled) = [self.viewModel validSignal];
    
//    @weakify(self);
    // 订阅登录成功信号并作出处理
    [self.viewModel.successSubject subscribeNext:^(NSArray * x) {
//        @strongify(self);
        User *user = x[0];
        NSLog(@"username:%@\tpassword:%@", user.username, user.password);
        NSLog(@"登陆成功");
    }];
    
    // 订阅登录失败信号并作出处理
    [self.viewModel.failureSubject subscribeNext:^(id x) {
        NSLog(@"登陆失败");
    }];
    
    // 订阅登录错误信号并作出处理
    [self.viewModel.errorSubject subscribeNext:^(id x) {
        NSLog(@"登陆错误");
    }];
    
    // 添加按钮点击事件
    [[self.btLogin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel login];
    }];
    
}

@end
