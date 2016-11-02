//
//  DZURLRouteUtils.h
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import <Foundation/Foundation.h>

// the key and value must be kind of NSString, or the func will transform it to NSString
FOUNDATION_EXTERN NSString* DZURLRouteEncodeURLQueryParamters(NSDictionary* paramters);
FOUNDATION_EXTERN NSDictionary* DZURLRouteDecodeURLQueryParamters(NSString* url);
FOUNDATION_EXTERN NSString* DZURLRouteJoinParamterString(NSString* url, NSString* query);
