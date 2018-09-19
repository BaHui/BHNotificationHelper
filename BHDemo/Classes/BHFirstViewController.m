//
//  BHFirstViewController.m
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/19.
//  Copyright © 2018年 QiaoBaHui. All rights reserved.
//

#import "BHFirstViewController.h"
#import "BHSecondViewController.h"

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

- (void)dealloc {
  NSLog(@"BHFirstViewController dealloc !");
}

#pragma mark - IBAction Methods

- (IBAction)nextButtonClicked:(id)sender {
  BHSecondViewController *secondViewController = [BHSecondViewController create];
  [self.navigationController pushViewController:secondViewController animated:YES];
}

@end
