//
//  DZURLContext.h
//  Pods
//
//  Created by baidu on 2016/11/10.
//
//

#import <Foundation/Foundation.h>

@interface DZURLContext : NSObject
- (void) setWeakValue:(id)value forKey:(NSString*)key;

- (void) setBoolValue:(BOOL)value forKey:(NSString*)key;

- (BOOL) boolValueForKey:(NSString*)key;

- (void) setIntValue:(int)value forKey:(NSString*)key;

- (int) intValueForKey:(NSString*)key;
@end
