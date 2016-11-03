//
//  DZUIStackLifeCircleAction.m
//  Pods
//
//  Created by baidu on 2016/11/2.
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
    NSPointerArray* _uiStack;
    
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
    _uiStack = [NSPointerArray weakObjectsPointerArray];;
    return self;
}
- (void) __logUIStack
{
    for (int i = (int)_uiStack.count - 1; i >= 0; i--) {
        UIViewController* vc = [_uiStack pointerAtIndex:i];
        NSLog(@"STACK [%d] is %@", i , vc);
    }
}
- (void) hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated
{
    [super hostController:vc viewDidAppear:animated];
    if (vc) {
        [_uiStack addPointer:(void*)vc];
    }
    [_uiStack compact];
#ifdef DEBUG
    [self __logUIStack];
#endif
}
- (void) hostController:(UIViewController *)vc viewWillDisappear:(BOOL)animated
{
    [super hostController:vc viewWillDisappear:animated];
    [_uiStack compact];
}

- (void) hostController:(UIViewController *)vc viewWillAppear:(BOOL)animated
{
    [super hostController:vc viewWillAppear:animated];
    [_uiStack compact];
}
- (void) hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated
{
    [super hostController:vc viewDidDisappear:animated];
    NSArray* allObjects = [_uiStack allObjects];
    for (int i = (int)allObjects.count-1; i >= 0; i--) {
        id object = allObjects[i];
        if (vc == object) {
            [_uiStack replacePointerAtIndex:i withPointer:NULL];
        }
    }
    [_uiStack compact];
#ifdef DEBUG
    [self __logUIStack];
#endif
}

- (NSArray*) viewControllerStack
{
    [_uiStack compact];
    return [_uiStack allObjects];
}
@end
