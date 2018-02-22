//
//  UnitTestUITests.m
//  UnitTestUITests
//
//  Created by weiyun on 2018/2/6.
//  Copyright © 2018年 孙世玉. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface UnitTestUITests : XCTestCase

@end

@implementation UnitTestUITests

// 单元测试是不包括UI测试的
- (void)setUp {
    [super setUp];
    
    // 每次都要置空
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
    // 因为下面一句，所以每次测试完就会退出一下
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"1"] tap];
    
    XCUIElement *button = app.buttons[@"2"];
    [button tap];
    [app.buttons[@"3"] tap];
    
    XCUIElement *button2 = app.buttons[@"+"];
    [button2 tap];
    
    XCUIElement *button3 = app.buttons[@"6"];
    [button3 tap];
    
    XCUIElement *button4 = app.buttons[@"5"];
    [button4 tap];
    [app.buttons[@"7"] tap];
    
    XCUIElement *button5 = app.buttons[@"="];
    [button5 tap];
    [button4 tap];
    [button3 tap];
    [button tap];
    [button2 tap];
    [button3 tap];
    [button5 tap];
    
}

- (void)testPlus
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"4"] tap];
    [app.buttons[@"+"] tap];
    [app.buttons[@"5"] tap];
    [app.buttons[@"="] tap];
    int n = 4 + 5;
    XCTAssertEqual(n, 9);
    
}
@end
