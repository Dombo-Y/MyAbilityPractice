//
//  NaviTranstionManager.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/1.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "NaviTranstionManager.h"
#import "TransformAnimationAViewController.h"
#import "TransformAnimationBViewController.h"
@implementation NaviTranstionManager {
    NaviTranstionManagerType _type;
}

+ (instancetype)transitionWithType:(NaviTranstionManagerType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(NaviTranstionManagerType)type {
    self = [super init];
    if (!self) return nil;
    _type = type;
    return self;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case NaviTranstionManagerPush:
            [self doPushAnimation:transitionContext];
            break;
        case NaviTranstionManagerPop:
            [self doPopAnimation:transitionContext];
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    TransformAnimationAViewController *fromVC = (TransformAnimationAViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransformAnimationBViewController *toVC = (TransformAnimationBViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
    
    fromVC.imageView.hidden = YES;
    toVC.imageView.alpha = 0;
    toVC.imageView.hidden =YES;
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:0 animations:^{
        tempView.center = toVC.view.center;//[toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    TransformAnimationBViewController *fromVC = (TransformAnimationBViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransformAnimationAViewController *toVC = (TransformAnimationAViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    
    toVC.imageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
        fromVC.imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else {
            fromVC.imageView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}
@end
