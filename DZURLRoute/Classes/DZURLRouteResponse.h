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
/**
 the context for response. it will contains the paramters or info that the handler produce.
 */
@property (nonatomic, readonly, strong) DZRouteResponseContext*  context;
+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithResult:(BOOL)result NS_DESIGNATED_INITIALIZER;

/**
 @return a success response with default context
 */
+ (DZURLRouteResponse*) successResponse;
/**
 @return a fail response with default context
 */
+ (DZURLRouteResponse*) faildResponse;


/**
 creat an instance of QCloudURLRouteResponse with result and mainResource.
 
 @param result the handler result
 @param mainResource handler produce resoucrce
 @return creat an instance of QCloudURLRouteResponse
 */
+ (DZURLRouteResponse*) responseResult:(BOOL)result withMainResouce:(id)mainResource ;


+ (DZURLRouteResponse*) successResponseWithMainResouce:(id)mainResource;


+ (DZURLRouteResponse*) faildResponseWithMainResouce:(id)mainResource;
@end
