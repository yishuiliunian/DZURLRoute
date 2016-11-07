//
//  DZURLRouteUtils.h
//  Pods
//
//  Created by yishuiliunian on 2016/11/2.
//
//

#import <Foundation/Foundation.h>

 /**
  Utils of DZURLRoute.
  the key and value must be kind of NSString, if not then the func will transform it to NSString
  @param paramters an dictionary contains all keys and values
  @return an query string
  */
FOUNDATION_EXTERN NSString* DZURLRouteEncodeURLQueryParamters(NSDictionary* paramters);


/**
 decode the query sting to dictionary. the key and value will be urlencoded.

 @param url the origin url that contains the query string
 @return a dictionary contains all keys and values form url.
 */
FOUNDATION_EXTERN NSDictionary* DZURLRouteDecodeURLQueryParamters(NSString* url);


/**
 join an baseurl and query string. 
 if baseurl is http://xxxx and query string is x=2&d=3, then return http://xxxx?x=2&d=3

 @param url baseurl
 @param query query string
 @return a string that contains baseurl and query string
 */
FOUNDATION_EXTERN NSString* DZURLRouteJoinParamterString(NSString* url, NSString* query);


/**
 it is a convinece method about DZURLRouteEncodeURLQueryParamters and DZURLRouteJoinParamterString.
 it will call DZURLRouteEncodeURLQueryParamters and DZURLRouteJoinParamterString.

 @param baseURL baseurl
 @param query the dictionary contains all keys and values
 @return a url contains baseurl and query string
 */
FOUNDATION_EXTERN NSURL* DZURLRouteQueryLink(NSString* baseURL, NSDictionary* query);
