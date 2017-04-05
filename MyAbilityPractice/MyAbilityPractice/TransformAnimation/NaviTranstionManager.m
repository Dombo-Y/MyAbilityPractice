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
            [self pushAnimation:transitionContext];
            break;
        case NaviTranstionManagerPop:
            [self popAnimation:transitionContext];
            break;
            
        case NaviTranstionManagerPersent:
            [self presentAnimation:transitionContext];
            break;
        case NaviTranstionManagerDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
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
        tempView.center = toVC.view.center;
        toVC.imageView.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    TransformAnimationBViewController *fromVC = (TransformAnimationBViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransformAnimationAViewController *toVC = (TransformAnimationAViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    toVC.imageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect rect2 = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        tempView.frame = rect2;
        fromVC.imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else {
            toVC.imageView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
 
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view]; // containerView.subviews 中有两个view：tempView 和 toVC.view
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否则认为你一直还在，会出现无法交互的情况，切记
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
   
    UIView *containerView = [transitionContext containerView];
    NSArray *subviewsArray = containerView.subviews;
    UIView *tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
   
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
        tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];  //失败了接标记失败
        }else{
            [transitionContext completeTransition:YES];//如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

@end
