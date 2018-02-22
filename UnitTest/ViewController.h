//
//  ViewController.h
//  UnitTest
//
//  Created by weiyun on 2018/2/6.
//  Copyright © 2018年 孙世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// 测试的时候是要暴露接口的
- (void)sendRequest:(void(^)(NSString *targetString))finished;

- (int)add:(int)numberA with:(int)numberB;

@end

