//
//  DZUIStackLifeCircleAction.m
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import "DZUIStackLifeCircleAction.h"



static DZUIStackLifeCircleAction* DZUIShareStack;

DZUIStackLifeCircleAction* DZUIShareStackInstance()
{
    return DZUIShareStack;
}

@interface DZUIStackLifeCircleAction ()
{
    NSMutableArray* _uiStack;
}
@end

@implementation DZUIStackLifeCircleAction

+ (void) load
{
    DZUIShareStack = [DZUIStackLifeCircleAction new];
    DZVCRegisterGlobalAction(DZUIShareStack);
}
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _uiStack = [NSMutableArray new];
    return self;
}
- (void) __logUIStack
{
    for (int i = (int)_uiStack.count - 1; i >= 0; i--) {
        UIViewController* vc = _uiStack[i];
        NSLog(@"STACK [%d] is %@", i , vc);
    }
}
- (void) hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated
{
    [super hostController:vc viewDidAppear:animated];
    if (vc) {
        [_uiStack addObject:vc];
    }
}

- (void) hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated
{
    [super hostController:vc viewDidDisappear:animated];
    [_uiStack removeObject:vc];
}

- (NSArray*) viewControllerStack
{
    return [_uiStack copy];
}
@end
