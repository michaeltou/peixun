//
//  LoginViewController.h
//  peixun
//
//  Created by michael on 2017/8/16.
//  Copyright © 2017年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking.h>


@interface LoginViewController : UIViewController


// 用于网络请求的Session对象
@property (nonatomic, strong) AFHTTPSessionManager *session;


@end
