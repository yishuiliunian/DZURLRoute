//
//  DZURLRouteResponse.m
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import "DZURLRouteResponse.h"


#define NS_UNAVAILABLE
@interface DZURLRouteResponse ()
- (instancetype) init ;
@end

@implementation DZURLRouteResponse

+ (DZURLRouteResponse*) responseResult:(BOOL)result withMainResouce:(id)mainResource
{
    DZURLRouteResponse* response = [[DZURLRouteResponse alloc] initWithResult:result];
    response.context.mainResource = mainResource;
    return response;
}


+ (DZURLRouteResponse*) successResponseWithMainResouce:(id)mainResource
{
    DZURLRouteResponse* response = [[DZURLRouteResponse alloc] initWithResult:YES];
    response.context.mainResource = mainResource;
    return response;
}

+ (DZURLRouteResponse*) faildResponseWithMainResouce:(id)mainResource
{
    DZURLRouteResponse* response = [[DZURLRouteResponse alloc] initWithResult:NO];
    response.context.mainResource = mainResource;
    return response;
}

- (instancetype) initWithResult:(BOOL)result
{
    self = [super init];
    if (!self) {
        return self;
    }
    _context = [DZRouteResponseContext new];
    _result = result;
    return self;
}

+ (DZURLRouteResponse*) successResponse
{
    return [[DZURLRouteResponse alloc] initWithResult:YES];
}

+ (DZURLRouteResponse*) faildResponse
{
    return [[DZURLRouteResponse alloc] initWithResult:NO];
}
@end
