//
//  PlayerTableViewController.m
//  peixun
//
//  Created by michael on 2017/6/16.
//  Copyright © 2017年 michael. All rights reserved.
//

#import "PlayerTableViewController.h"


@interface PlayerTableViewController ()

@end

@implementation PlayerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _players = [NSMutableArray arrayWithCapacity:20];
    
    
    Player *player = [[Player alloc] init];
    player.name = @"Bill Evans";
    player.game = @"Tic-Tac-Toe";
    player.rating = 4;
    [_players addObject:player];
    
    player = [[Player alloc] init];
    player.name = @"Oscar Peterson";
    player.game = @"Spin the Bottle";
    player.rating = 5;
    [_players addObject:player];
    
    
    player = [[Player alloc] init];
    player.name = @"Dave Brubeck";
    player.game = @"Texas Hold’em Poker";
    player.rating = 2;
    [_players addObject:player];
    
    
    // 初始化Session对象
    self.session = [AFHTTPSessionManager manager];
    // 设置请求接口回来的时候支持什么类型的数据
    self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
  
    
    
}



#pragma mark - 网络监测按钮的响应方法
- (IBAction)NetworkmonitoringAction:(id)sender {
    
    if (!isOpen) {
        //打开网络监测
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        isOpen = YES;
        
        
    } else {
        // 关闭网络监测
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        
        isOpen = NO;
        
    }
    
    // 接下来会判断当前是WiFi状态还是3g状态,网络不可用状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"当前网络处于未知状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"当前网络处于未链接状态");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机流量网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi状态");
                break;
            default:
                break;
        }
    }];
    
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [[self players] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerCell" forIndexPath:indexPath];
    
    Player *player = [_players objectAtIndex:indexPath.row];
    
    cell.textLabel.text = player.name;
    cell.detailTextLabel.text = player.game;
    
    // Configure the cell...
    
    return cell;
}



-(void)sendGetRequest{
    
    //    1.设置请求路径
    NSString *urlStr=[NSString stringWithFormat:@"http://106.14.95.85/hello?act=123"];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    //    2.创建请求对象
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    
    
    //    3.发送请求
    //3.1发送同步请求，在主线程执行
    //    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //（一直在等待服务器返回数据，这行代码会卡住，如果服务器没有返回数据，那么在主线程UI会卡住不能继续执行操作）
    
    //3.1发送异步请求
    //创建一个队列（默认添加到该队列中的任务异步执行）
    //    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    //获取一个主队列
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"--block回调数据--%@---%lu", [NSThread currentThread],(unsigned long)data.length);
        
        if (data) {
            //解析data
            /*
             {"success":"登录成功"}
             {"error":"用户名不存在"}
             {"error":"密码不正确"}
             */
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dict);
            
           
        }
        
    }];
    NSLog(@"请求发送完毕");
    
}



- (void)sendPostRequest{
    
    NSURL *url = [NSURL URLWithString:@"http://106.14.95.85/hellopost"];
    
    NSString *post=@"{username:'daoying',age:32}";
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:10.0];
    
    // NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               /*  if (error) {
                                NSLog(@"Httperror:%@%d", error.localizedDescription,error.code);
                                }else{
                                
                                NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                
                                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                
                                NSLog(@"HttpResponseCode:%d", responseCode);
                                NSLog(@"HttpResponseBody %@",responseString);
                                _myLabel.text = responseString;
                                
                                }*/
                               
                               
                               NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               NSLog(@"%@",ret);
                               //解析返回的数据JSON格式字符串
                               NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSLog(@"%@",dic);
                               
                               
                           }];
    
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
