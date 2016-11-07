//
//  DZViewController.m
//  DZURLRoute
//
//  Created by yishuiliunian on 11/02/2016.
//  Copyright (c) 2016 yishuiliunian. All rights reserved.
//

#import "DZViewController.h"
#import "DZRoutePatternDefines.h"
@interface DZViewController ()

@end

@implementation DZViewController

+ (void) load
{
    [[DZURLRoute defaultRoute] addRoutePattern:kDZRoutePatternExampleViewController handler:^BOOL(DZURLRouteRequest *request) {
        
        NSLog(@"paramters is %@",request.paramters);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DZViewController *firstViewController = [storyboard instantiateViewControllerWithIdentifier:@"DZViewController"];
        [request.topNavigationController pushViewController:firstViewController animated:YES];
        return YES;
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


- (IBAction)showOtherController:(id)sender
{
    [[DZURLRoute defaultRoute] routeURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",kDZRoutePatternExmapleOtherController]]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
