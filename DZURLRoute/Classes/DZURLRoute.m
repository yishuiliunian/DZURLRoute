//
//  DZURLRoute.m
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import "DZURLRoute.h"
#import "DZURLRouteRequest.h"
@interface DZURLRoute ()
{
    NSMutableArray* _route;
    DZURLRouteRecord* _404Record;
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

- (void) addRoutePattern:(NSString *)routePattern handler:(DZURLRouteLocationResourceHandler)handler
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

- (BOOL) routeURL:(NSURL *)url
{
    [self routeURL:url context:nil];
}

- (BOOL) routeURL:(NSURL*)url context:(DZRouteRequestContext *)context
{
#ifdef DEBUG
    NSLog(@"[ROUTE] will route %@", url);
#endif
    if (!context) {
        context = [DZRouteRequestContext new];
    }
    DZURLRouteRequest* request = [[DZURLRouteRequest alloc] initWithURL:url context:context];
    DZURLRouteResponse*(^Hanlde404)(void) = ^ {
        if (_404Record.handler) {
            return _404Record.handler(request);
        }
        return [DZURLRouteResponse faildResponse];
    };
    if (!url) {
        return Hanlde404();
    }
    DZURLRouteRecord* record = [self routeRecordHandleURL:url];
    if (!record) {
        return Hanlde404();
    }
    if (record.handler) {
        return record.handler(request);
    }
    // do not delete the below line , it will handle the rest logic if the function growing
    return Hanlde404();
}

- (void) add404Handler:( DZURLRoutePatternHandler )handler
{
    _404Record = [[DZURLRouteRecord alloc] initWithPartern:@"unkonw-404://" handler:handler];
}

@end
