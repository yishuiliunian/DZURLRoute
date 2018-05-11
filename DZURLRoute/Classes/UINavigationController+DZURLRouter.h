//
//  UINavigationController+DZURLRouter
//  Pods
//
//  Created by Dong Zhao on 2017/4/19.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DZURLRouter)

/**
 if you push many pages in to navigation stack , and you want to pop to special page. you can use this method. just by the url of the page.

 @param pageURL the url of the special page.
 */
- (void) popToPage:(NSURL*)pageURL;
@end
