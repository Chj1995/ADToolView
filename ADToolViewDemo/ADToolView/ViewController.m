//
//  ViewController.m
//  ADToolView
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "ViewController.h"
#import "ADToolModel.h"
#import "ADToolView.h"

@interface ViewController ()

/**
 *  工具栏数组
 */
@property(nonatomic,strong)NSMutableArray *ADToolArray;

@property(nonatomic,weak)ADToolView *adtoolView;

@end

@implementation ViewController
#pragma mark - 懒加载
-(NSMutableArray *)ADToolArray
{
    if (!_ADToolArray) {
        
        _ADToolArray = [NSMutableArray array];
    }
    return _ADToolArray;
}
-(ADToolView *)adtoolView
{
    if (!_adtoolView) {
        
        ADToolView *view = [[ADToolView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 60)];
        [self.view addSubview:view];
        
        _adtoolView = view;
    }
    return _adtoolView;
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *urlStr = @"http://api-v2.mall.hichao.com/forum/tag-recommend?ga=%2Fforum%2Ftag-recommend";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //9.0版本之前可以用
    [NSURLConnection  sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self handleToolDataObjectWithOnject:responseObject];
    }];


}

-(void)handleToolDataObjectWithOnject:(id)responseObject
{
    [self.ADToolArray removeAllObjects];
    NSArray *items = responseObject[@"response"][@"data"][@"items"];
    
    for (NSDictionary *dic  in items) {
        
        ADToolModel *model = [[ADToolModel alloc] init];
        model.picUrl = dic[@"component"][@"picUrl"];
        model.title = dic[@"component"][@"title"];
        
        [self.ADToolArray addObject:model];
    }
    self.adtoolView.ADToolArray = self.ADToolArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
