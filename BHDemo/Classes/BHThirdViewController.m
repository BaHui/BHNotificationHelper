//
//  BHThirdViewController.m
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/19.
//  Copyright © 2018年 QiaoBaHui. All rights reserved.
//

#import "BHThirdViewController.h"
#import "BHNotificationHelper.h"

@interface BHThirdViewController ()

@end

static NSString *const DEMO_VIEWS_STORYBOARD_NAME = @"DemoViews";

@implementation BHThirdViewController

+ (instancetype)create {
  UIStoryboard *demoViewsStoryboard = [UIStoryboard storyboardWithName:DEMO_VIEWS_STORYBOARD_NAME bundle:nil];
  return [demoViewsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)dealloc {
  NSLog(@"BHThirdViewController dealloc!");
}

#pragma mark - IBAction Methods

- (IBAction)postFistViewNotifyButtonClicked:(id)sender {
  [self postNotificationForName:BHChangeFirstTitleNFName userInfo:@{@"title" : @"changed form third view notify!"}];
}

- (IBAction)postSecondNotifyViewButtonClicked:(id)sender {
  [self postNotificationForName:BHChangeSecondBGColorNFName userInfo:@{@"color" : [UIColor blueColor]}];
}

@end
