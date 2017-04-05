//
//  TransformAnimationCViewController.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/5.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "TransformAnimationCViewController.h"
#import "NaviTranstionManager.h"
#import "InteractiveTransition.h"
@interface TransformAnimationCViewController ()

@property (nonatomic, strong) InteractiveTransition *interativeTransition;
@end

@implementation TransformAnimationCViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.interativeTransition = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypeDismiss gestureDirection:InteractiveTransitionGestureDirectionDown];
    [self.interativeTransition addPanGestureForViewController:self];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 50)];
    label.text = @"试试向下拖动";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [NaviTranstionManager transitionWithType:NaviTranstionManagerPersent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [NaviTranstionManager transitionWithType:NaviTranstionManagerDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interativeTransition.interation ? _interativeTransition: nil;
}
@end
