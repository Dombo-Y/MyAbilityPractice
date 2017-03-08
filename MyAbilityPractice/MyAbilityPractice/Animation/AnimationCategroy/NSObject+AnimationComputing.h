//
//  NSObject+AnimationComputing.h
//  MyAbilityPractice
//
//  Created by 尹东博 on 17/3/8.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (AnimationComputing)

- (CGFloat)centerDistanceWithBigCenter:(CGPoint)bigCenter smallCenter:(CGPoint)smallCenter;

// 描述形变路径
- (UIBezierPath *)pathWithBigCenter:(CGPoint)bigCenter bigRadius:(CGFloat)bigRadius smallCenter:(CGPoint)smallCenter smallRadius:(CGFloat)smallRadius;
@end
