//
//  AnimationTranslatorManager.m
//  MyAbilityPractice
//
//  Created by yindongbo on 17/3/27.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "AnimationTranslatorManager.h"
#import "AnimationViewController.h"
@implementation AnimationTranslatorManager
{
    AnimationTranslatorType _type;
}

+ (instancetype)transitionWithTransitionType:(AnimationTranslatorType) type
{
    return [[self alloc] initTransitionWithTansitonType:type];
}

- (instancetype)initTransitionWithTansitonType:(AnimationTranslatorType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

/*
 A 跳转 B
 在跳转过程中 的动画展示在C = [transitionContext containerView] 中
 所以 图像层级 为A C B ，所以提前将B.view 加到C中，然后在B.view.layer制作动效
 */
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *formVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    AnimationViewController *animationVC = formVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    CGRect anchorRect = animationVC.redDot.frame;//CGRectMake(200, 200, 50, 50);
    anchorRect.origin.y = 64 + anchorRect.origin.y; // present 进来高度是从屏幕顶端计算，所以需要加上nav的高度64
    
    CGFloat x = MAX(anchorRect.origin.x, containerView.frame.size.width - anchorRect.origin.x);
    CGFloat y = MAX(anchorRect.origin.y, containerView.frame.size.height - anchorRect.origin.y);

    //    CGFloat radius = sqrt(pow(x, 2) + pow(y, 2));// sqrtf 平方根 // pow 求x的y次方（次幂）
    CGFloat radius = hypot(x, y); // 求直角三角形斜边的长度  用这个更屌  hypot(x, y) == sqrt(pow(x, 2) + pow(y, 2))
    
    UIBezierPath *startBezier = [UIBezierPath bezierPathWithOvalInRect:anchorRect];
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    toVC.view.layer.mask = maskLayer; // 这里将 自定义画面 给 toVC.view.layer.mask
    
//    创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    
//    动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startBezier.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC =(UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    AnimationViewController *animationVC = toVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    
    CGRect anchorRect = animationVC.redDot.frame;//CGRectMake(200, 200, 50, 50);
    anchorRect.origin.y = 64 + anchorRect.origin.y;
    
    CGFloat radius = sqrt(CGRectGetHeight(containerView.frame) * CGRectGetHeight(containerView.frame) + CGRectGetWidth(containerView.frame) * CGRectGetWidth(containerView.frame))/ 2;
    
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithOvalInRect:anchorRect];
    
    CAShapeLayer *maskLayer =[CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case AnimationTranslatorTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case AnimationTranslatorTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%s", __FUNCTION__);
    switch (_type) {
        case AnimationTranslatorTypePresent: {
            id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case AnimationTranslatorTypeDismiss: {
            id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
        default:
            break;
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"%s", __FUNCTION__);
}

@end
