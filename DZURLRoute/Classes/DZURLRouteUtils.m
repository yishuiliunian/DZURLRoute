//
//  DZURLRouteUtils.m
//  Pods
//
//  Created by baidu on 2016/11/2.
//
//

#import "DZURLRouteUtils.h"
#import <NSString-UrlEncode/NSString+URLEncode.h>
NSDictionary* DZURLRouteDecodeURLQueryParamters(NSString* url) {
    NSArray* coms = [url componentsSeparatedByString:@"&"];
    if (coms.count == 0) {
        return nil;
    }
    
    NSMutableDictionary* paramters = [NSMutableDictionary new];
    for (NSString* s  in coms) {
        NSRange indexOfEqual = [s rangeOfString:@"="];
        if (indexOfEqual.location == NSNotFound) {
            [paramters setValue:@"" forKey:[s URLDecode]];
        } else {
            NSString* key = [s substringToIndex:indexOfEqual.location];
            NSString* value = nil;
            if (s.length > indexOfEqual.location + indexOfEqual.length) {
                value = [s substringFromIndex:indexOfEqual.location + indexOfEqual.length];
            } else {
                value = @"";
            }
            paramters[[key URLDecode]] = [value URLDecode];
        }
    }
    return paramters;
}

NSString* DZURLRouteEncodeURLQueryParamters(NSDictionary* paramters)
{
    NSMutableDictionary* infos = [NSMutableDictionary dictionaryWithDictionary:paramters];
    NSArray* allKeys = infos.allKeys;
    NSMutableString* path = [NSMutableString new];
    for (int i = 0; i < allKeys.count; i++) {
        if (i > 0) {
            [path appendString:@"&"];
        }
        NSString* key = [NSString stringWithFormat:@"%@", allKeys[i]];
        NSString* value = [NSString stringWithFormat:@"%@", infos[key]];
        NSString* segement = [NSString stringWithFormat:@"%@=%@", [key URLEncode], [value URLEncode]];
        [path appendString:segement];
    }
    return [path copy];
}


NSString* DZURLRouteJoinParamterString(NSString* url, NSString* query) {
    NSMutableString* str = [NSMutableString stringWithString:url];
    if (![str hasSuffix:@"?"]) {
        [str appendString:@"?"];
    }
    
    if ([query hasPrefix:@"?"]) {
        query = [query substringFromIndex:1];
    }
    [str appendString:query];
    return [str copy];
}

NSURL* DZURLRouteQueryLink(NSString* baseURL, NSDictionary* query)
{
    NSString* queryString = DZURLRouteEncodeURLQueryParamters(query);
    NSString* url = DZURLRouteJoinParamterString(baseURL, queryString);
    return [NSURL URLWithString:url];
}
