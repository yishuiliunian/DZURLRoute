//
//  DZVCOnceLifeCircleAction.m
//  Pods
//
//  Created by stonedong on 16/10/30.
//
//

#import "DZVCOnceLifeCircleAction.h"

@interface DZVCOnceLifeCircleAction ()
{
    BOOL _firstAppear;
}
@end
@implementation DZVCOnceLifeCircleAction
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _firstAppear = YES;
    return self;
}
+ (instancetype) actionWithOnceBlock:(DZViewControllerOnceActionWhenAppear)block
{
    return [[DZVCOnceLifeCircleAction alloc] initWithBlock:block];
}

- (instancetype) initWithBlock:(DZViewControllerOnceActionWhenAppear)block
{
    self = [self init];
    if (!self) {
        return self;
    }
    _actionBlock = block;
    return self;
}
- (void) hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated
{
    [super hostController:vc viewDidAppear:animated];
    if (_firstAppear) {
        if (_actionBlock) {
            _actionBlock(vc, animated);
        }
        _firstAppear = NO;
    }
}
@end
