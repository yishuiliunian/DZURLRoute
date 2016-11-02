//
//  DZURLRouteRecord.h
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import <Foundation/Foundation.h>

@class DZURLRouteRequest;
typedef BOOL (^DZURLRoutePatternHandler)(DZURLRouteRequest* request);
@interface DZURLRouteRecord : NSObject
@property (nonatomic, strong, readonly) NSString* partern;
@property (nonatomic, strong, readonly) DZURLRoutePatternHandler handler;
- (instancetype) initWithPartern:(NSString*)partern handler:(DZURLRoutePatternHandler)handler;
- (BOOL) canHandlerRequestURL:(NSString *)url;
@end
