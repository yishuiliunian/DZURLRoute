//
//  DZURLContext.m
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import "DZURLContext.h"
#import "DZURLWeakProxy.h"
@interface DZURLContext ()
{
    NSMutableDictionary* _dictonary;
}

@end
@implementation DZURLContext
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _dictonary = [NSMutableDictionary new];
    return self;
}
- (void) setValue:(id)value forKey:(NSString *)key
{
    if (!key) {
        return;
    }
    if (!value) {
        if ([_dictonary objectForKey:key]) {
            [_dictonary removeObjectForKey:key];
        }
    } else {
        _dictonary[key] = value;
    }
}

- (void) setWeakValue:(id)value forKey:(NSString *)key
{
    if (value) {
        [self setValue:[DZURLWeakProxy proxyWithTarget:value] forKey:key];
    } else {
        [self setValue:nil forKey:key];
    }
}

- (id) valueForKey:(NSString *)key
{
    return _dictonary[key];
}


- (void) setBoolValue:(BOOL)value forKey:(NSString*)key
{
    [self setValue:@(value) forKey:key];
}

- (BOOL) boolValueForKey:(NSString*)key
{
    id value = [self valueForKey:key];
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return NO;
}

- (void) setIntValue:(int)value forKey:(NSString*)key
{
    [self setValue:@(value) forKey:key];
}

- (int) intValueForKey:(NSString*)key
{
    id value = [self valueForKey:key];
    if ([value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    return 0;
}
@end
