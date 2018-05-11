//
//  DZURLRoute.m
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import "DZURLRoute.h"
#import "DZURLRouteRequest.h"
#import "DZURLDelayCommand.h"
#import "DZUIStackLifeCircleAction.h"
#import "NSObject+DZURLRouter.h"


@interface DZURLRoute ()
{
    NSMutableArray* _route;
    DZURLRouteRecord* _404Record;
    NSMutableArray* _delayCommandQueue;
}
@end

@implementation DZURLRoute

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    _delayCommandQueue = [NSMutableArray new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRootViewControllerLoaded:) name:DZUIStackNotificationRootVCLoaded object:nil];
    return self;
}

- (void) handleRootViewControllerLoaded:(NSNotification*)nc
{
    for (DZURLDelayCommand* cmd in _delayCommandQueue) {
        [self routeURL:cmd.url context:cmd.context];
    }
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
   return [self routeURL:url context:nil];
}

- (BOOL) routeURL:(NSURL*)url context:(DZRouteRequestContext *)context
{
    DZURLRouteResponse* response = [self locationResource:url context:context redirect404:YES];
    return response.result;
}

- (void) add404Handler:( DZURLRouteLocationResourceHandler )handler
{
    _404Record = [[DZURLRouteRecord alloc] initWithPartern:@"unknown-404://" handler:handler];
}


- (DZURLRouteResponse*) locationResource:(NSURL *)url context:(DZRouteResponseContext *)context redirect404:(BOOL)redirect
{
#ifdef DEBUG
    NSLog(@"[ROUTE] will route %@", url);
#endif
    if (!context) {
        context = [DZRouteRequestContext new];
    }
    DZURLRouteRequest* request = [[DZURLRouteRequest alloc] initWithURL:url context:context];
    
    
    DZURLRouteResponse*(^Hanlde404)(void) = ^ {
        if (_404Record.handler && redirect) {
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
        DZURLRouteResponse* response = record.handler(request);
        response.context.mainResource.dzSourceRouteURL = url;
        return response;
    }
    // do not delete the below line , it will handle the rest logic if the function growing
    return Hanlde404();
}

- (void) routePage:(NSURL *)url context:(DZRouteRequestContext *)context
{
    if (DZUIShareStackInstance().rootViewControllerLoaded) {
        [self routeURL:url context:context];
    } else {
        DZURLDelayCommand* cmd = [[DZURLDelayCommand alloc] initWithURL:url context:context];
        [_delayCommandQueue addObject:cmd];
    }
}
@end
