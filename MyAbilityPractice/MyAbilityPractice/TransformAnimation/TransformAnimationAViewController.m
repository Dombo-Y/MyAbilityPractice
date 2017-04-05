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
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7472Image.PNG"]];
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    [self.view addSubview:self.imageView];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = self.imageView.frame;
    [btn addTarget:self action:@selector(tapAciton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backToRoot {
    self.navigationController.delegate = nil; // 这里一定要移除
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapAciton {
    TransformAnimationBViewController *vc = [[TransformAnimationBViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
