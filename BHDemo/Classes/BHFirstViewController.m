//
//  BHFirstViewController.m
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/19.
//  Copyright © 2018年 QiaoBaHui. All rights reserved.
//

#import "BHFirstViewController.h"
#import "BHSecondViewController.h"
#import "BHNotificationHelper.h"

@interface BHFirstViewController ()

@end

static NSString *const DEMO_VIEWS_STORYBOARD_NAME = @"DemoViews";

@implementation BHFirstViewController

+ (instancetype)create {
  UIStoryboard *demoViewsStoryboard = [UIStoryboard storyboardWithName:DEMO_VIEWS_STORYBOARD_NAME bundle:nil];
  return [demoViewsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - IBAction Methods

- (IBAction)nextButtonClicked:(id)sender {
  BHSecondViewController *secondViewController = [BHSecondViewController create];
  [self.navigationController pushViewController:secondViewController animated:YES];
}

- (IBAction)addObserverButtonClicked:(id)sender {
  __weak typeof(self) weakSelf = self;

  [self addNotificationForName:BHChangeFirstTitleNFName response:^(NSDictionary *userInfo) {
    NSLog(@"First view title changed");

    NSString *title = [userInfo objectForKey:@"title"];
    weakSelf.navigationItem.title = title;
  }];

  [self addNotificationForName:BHChangeFirstBGColorNFName response:^(NSDictionary *userInfo) {
    NSLog(@"First view color changed");

    UIColor *color = [userInfo objectForKey:@"color"];
    weakSelf.view.backgroundColor = color;
  }];
}

- (IBAction)removeObserverButtonClicked:(id)sender {
  [self removeNotificationForName:BHChangeFirstTitleNFName];
}

@end
