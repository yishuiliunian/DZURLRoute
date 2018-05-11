# DZURLRoute

[![CI Status](http://img.shields.io/travis/yishuiliunian/DZURLRoute.svg?style=flat)](https://travis-ci.org/yishuiliunian/DZURLRoute)
[![Version](https://img.shields.io/cocoapods/v/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)
[![License](https://img.shields.io/cocoapods/l/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)
[![Platform](https://img.shields.io/cocoapods/p/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)

## What's it

DZURLRoute是支持基于标准URL进行Native页面间跳转的Objective-C实现。方便您架构页面之间高内聚低耦合的开发模式。他的核心思想是把每一个页面当成一个资源，通过标准的URL协议（统一资源定位符）来定位到每一个可触达的页面（资源）。

在设计该类库的时候，进行了多伦次抽象。最后突然灵光一现，应该首先设计的是页面之间的规则。而当我们把页面看成一种资源，页面之间的的调用看成资源寻址和调用的时候。很容易就想到了URL的方式。通过一个简单的规则（URL）来页面之间的关系。没有那么多复杂的机制。只是一个规则，这个东西简单而美丽。一旦有了这个规则，剩下的事情就是如果去实现这个了。而DZURLRoute只是其中的一种实现，相信其他人还会有更好的实现版本，欢迎分享。

> Next 看怎么扩展成一个 IOC 的基础类库

### Features
#### URL唤起任意见面
采用标准的正则表达式匹配URL，通过URL来定为每一个资源，唤起页面只需要拼装好需要跳转的URL，通过DZURLRoute进行转发就好。

~~~
[[DZURLRoute defaultRoute] routeURL:[NSURL URLWithString:@"scheme://host/path?query=xx"]];
~~~

#### 在处理页面的时候每个返回的页面会绑定一个 SourceURL，您可以利用该 SourceURL 做些事情

比如 NavigationController 回退到指定页面


~~~
    [self.navigationController popToPage:DZURLRouteQueryLink(kDZRoutePatternExampleViewController, @{})];
~~~

> 这是新增加的巨牛逼的功能！！！

#### 采用标准的通配符进行URL匹配，并使用block的方式来处理请求。扩展性好。

注册匹配规则的地方接受收入标注的通配符规则，内部通过正则表达式进行匹配。方便您将一类URL统一定位到一个资源。同时，采用通配符匹配而非字符串对比也是考虑到未来的可扩展性。

~~~
@interface YHActionGroupDetailElement : UIViewController
@end

@implementation YHActionGroupDetailElement
+ (void) load
{
    [[DZURLRoute defaultRoute] addRoutePattern:@"scheme://host/path" handler:^BOOL(DZURLRouteRequest *request) {
        ActionGroup* profile = [request.paramters protobuffInstanceForKey:kYHURLQueryParamterProfile kindOf:[ActionGroup class]];
        YHActionGroupDetailElement* vcx = [[YHActionGroupDetailViewController alloc] initWithprofile:profile];
        [request.topNavigationController pushViewController:vcx animated:YES];
        return YES;
    }];
}
~~~

##### 您可以在block中自定义行为，比如类似304跳转的行为

#### 携带页面跳转需要的上下文环境

~~~
@interface DZURLRouteRequest : NSObject
......
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;
@property (nonatomic, strong, readonly) UIViewController* topViewController;
@property (nonatomic, strong, readonly) UINavigationController* topNavigationController;
......
@end
~~~

我们加载一个页面在iOS中有两种比较标准的方式：

1. UINavigationController push
2. UIViewController present

这两种方式都需要从唤起页面的地方开始调用，这也是之前页面之间耦合性很高的原因。在调用的地方需要知道被调用页面的类和初始化方法，才能正确的创建和初始化被调用方的变量。在DZURLRoute中，通过维护全局的可展示的UI栈。可以把整个用户界面显示中的UIViewController的上下文情况得到。并通过DZURLRequest传递给处理函数。在处理函数内部可以直接通过该上下文来唤起当前界面。推荐在+load方法中注册当前类的通配符规则，这样可以保持较好的封闭性（该类的处理，在该类内部完成）。例如在上个特性中展示的代码。

这个能够实现携带UI堆栈上下文还要得力于另外一个库[DZUIViewControllerLifeCircleAction]()，提供了对于UIViewController进行AOP编程的基础。



#### 支持[标准的URL协议](标准URL协议链接)

>scheme://host/path?query

会自动解析出URL中相关的属性，同时将其他相关传递处理:

|名称|含义|备注|
|:--|:--|:--|
|originURL|原始的跳转URL||
|scheme|scheme||
|module|URL的host||
|method|URL中Path部分的第一层||
|paramters|以字典形式提供的query中的Key-Value对||


~~~
@interface DZURLRouteRequest : NSObject
.......
@property (nonatomic, strong, readonly) NSURL* originURL;
@property (nonatomic, strong, readonly) NSString* scheme;
@property (nonatomic, strong, readonly) NSString* module;
@property (nonatomic, strong, readonly) NSString* method;
@property (nonatomic, strong, readonly) NSDictionary* paramters;
......

~~~



#### 支持降级策略
支持类似HTTP404错误的处理方式，在本地不支持某个URL处理的时候，将请求转发到统一的404处理页面。在该页面内部，用户可以自己写处理逻辑，将原始URL带到服务器后端，服务器设置降级策略将Native请求跳转到H5页面。


#### 支持外部scheme跳转

因为支持标准的URL处理，如果需要处理外部的URL跳转，只要在appdelgate中进行直接调用路由转发即可:

- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
      return [[NSURLRoute defaultRoute] routeURL:url]
}

#### ABTest等扩展需求支持

对于某些业务会有的在ABTest的方案，也是支持良好只需要在URL中携带相关ABTest的参数即可。在该方案设计中，每个类在自己的+load方法中注册自己的唤起方法。其中包括实例初始化，必要参数传递，还有页面跳转。因而，在注册唤起定位方位时，可以将ABTest的实验数据通过URL query传输过来，在初始化过程中传递之。并在实验中根据不同的实验条件进行实验。

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

~~~
s.dependency  'DZViewControllerLifeCircleAction'
s.dependency 'NSString-UrlEncode'
~~~

## Installation

DZURLRoute is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DZURLRoute"
```

## Author

yishuiliunian, yishuiliunian@gmail.com

## License

DZURLRoute is available under the MIT license. See the LICENSE file for more info.

Copyright (c) 2016 yishuiliunian <yishuiliunian@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
