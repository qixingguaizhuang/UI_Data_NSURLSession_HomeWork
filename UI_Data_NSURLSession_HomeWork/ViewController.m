//
//  ViewController.m
//  UI_Data_NSURLSession_HomeWork
//
//  Created by sp on 16/1/6.
//  Copyright © 2016年 sp. All rights reserved.
//

#import "ViewController.h"
#import "ModelOfMtime.h"

@interface ViewController ()<NSURLSessionDelegate>
//@property (nonatomic, retain)NSMutableData *data;

@property (nonatomic, retain)NSMutableArray *arrOfModel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self handleDateByBlock];
    
}

- (void)handleDateByBlock{
    
    //获取url

    NSURL *url = [NSURL URLWithString:@"http://api.m.mtime.cn/News/NewsList.api?pageIndex=1"];

    //创建通道
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    //挂起任务 task
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     
        //解析
        
        NSError *errorJson = nil;
        id resule = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
        
     
        // 处理数据
        
        NSArray *arr = [resule objectForKey:@"newsList"];
        
        self.arrOfModel = [NSMutableArray array];//初始化数组
        
        for (NSDictionary *dic in arr) {
            
            ModelOfMtime *model = [[ModelOfMtime alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            [self.arrOfModel addObject:model];
            
           // NSLog(@"model:%@", self.arrOfModel);

        }
        
        
    }];


    [task resume];


}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
