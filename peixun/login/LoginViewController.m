//
//  LoginViewController.m
//  peixun
//
//  Created by michael on 2017/8/16.
//  Copyright © 2017年 michael. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernametext;
@property (weak, nonatomic) IBOutlet UITextField *passwordtext;

 
@end

@implementation LoginViewController


- (IBAction)backNavigate:(id)sender {
    
    
     

     [self dismissViewControllerAnimated:YES completion:nil];//从nextVC界面回去
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化Session对象
    self.session = [AFHTTPSessionManager manager];
    // 设置请求接口回来的时候支持什么类型的数据
     self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    //[self.session.requestSerializer  setValue:@"application/json"  forHTTPHeaderField:@"Accept"];
    
    //[self.session.requestSerializer    setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    
    
    
    
    NSString * username= [_usernametext text];
    NSString * password = [_passwordtext text];
    
     NSLog(@"触发登陆");
    NSLog(username,nil);
    NSLog(password,nil);
    
    
    /*{
     do = "pri_memberlist";
     "member_id" = zpHr2dsRvQQxYJxo2;
     "workspace_id" = ILfYpE4Dhs2gWcuQx;
     }*/
    NSString *urlString = @"http://106.14.95.85/processLoginForApp";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    [dict setObject:username  forKey:@"username"];
    [dict setObject:password forKey:@"password"];
    
    // 参数1: url
    // 参数2: body体
    [self.session POST:urlString
            parameters:dict
     
              progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"post请求成功%@", responseObject);
        
        
        //self.jsonDic = (NSDictionary *)responseObject;
        
      NSString *isSuccess = [responseObject[@"success"] stringValue] ;
        NSLog(@"登陆结果:%@",isSuccess);
        
        if ([isSuccess isEqualToString: @"1"]) {
            NSLog(@"登陆成功！");
        }else{
            NSLog(@"登陆失败！");
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post请求失败:%@", error);
    }];
    
   
    
}

/**
 responseObject 结果解析.
 
 http://www.itstrike.cn/Question/2a86c09f-92cc-47cf-a4bb-82ca3154cff6.html
 
 
 更改顺序，和一些引号就被剥夺了。每当我试图使用的 responseObject ("song_name"期望) 值，我的应用程序崩溃与
 
 -[__NSCFNumber length]: unrecognized selector sent to instance
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFNumber length]: unrecognized selector sent to instance
 我到底做错了?
 
 解决方法 1:
 
 你的 JSON 对象中一切，除了 song_name 是 NSNumber (这不懂选择器"长度")。您可以使用选择器"stringValue"将 NSNumber 转换为 NSString。
 
 就像这个样子:
 
 NSString* song_id_str = [responseObject[@"song_id"] stringValue];
 或者你只是使用 NSNumber
 
 NSNumber* song_id = responseObject[@"song_id"];
 
 **/



#pragma mark - get请求
- (IBAction)getRequestAction:(id)sender {
    
    
    
    
    
    // 参数1: get请求的网址
    // 参数2: 拼接参数
    // 参数3: 当前的进度
    // 参数4: 请求成功
    // 参数5: 请求失败
    [self.session GET:@"http://api.yhouse.com/m/city/dynmiclist" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功:%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);
    }];
    
    
}

#pragma mark - post请求
- (IBAction)postRequestAction:(id)sender {
    
    /*{
     do = "pri_memberlist";
     "member_id" = zpHr2dsRvQQxYJxo2;
     "workspace_id" = ILfYpE4Dhs2gWcuQx;
     }*/
    NSString *urlString = @"http://m.taskwedo.com/API/wedo1/wedo.php";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"pri_memberlist" forKey:@"do"];
    
    [dict setObject:@"zpHr2dsRvQQxYJxo2" forKey:@"member_id"];
    [dict setObject:@"ILfYpE4Dhs2gWcuQx" forKey:@"workspace_id"];
    // 参数1: url
    // 参数2: body体
    [self.session POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"post请求成功%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post请求失败:%@", error);
    }];
}

#pragma mark - post2请求
- (IBAction)postTwoRequestAction:(id)sender {
    
    /*address = "";
     comment = "\U7c7b\U6a21\U5757\U8ba1\U5212\U7528\U5230\U7b2c\U4e09\U90e8\U5206\U4e2d\Uff0c\U5f85\U63d0\U95ee\U3001\U56de\U7b54\U79ef\U7d2f\U5230\U4e00\U5b9a\U6570\U91cf\U65f6\Uff0c\U4fbf\U4e8e\U5927\U5bb6\U7684\U95ee\U9898\U7684\U5feb\U901f\U67e5\U627e\Uff0c\U6240\U4ee5\U63d0\U95ee\U90e8\U5206\U6682\U65f6\U4e0d\U52a0\U5165\U8fd9\U4e2a";
     do = "add_comment";
     kind = task;
     "member_id" = zpHr2dsRvQQxYJxo2;
     other = "";
     "task_id" = 55a47e79ec25e3641;*/
    
    NSString *urlString = @"http://m.taskwedo.com/API/wedo1/wedo.php";
    
    NSString *commonContent = @"类模块计划用到第三部分中，待提问、回答积累到一定数量时，便于大家的问题的快速查找，所以提问部分暂时不加入这个";
    // 把汉字进行编码
    commonContent = [commonContent stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"" forKey:@"address"];
    [dict setValue:commonContent forKey:@"comment"];
    [dict setValue:@"add_comment" forKey:@"do"];
    [dict setValue:@"task" forKey:@"kind"];
    [dict setValue:@"zpHr2dsRvQQxYJxo2" forKey:@"member_id"];
    [dict setValue:@"" forKey:@"other"];
    [dict setValue:@"55a47e79ec25e3641" forKey:@"task_id"];
    
    [self.session POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"post请求成功:%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post请求失败:%@", error);
    }];
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
