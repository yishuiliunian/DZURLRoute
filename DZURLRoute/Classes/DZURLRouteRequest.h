//
//  DZURLRouteRequest.h
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import <Foundation/Foundation.h>

@interface DZURLRouteRequest : NSObject
@property (nonatomic, strong, readonly) NSURL* originURL;
@property (nonatomic, strong, readonly) NSString* scheme;
@property (nonatomic, strong, readonly) NSString* module;
@property (nonatomic, strong, readonly) NSString* method;
@property (nonatomic, strong, readonly) NSDictionary* paramters;
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;
@property (nonatomic, strong, readonly) UIViewController* topViewController;
@property (nonatomic, strong, readonly) UINavigationController* topNavigationController;
- (instancetype) initWithURL:(NSURL*)url;
@end
