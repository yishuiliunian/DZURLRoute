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
@property (nonatomic, readonly, assign) DZRouteResponseContext*  context;

+ (DZURLRouteResponse*) successResponse;
+ (DZURLRouteResponse*) faildResponse;
@end
