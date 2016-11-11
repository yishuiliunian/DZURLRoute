//
//  DZURLRouteResponse.h
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import <Foundation/Foundation.h>
#import "DZRouteResponseContext.h"
@interface DZURLRouteResponse : NSObject
@property (nonatomic, assign, readonly) BOOL result;
@property (nonatomic, readonly, assign) DZRouteResponseContext*  context;
+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithResult:(BOOL)result NS_DESIGNATED_INITIALIZER;
+ (DZURLRouteResponse*) successResponse;
+ (DZURLRouteResponse*) faildResponse;
@end
