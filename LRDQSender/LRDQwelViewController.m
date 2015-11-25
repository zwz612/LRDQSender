//
//  LRDQwelViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQwelViewController.h"
#import "LRDQLogonAndSignUpViewController.h"
#import "LRDQTableViewController.h"
#import "LRDQTBController.h"
#define kStartButtonCenterYRatio 470.f/667.f
#define kPageControlCenterYRatio 480.f/667.f
#define kscrollXRatio 300.f/375.f
#define kscrollYRatio 358.f/667.f
#define num 5
#import "AppDelegate.h"
@interface LRDQwelViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimage;
@property (weak,nonatomic) UIPageControl * pageControl;
@property (weak,nonatomic) UIScrollView * scrollView;
@end

@implementation LRDQwelViewController
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCoverBoard];
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    _pageControl = pageControl;
    pageControl.numberOfPages=num;
    pageControl.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kPageControlCenterYRatio);
    [self.view addSubview:pageControl];
    [pageControl setBackgroundColor:[UIColor blackColor]];
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    _scrollView = scrollView;
    scrollView.delegate = self;
    
    [_backgroundimage setImage:[UIImage imageNamed:@"33"]];
    _backgroundimage.frame=[UIScreen mainScreen].bounds;
    scrollView.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5-70.f);
    scrollView.bounds=CGRectMake(0, 0,(([UIScreen mainScreen].bounds.size.width)*kscrollXRatio) ,(kscrollYRatio*[UIScreen mainScreen].bounds.size.height));
    scrollView.layer.cornerRadius = 25.f;
    [self.view addSubview:scrollView];
    [self.view bringSubviewToFront:scrollView];
    [self.view bringSubviewToFront:pageControl];
    [self setUpScrollView];
    
    
}
-(void)addCoverBoard{
    UIView*CoverBoard=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:CoverBoard];
    CoverBoard.alpha=0.2;
    CoverBoard.backgroundColor=[UIColor whiteColor];
    
}

-(void)setUpScrollView
{
    for (int i = 0; i<num; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        NSString * imageName = [NSString stringWithFormat:@"%i0.jpg",i];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.bounds.size.width, _scrollView.frame.size.height);
        if (i==4) {
            
            [self addStartButton:imageView];
        }
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(5*_scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.bounces = NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger number = (int)_scrollView.contentOffset.x/(int)_scrollView.bounds.size.width;
    _pageControl.currentPage = number;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)addStartButton:(UIImageView * )imageView{
    imageView.userInteractionEnabled = YES;
    UIButton * startButton = [[UIButton alloc]init];
  
    startButton.bounds = CGRectMake(0, 0, 44.f, 44.f);
    startButton.center = CGPointMake(_scrollView.frame.size.width*6/7, _scrollView.frame.size.height*7/9);
    [startButton setBackgroundColor:[UIColor blueColor]];
    [startButton setTitle:@"GO" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startButton.layer.cornerRadius = startButton.frame.size.width*0.5;
    
    [imageView addSubview:startButton];
    [startButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)start:(UIButton * )sender{
    UIStoryboard*storyBoard=[UIStoryboard storyboardWithName:@"LRDQLogonAndSignUpStoryBoard" bundle:nil];
    LRDQLogonAndSignUpViewController*bothVC=[storyBoard instantiateViewControllerWithIdentifier:@"LogonAndSIgnUPID"];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:bothVC];
    [UIApplication sharedApplication].keyWindow.rootViewController=nav;
    
}



@end
