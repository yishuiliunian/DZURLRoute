//
//  DZUIStackLifeCircleAction.h
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import <DZViewControllerLifeCircleAction/DZViewControllerLifeCircleAction.h>


@interface DZUIStackLifeCircleAction : DZViewControllerLifeCircleBaseAction
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;
@end


FOUNDATION_EXTERN DZUIStackLifeCircleAction* DZUIShareStackInstance();
