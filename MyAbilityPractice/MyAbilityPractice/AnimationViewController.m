//
//  AnimationViewController.m
//  MyAbilityPractice
//
//  Created by 尹东博 on 17/3/8.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "AnimationViewController.h"
#import "RedDot.h"
@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RedDot *redDot =[[RedDot alloc] initWithFrame:CGRectMake(50, 64, 50, 50)];
    [self.view addSubview:redDot];
    
    [redDot ]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
