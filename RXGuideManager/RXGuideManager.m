//
//  RXGuideManager.m
//  RXGuideManagerExample
//
//  Created by Rush.D.Xzj on 15/11/20.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXGuideManager.h"


const NSString *kRXGuideManager_4_4s_key = @"kRXGuideManager_4_4s_key";
const NSString *kRXGuideManager_5_5s_key = @"kRXGuideManager_5_5s_key";
const NSString *kRXGuideManager_6_6s_key = @"kRXGuideManager_6_6s_key";
const NSString *kRXGuideManager_6p_6sp_key = @"kRXGuideManager_6p_6sp_key";


@implementation RXGuideManager



+ (NSString *)guideKey
{
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    NSString *result1 = plistDic[@"CFBundleShortVersionString"];
    NSString *result2 = plistDic[@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@%@", result1, result2];
}


+ (BOOL)firstStartGuideValue
{
    NSString *key = [self guideKey];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    id value = [ud objectForKey:key];
    if (value == nil) {
        return NO;
    } else {
        return [value boolValue];
    }
}
+ (void)setFirstStartGuideValue:(BOOL)value
{
    NSString *key = [self guideKey];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@(value) forKey:key];
    [ud synchronize];
}





#pragma mark - Constructor And Destructor
- (id)init
{
    if (self = [super init]) {
        self.pageIndicatorTintColor = [UIColor whiteColor];
        self.currentPageIndicatorTintColor = [UIColor grayColor];
        self.e_RX_ImageType = kE_RX_ImageType_Png;
    }
    return self;
}
- (void)dealloc
{
    
}

#pragma mark - Singleton Model

+ (RXGuideManager *)sharedInstance
{
    static RXGuideManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


@end
