//
//  PositionViewController.m
//  futures
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PositionViewController.h"
#import "PositionTableViewCell.h"
#import "PrepaidCashWithdrawalViewController.h"
#import "FWNullStoresView.h"
#import "HoldDetaiVController.h"

#import "closeHistoryVController.h"

#import "tradeDetailModel.h"
@interface PositionViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,SecondViewControllerDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSMutableArray * photoArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIImageView *headImageView;



@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation PositionViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nabg"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    
    self.automaticallyAdjustsScrollViewInsets =YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:USER_NAME_KEY] == nil) {
        
    }else{
        [self createTimer];
    }
    [self getData1];
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [_timer invalidate];
//     _timer = nil;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
//     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)createTimer{
//    if (_timer == nil) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updata) userInfo:nil repeats:YES];
//    }
}
- (void)updata{
    
    [self getData];
    
    
}
#pragma mark - 获取用户开户信息
-(void)getData1{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //            [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
    
    NSString * codeurl = [NSString stringWithFormat:@"%@/api/users/centreInfo.json",codeUrl4];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    NSString * userId = [userDefaults objectForKey:USER_NAME_KEY];
    NSDictionary *dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY]};
    //3.请求
    [manager POST:codeurl parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        [[CustomHua sharedInstance]stoploaddata:self.view];
        NSLog(@"服务器连接成功=============================2%@",responseObject);
        //                请求验证码返回数据
        //                验证码
        
        NSString * Boll = responseObject[@"code"];
        if ([Boll isEqualToString:@"0"]) {
            
            _type = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"type"]];
            FWNullStoresView *nullView = [FWNullStoresView fwNullStoresView];
       
            if ([_type isEqualToString:@"2"]) {
           
//                [self.myTableview.tableFooterView removeFromSuperview];
//                self.myTableview.tableFooterView = nil;
//                nullView = nil;
//                [nullView removeFromSuperview];
            }else{
             
                self.myTableview.tableFooterView = nullView;
                self.myTableview.tableFooterView.height = 400;
                nullView.forwordImage.image = [UIImage imageNamed:@"2-我的定购"];
                nullView.forwordLabel.text = @"暂无持仓单";
                //                 [nullView.ForwordBtn setTitle:@"前往预定" forState:UIControlStateNormal];
                nullView.ForwordBtn.hidden = NO;
                
                UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:3];
                item.badgeValue = nil;
                
                //#pragma mark- 前往开仓按钮跳转
                nullView.blockClick = ^(){
                    
                    self.tabBarController.selectedIndex = 2;
                };
            }
            
            
        }else{
            
            
            
        }
        
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [[CustomHua sharedInstance]stoploaddata:self.view];
        
    }];
    
    
}
-(void)getData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userId = [userDefaults objectForKey:USER_NAME_KEY];
    //  如果没有登录userId则设置为空
    if (userId == nil) {
        userId = @"";
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * url = [NSString stringWithFormat:@"%@/tiger/trade/myposition.json",codeUrl4];
    
    NSDictionary * dict = @{@"user_id":userId};
    NSLog(@"%@",dict);
    //3.请求
    [manager POST:url parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
      
        NSString * NsCode = responseObject[@"code"];
        
        if ([NsCode isEqualToString:@"0"]) {
            [[CustomHua sharedInstance]stoploaddata:self.view];
            
//            NSDictionary * dic = responseObject[@"data"];
            
            
            NSLog(@"%@",responseObject);

            [_dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:responseObject[@"data"][@"list"]];
             _OrderRecord.text = [NSString stringWithFormat:@"持仓单：%0lu",(unsigned long)self.dataArray.count];
//            self.OrderRecordAmount.text = [NSString stringWithFormat:@"定购数：%ld",self.dataArray.count];
            FWNullStoresView *nullView = [FWNullStoresView fwNullStoresView];
            if (self.dataArray.count == 0) {
#pragma mark- 持仓为空页面
                //                [OneKeyPositionButton setBackgroundColor:UIColorFromRGB(0xe5e5e5)];
                //                OneKeyPositionButton.userInteractionEnabled = NO;
                self.buttonTwo.userInteractionEnabled = NO;
                self.myTableview.tableFooterView = nullView;
                self.myTableview.tableFooterView.height = 400;
                nullView.forwordImage.image = [UIImage imageNamed:@"2-我的定购"];
                nullView.forwordLabel.text = @"暂无持仓单";
                //                 [nullView.ForwordBtn setTitle:@"前往预定" forState:UIControlStateNormal];
                nullView.ForwordBtn.hidden = NO;
                
                UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:3];
                item.badgeValue = nil;
                
                //#pragma mark- 前往开仓按钮跳转
                nullView.blockClick = ^(){
                    
                    self.tabBarController.selectedIndex = 2;
                };
            }else {
                self.buttonTwo.userInteractionEnabled = YES;
                //                OneKeyPositionButton.userInteractionEnabled = YES;
                //                [OneKeyPositionButton setBackgroundColor:UIColorFromRGB(0xd7a101)];
                [self.myTableview.tableFooterView removeFromSuperview];
                self.myTableview.tableFooterView = nil;
                nullView = nil;
                [nullView removeFromSuperview];
              
                
            }
            
            
            [self.myTableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
            [self.myTableview footerEndRefreshing];
            
            
            [self.myTableview reloadData];
            
            
//            if (self.myTableview.contentSize.height > self.myTableview.frame.size.height)
//            {
//                CGPoint offset = CGPointMake(0, self.myTableview.contentSize.height - self.myTableview.frame.size.height);
//                [self.myTableview setContentOffset:offset animated:YES];
//            }
            
        }else if ([NsCode isEqualToString:@"1"]){
            
            [self.myTableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
            [self.myTableview footerEndRefreshing];
            
            
            [[CustomHua sharedInstance]stoploaddata:self.view];
        }else if ([NsCode isEqualToString:@"666"]){
            
            
            
        }else if ([NsCode isEqualToString:@"406"]){
          
        }else if ([NsCode isEqualToString:@"405"]){
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [WKProgressHUD popMessage:@"本地登录已失效,请重新登录" inView:window duration:1.0 animated:YES];
      
        }
        
        
        [self.myTableview headerEndRefreshingWithResult:JHRefreshResultNone];
        [self.myTableview footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self.myTableview headerEndRefreshingWithResult:JHRefreshResultNone];
        [self.myTableview footerEndRefreshing];
        [[CustomHua sharedInstance]stoploaddata:self.view];
    }];
}



int chicangtime;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coupontiao) name:@"TradeSuccess" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];

    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(coupontiao) name:@"holdVCtiaozhuangback" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(EURUSDPntf1:) name:@"EURUSDPntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(GBPUSDntf1:) name:@"GBPUSDntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(USDCHFntf1:) name:@"USDCHFntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(AUDUSDntf1:) name:@"AUDUSDntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(NZDUSDntf1:) name:@"NZDUSDntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(USDJPYntf1:) name:@"USDJPYntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(EURGBPntf1:) name:@"EURGBPntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(USDCNHntf1:) name:@"USDCNHntf" object:nil];
    
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(XAGUSDntf1:) name:@"XAGUSDntf" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(XAUUSDntf1:) name:@"XAUUSDntf" object:nil];

    _profit = 0;
    _balance = @"0";
     [self createNator];
    
    



 NSString *RequestURL = [NSString stringWithFormat:@"%@/api/index/iosVersionCheck.json?version=%@",codeUrl8,iosversion];
    [[FWNetWorkTool sharedNetWorkTool] GET:RequestURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"0"])
        {
            [self chushihua];
        }else if ([responseObject[@"code"] isEqualToString:@"1"]){

chicangtime = 1;
//创建CLLocationManager对象
self.locationManager = [[CLLocationManager alloc] init];
//设置代理为自己
self.locationManager.delegate = self;

if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    [self.locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
}

[self.locationManager startUpdatingLocation];

        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];



}





- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    NSLog(@"longitude = %f", ((CLLocation *)[locations
                                             lastObject]).coordinate.longitude);
    NSLog(@"latitude = %f", ((CLLocation *)[locations lastObject]).coordinate.latitude);
    
    NSLog(@"我在定位");
    
    CGFloat longitude = ((CLLocation *)[locations
                                        lastObject]).coordinate.longitude;
    CGFloat latitude = ((CLLocation *)[locations lastObject]).coordinate.latitude;
    
    BOOL ischina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){latitude,longitude}];
    //        BOOL ischina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){23.398932,121.19027}];
    
    
    if (ischina == YES) {
        
        if (chicangtime == 1)
        {
            [self chushihua];
            chicangtime = 0;
        }
        
    }else{
        
        if (chicangtime == 1)
        {
            chicangtime = 0;
            UIAlertView * alaler = [[UIAlertView alloc] initWithTitle:nil message:@"由于法律允许范围内，我们暂时只为中国地区的用户提供服务，由于您目前不在中国大陆区域，所以没办法为您提供服务，抱歉!!!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alaler show];
            UIViewController * kongVC = [[UIViewController alloc] init];
            kongVC.view.backgroundColor = [UIColor whiteColor];
            UILabel * tishiLabel = [[UILabel alloc] init];
            tishiLabel.text = @"由于不在中国大陆，暂无法获取数据,暂不可使用,抱歉!!!";
            tishiLabel.textColor = [UIColor redColor];
            tishiLabel.numberOfLines = 0;
            [kongVC.view addSubview:tishiLabel];
            [tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(kongVC.view).offset(-50);
                make.centerX.equalTo(kongVC.view);
                make.leading.equalTo(kongVC.view).offset(20);
                make.trailing.equalTo(kongVC.view).offset(-20);
            }];
            [self addChildViewController:kongVC];
            [self.view addSubview:kongVC.view];
        }
        
    }
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:[locations
                                      lastObject] completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             NSLog(@"city = %@", city);
             
             
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}
//定位失败，回调从方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        UIAlertView * alaler = [[UIAlertView alloc] initWithTitle:nil message:@"由于法律允许范围内，我们暂时只为中国地区的用户提供服务，未能获取您的地理位置信息，我们不确定你是否在中国，所以没办法为您提供服务，抱歉!!!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alaler show];
        
        
        UIViewController * kongVC = [[UIViewController alloc] init];
        kongVC.view.backgroundColor = [UIColor whiteColor];
        UILabel * tishiLabel = [[UILabel alloc] init];
        tishiLabel.text = @"由于无法定位您的位置，暂无法获取数据,暂不可使用,抱歉!!!";
        tishiLabel.textColor = [UIColor redColor];
        tishiLabel.numberOfLines = 0;
        [kongVC.view addSubview:tishiLabel];
        [tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(kongVC.view).offset(-50);
            make.centerX.equalTo(kongVC.view);
            make.leading.equalTo(kongVC.view).offset(20);
            make.trailing.equalTo(kongVC.view).offset(-20);
        }];
        [self addChildViewController:kongVC];
        [self.view addSubview:kongVC.view];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}


-(void)chushihua{
    
    [self setTableview];
    [self getDataONe];
    
    [self getData];
    
}





-(void)coupontiao{
 [self getData];
}
-(void)getDataONe{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userId = [userDefaults objectForKey:USER_NAME_KEY];
    //  如果没有登录userId则设置为空
    if (userId == nil) {
        userId = @"";
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * url = [NSString stringWithFormat:@"%@/tiger/trade/myAccount.json",codeUrl4];
    
    NSDictionary * dict = @{@"user_id":userId};
    //3.请求
    [manager POST:url parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * NsCode = responseObject[@"code"];
        
        if ([NsCode isEqualToString:@"0"]) {
                    NSLog(@"%@",responseObject);
            self.AvailableAmount.text = [NSString stringWithFormat:@"$%@",responseObject[@"data"][@"accountInfo"][@"floating_profit"]];
            self.NetAmount.text = [NSString stringWithFormat:@"$%@",responseObject[@"data"][@"accountInfo"][@"margin_free"]];
            self.NetAmountOne.text = [NSString stringWithFormat:@"%@%@",responseObject[@"data"][@"accountInfo"][@"margin_level"],@"%"];
            
            self.differencePrice.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"accountInfo"][@"margin"]];
            
            self.differencePriceOne.text = [NSString stringWithFormat:@"$%@",responseObject[@"data"][@"accountInfo"][@"equity"]];
  
            _balance = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"accountInfo"][@"balance"]];
            _credit = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"accountInfo"][@"credit"]];
            
           
        }else if ([NsCode isEqualToString:@"1"]){
            
        
        }else if ([NsCode isEqualToString:@"666"]){
            
            
            
        }else if ([NsCode isEqualToString:@"406"]){
            
        }else if ([NsCode isEqualToString:@"405"]){
            
            
        }
        
        
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
      
    }];
}
-(void)loginSuccess{
    [self getData];
}
#pragma mark - tableview
-(void)setTableview{
    //数据初始化
    self.dataArray = [[NSMutableArray alloc] init];
    
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH-64)];
    self.myTableview.separatorStyle = NO;
    self.myTableview.delegate = self;
    self.myTableview.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.myTableview.dataSource = self;
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    self.myTableview.tableFooterView = view;
    [self.view addSubview:self.myTableview];
    //    [self.view addSubview:label];
    
    //设置tableview的头部视图
    _headImageView = [[UIImageView alloc]init];
    _headImageView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    _headImageView.frame = CGRectMake(0, 0, self.view.frame.size.width,260-18);
    _headImageView.userInteractionEnabled = YES;
    
    [self createHeadImage];
    
    
    self.myTableview.tableHeaderView = _headImageView;
    
    
    
    __weak PositionViewController *weakSelf = self;
    [self.myTableview addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //获取第一页数据
        //        [weakSelf createTimer];
        [weakSelf getData];
        [weakSelf getDataONe];
    }];
    
    [self.myTableview registerNib:[UINib nibWithNibName:@"PositionTableViewCell" bundle:nil] forCellReuseIdentifier:@"pos"];
    
}
#pragma mark - tableviewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"pos";
    
    PositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
//    if (cell == nil) {
    cell = [[[NSBundle mainBundle]loadNibNamed:@"PositionTableViewCell" owner:self options:nil]firstObject];
//    }
    cell.backgroundColor = UIColorFromRGB(0xf7f7f7);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (_dataArray.count > 0) {
        
        [cell setCellWithDict:self.dataArray[indexPath.row]];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
            return _dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        HoldDetaiVController * HoldDetaiVC = [[HoldDetaiVController alloc] init];
        HoldDetaiVC.hidesBottomBarWhenPushed = YES;
    
    HoldDetaiVC.symbol = _dataArray[indexPath.row][@"symbol"];
    HoldDetaiVC.ticketNo = _dataArray[indexPath.row][@"ticket"];
    
    
    tradeDetailModel * model = [[tradeDetailModel alloc] init];
    [model mj_setKeyValues:_dataArray[indexPath.row]];
    HoldDetaiVC.model = model;
 
    HSKStorage *storage = [[HSKStorage alloc]initWithPath:AccountPath];
    [storage hsk_setObject:_dataArray[indexPath.row][@"sl"] forKey:[NSString stringWithFormat:@"%@sun", HoldDetaiVC.ticketNo]];
    [storage hsk_setObject:_dataArray[indexPath.row][@"tp"] forKey:[NSString stringWithFormat:@"%@ying", HoldDetaiVC.ticketNo]];
        [self.navigationController pushViewController:HoldDetaiVC animated:YES
         ];
    
}
-(void)createHeadImage{

    [_headImageView addSubview:self.bgImageOne];
    [self.bgImageOne addSubview:self.AvailableFunds];
    [self.bgImageOne addSubview:self.AvailableAmount];
    [self.bgImageOne addSubview:self.buttonOne];
    [self.bgImageOne addSubview:self.GrayLabel];
    [self.bgImageOne addSubview:self.NetAmount];
    [self.bgImageOne addSubview:self.NetAssets];
    [self.bgImageOne addSubview:self.NetAmountOne];
    [self.bgImageOne addSubview:self.NetAssetsOne];
    [self.bgImageOne addSubview:self.GrayLabelOne];
    [self.bgImageOne addSubview:self.differencePrice];
    [self.bgImageOne addSubview:self.differencePriceAmount];
    [self.bgImageOne addSubview:self.differencePriceOne];
    [self.bgImageOne addSubview:self.differencePriceAmountOne];
    [_headImageView addSubview:self.bgImageTwo];
    [self.bgImageTwo addSubview:self.OrderRecord];
    
   }
-(UIImageView *)bgImageOne{
    
    if (!_bgImageOne) {
        _bgImageOne = [[UIImageView alloc] init];
        
        _bgImageOne.frame = CGRectMake(0, 0, screenW, 200);
        _bgImageOne.backgroundColor = UIColorFromRGB(0xffffff);
        _bgImageOne.userInteractionEnabled = YES;
    }
    
    
    return _bgImageOne;
}
-(UIButton *)bgImageTwo{
    
    if (!_bgImageTwo) {
        _bgImageTwo = [UIButton buttonWithType:UIButtonTypeSystem];
        _bgImageTwo.frame = CGRectMake(0, CGRectGetMaxY(self.bgImageOne.frame)+1, screenW, 40);
        _bgImageTwo.backgroundColor = UIColorFromRGB(0xf7f7f7);
        _bgImageTwo.userInteractionEnabled = YES;
        [_bgImageTwo addTarget:self action:@selector(buttonOrde) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _bgImageTwo;
}
-(void)buttonOrde{
    
//    OrderHistoryViewController * order = [[OrderHistoryViewController alloc] init];
//    order.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:order animated:YES];
    
    
    
}
-(UILabel *)AvailableFunds{
    
    if (!_AvailableFunds) {
        _AvailableFunds = [[UILabel alloc] init];
        CGSize size = [self sizeWithText:@"浮动盈亏" font:[UIFont systemFontOfSize:15]];
        _AvailableFunds.text = @"浮动盈亏";
        CGFloat nameW = size.width;
        _AvailableFunds.font = [UIFont systemFontOfSize:15];
        _AvailableFunds.frame = CGRectMake(20, 20, nameW, 20);
        _AvailableFunds.textColor = UIColorFromRGB(0x999999);
    }
    
    return _AvailableFunds;
}
-(UILabel *)AvailableAmount{
    
    if (!_AvailableAmount) {
        _AvailableAmount = [[UILabel alloc] init];
        //        CGSize size = [self sizeWithText:@"可用资金" font:[UIFont systemFontOfSize:12]];
        _AvailableAmount.text = @"$0.00";
        //        CGFloat nameW = size.width;
        _AvailableAmount.frame = CGRectMake(20, 40, 200, 40);
        _AvailableAmount.font = [UIFont boldSystemFontOfSize:30];
        _AvailableAmount.textColor = UIColorFromRGB(0x222222);
    }
    
    return _AvailableAmount;
}
-(UIButton *)buttonOne{
    
    if (!_buttonOne) {
        _buttonOne = [UIButton buttonWithType:UIButtonTypeSystem];
        _buttonOne.frame = CGRectMake(screenW-90, 35, 70, 30);
        [_buttonOne setTitle:@"充值" forState:UIControlStateNormal];
        [_buttonOne setTitleColor:UIColorFromRGB(0x4d93e9) forState:UIControlStateNormal];
        [_buttonOne addTarget:self action:@selector(buttonONeClick) forControlEvents:UIControlEventTouchUpInside];
        [_buttonOne.layer setBorderColor:UIColorFromRGB(0x4d93e9).CGColor];
        [_buttonOne.layer setBorderWidth:1];
        //        [_buttonOne setBackgroundImage:[UIImage imageNamed:@"nabg"] forState:UIControlStateNormal];
//        _buttonOne.backgroundColor = UIColorFromRGB(0xdc2b36);
    }
    
    return _buttonOne;
}
-(void)buttonONeClick{
    [_timer invalidate];
    _timer = nil;
    
    if ([_type isEqualToString:@"2"]) {
        PrepaidCashWithdrawalViewController * pre = [[PrepaidCashWithdrawalViewController alloc] init];
        pre.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pre animated:YES];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
        NSString * url1 = [NSString stringWithFormat:@"%@/api/users/register/url.json",codeUrl4];
         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY]};
        
        //3.请求
        [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString * NsCode = responseObject[@"code"];
            
            
            NSLog(@"%@",responseObject);
            
            
            if ([NsCode isEqualToString:@"0"]) {
                
                ZTWebViewController * zeweb = [[ZTWebViewController alloc] init];
                zeweb.hidesBottomBarWhenPushed = YES;
                zeweb.string = responseObject[@"data"][@"registerUrl"];
                
                [self.navigationController pushViewController:zeweb animated:YES];
                
            }else if ([NsCode isEqualToString:@"1"]){
                
                
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"======%@", error);
            
            
        }];
    }
    
    
  

}

-(UILabel *)GrayLabel{
    
    if (!_GrayLabel) {
        _GrayLabel = [[UILabel alloc] init];
        _GrayLabel.frame = CGRectMake(0, 90, screenW, 1);
        _GrayLabel.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _GrayLabel;
}
-(UILabel *)GrayLabelOne{
    
    if (!_GrayLabelOne) {
        _GrayLabelOne = [[UILabel alloc] init];
        _GrayLabelOne.frame = CGRectMake(screenW/2, 90, 1, 110);
        _GrayLabelOne.backgroundColor = UIColorFromRGB(0xf7f7f7);
    }
    
    return _GrayLabelOne;
}
-(UILabel *)NetAmount{
    
    if (!_NetAmount) {
        _NetAmount = [[UILabel alloc] init];
        
        _NetAmount.text = @"$0.00";
        _NetAmount.frame = CGRectMake(0, CGRectGetMaxY(self.GrayLabel.frame)+10, screenW/2, 20);
        _NetAmount.font = [UIFont systemFontOfSize:16];
        _NetAmount.textColor = UIColorFromRGB(0x222222);
        _NetAmount.textAlignment = NSTextAlignmentCenter;
    }
    
    return _NetAmount;
}
-(UILabel *)NetAssets{
    
    if (!_NetAssets) {
        _NetAssets = [[UILabel alloc] init];
        
        _NetAssets.text = @"可用保证金";
        _NetAssets.frame = CGRectMake(0, CGRectGetMaxY(self.NetAmount.frame)-2, screenW/2, 20);
        _NetAssets.font = [UIFont boldSystemFontOfSize:10];
        _NetAssets.textColor = UIColorFromRGB(0x999999);
        _NetAssets.textAlignment = NSTextAlignmentCenter;
    }
    
    return _NetAssets;
}
-(UILabel *)NetAmountOne{
    
    if (!_NetAmountOne) {
        _NetAmountOne = [[UILabel alloc] init];
        
        _NetAmountOne.text = @"0.00%";
        _NetAmountOne.frame = CGRectMake(0, CGRectGetMaxY(self.NetAssets.frame)+10, screenW/2, 20);
        _NetAmountOne.font = [UIFont systemFontOfSize:16];
        _NetAmountOne.textColor = UIColorFromRGB(0x222222);
        _NetAmountOne.textAlignment = NSTextAlignmentCenter;
    }
    
    return _NetAmountOne;
}
-(UILabel *)NetAssetsOne{
    
    if (!_NetAssetsOne) {
        _NetAssetsOne = [[UILabel alloc] init];
        
        _NetAssetsOne.text = @"保证金比例";
        _NetAssetsOne.frame = CGRectMake(0, CGRectGetMaxY(self.NetAmountOne.frame)-2, screenW/2, 20);
        _NetAssetsOne.font = [UIFont boldSystemFontOfSize:10];
        _NetAssetsOne.textColor = UIColorFromRGB(0x999999);
        _NetAssetsOne.textAlignment = NSTextAlignmentCenter;
    }
    
    return _NetAssetsOne;
}
-(UILabel *)differencePrice{
    
    if (!_differencePrice) {
        _differencePrice = [[UILabel alloc] init];
        
        _differencePrice.text = @"$0.00";
        _differencePrice.frame = CGRectMake(screenW/2, CGRectGetMaxY(self.GrayLabel.frame)+10, screenW/2, 20);
        _differencePrice.font = [UIFont systemFontOfSize:16];
        _differencePrice.textColor = UIColorFromRGB(0x222222);
        _differencePrice.textAlignment = NSTextAlignmentCenter;
    }
    
    return _differencePrice;
}
-(UILabel *)differencePriceAmount{
    
    if (!_differencePriceAmount) {
        _differencePriceAmount = [[UILabel alloc] init];
        
        _differencePriceAmount.text = @"已用保证金";
        _differencePriceAmount.frame = CGRectMake(screenW/2, CGRectGetMaxY(self.NetAmount.frame)-2, screenW/2, 20);
        _differencePriceAmount.font = [UIFont boldSystemFontOfSize:10];
        _differencePriceAmount.textColor = UIColorFromRGB(0x999999);
        _differencePriceAmount.textAlignment = NSTextAlignmentCenter;
    }
    
    return _differencePriceAmount;
}
-(UILabel *)differencePriceOne{
    
    if (!_differencePriceOne) {
        _differencePriceOne = [[UILabel alloc] init];
        
        _differencePriceOne.text = @"$0.00";
        _differencePriceOne.frame = CGRectMake(screenW/2, CGRectGetMaxY(self.differencePriceAmount.frame)+10, screenW/2, 20);
        _differencePriceOne.font = [UIFont systemFontOfSize:16];
        _differencePriceOne.textColor = UIColorFromRGB(0x222222);
        _differencePriceOne.textAlignment = NSTextAlignmentCenter;
    }
    
    return _differencePriceOne;
}
-(UILabel *)differencePriceAmountOne{
    
    if (!_differencePriceAmountOne) {
        _differencePriceAmountOne = [[UILabel alloc] init];
        
        _differencePriceAmountOne.text = @"账户净值";
        _differencePriceAmountOne.frame = CGRectMake(screenW/2, CGRectGetMaxY(self.differencePriceOne.frame)-2, screenW/2, 20);
        _differencePriceAmountOne.font = [UIFont boldSystemFontOfSize:10];
        _differencePriceAmountOne.textColor = UIColorFromRGB(0x999999);
        _differencePriceAmountOne.textAlignment = NSTextAlignmentCenter;
    }
    
    return _differencePriceAmountOne;
}




-(UILabel *)OrderRecord{
    
    if (!_OrderRecord) {
        _OrderRecord = [[UILabel alloc] init];
        
        _OrderRecord.text = @"持仓单：0";
        _OrderRecord.frame = CGRectMake(20, 20, 200, 20);
        _OrderRecord.font = [UIFont systemFontOfSize:18];
        _OrderRecord.textColor = UIColorFromRGB(0x222222);
        //        _OrderRecord.textAlignment = NSTextAlignmentCenter;
    }
    
    return _OrderRecord;
}


#pragma mark - 创建导航栏
-(void)createNator{
    //    登陆label
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"持仓";
    _label.font = [UIFont systemFontOfSize:18];
    _label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = _label;
    //    设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nabg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.navigationController.navigationBar.translucent = NO;
    
//    [_rightButton setBackgroundImage:[UIImage imageNamed:@"信息icon"] forState:UIControlStateNormal];
    [_rightButton setTitle:@"历史" forState:0];
    [_rightButton addTarget:self action:@selector(RightbuttonAction) forControlEvents:UIControlEventTouchUpInside];
    _rightButton.frame = CGRectMake(0, 0, 40, 30);
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [_rightButton  yee_MakeBadgeText:@"23" textColor:[UIColor whiteColor] backColor:[UIColor redColor] Font:[UIFont systemFontOfSize:9]];
    [_rightButton setTitleColor:UIColorFromRGB(0x999999) forState:0];
    UIBarButtonItem *rightItemCustom = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItemCustom;
    
    
    
    
}
-(void)RightbuttonAction{
    
    if ([_type isEqualToString:@"2"]) {
        closeHistoryVController * MarkDetaiVC = [[closeHistoryVController alloc] init];
        
        MarkDetaiVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:MarkDetaiVC animated:YES
         ];
 
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    [manager setSecurityPolicy:[NetWorkManager customSecurityPolicy]];
        NSString * url1 = [NSString stringWithFormat:@"%@/api/users/register/url.json",codeUrl4];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary * dict = @{@"userId":[userDefaults objectForKey:USER_NAME_KEY]};
        
        //3.请求
        [manager POST:url1 parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString * NsCode = responseObject[@"code"];
            
            
            NSLog(@"%@",responseObject);
            
            
            if ([NsCode isEqualToString:@"0"]) {
                
                ZTWebViewController * zeweb = [[ZTWebViewController alloc] init];
                zeweb.hidesBottomBarWhenPushed = YES;
                zeweb.string = responseObject[@"data"][@"registerUrl"];
                
                [self.navigationController pushViewController:zeweb animated:YES];
                
            }else if ([NsCode isEqualToString:@"1"]){
                
                
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"======%@", error);
            
            
        }];
    }
    
    

}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    return [text sizeWithAttributes:attrDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)secondViewControllerChangeBgid:(NSString *)str{
    
    [self getData];
    [self getDataONe];
    
    //        }else{
    //            [MBProgressHUD hideHUD];
    //
    //        }
    
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"%@",error);
    //        [MBProgressHUD hideHUD];
    //    }];
    
}

- (void)InterruptTimer:(NSString *)str{

   

}
-(void)EURUSDPntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        if (_dataArray.count > 0) {
            //        self.label10.text = [NSString stringWithFormat:@"%@",array[3]];
            float profit1 = [array[3] floatValue];
            
            profitModel * promode = [profitModel model];
            promode.profit1 = profit1;
            promode.askprofit1 = [array[1] floatValue];
            promode.bidprofit1 = [array[2] floatValue];
            [self juSuan];
        }


        
    }
    
}








-(void)GBPUSDntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        if (_dataArray.count > 0) {
            float profit1 = [array[3] floatValue];
            
            profitModel * promode = [profitModel model];
            promode.profit2 = profit1;
            promode.askprofit2 = [array[1] floatValue];
            promode.bidprofit2 = [array[2] floatValue];
            [self juSuan];
        }
        

       
    }
    
}
-(void)USDCHFntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        if (_dataArray.count > 0) {
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit3 = profit1;
            promode.askprofit3 = [array[1] floatValue];
            promode.bidprofit3 = [array[2] floatValue];
            [self juSuan];
        }
        

    }
    
}
-(void)AUDUSDntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        
        if (_dataArray.count > 0) {
            
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit4 = profit1;
            promode.askprofit4 = [array[1] floatValue];
            promode.bidprofit4 = [array[2] floatValue];
            [self juSuan];

        }

    }
    
}
-(void)NZDUSDntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        if (_dataArray.count > 0) {
            
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit5 = profit1;
            promode.askprofit5 = [array[1] floatValue];
            promode.bidprofit5 = [array[2] floatValue];
            [self juSuan];
            
        }
      

    }
    
}
-(void)USDJPYntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        if (_dataArray.count > 0) {
            
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit6 = profit1;
            promode.askprofit6 = [array[1] floatValue];
            promode.bidprofit6 = [array[2] floatValue];
            [self juSuan];
            
        }
       
    

     
    }
    
}
-(void)EURGBPntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        if (_dataArray.count > 0) {
            
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit7 = profit1;
            promode.askprofit7 = [array[1] floatValue];
            promode.bidprofit7 = [array[2] floatValue];
            [self juSuan];
            
        }
      
       
    
}
}
-(void)USDCNHntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        if (_dataArray.count > 0) {
            
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit8 = profit1;
            promode.askprofit8 = [array[1] floatValue];
            promode.bidprofit8 = [array[2] floatValue];
            [self juSuan];
            
        }
       
      
    
}
    
}
-(void)XAGUSDntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        if (_dataArray.count > 0) {
            
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit9 = profit1;
            promode.askprofit9 = [array[1] floatValue];
            promode.bidprofit9 = [array[2] floatValue];
            [self juSuan];
            
        }
        
        
        
    }
    
}
-(void)XAUUSDntf1:(NSNotification *)ntf{
    NSMutableArray * array = ntf.object;
    if (array.count != 0) {
        if (_dataArray.count > 0) {
            
            float profit1 = [array[3] floatValue];
            
            
            profitModel * promode = [profitModel model];
            promode.profit10 = profit1;
            promode.askprofit10 = [array[1] floatValue];
            promode.bidprofit10 = [array[2] floatValue];
            [self juSuan];
            
        }
        
        
        
    }
    
}
-(void)juSuan{
    profitModel * model = [profitModel model];
    
    //    NSLog(@"%lf--%lf--%lf--%lf--%lf--%lf--%lf--%lf",model.profit1,model.profit2,model.profit3,model.profit4,model.profit5,model.profit6,model.profit7,model.profit8);
    
    
    _profit = 0;
    _profitOne = 0;
    _profitTwo = 0;
    if (_dataArray.count > 0) {
        for (int i = 0; i < _dataArray.count; i++) {
            if ([_dataArray[i][@"symbol"] rangeOfString:@"EURUSD"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if (model.profit1 == 0) {
                 profit1 = [_dataArray[i][@"open_price"] floatValue];
                   
//                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                  
//                    bidprofit = model.bidprofit1;
                    profit1 = model.profit1;
                }
                if (model.askprofit1 == 0) {
                     askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                     askprofit = model.askprofit1;
                }
                if (model.bidprofit1 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit1;
                }
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
               
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000;
                }
                //                float profit = (profit1 - profit2) * profit3 * 100000;
                _profit += profit;
                
                //                NSLog(@"%@",);
                
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"GBPUSD"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit2 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit2;
                }
                if (model.askprofit2 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit2;
                }
                if (model.bidprofit2 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit2;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"USDCHF"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit3 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit3;
                }
                if (model.askprofit3 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit3;
                }
                if (model.bidprofit3 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit3;
                }
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000/bidprofit;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000/askprofit;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"AUDUSD"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit4 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit4;
                }
                if (model.askprofit4 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit4;
                }
                if (model.bidprofit4 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit4;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"NZDUSD"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit5 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit5;
                }
                if (model.askprofit5 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit5;
                }
                if (model.bidprofit5 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit5;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"USDJPY"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit6 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit6;
                }
                if (model.askprofit6 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit6;
                }
                if (model.bidprofit6 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit6;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000/bidprofit;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000/askprofit;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"EURGBP"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit7 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit7;
                }
                if (model.askprofit7 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit7;
                }
                if (model.bidprofit7 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit7;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000*bidprofit;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000*askprofit;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"XAGUSD"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit9 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit9;
                }
                if (model.askprofit9 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit9;
                }
                if (model.bidprofit9 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit9;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 5000;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 5000;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"XAUUSD"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit10 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit10;
                }
                if (model.askprofit10 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit10;
                }
                if (model.bidprofit10 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit10;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100;
                }
                _profit += profit;
            }else if ([_dataArray[i][@"symbol"] rangeOfString:@"USDCNH"].location != NSNotFound){
                float profit1 = 0;
                float askprofit = 0;
                float bidprofit = 0;
                if (model.profit8 == 0) {
                    profit1 = [_dataArray[i][@"open_price"] floatValue];
                    
                    //                   bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    
                    //                    bidprofit = model.bidprofit1;
                    profit1 = model.profit8;
                }
                if (model.askprofit8 == 0) {
                    askprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    askprofit = model.askprofit8;
                }
                if (model.bidprofit8 == 0) {
                    bidprofit = [_dataArray[i][@"open_price"] floatValue];
                }else{
                    bidprofit = model.bidprofit8;
                }
                
                float profit2 = [_dataArray[i][@"open_price"] floatValue];
                
                float profit3 = [_dataArray[i][@"volume"] floatValue];
                
                NSString * cmd = _dataArray[i][@"cmd"];
                float profit;
                if ([cmd isEqualToString:@"0"]) {
                    profit = (bidprofit - profit2) * profit3 * 100000/bidprofit;
                }else{
                    profit = (profit2 - askprofit) * profit3 * 100000/askprofit;
                }
                _profit += profit;
            }
            
            _profitOne += [_dataArray[i][@"margin"] floatValue];
        }
        
    }
    if (_dataArray.count > 0) {
        self.AvailableAmount.text = [NSString stringWithFormat:@"$%.2lf",_profit];
        
        if (_profit >= 0) {
             self.AvailableAmount.textColor = UIColorFromRGB(0xfc5662);
          
        }else{
             self.AvailableAmount.textColor = UIColorFromRGB(0x25c991);
           
            
        }
        
        float margin_free = [_balance floatValue] + [_credit floatValue] + _profit - _profitOne;
        float equity = [_balance floatValue] + [_credit floatValue] + _profit;
        self.NetAmount.text = [NSString stringWithFormat:@"$%.2f",margin_free];
        float margin_level = equity/_profitOne;
        if (_dataArray.count > 0) {
            self.NetAmountOne.text = [NSString stringWithFormat:@"%.2f%@",margin_level,@"%"];
        }
        
        
        self.differencePrice.text = [NSString stringWithFormat:@"$%.2f",_profitOne];
        self.differencePriceOne.text = [NSString stringWithFormat:@"$%.2f",equity];
    }
    
   
    
  


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
