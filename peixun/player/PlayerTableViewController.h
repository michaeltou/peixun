//
//  PlayerTableViewController.h
//  peixun
//
//  Created by michael on 2017/6/16.
//  Copyright © 2017年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import <AFNetworking.h>


@interface PlayerTableViewController : UITableViewController


{
         // 进行网络监测判断的bool值
         BOOL isOpen;

}


@property (nonatomic,strong) NSMutableArray *players;


// 用于网络请求的Session对象
@property (nonatomic, strong) AFHTTPSessionManager *session;


@end
