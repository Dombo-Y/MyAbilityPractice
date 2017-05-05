//
//  DonutHUBView.h
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/25.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DonutHUBView : UIView


@property(nonatomic,strong)UIColor *trackColor;
@property(nonatomic,strong)UIColor *progressColor;
@property(nonatomic)float progress;//0~1之间的数
@property(nonatomic)float progressWidth;

-(void)setProgress:(float)progress animated:(BOOL)animated;

- (void)start;

- (void)stop;
@end
