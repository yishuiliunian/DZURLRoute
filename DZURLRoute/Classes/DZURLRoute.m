//
//  DZURLRoute.m
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import "DZURLRoute.h"
#import "DZURLRouteRequest.h"
@interface DZURLRoute ()
{
    NSMutableArray* _route;
}
@end

@implementation DZURLRoute
+ (DZURLRoute*) defaultRoute
{
    static DZURLRoute* route = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cla = [DZURLRoute class];
        route = [[cla alloc] init];
    });
    return route;
}
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _route = [NSMutableArray new];
    return self;
}

- (void) addRoutePattern:(NSString *)routePattern handler:(DZURLRoutePatternHandler)handler
{
    NSParameterAssert(routePattern);
    NSParameterAssert(handler);
    DZURLRouteRecord* record = [[DZURLRouteRecord alloc] initWithPartern:routePattern handler:handler];
    if ([_route containsObject:record]) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"the pattern[%@] is exist in the route, please choose another", routePattern]
                                     userInfo:@{}];
    }
    [_route addObject:record];
}

- (DZURLRouteRecord*) routeRecordHandleURL:(NSURL*)url
{
    NSString* urlStr = url.absoluteString;
    for (DZURLRouteRecord* record in _route) {
        if (![record canHandlerRequestURL:urlStr]) { // can not route, then next
            continue;
        } else { //can route, then break

            return record;
        }
    }
    return nil;
}
- (BOOL) routeURL:(NSURL*)url
{
    if (!url) {
        return NO;
    }
    DZURLRouteRecord* record = [self routeRecordHandleURL:url];
    if (!record) {
        return NO;
    }
    DZURLRouteRequest* request = [[DZURLRouteRequest alloc] initWithURL:url];
    if (record.handler) {
        return record.handler(request);
    } else {
        return NO;
    }
    // do not delete the below line , it will handle the rest logic if the function growing
    return NO;
}


@end
