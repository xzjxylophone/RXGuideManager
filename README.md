# RXGuideManager

```objective-c

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
    [RXGuideManager sharedInstance].dicGuide = dic;
    [RXGuideManager sharedInstance].pageIndicatorTintColor = [UIColor redColor];
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
```


