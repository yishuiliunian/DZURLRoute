//
//  DZRouteResponseContext.h
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import "DZURLContext.h"

@interface DZRouteResponseContext : DZURLContext

/**
 the main resouce that hanlde the request
 */
@property (nonatomic, strong) NSObject* mainResource;
@end
