//
//  RXGuideManager.h
//  RXGuideManagerExample
//
//  Created by Rush.D.Xzj on 15/11/20.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 关闭引导页的通知
#define NKey_RXManager_CloseStartGuide      @"NKey_RXManager_CloseStartGuide"

extern const NSString *kRXGuideManager_4_4s_key;
extern const NSString *kRXGuideManager_5_5s_key;
extern const NSString *kRXGuideManager_6_6s_key;
extern const NSString *kRXGuideManager_6p_6sp_key;

@interface RXGuideManager : NSObject



//
//
@property (nonatomic, strong) NSDictionary *dicGuide;


// default:whiteColor
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
// default:grayColor
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;


















+ (BOOL)firstStartGuideValue;
+ (void)setFirstStartGuideValue:(BOOL)value;



#pragma mark - Singleton Model
+ (RXGuideManager *)sharedInstance;

@end
