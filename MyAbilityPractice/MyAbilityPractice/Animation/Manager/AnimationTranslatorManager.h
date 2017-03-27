//
//  AnimationTranslatorManager.h
//  MyAbilityPractice
//
//  Created by yindongbo on 17/3/27.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AnimationTranslatorManager : NSObject<
UIViewControllerAnimatedTransitioning,
CAAnimationDelegate
>

typedef enum : NSInteger {
    AnimationTranslatorTypePresent,
    AnimationTranslatorTypeDismiss
}AnimationTranslatorType;


+ (instancetype)transitionWithTransitionType:(AnimationTranslatorType) type;
@end
