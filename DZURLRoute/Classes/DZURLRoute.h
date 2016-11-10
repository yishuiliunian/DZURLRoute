//
//  DZURLRoute.h
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import <Foundation/Foundation.h>
#import "DZURLRouteRecord.h"
#import "DZURLRouteRequest.h"
#import "DZURLRouteUtils.h"
#import "DZUIStackLifeCircleAction.h"



/**
 DZURLRoute is an lib to location any objective-c controller and route it. this call provide API. what you will do is just to add the handler , then route a url that is registed pattern.
 */
@interface DZURLRoute : NSObject
// disable the  initialize method that is not used.
+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) copy NS_UNAVAILABLE;
- (instancetype) mutableCopy NS_UNAVAILABLE;
//

/**
 singloton of route. it hold the records of route pattern.

 @return singloton of router
 */
+ (DZURLRoute*) defaultRoute;


/**
 insert an route pattern to default router. it is designed every pattern must be unique. it maybe use priority next version , if so it can be not unique. 
 the handler is block. it post an DZURLRequest that is the program context. you can use it to find something usefully.

 @param routePattern the route pattern to mate URL
 @param handler handle the request when a URL is mate the pattern
 */
- (void) addRoutePattern:(NSString*)routePattern handler:(DZURLRoutePatternHandler)handler;


/**
 if all pattern is not mated, then this one will be called. It handle the not found action.

 @param handler the 404 handler
 */
- (void) add404Handler:(DZURLRoutePatternHandler)handler;


/**
 we use the stand URL to locate page. so you just post an url to start a page. like:
 scheme://host/pwd?need=0&name=22 . don't worry about the start of page, i will post you the navigation and UI stack via the request paramter.

 @param url the location of an page
 @return if router can  hanle the url, it will be YES, otherwise NO.
 */
- (BOOL) routeURL:(NSURL*)url;


- (BOOL) routeURL:(NSURL *)url context:(DZRouteRequestContext*)context;
@end
