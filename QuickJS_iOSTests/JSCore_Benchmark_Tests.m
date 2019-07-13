//
//  JSCore_Benchmark_Tests.m
//  QuickJS_iOSTests
//
//  Created by Francis Chong on 13/7/2019.
//  Copyright © 2019 Francis Chong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCore_Benchmark_Tests : XCTestCase
@end

@implementation JSCore_Benchmark_Tests

- (void)testRegexpMeasure_QuickJS {
    JSContext* context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    [context evaluateScript:@"function fib(n) {\n if (n <= 0) return 0;\n else if (n == 1) return 1;\n else return fib(n - 1) + fib(n - 2);}"];

    [self measureBlock:^{
        [context evaluateScript:@"fib(36)"];
    }];
}


@end
