//
//  DZURLRouteRecord.m
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import "DZURLRouteRecord.h"

@interface DZURLRouteRecord ()
{
    NSRegularExpression* _regx;
}
@end
@implementation DZURLRouteRecord
- (instancetype) initWithPartern:(NSString*)parten handler:(DZURLRoutePatternHandler)handler
{
    self = [super init];
    if (!self) {
        return self;
    }
    _partern = parten;
    _handler = handler;
    
    NSError* error;
    NSRegularExpression* regx = [NSRegularExpression regularExpressionWithPattern:_partern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"the pattern is invalid %@;\n %@", _partern, error] userInfo:@{NSLocalizedFailureReasonErrorKey:_partern?:@"nil"}];
    }
    _regx = regx;
    return self;
}
//http://
//http://www.xxx.com
- (BOOL) canHandlerRequestURL:(NSString *)url
{
    NSArray<NSTextCheckingResult*> *result = [_regx matchesInString:url options:0 range:NSMakeRange(0, url.length)];
    if (result.count == 0) {
        return NO;
    }
    NSTextCheckingResult* firstResult = result.firstObject;
    if (firstResult.range.location != 0) {
        return NO;
    }
    return YES;
}

- (BOOL) isEqual:(DZURLRouteRecord*)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.partern isEqualToString:object.partern];
}

@end
