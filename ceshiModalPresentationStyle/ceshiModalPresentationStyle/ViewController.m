//
//  ViewController.m
//  ceshiModalPresentationStyle
//
//  Created by 高崇 on 2017/8/23.
//  Copyright © 2017年 LieLvWang. All rights reserved.
//

#import "ViewController.h"
#import "GCViewController.h"
#import "GCTransitionManager.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) GCTransitionManager *transitionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.transitionManager = [[GCTransitionManager alloc] init];
    NSLog(@"ViewController:%@", self);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    GCViewController *vc = [GCViewController new];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.transitionManager;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate


@end
