//
//  TransformAnimationBViewController.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/1.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "TransformAnimationBViewController.h"
#import "NaviTranstionManager.h"
#import "TransformAnimationCViewController.h"
#import "InteractiveTransition.h"
@interface TransformAnimationBViewController ()

@property (nonatomic, strong) InteractiveTransition *interativeTransition;
@end

@implementation TransformAnimationBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7472Image.PNG"]];
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
    
    UIButton *persentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:persentBtn];
    persentBtn.frame = CGRectMake(0, self.view.frame.size.height - 50, 200, 50);
    persentBtn.layer.borderWidth = 1;
    [persentBtn setTitle:@"点我试试" forState:UIControlStateNormal];
    [persentBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    self.interativeTransition = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypePop gestureDirection:InteractiveTransitionGestureDirectionRight];
    [self.interativeTransition addPanGestureForViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - click
- (void)click {
    TransformAnimationCViewController *TAC = [[TransformAnimationCViewController alloc] init];
    [self presentViewController:TAC animated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    return [NaviTranstionManager transitionWithType:operation == UINavigationControllerOperationPush?NaviTranstionManagerPush:NaviTranstionManagerPop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interativeTransition.interation ? _interativeTransition : nil;
}
@end
