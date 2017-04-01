//
//  TransformAnimationBViewController.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/1.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "TransformAnimationBViewController.h"
#import "NaviTranstionManager.h"
@interface TransformAnimationBViewController ()

@end

@implementation TransformAnimationBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7472Image"]];
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [NaviTranstionManager transitionWithType:operation == UINavigationControllerOperationPush?NaviTranstionManagerPush:NaviTranstionManagerPop];
}
@end
