//
//  AnimationTransformViewController.m
//  MyAbilityPractice
//
//  Created by yindongbo on 17/3/27.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "AnimationTransformViewController.h"
#import "AnimationTranslatorManager.h"
@interface AnimationTransformViewController ()<
UIViewControllerTransitioningDelegate
>

@end

@implementation AnimationTransformViewController

- (instancetype)init {
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [AnimationTranslatorManager transitionWithTransitionType:AnimationTranslatorTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [AnimationTranslatorManager transitionWithTransitionType:AnimationTranslatorTypeDismiss];
}

// MARK: 自定义Presentation 交互 默认return nil
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    
//}

// MARK: 自定义 dimissal 交互 默认return nil
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
//    
//}
@end
