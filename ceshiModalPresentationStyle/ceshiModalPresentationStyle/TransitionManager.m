//
//  TransitionManager.m
//  GCBroswerController
//
//  Created by 高崇 on 17/2/10.
//  Copyright © 2017年 LieLvWang. All rights reserved.
//

#import "TransitionManager.h"

@interface TransitionManager ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresent;

@end

@implementation TransitionManager

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresent = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    _isPresent = NO;
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
    if (_isPresent) {
        
        [self presentAnimation:transitionContext];
    }else{
        
        [self dismissAnimation:transitionContext];
    }
}

/**
 *  实现present动画
 */
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    NSLog(@"startAnimation! fromView = %@", fromView);
    NSLog(@"startAnimation! toView = %@", toView);
    for(UIView * view in containerView.subviews){
        NSLog(@"startAnimation! list : %@", view);
    }
    
    [containerView addSubview:toView];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        for(UIView * view in containerView.subviews){
            NSLog(@"endAnimation! list container subviews: %@", view);
        }
    }];
    
}

/**
 *  实现dimiss动画
 */
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIView * containerView = [transitionContext containerView];
    
    for(UIView * view in containerView.subviews){
        NSLog(@"实现dimiss动画 startAnimation! list : %@", view);
    }
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        for(UIView * view in containerView.subviews){
            NSLog(@"实现dimiss动画 endAnimation! list : %@", view);
        }
    }];
    
}


@end
