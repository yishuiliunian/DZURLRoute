//
//  UIViewController+appearSwizzedBlock.m
//  Pods
//
//  Created by stonedong on 16/10/29.
//
//

#import "UIViewController+appearSwizzedBlock.h"
#import <objc/runtime.h>
void __DZViewControllerLifeCircleSwizzInstance(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static void* DZViewAppearKey = &DZViewAppearKey;

typedef void(^DZViewAppearBlock)(BOOL animated);

typedef void(^DZItorActionBlock)(DZViewControllerLifeCircleBaseAction* action );

void DZItorAction(NSArray* actions, DZItorActionBlock block) {
    for (DZViewControllerLifeCircleBaseAction* action in actions) {
        if (block) {
            block(action);
        }
    }
}

NSMutableArray* DZViewControllerGlobalActions() {
    static NSMutableArray* globalActions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalActions = [NSMutableArray array];
    });
    return globalActions;
}

void DZVCRegisterGlobalAction(DZViewControllerLifeCircleBaseAction* action) {
    void(^Register)(void) = ^(void) {
        NSMutableArray* actions = DZViewControllerGlobalActions();
        if (![actions containsObject:action]) {
            [actions addObject:action];
        }
    };
    
    if ([NSThread mainThread]) {
        Register();
    } else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            Register();
        });
    }
}

void DZVCRemoveGlobalAction(DZViewControllerLifeCircleBaseAction* action) {
    void(^Remove)(void) = ^(void) {
        NSMutableArray* actions = DZViewControllerGlobalActions();
        if ([actions containsObject:action]) {
            [actions removeObject:action];
        }
    };
    if ([NSThread mainThread]) {
        Remove();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            Remove();
        });
    }
}

@implementation UIViewController (appearSwizzedBlock)
- (NSArray*) lifeCircleActions
{
    NSArray* lcs = objc_getAssociatedObject(self, DZViewAppearKey);
    if ([lcs isKindOfClass:[NSArray class]]) {
        return lcs;
    }
    return [NSArray array];
}

- (void) setLifeCircleActions:(NSArray*)array
{
    objc_setAssociatedObject(self, DZViewAppearKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (DZViewControllerLifeCircleBaseAction* )registerLifeCircleAction:(DZViewControllerLifeCircleBaseAction *)action
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:[self lifeCircleActions]];
    if ([array containsObject:action]) {
        for (DZViewControllerLifeCircleBaseAction* act in array) {
            if ([action.identifier isEqualToString:act.identifier]) {
                return act;
            }
        }
    }
    [array addObject:action];
    [self setLifeCircleActions:array];
    return action;
}

- (void) removeLifeCircleAction:(DZViewControllerLifeCircleBaseAction *)action
{
    NSArray* array = [self lifeCircleActions];
    NSInteger index = [array indexOfObject:action];
    if (index == NSNotFound) {
        return;
    }
    NSMutableArray* mArray = [NSMutableArray arrayWithArray:array];
    [mArray removeObjectAtIndex:index];
    [self setLifeCircleActions:array];
}



- (void) yh_action_performAction:(DZItorActionBlock)block
{
    DZItorAction([DZViewControllerGlobalActions() copy], block);
    DZItorAction([[self lifeCircleActions] copy], block);
}

- (void) yh_action_swizzViewDidDisappear:(BOOL)animated
{
    [self yh_action_swizzViewDidDisappear:animated];
    [self yh_action_performAction:^(DZViewControllerLifeCircleBaseAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewDidDisappear:)]) {
            [action hostController:self viewDidDisappear:animated];
        }
    }];
}

- (void) yh_action_swizzViewWillDisappear:(BOOL)animated
{
    [self yh_action_swizzViewWillDisappear:animated];
    [self yh_action_performAction:^(DZViewControllerLifeCircleBaseAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewWillDisappear:)]) {
            [action hostController:self viewWillDisappear:animated];
        }
    }];
}
- (void) yh_action_swizzviewWillAppear:(BOOL)animated
{
    [self yh_action_swizzviewWillAppear:animated];
    [self yh_action_performAction:^(DZViewControllerLifeCircleBaseAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewWillAppear:)]) {
            [action hostController:self viewWillAppear:animated];
        }
    }];
}

-(void)yh_action_swizzviewDidAppear:(BOOL)animated
{
    [self yh_action_swizzviewDidAppear:animated];
    [self yh_action_performAction:^(DZViewControllerLifeCircleBaseAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewDidAppear:)]) {
            [action hostController:self viewDidAppear:animated];
        }
    }];
}

@end

@interface UIViewControllerActionSetup : NSObject

@end

@implementation UIViewControllerActionSetup

+ (void) load
{
    Class viewControllerClass = [UIViewController class];
    __DZViewControllerLifeCircleSwizzInstance(viewControllerClass,@selector(viewDidAppear:),@selector(yh_action_swizzviewDidAppear:));
    __DZViewControllerLifeCircleSwizzInstance(viewControllerClass, @selector(viewDidDisappear:), @selector(yh_action_swizzViewDidDisappear:));
    __DZViewControllerLifeCircleSwizzInstance(viewControllerClass, @selector(viewWillAppear:), @selector(yh_action_swizzviewWillAppear:));
    __DZViewControllerLifeCircleSwizzInstance(viewControllerClass, @selector(viewWillDisappear:), @selector(yh_action_swizzViewWillDisappear:));
}

@end
