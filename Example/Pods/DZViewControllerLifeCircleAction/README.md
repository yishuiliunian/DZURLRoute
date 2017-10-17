# DZViewControllerLifeCircleAction

[![CI Status](http://img.shields.io/travis/yishuiliunian/DZViewControllerLifeCircleAction.svg?style=flat)](https://travis-ci.org/yishuiliunian/DZViewControllerLifeCircleAction)
[![Version](https://img.shields.io/cocoapods/v/DZViewControllerLifeCircleAction.svg?style=flat)](http://cocoapods.org/pods/DZViewControllerLifeCircleAction)
[![License](https://img.shields.io/cocoapods/l/DZViewControllerLifeCircleAction.svg?style=flat)](http://cocoapods.org/pods/DZViewControllerLifeCircleAction)
[![Platform](https://img.shields.io/cocoapods/p/DZViewControllerLifeCircleAction.svg?style=flat)](http://cocoapods.org/pods/DZViewControllerLifeCircleAction)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DZViewControllerLifeCircleAction is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DZViewControllerLifeCircleAction"
```
## iOS架构设计解耦的尝试之VC逻辑AOP切割

> 该系列文章是2016年折腾的一个总结，对于这一年中思考和解决的一些问题做一些梳理和总结

上一篇文章[iOS架构设计解耦的尝试之模块间通信](http://www.dzpqzb.com/2017/01/11/ios-module-communication.html)中提到要说一下全局UI堆栈是怎么维护的。要写的时候发现，这个东西背后还有一个更有意思的东西：使用AOP对VC的业务逻辑进行切割。在DZURLRoute中所使用到的全局UI堆栈就是基于该思想构建出来的。这一部分的成果在库[DZViewControllerLifeCircleAction](https://github.com/yishuiliunian/DZViewControllerLifeCircleAction)中总结成了Code（Talk is cheap. Show me the code）。而我们在[
iOS架构设计系列之解耦的尝试之变异的MVVM](http://www.dzpqzb.com/2016/10/28/mvvm-elementkit.html)中提到了通过MVVM来进行解耦，而这篇文章我们又通过另外一种方式AOP来尝试进行解耦。感觉这一年在疯狂的解耦：)。

## AOP
先从AOP说起，其实在之前的文章中或者开发的库中已经涉及到过很多次。比如对于Instance进行逻辑注入的库[MRLogicInjection](http://www.dzpqzb.com/2016/08/18/mrlogicinjection.html)，基于MRLogicInjection的应用方案用于相应区域扩展的[DZExtendResponse](https://github.com/yishuiliunian/DZExtendResponse)、用于放重复点击的[DZDeneyRepeat](https://github.com/yishuiliunian/DZDeneyRepeat)、用于界面上红点提醒的[MagicRemind](https://github.com/yishuiliunian/MagicRemind)。这一年对于AOP也算有了一个比较深入的实践。而这次要说的VC逻辑切割，其实也算是AOP的一个实践。说句题外话，Objective-C是门神奇的语言，他提供的动态性，让我们可以对其进行很多有意思的改造，把OC改造成一个更好用的工具。而对其进行AOP改造就是我发现的非常有意思的一个事情。



> 在软件业，AOP为Aspect Oriented Programming的缩写，意为：面向切面编程，通过预编译方式和运行期动态代理实现程序功能的统一维护的一种技术。AOP是OOP的延续，是软件开发中的一个热点，也是Spring框架中的一个重要内容，是函数式编程的一种衍生范型。利用AOP可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的耦合度降低，提高程序的可重用性，同时提高了开发的效率。


上面这段文字摘自[百度百科](http://baike.baidu.com/item/AOP/1332219)。对于AOP做了一个非常好的解释，点击链接可以进去看看具体的内容。关于AOP只简短的说一下我自己的理解，以作补充。

OC本来是个OOP的语言，我们通过封装、继承、多态来组织类之间的静态结构，然后去实现我们的业务逻辑。只不过有些时候，严格遵循OOP的思想去设计继承结构，会产生非常深的继承关系。这势必要增加整个系统的理解复杂度。而这并不是我们希望的。另外一点，我们讲究设计的时候能够满足开闭原则，对变化是开放的，对于修改是封闭的。然而当我们的类继承结构比较复杂的时候，就很难做到这一点。我们先来看一个比较Common的例子：

~~~
└── Object
    └── biont
        ├── Animal
        │   ├── cat
        │   └── dog
        └── plant
~~~

我们现在要构建一个用于描述生物的系统（精简版），第一版我们做出了类似于上面的类结构。我们在Animal类中写了cat和dog的公有行为，在cat和dog中各自描述了他们独有的行为。这个时候突然发现我们多了一个sparrow物种。但是呢我们在Animal中描述的是动物都有四条腿，而sparrow只有两条腿，于是原有的类结构就不能满足现在的需求了，就得改啊。

~~~
└── Object
    └── biont
        ├── Animal
        │   ├── flying
        │   │   └── sparrow
        │   └── reptile
        │       ├── cat
        │       └── dog
        └── plant
~~~

为了能够引入sparrow我们修改了Animal类，将四条腿的描述放到了reptile类中，并修改了Cat和Dog的继承关系。修改的变动量还是不小的。引入了两个新类，并对原有三个进行比较大的改动。

而如果用AOP的话我们会怎么处理这个事情呢？切割和组合。

![](http://wx2.sinaimg.cn/mw690/7df22103ly1fbmp5nht8gj208x06q74q.jpg)


我们会将四条腿独立出来，爬行切割出来，两条腿切割出来，会飞切割出来
。。。然后dog就是四条腿爬行的动物。sparrow就是两条腿会飞的动物。没有了层次深的类继承结构。更多的是组合，而一个具体的类更像是一个容器，用来容纳不同的职责。当把这些不同的职责组合在一起的时候就得到了我们需要的类。AOP则提供一整套的瑞士军刀，指导你如何进行切割，并如何进行组合。这也是我认为AOP的最大魅力。


## [DZViewControllerLifeCircleAction](https://github.com/yishuiliunian/DZViewControllerLifeCircleAction) 对VC进行逻辑切割和组合

类似于上面我们提到的例子，我们在写ViewController的业务逻辑的时候，也有可能造成非常深的继承结构。而我们其实发现在众多的业务逻辑中，有些东西是可以单独抽离出来的。比如：

1. 我们会在页面第一次viewWillAppear的时候刷新一次数据，这个在TableViewController会这样，在CollectionViewController的时候也会这样。
2. 我们会在生命周期打Log，对用户的使用路径进行上报。
3. ....

有些事情我们通过类集成来做了，比如打Log，找一个跟类，在里面把打Log的逻辑写了。但是当发现在继承树的末端有一个ViewController不需要打Log的时候就尴尬了。得大费周折的去改类结构，来适配这个需求。但是，如果这些业务逻辑像是积木一样，需要的时候拿过来用，不需要的时候不管他，多好。这样需要打Log的时候，拿过来一个打Log的积木堆进去，不需要的时候把打Log的积木拿走。

### 职责编程界面

而这就是AOP，面向切面编程。我们在ViewController上所选择进行逻辑编制的切面就是UIViewController的各种展示回调：

~~~
- (void)viewWillAppear:(BOOL)animated
- (void)viewDidAppear:(BOOL)animated
- (void)viewWillDisappear:(BOOL)animated
- (void)viewDidDisappear:(BOOL)animated
~~~


选择这四个函数做为切面是因为在实际的编程过程中发现我们绝大多数的业务逻辑的起点都在这里面，还有一些在viewDidLoad里面。不过按照语义来讲，viewDidLoad中应该是更多的对于VC中属性变量的初始化工作，而不是业务逻辑的处理。在DZViewControllerLifeCircleAction的设计的时候，我们更多的是关注到ViewController的展示周期内会做的一些事情。就像：

1. 在第一次展示的进行数据加载
2. 展示的时候增加xxx的通知，在不展示的时候移除
3. 在第一次展示的时候执行特殊的动作
4. 构建特殊的页面逻辑
5. 。。。。。。

对应的我们在抽象出来的职责基类DZViewControllerLifeCircleBaseAction中提供了具体的编程接口：

~~~
/**
 When a instance of UIViewController's view will appear , it will call this method. And post the instance of UIViewController
 @param vc the instance of UIViewController that will appear
 @param animated  appearing is need an animation , this will be YES , otherwise NO.
 */
- (void) hostController:(UIViewController*)vc viewWillAppear:(BOOL)animated;
/**
 When a instance of UIViewController's view did appeared. It will call this method, and post the instance of UIViewController which you can modify it.
 @param vc the instance of UIViewController that did appeared
 @param animated appearing is need an animation , this will be YES, otherwise NO.
 */
- (void) hostController:(UIViewController*)vc viewDidAppear:(BOOL)animated;
/**
 When a instance of UIViewController will disappear, it will call this method, and post the instance of UIViewController which you can modify it.
 @param vc the instance of UIViewController that will disappear
 @param animated dispaaring is need an animation , this will be YES, otherwise NO.
 */
- (void) hostController:(UIViewController*)vc viewWillDisappear:(BOOL)animated;
/**
 When a UIViewController did disappear, it will call this method ,and post the instance of UIViewController which you can modify it.
 @param vc the instance of UIViewControll that did disppeared.
 @param animated disappearing is need an animation, this will be YES, otherwise NO.
 */
- (void) hostController:(UIViewController*)vc viewDidDisappear:(BOOL)animated;
~~~
一个独立的职责可以集成基类创建一个子类，重载上述编程接口，进行逻辑编制。在展示周期内去写自己都有的逻辑。这里建议将这些逻辑尽可能的切割成粒度较小的逻辑单元。

> 在后续版本中也会考虑增加其他函数切入点的支持。

###  职责注入与删除编程界面

而所有的这些职责，可以分成两类：

1. 通用职责，表现为所有的UIViewController都会有的职责，比如日志Log。
2. 专用职责，比如一个UITableViewController，需要在展示时才注册xxx通知。

因而，在ViewController中设计职责容器的时候，也对应的设计了两个职责容器：

#### DZViewControllerGlobalActions(）用来承载通用职责

可以通过接口：

~~~

/**
 This function will remove the target instance from the global cache . Global action will be call when every UIViewController appear. if you want put some logic into every instance of UIViewController, you can user it.
 
 @param action the action that will be rmeove from global cache.
 */
FOUNDATION_EXTERN void DZVCRemoveGlobalAction(DZViewControllerLifeCircleBaseAction* action);



/**
 This function will add an instance of DZViewControllerLifeCircleBaseAction into the global cache. Global action will be call when every UIViewController appear. if you want put some logic into every instance of UIViewController, you can user it.
 
 @param action the action that will be insert into global cache
 */

FOUNDATION_EXTERN void DZVCRegisterGlobalAction(DZViewControllerLifeCircleBaseAction* action);
~~~

来增加或者删除职责。


#### 专用职责容器
可以通过下述接口进行添加或者删除职责：

~~~
@interface UIViewController (appearSwizzedBlock)


/**
 add an instance of DZViewControllerLifeCircleBaseAction to the instance of UIViewController or it's subclass.
 @param action the action that will be inserted in to the cache of UIViewController's instance.
 */
- (DZViewControllerLifeCircleBaseAction* )registerLifeCircleAction:(DZViewControllerLifeCircleBaseAction *)action;


/**
 remove an instance of DZViewControllerLifeCircleBaseAction from the instance of UIViewController or it's subclass.
 @param action the action that will be removed from cache.
 */
- (void) removeLifeCircleAction:(DZViewControllerLifeCircleBaseAction *)action;
@end

~~~

### 使用举例

#### LogAction
先拿我们刚才一直再说的Log的例子来说，我们可以写一个专门打Log的Action：

~~~
@interface DZViewControllerLogLifeCircleAction : DZViewControllerLifeCircleBaseAction
@end


@implementation DZViewControllerLogLifeCircleAction

+ (void) load
{
    DZVCRegisterGlobalAction([DZViewControllerLogLifeCircleAction new]);
}
- (void) hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated
{
    [super hostController:vc viewDidDisappear:animated];
    [TalkingData trackPageBegin:YHTrackViewControllerPageName(vc)];
    
}
- (void) hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated
{
    [super hostController:vc viewDidAppear:animated];
    [TalkingData trackPageEnd:YHTrackViewControllerPageName(vc)];
}
@end
~~~

在该类Load的时候将该Action注册到通用职责容器中，这样所有的ViewController都能够打Log了。如果某一个ViewController不需要打Log可以直接选择屏蔽掉该Action。


### UIStack
好了，这个才是最终要说的正题。扯了半天，其实就是为了说这个全局的展示的UIStack是怎么维护的。首先要说明的是，此处的UIStack所维护的内容的是正在展示的ViewController的堆栈关系，而不是keywindow上ViewController的叠加关系。

当一个ViewController展示的时候他就入栈，当一个ViewController不在展示的时候就出栈。

因而在该UIStack中的内容是当前整个APP正在展示的ViewController的堆栈。而他的实现原理就是继承DZViewControllerLifeCircleBaseAction并在viewAppear的时候入栈，在viewDisAppear的时候出栈。

~~~
@implementation DZUIStackLifeCircleAction

+ (void) load
{
    DZUIShareStack = [DZUIStackLifeCircleAction new];
    DZVCRegisterGlobalAction(DZUIShareStack);
}

- (void) hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated
{
    [super hostController:vc viewDidAppear:animated];
    //入栈
    if (vc) {
        [_uiStack addPointer:(void*)vc];
    }
}

//出栈
- (void) hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated
{
    [super hostController:vc viewDidDisappear:animated];
    NSArray* allObjects = [_uiStack allObjects];
    for (int i = (int)allObjects.count-1; i >= 0; i--) {
        id object = allObjects[i];
        if (vc == object) {
            [_uiStack replacePointerAtIndex:i withPointer:NULL];
        }
    }
    [_uiStack compact];
}
....
@end
~~~

同样也注册为一个通用职责。上面这两个例子下来，就已经在ViewController中加入了两个通用职责了。而这些职责之间都是隔离的，是代码隔离的那种！！！

### 执行一次的Action， 专用职责的例子

在ViewController编程的时候，我们经常会写一些类似于_firstAppear这样的BOOL类型的变量，来标记这个VC是第一次被展示，然后做一些特定的动作。其实这个就是在VC所有的展示周期内只做一次的操作，针对此需求我们可以写一个这样的Action：

~~~

/**
 The action block to handle ViewController appearing firstly.

 @param vc The UIViewController tha appear
 @param animated It will aminated paramter from the origin SEL paramter.
 */
typedef void (^DZViewControllerOnceActionWhenAppear)(UIViewController* vc, BOOL animated);

/**
 when a ViewController appear firstly , it will do something . This class is design for this situation
 */
@interface DZVCOnceLifeCircleAction : DZViewControllerLifeCircleBaseAction


/**
 The action block to handle ViewController appearing firstly.
 */
@property (nonatomic, strong) DZViewControllerOnceActionWhenAppear actionBlock;

 
/**
 Factory method to reduce an instance of DZViewControllerOnceActionWhenAppear
 @param block The handler to cover UIViewController appearing firstly
 @return an instance of DZViewControllerOnceActionWhenAppear
 */
+ (instancetype) actionWithOnceBlock:(DZViewControllerOnceActionWhenAppear)block;

 

/**
 a once action is an class that handle some logic once when one instance of UIViewController appear. It need a block to exe the function.

 @param  the logic function to exe
 @return an instance of DZVCOnceLifeCircleAction
 */
- (instancetype) initWithBlock:(DZViewControllerOnceActionWhenAppear)block;

@end
~~~

该Action默认包含在DZViewControllerLifeAction库中了。当有VC需要这种指责的时候直接注入就行了，例如：

~~~
  [tableVC registerLifeCircleAction:[DZVCOnceLifeCircleAction actionWithOnceBlock:^(UIViewController *vc, BOOL animated) {
                [[DZContactMonitor userMonitor] asyncLoadSystemContacts];
            }]];
~~~

## 其他

上面我们举了通用职责和专用职责的例子，都还算是比较简单的例子。其实，就是希望把职责拆解成粒度更小的单元。然后组合使用。而在我的APP中还有更加复杂的关于应用ViewController的AOP的例子。我把一个整个逻辑模块，比如弹幕功能做为了一个逻辑单元，基于DZViewControllerLifeAction来写，当某个界面需要弹幕的时候，就当做专用职责进行逻辑注入。而这样一来，发现你完全可以复用一整块原先可能完全不能复用的逻辑。在解耦和复用这条路上，这种方式算是目前我做的比较疯狂的事情了。非常有意思。
## Author

yishuiliunian, yishuiliunian@gmail.com

## License

DZViewControllerLifeCircleAction is available under the MIT license. See the LICENSE file for more info.
