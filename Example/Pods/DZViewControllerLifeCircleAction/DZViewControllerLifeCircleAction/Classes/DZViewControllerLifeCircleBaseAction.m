//
//  DZViewControllerLifeCircleBaseAction.m
//  Pods
//
//  Created by baidu on 16/10/31.
//
//

#import "DZViewControllerLifeCircleBaseAction.h"

@interface DZViewControllerLifeCircleBaseAction ()
@property (nonatomic, strong) UIViewController* hostViewController;
@end

@implementation DZViewControllerLifeCircleBaseAction

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _identifier = [NSUUID UUID].UUIDString;
    return self;
}
- (BOOL) isEqual:(DZViewControllerLifeCircleBaseAction*)object
{
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[DZViewControllerLifeCircleBaseAction class]]) {
        return NO;
    }
    return [self.identifier isEqualToString:object.identifier];
}

- (void) hostController:(UIViewController *)vc viewWillAppear:(BOOL)animated
{
    _liveViewController = vc;
}
- (void) hostController:(UIViewController *)vc viewWillDisappear:(BOOL)animated
{
    
}
- (void) hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated
{

}
- (void) hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated
{
    _liveViewController = nil;
}
@end
