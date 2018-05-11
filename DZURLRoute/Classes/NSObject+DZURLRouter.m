//
//  UIViewController+QCloudURLRouter.m
//  Pods
//
//  Created by Dong Zhao on 2017/3/23.
//
//

#import "NSObject+DZURLRouter.h"
#import <objc/runtime.h>

static void * kDZURLRouteURLKey = &kDZURLRouteURLKey;
@implementation NSObject (DZURLRouter)

- (NSURL*) dzSourceRouteURL
{
    return objc_getAssociatedObject(self, kDZURLRouteURLKey);
}

- (void) setDzSourceRouteURL:(NSURL *)dzSourceRouteURL
{
    objc_setAssociatedObject(self, kDZURLRouteURLKey, dzSourceRouteURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
