//
//  DZRouteRequestContext.h
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import "DZURLContext.h"


/**
 The route request context. it contains some values for enviroment. for example : the UIViewController stack and so on.
  the class design for  contains value that not only string.  URL query can pass string or interger value, but no object. this class can pass object value.
 */
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
