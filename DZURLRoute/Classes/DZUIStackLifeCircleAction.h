//
//  DZUIStackLifeCircleAction.h
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import <DZViewControllerLifeCircleAction/DZViewControllerLifeCircleAction.h>


/**
 this action inherit from an AOP base class named DZViewControllerLifeCircleBaseAction. You can check it at http://www.github/yishuiliunian/DZViewControllerLifeCircleAction .  responsibility of this class is that hold a stack for all  UIViewController that is appearing. It will register an instance of class when +load. and the instance is singloton. Useing it you can get the appearing view stack.
 */
@interface DZUIStackLifeCircleAction : DZViewControllerLifeCircleBaseAction

/**
 the appearing UIViewController stack. you can use it to find some UIViewController that meet the conditions.
 */
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;
@end



/**
 The singloton of DZUIStackLifeCircleAction. you global ui stack is in it.

 @return the singloton of DZUIStackLifeCircleAction
 */
FOUNDATION_EXTERN DZUIStackLifeCircleAction* DZUIShareStackInstance();
