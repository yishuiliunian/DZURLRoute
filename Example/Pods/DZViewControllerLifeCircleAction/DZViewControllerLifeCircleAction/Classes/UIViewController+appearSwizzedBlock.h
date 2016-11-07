//
//  UIViewController+appearSwizzedBlock.h
//  Pods
//
//  Created by stonedong on 16/10/29.
//
//

#import <UIKit/UIKit.h>

#import "DZViewControllerLifeCircleBaseAction.h"

/**
 every instance of UIViewController have a action cache. This category provide the API to manipulate this cache.
 */
@interface UIViewController (appearSwizzedBlock)


/**
 add an instance of DZViewControllerLifeCircleBaseAction to the instance of UIViewController or it's subclass.

 @param action the action that will be inserted in to the cache of UIViewController's instance.
 */
- (void)registerLifeCircleAction:(DZViewControllerLifeCircleBaseAction *)action;


/**
 remove an instance of DZViewControllerLifeCircleBaseAction from the instance of UIViewController or it's subclass.

 @param action the action that will be removed from cache.
 */
- (void) removeLifeCircleAction:(DZViewControllerLifeCircleBaseAction *)action;
@end



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
