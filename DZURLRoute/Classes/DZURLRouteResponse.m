//
//  DZURLRouteResponse.m
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import "DZURLRouteResponse.h"

@implementation DZURLRouteResponse
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _context = [DZRouteResponseContext new];
    return self;
}
@end
