//
//  AppDelegate.m
//  RXGuideManagerExample
//
//  Created by Rush.D.Xzj on 15/11/20.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "AppDelegate.h"
#import "RXGuideManagerHeader.h"
#import "MainViewController.h"


@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *mainNC;

@end

@implementation AppDelegate
- (void)showMain
{
    UIViewController *vc = [[MainViewController alloc] init];
    self.mainNC = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = self.mainNC;
}
- (void)showGuide
{
    UIViewController *vc = [[RXGuideViewController alloc] init];
    self.window.rootViewController = vc;
}

#pragma mark - Notification
- (void)nkey_RXManager_CloseStartGuide:(id)sender
{
    [self showMain];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(nkey_RXManager_CloseStartGuide:) name:NKey_RXManager_CloseStartGuide object:nil];
    NSDictionary *dic = @{kRXGuideManager_5_5s_key:@[@"info5_1", @"info5_2", @"info5_3"]};
//    [RXGuideManager sharedInstance].dicGuide = dic;
    
    NSArray *(^viewArray)(void) = ^{
        NSMutableArray *viewAry = [NSMutableArray array];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        NSArray *colorAry = @[[UIColor redColor], [UIColor redColor], [UIColor redColor]];
        for (NSInteger i = 0; i < colorAry.count; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            lbl.backgroundColor = colorAry[i];
            lbl.text = [NSString stringWithFormat:@"这是第%zd页", i + 1];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.font = [UIFont systemFontOfSize:40];
            lbl.numberOfLines = 0;
            [view addSubview:lbl];
            if (i == colorAry.count - 1) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(20, height - 50 - 30, width - 20 * 2, 50);
                [btn setTitle:@"立即体验" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [view addSubview:btn];
            }
            [viewAry addObject:view];
        }
        return viewAry;

    };
    
    [RXGuideManager sharedInstance].viewArray = viewArray;
    [RXGuideManager sharedInstance].pageIndicatorTintColor = [UIColor orangeColor];
    [RXGuideManager sharedInstance].currentPageIndicatorTintColor = [UIColor blackColor];
    BOOL showGuide = [RXGuideManager firstStartGuideValue];
#if DEBUG
        showGuide = NO;
#endif
    if (showGuide) {
        [self showMain];
    } else {
        [self showGuide];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
