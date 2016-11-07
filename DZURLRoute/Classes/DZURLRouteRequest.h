//
//  DZURLRouteRequest.h
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import <Foundation/Foundation.h>


/**
 when a pattern is mated. the lib will transform the url to DZURLRequest and pust some context in it. you can find some convinice method about url and some context valiable too.
 */
@interface DZURLRouteRequest : NSObject

/**
 the request's origin url
 */
@property (nonatomic, strong, readonly) NSURL* originURL;

/**
 This property contains the scheme. Any percent-encoded characters are not unescaped. For example, in the URL http://www.example.com/index.html, the scheme is http.
 The full URL is the concatenation of the scheme, a colon (:), and the value of resourceSpecifier.
 

 */
@property (nonatomic, strong, readonly) NSString* scheme;


/**
 the first part of URL's paths
 */
@property (nonatomic, strong, readonly) NSString* module;


/**
 the sencond part of URL's paths
 */
@property (nonatomic, strong, readonly) NSString* method;


/**
 the paramters decoded from the query string.
 */
@property (nonatomic, strong, readonly) NSDictionary* paramters;


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
- (instancetype) initWithURL:(NSURL*)url;
@end
