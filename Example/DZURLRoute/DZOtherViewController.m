//
//  DZOtherViewController.m
//  DZURLRoute
//
//  Created by baidu on 2016/11/7.
//  Copyright © 2016年 yishuiliunian. All rights reserved.
//

#import "DZOtherViewController.h"
#import "DZRoutePatternDefines.h"
@interface DZOtherViewController ()

@end

@implementation DZOtherViewController
+ (void) load
{
    [[DZURLRoute defaultRoute] addRoutePattern:kDZRoutePatternExmapleOtherController handler:^DZURLRouteResponse*(DZURLRouteRequest *request) {
    
        DZOtherViewController* otherVC = [DZOtherViewController new];
        [request.context.topNavigationController pushViewController:otherVC animated:YES];
        return [DZURLRouteResponse successResponseWithMainResouce:otherVC];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showFirstViewController:(id)sender {
    NSMutableDictionary* paramters = [NSMutableDictionary new];
    paramters[@"from"] = @"otherViewController";
    NSURL* url = DZURLRouteQueryLink(kDZRoutePatternExampleViewController, paramters);
    [[DZURLRoute defaultRoute] routeURL:url];
}

- (IBAction)send404Test:(id)sender {
    [[DZURLRoute defaultRoute] routeURL:[NSURL URLWithString:@"xhjshdjkf:Lsdhjehjkh"]];
}

- (IBAction)popToPreviousViewController:(id)sender
{
    [self.navigationController popToPage:DZURLRouteQueryLink(kDZRoutePatternExampleViewController, @{})];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
