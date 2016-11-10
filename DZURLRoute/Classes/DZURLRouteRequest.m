//
//  DZURLRouteRequest.m
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import "DZURLRouteRequest.h"

#import "DZURLRouteUtils.h"

@implementation DZURLRouteRequest
- (instancetype) initWithURL:(NSURL *)url context:(DZRouteRequestContext *)context
{
    self = [super init];
    if (!self) {
        return self;
    }
    _originURL = url;
    _context = context;
    [self decodeURL];
    return self;
}

- (void) decodeURL
{
    _scheme = _originURL.scheme;
    NSArray* paths = _originURL.pathComponents;
    _module = _originURL.host;
    if (paths.count > 1) {
        _method = paths[1];
    }
    NSString* query = _originURL.query;
    _paramters = DZURLRouteDecodeURLQueryParamters(query);
}

@end
