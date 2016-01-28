//
//  RXGuideViewController.m
//  KC
//
//  Created by Rush.D.Xzj on 15/9/1.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXGuideViewController.h"
#import "RXGuideManager.h"


@interface RXGuideViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UITapGestureRecognizer *tgr;
@end

@implementation RXGuideViewController
#pragma mark - Action
- (void)startGuideAction:(id)sender
{
    [RXGuideManager setFirstStartGuideValue:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NKey_RXManager_CloseStartGuide object:nil];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2)/pageWidth)+1;
    self.pageControl.currentPage = page;
}

#pragma mark - Private
- (NSArray *)viewAry
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSMutableArray *viewAry = [NSMutableArray array];
    NSArray *imgAry = nil;
    NSDictionary *dic = [RXGuideManager sharedInstance].dicGuide;
    NSArray *ary4 = dic[kRXGuideManager_4_4s_key];
    NSArray *ary5 = dic[kRXGuideManager_5_5s_key];
    NSArray *ary6 = dic[kRXGuideManager_6_6s_key];
    NSArray *ary6p = dic[kRXGuideManager_6p_6sp_key];
    if (height == 480) { // iPhone4/4s
        imgAry = ary4;
    } else if (height == 568) { // iPhone5/5s
        imgAry = ary5;
    } else if (height == 667) { // iPhone6/6s
        imgAry = ary6;
        
    } else if (height == 736) { // iPhone6p/6ps
        imgAry = ary6p;
    } else {
        imgAry = ary5;
    }
    // 没有的就默认认为是5/5s的
    if (imgAry.count == 0) {
        imgAry = ary5;
    }
    
    BOOL isTest = (imgAry.count == 0);
    if (isTest) {
        // 是测试
        NSArray *colorAry = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
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
    } else {
        // 不是测试
        for (NSUInteger i = 0; i < imgAry.count; i++) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
            NSString *imageName = imgAry[i];
            UIImage *image = nil;
            switch ([RXGuideManager sharedInstance].e_RX_ImageType) {
                case kE_RX_ImageType_Png:
                    image = [UIImage imageNamed:imageName];
                    break;
                case kE_RX_ImageType_Jpg:
                default:
                {
                    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
                    image = [UIImage imageWithContentsOfFile:filePath];
                }
                    break;
            }
            iv.userInteractionEnabled = YES;
            iv.image = image;
            [viewAry addObject:iv];
        }
    }
    return viewAry;
}

#pragma mark - initialize UI And Data
- (void)initializeUIAndData
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.scrollView.delegate = self;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((width - 100) / 2.0, height - 30 - 15, 100, 30)];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    self.tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startGuideAction:)];
    
    
    NSArray *viewAry = [self viewAry];
    
    // 把view添加到scrollView中
    NSUInteger count = viewAry.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIView *view = viewAry[i];
        if (i == viewAry.count - 1) {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self.tgr];
        }
        [self.scrollView addSubview:view];
    }
    // scrollView
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    self.scrollView.delegate = self;
    // pageControl
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.numberOfPages = viewAry.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [RXGuideManager sharedInstance].pageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = [RXGuideManager sharedInstance].currentPageIndicatorTintColor;
}
- (void)initializeAction
{
}
#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeUIAndData];
    [self initializeAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
