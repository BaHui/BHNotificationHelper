//
//  BHSecondViewController.m
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/19.
//  Copyright © 2018年 QiaoBaHui. All rights reserved.
//

#import "BHSecondViewController.h"
#import "BHThirdViewController.h"

@interface BHSecondViewController ()

@end

static NSString *const DEMO_VIEWS_STORYBOARD_NAME = @"DemoViews";

@implementation BHSecondViewController

+ (instancetype)create {
  UIStoryboard *demoViewsStoryboard = [UIStoryboard storyboardWithName:DEMO_VIEWS_STORYBOARD_NAME bundle:nil];
  return [demoViewsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)dealloc {
  NSLog(@"BHSecondViewController dealloc !");
}

#pragma mark - IBAction Methods

- (IBAction)nextButtonClicked:(id)sender {
  BHThirdViewController *thirdViewController = [BHThirdViewController create];
  [self.navigationController pushViewController:thirdViewController animated:YES];
}

@end
