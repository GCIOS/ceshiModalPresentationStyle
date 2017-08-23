//
//  GCTransitionManager.m
//  GCBroswerController
//
//  Created by 高崇 on 17/2/10.
//  Copyright © 2017年 LieLvWang. All rights reserved.
//

#import "GCTransitionManager.h"

@interface GCTransitionManager ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresent;
@property (nonatomic, strong) UIButton *converBtn;

@end

@implementation GCTransitionManager

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
    return 1.25;
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
    
    self.converBtn = [[UIButton alloc] initWithFrame:containerView.bounds];
    self.converBtn.backgroundColor = [UIColor blackColor];
    self.converBtn.alpha = 0.0;
    [containerView addSubview:self.converBtn];
    
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = containerView.bounds;
    toView.transform = CGAffineTransformMakeTranslation(0, containerView.bounds.size.height);
    [containerView addSubview:toView];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformMakeTranslation(0, 0);
        self.converBtn.alpha = 0.3;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
      
    }];
    
}

/**
 *  实现dimiss动画
 */
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromView.transform = CGAffineTransformMakeTranslation(0, containerView.bounds.size.height);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [self.converBtn removeFromSuperview];
        self.converBtn = nil;
    }];
    
}
#pragma mark - lazy


@end
