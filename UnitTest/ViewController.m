//
//  ViewController.m
//  UnitTest
//
//  Created by weiyun on 2018/2/6.
//  Copyright © 2018年 孙世玉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic , strong) NSMutableArray<UIButton *> *buttonArr;
@property (nonatomic , copy) NSString * numA;
@property (nonatomic , copy) NSString * numB;
@property (nonatomic , strong) UILabel *label;
@property (nonatomic , assign) BOOL isPlus; ///< 是否点击了加号
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numA = nil;
    self.numB = nil;
    self.isPlus = NO;
    
    int num = 12;

    int space = 20;
    float w = ([UIScreen mainScreen].bounds.size.width - space*5)/4;
    
    self.buttonArr = [[NSMutableArray alloc] initWithCapacity:num];
    
    for (int i = 0; i < num; i ++) {
        int row = i / 4; // 行
        int loc = i % 4; // 列
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        button.frame = CGRectMake(space + (w+space)*loc, 40 + (w+space)*row, w, w);
        [button setTitle:[NSString stringWithFormat:@"%zd",i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.buttonArr addObject:button];
        if (i == num-1) {
            [button setTitle:@"=" forState:UIControlStateNormal];
        }
        if (i == num-2) {
            [button setTitle:@"+" forState:UIControlStateNormal];
        }
    }
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 40)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:25];
    self.label.text = @"总计：0";
    [self.view addSubview:self.label];
    
}

- (void)buttonClick:(UIButton *)button
{
    // 等于
    if ([button.titleLabel.text isEqualToString:@"="]) {
        NSInteger totle = [self.numA integerValue] + [self.numB integerValue];
        self.label.text = [NSString stringWithFormat:@"总计：%zd",totle];
        self.numA = nil;
        self.numB = nil;
        self.isPlus = NO;
        return;
    }
    
    // 加
    if ([button.titleLabel.text isEqualToString:@"+"]) {
        self.isPlus = YES;
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"%zd",button.tag];
    if (self.isPlus == NO) {
        self.numA = self.numA == nil?str:[self.numA stringByAppendingString:str];
    }else{
        self.numB = self.numB == nil?str:[self.numB stringByAppendingString:str];
    }
}

// 异步
- (void)sendRequest:(void(^)(NSString *targetString))finished
{
    dispatch_queue_t globle = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globle, ^{
        [NSThread sleepForTimeInterval:3];
        dispatch_async(dispatch_get_main_queue(), ^{
            finished(@"完成");
        });
        
    });
}


- (int)add:(int)numberA with:(int)numberB
{
    return numberA + numberB;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
