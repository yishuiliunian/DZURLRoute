//
//  DZURLDelayCommand.m
//  Pods
//
//  Created by baidu on 2017/2/8.
//
//

#import "DZURLDelayCommand.h"

@implementation DZURLDelayCommand

- (instancetype) initWithURL:(NSURL *)url context:(DZRouteRequestContext *)context
{
    self = [super init];
    if (!self) {
        return self;
    }
    _url = url;
    _context = context;
    return self;
}
@end
