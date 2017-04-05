//
//  NaviTranstionManager.h
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/1.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NaviTranstionManagerType) {
    NaviTranstionManagerPush,
    NaviTranstionManagerPop,
    NaviTranstionManagerPersent,
    NaviTranstionManagerDismiss
};

@interface NaviTranstionManager : NSObject<
UIViewControllerAnimatedTransitioning
>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(NaviTranstionManagerType)type;
- (instancetype)initWithTransitionType:(NaviTranstionManagerType)type;
@end
