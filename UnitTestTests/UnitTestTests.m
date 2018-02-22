//
//  UnitTestTests.m
//  UnitTestTests
//
//  Created by weiyun on 2018/2/6.
//  Copyright © 2018年 孙世玉. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface UnitTestTests : XCTestCase
@property (nonatomic , strong) ViewController *vc;
@end

@implementation UnitTestTests
//********************* 下面两个类方法只跑一次 *********************//
// 只跑一次
+ (void)setUp
{
    [super setUp];
}
// 只跑一次
+ (void)tearDown
{
    [super tearDown];
}

// 每次测试方法执行的时候都会跑
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // 1.重置对象，为测试条件做准备
    self.vc = [[ViewController alloc] init];
}

// 每次测试方法执行的时候都会跑
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    // 2.置空
    self.vc = nil;
    
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // 1.Given:初始条件设置
    int num1 = 1;
    int num2 = 2;
    
    // 类似于自己写了一个捕获异常
    XCTestExpectation *expectation = [self expectationWithDescription:@"Async test was failed"];
    
    
    // 2.When:被测试的一些方法
    
    int result = [self.vc add:num1 with:num2];
    
    [self.vc sendRequest:^(NSString *targetString) {
        
        // 1.传回来的的值是否正确，是否存在
        XCTAssertNotNil(targetString);
        
        // 2.是否按时传回（履行，执行）
        [expectation fulfill];
    }];
    
    // 如果走了 [expectation fulfill] 方法就不会再走下面的方法了，说明已经按时返回了。
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
    // 3.Then 测试判断结果
    XCTAssertEqual(result, 3);
    
}

// 性能测试
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    
    // 1. 百分比，和平均值进行比对的
    // 2. 基线 baseline 参考值
    // 3. STDDEV 标准偏差 10%
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.

        [self.vc sendRequest:^(NSString *targetString) {
 
        }];
        
    }];
    
}

// 在方法前面加上前缀test就可以直接测试了该方法了

// 性能测试提高精度
- (void)testUseFileHandlePerformance
{
    
    [self measureMetrics:@[XCTPerformanceMetric_WallClockTime] automaticallyStartMeasuring:NO forBlock:^{
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:@""];
        XCTAssertNil(fileHandle);
        
        // 只测试一部分
        [self startMeasuring];
        [fileHandle writeData:[NSData data]];
        [self stopMeasuring];
        
        [fileHandle closeFile];
    }];
}

@end
