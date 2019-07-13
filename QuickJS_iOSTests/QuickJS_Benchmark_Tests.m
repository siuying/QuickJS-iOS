//
//  QuickJS_Benchmark_Tests.m
//  QuickJS_iOSTests
//
//  Created by Francis Chong on 13/7/2019.
//  Copyright © 2019 Francis Chong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <QuickJS/quickjs.h>

@interface QuickJS_Benchmark_Tests : XCTestCase

@end

@implementation QuickJS_Benchmark_Tests

- (void)testRegexpMeasure_QuickJS {
    JSRuntime* runtime = JS_NewRuntime();
    JSContext* context = JS_NewContext(runtime);
    const char * fib = "function fib(n) {\n if (n <= 0) return 0;\n else if (n == 1) return 1;\n else return fib(n - 1) + fib(n - 2);}";
    JS_Eval(context, fib, strlen(fib), "cmdline", 0);

    [self measureBlock:^{
        const char * script = "fib(36)";
        JS_Eval(context, script, strlen(script), "cmdline", 0);
    }];
}

@end
