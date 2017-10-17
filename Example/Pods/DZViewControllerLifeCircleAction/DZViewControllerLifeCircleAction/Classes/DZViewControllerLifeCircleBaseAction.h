//
//  DZViewControllerLifeCircleBaseAction.h
//  Pods
//
//  Created by baidu on 16/10/31.
//
//

#import <Foundation/Foundation.h>
/**
 So many business logic will process between UIViewController appearing and disappearing. But when you want to put thoese logics into every subclass of UIViewController.  The common way is to inheriting. But the obvious problem is UIViewControll what is a class in SDK. We do not have the code, and can not change it. So when subclass it. and make other inherit from this subclass.  and it go on. When have so may class to solve the common logic.  But, when the need changed. PM ask you to remove the logic. The bad dream come. Thinking if the logic is like toy bricks. If it is fine, put it in. If it is not fine, remove it off. So easy. When call it AOP(Aspect Oriented Program) usually.
     
 This class's aim is that building the foundation about AOP to UIVIewController. I swizzed the appear status function. And make this class's method be called when appear status changed. Then you subclass this class and implitation your logic.
 */
@interface DZViewControllerLifeCircleBaseAction : NSObject

@property  (nonatomic, weak, readonly) UIViewController * liveViewController;

/**
 every action have unique identifier. 1to1 replationship.
 */
@property (nonatomic, strong) NSString* identifier;



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
@end
