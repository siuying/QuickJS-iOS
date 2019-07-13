//
//  QuickJS_iOSTests.m
//  QuickJS_iOSTests
//
//  Created by Francis Chong on 13/7/2019.
//  Copyright © 2019 Francis Chong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <QuickJS/quickjs.h>

@interface QuickJS_iOSTests : XCTestCase
@end

@implementation QuickJS_iOSTests

- (void)testFib {
    JSRuntime* runtime = JS_NewRuntime();
    JSContext* context = JS_NewContext(runtime);
    const char * fib = "function fib(n) {\n if (n <= 0) return 0;\n else if (n == 1) return 1;\n else return fib(n - 1) + fib(n - 2);}";
    JS_Eval(context, fib, strlen(fib), "cmdline", 0);

    const char * script = "fib(36)";
    JSValue value = JS_Eval(context, script, strlen(script), "cmdline", 0);
    NSLog(@"value: %s", JS_ToCString(context, value));
}

@end
