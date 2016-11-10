//
//  DZRouteRequestContext.h
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import "DZURLContext.h"

@interface DZRouteRequestContext : DZURLContext
/**
 the global ui stack
 */
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;


/**
 the toppest instance of UIViewController, it is appearing. you can use it present some page.
 */
@property (nonatomic, strong, readonly) UIViewController* topViewController;

/**
 the topppest navigationcontroller (if stack contains one). you can use it push some page.
 */
@property (nonatomic, strong, readonly) UINavigationController* topNavigationController;

@end
