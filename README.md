



# WJAppContext

 应用程序模块化管理组件（包含用户虚拟Session管理）

### CocoaPods 安装

```
	pod WJAppContext	
```

### 要求
* ARC支持
* iOS 5.0+

### 使用方法

* 在WJConfig配置中心：

```
	//WJAppContext在配置中心名称
	WJAppContext : {
		//模块列表
		modules : ['ModuleAClassName', 'ModuleBClassName', ...],
		//回话数据格式化程序
		sessionDataFormatter : 'SessionDataFormatterClassName'
	}

```


* AppDelegate.m 中的 application:didFinishLaunchingWithOptions: 方法添加：

```objective-c

    //注册App
	[WJAppContext registerAppContext];
	[WJAppContext application:application didFinishLaunchingWithOptions:launchingOptions];
	
```


* 在AppDelegate.m中所有的 UIApplicationDelegate 实现方法需要添加代码：

```
	[WJAppContext appDelegate方法名称];
	
	例如：
	[WJAppContext applicationDidEnterBackground:application];
	
```
