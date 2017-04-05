//
//  InteractiveTransition.h
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/5.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,InteractiveTransitionGestureDirection) {
    InteractiveTransitionGestureDirectionLeft,
    InteractiveTransitionGestureDirectionRight,
    InteractiveTransitionGestureDirectionUp,
    InteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSInteger, InteractiveTransitionType) {
    InteractiveTransitionTypePresent,
    InteractiveTransitionTypeDismiss,
    InteractiveTransitionTypePush,
    InteractiveTransitionTypePop
};

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interation;//!< 记录是否开始手势，判断pop操作是手势出发还是返回出发
@property (nonatomic, copy) void (^presentGestureConfig)();
@property (nonatomic, copy) void (^pushGestureConfig)();

+ (instancetype)interactiveTransitionWithTransitionType:(InteractiveTransitionType)type
                                       gestureDirection:(InteractiveTransitionGestureDirection)direction;

- (instancetype)initWithTransitionType:(InteractiveTransitionType)type
                      gestureDirection:(InteractiveTransitionGestureDirection)direction;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end
