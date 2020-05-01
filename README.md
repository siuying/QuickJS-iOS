# QuickJS iOS

[QuickJS Javascript Engine](https://bellard.org/quickjs/) static libraries compiled for armv64, arm64e and x86_64 for use in iOS development.

## Why?

This is just an experiment to build the library on iOS. Consider iOS has JavaScriptCore built in, there is not
much reason to use this over JSC.

## Usage

To use the library with cocoapods:

```
pod "QuickJS", :podspec => 'https://raw.githubusercontent.com/siuying/QuickJS-iOS/0.0.2019-07-09/QuickJS.podspec'

```

## Compilation

Run `build.sh` to fetch and build the library/xcframework.

## Licensing

QuickJS is released under the MIT license.

The license for this repository is also released under the MIT license.