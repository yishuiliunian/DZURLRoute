//
//  DZURLRouteRequest.m
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import "DZURLRouteRequest.h"
#import "DZUIStackLifeCircleAction.h"

#import "DZURLRouteUtils.h"

@implementation DZURLRouteRequest
- (instancetype) initWithURL:(NSURL *)url
{
    self = [super init];
    if (!self) {
        return self;
    }
    _originURL = url;
    [self decodeURL];
    return self;
}

- (void) decodeURL
{
    _scheme = _originURL.scheme;
    NSArray* paths = _originURL.pathComponents;
    _module = _originURL.host;
    if (paths.count > 1) {
        _method = paths[1];
    }
    NSString* query = _originURL.query;
    _paramters = DZURLRouteDecodeURLQueryParamters(query);
}

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
