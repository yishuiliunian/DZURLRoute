//
//  DZURLRoute.h
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import <Foundation/Foundation.h>
#import "DZURLRouteRecord.h"
#import "DZURLRouteRequest.h"
#import "DZURLRouteUtils.h"
@interface DZURLRoute : NSObject
+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) copy NS_UNAVAILABLE;
- (instancetype) mutableCopy NS_UNAVAILABLE;
+ (DZURLRoute*) defaultRoute;

//
- (void) addRoutePattern:(NSString*)routePattern handler:(DZURLRoutePatternHandler)handler;
- (void) add404Handler:(DZURLRoutePatternHandler)handler;
- (BOOL) routeURL:(NSURL*)url;
@end
