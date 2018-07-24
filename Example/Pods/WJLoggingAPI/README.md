# WJLoggingAPI

日志组件统一API,目前所有组件全部支持WJLoggingAPI

### CocoaPods 安装
    pod WJLoggingAPI
    
### 要求
* ARC支持
* iOS 5.0+

### 使用方法

```objective-c
	#import "WJLoggingMacros.h"

	WJLogError(frmt, ...);
	WJLogWarn(frmt, ...);
	WJLogInfo(frmt, ...)
	WJLogDebug(frmt, ...)
	WJLogVerbose(frmt, ...)
	
```