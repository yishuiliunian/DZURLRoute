# DZURLRoute

[![Version](https://img.shields.io/cocoapods/v/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)
[![License](https://img.shields.io/cocoapods/l/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)
[![Platform](https://img.shields.io/cocoapods/p/DZURLRoute.svg?style=flat)](http://cocoapods.org/pods/DZURLRoute)



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
