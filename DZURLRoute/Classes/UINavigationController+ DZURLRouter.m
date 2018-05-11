//
//  UINavigationController+DZURLRouter
//  Pods
//
//  Created by Dong Zhao on 2017/4/19.
//
//

#import "UINavigationController+DZURLRouter.h"
#import "NSObject+DZURLRouter.h"
@implementation UINavigationController (DZURLRouter)
- (void) popToPage:(NSURL*)pageURL
{
    UIViewController* aimVC = nil;
    for (UIViewController* vc  in self.viewControllers) {
        if (![vc.dzSourceRouteURL.scheme.lowercaseString isEqualToString:pageURL.scheme.lowercaseString]) {
            continue;
        }
        if (![vc.dzSourceRouteURL.host.lowercaseString isEqualToString:pageURL.host.lowercaseString]) {
            continue;
        }
        aimVC = vc;
        break;
    }
    if (aimVC) {
        [self popToViewController:aimVC animated:YES];
    }
}
@end
