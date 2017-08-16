//
//  MineViewController.m
//  peixun
//
//  Created by michael on 2017/8/16.
//  Copyright © 2017年 michael. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gotoLoginPage:(id)sender {
    
    //页面跳转最好的方式
    LoginViewController *loginVC  =  [self.storyboard instantiateViewControllerWithIdentifier:@"loginscene"];
    
    
    [ self presentViewController:loginVC animated: YES completion:nil];
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
