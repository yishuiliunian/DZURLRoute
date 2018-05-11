# DZURLRoute

[![Version](https://img.shields.io/cocoapods/v/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)
[![License](https://img.shields.io/cocoapods/l/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)
[![Platform](https://img.shields.io/cocoapods/p/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)

![中文版](https://github.com/yishuiliunian/DZURLRoute/blob/master/ChineseReadme.md)


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

## What's it


DZURLRoute is an Objective-C implementation that supports standard-based URLs for local page jumps. It is convenient for you to build a high cohesion and low coupling development mode between pages. His core idea is to treat each page as a resource and to locate each reachable page (resource) through a standard URL protocol (Uniform Resource Locator).



When designing this kind of library, Duolun's abstraction was performed. At the end of the sudden glimpse, the first thing that should be designed is the rules between the pages. And when we think of a page as a resource, calls between pages are treated as resource addressing and invocation. It's easy to think of the URL. Through a simple rule (URL) to the relationship between the pages. There are not so many complicated mechanisms. Just a rule, this thing is simple and beautiful. Once this rule is in place, the remaining thing is to achieve this. DZURLRoute is just one of the implementations, I believe that other people will have a better implementation version, welcome to share.

>  Next i will  try expand the library into an IOC  library

### Features

#### Use NSURL to route an page


Use standard regular expressions to match URLs and use URLs for each resource. To evoke a page, you only need to assemble URLs that need to be redirected. Forward through DZURLRoute.

~~~
[[DZURLRoute defaultRoute] routeURL:[NSURL URLWithString:@"scheme://host/path?query=xx"]];
~~~

#### Each page returned is bound to a SourceURL when processing the page. You can use this SourceURL to do something


For example, NavigationController pop to the specified page


~~~
    [self.navigationController popToPage:DZURLRouteQueryLink(kDZRoutePatternExampleViewController, @{})];
~~~

> This is a new addition to the giant Niubi! ! !

####  Use standard wildcards for URL matching and use block methods to handle requests. Good scalability.


Registered matching rules accept wildcard rules for revenue labeling and internally match by regular expressions. You can easily locate a category of URLs to a single resource. At the same time, adopting wildcard matching instead of string comparison also takes into account future extensibility.

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

#####  You can customize the behavior in the block, such as the behavior of jumps like 304

####  Contexts needed to automatically carry page jumps

~~~
@interface DZURLRouteRequest : NSObject
......
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;
@property (nonatomic, strong, readonly) UIViewController* topViewController;
@property (nonatomic, strong, readonly) UINavigationController* topNavigationController;
......
@end
~~~


We load a page in iOS with two more standard ways：

1. UINavigationController push
2. UIViewController present


Both of these methods need to be called from where the page was evoked, which is why the previous page was highly coupled. In the calling place need to know the class and initialization method of the called page, in order to correctly create and initialize the callee's variables. In DZURLRoute, maintain the global displayable UI stack. You can get the context of UIViewController in the entire user interface display. And passed to the handler via DZURLRequest. Inside the processing function, the current interface can be evoked directly through this context. It is recommended to register the wildcard rules of the current class in the +load method to maintain good closeness (the processing of this class is done inside this class). For example, the code shown in the previous feature。


This can be achieved by carrying the UI stack context but also by another library [DZUIViewControllerLifeCircleAction](), which provides the basis for AOP programming UIViewController.



####  Support for demotion strategy


Supports HTTP 404 error handling. When a URL is not supported locally, the request is forwarded to the unified 404 processing page. Inside this page, users can write their own processing logic, bring the original URL to the server backend, and the server sets downgrade policies to jump Native requests to the H5 page.


####  Supports external scheme jumps


Because it supports standard URL processing, if you need to handle external URL jumps, just call route forwarding directly in appdelgate:


- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
      return [[NSURLRoute defaultRoute] routeURL:url]
}

#### Expanded requirements support such as ABTest


For some businesses there are ABTest programs that are also well-supported and only need to carry the ABTest parameters in the URL. In this scenario design, each class registers its own arousal method in its own +load method. These include instance initialization, necessary argument passing, and page jumps. Therefore, when the registration arouses the orientation, the experimental data of ABTest can be transmitted through the URL query and transmitted during the initialization process. In the experiment, experiments were performed according to different experimental conditions.




# 中文介绍


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

| 名称      | 含义                                 | 备注 |
|:----------|:-------------------------------------|:-----|
| originURL | 原始的跳转URL                        |      |
| scheme    | scheme                               |      |
| module    | URL的host                            |      |
| method    | URL中Path部分的第一层                |      |
| paramters | 以字典形式提供的query中的Key-Value对 |      |


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
