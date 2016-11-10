//
//  DZRouteRequestContext.m
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import "DZRouteRequestContext.h"
#import "DZUIStackLifeCircleAction.h"

@implementation DZRouteRequestContext
- (NSArray*) viewControllerStack
{
    return [DZUIShareStackInstance() viewControllerStack];
}

- (UIViewController*) topViewController
{
    return DZUIShareStackInstance().viewControllerStack.lastObject;
}

- (UINavigationController*) topNavigationController
{
    NSArray* vcs = [self viewControllerStack];
    for (int i = (int)vcs.count -1; i >=0 ; i--) {
        UIViewController* vc = vcs[i];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            return vc;
        }
        if (vc.navigationController) {
            return vc.navigationController;
        }
    }
    return nil;
}

@end
