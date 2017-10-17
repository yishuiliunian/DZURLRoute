//
//  DZVCOnceLifeCircleAction.h
//  Pods
//
//  Created by stonedong on 16/10/30.
//
//

#import "DZViewControllerLifeCircleBaseAction.h"

/**
 The action block to handle ViewController appearing firstly.
 
 @param vc The UIViewController tha appear
 @param animated It will aminated paramter from the origin SEL paramter.
 */
typedef void (^DZViewControllerOnceActionWhenAppear)(id viewController, BOOL animated);


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
