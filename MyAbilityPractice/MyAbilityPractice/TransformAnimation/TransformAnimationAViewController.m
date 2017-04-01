//
//  TransformAnimationViewController.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/1.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "TransformAnimationAViewController.h"
#import "TransformAnimationBViewController.h"
@interface TransformAnimationAViewController ()<
UINavigationControllerDelegate
>
@end

@implementation TransformAnimationAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7472Image"]];
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    [self.view addSubview:self.imageView];
    

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = self.imageView.frame;
    [btn addTarget:self action:@selector(tapAciton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)tapAciton {
    TransformAnimationBViewController *vc = [[TransformAnimationBViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
