//
//  DZURLDelayCommand.h
//  Pods
//
//  Created by baidu on 2017/2/8.
//
//

#import <Foundation/Foundation.h>

@class DZRouteRequestContext;
@interface DZURLDelayCommand : NSObject
@property (nonatomic, strong, readonly) DZRouteRequestContext* context;
@property (nonatomic, strong, readonly) NSURL * url;

- (instancetype) initWithURL:(NSURL*)url context:(DZRouteRequestContext*)context;
@end
