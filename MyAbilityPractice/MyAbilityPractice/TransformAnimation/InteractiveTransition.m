//
//  InteractiveTransition.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/5.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "InteractiveTransition.h"

@interface InteractiveTransition()

@property (nonatomic, strong) UIViewController *vc;
@end

@implementation InteractiveTransition {
    InteractiveTransitionType _type;
    InteractiveTransitionGestureDirection _direction;
}

+ (instancetype)interactiveTransitionWithTransitionType:(InteractiveTransitionType)type gestureDirection:(InteractiveTransitionGestureDirection)direction {
    return [[self alloc] initWithTransitionType:type gestureDirection:direction];
}

- (instancetype)initWithTransitionType:(InteractiveTransitionType)type gestureDirection:(InteractiveTransitionGestureDirection)direction {
    if (self = [super init]) {
        _type = type;
        _direction = direction;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture {
    CGFloat persent = 0;
    switch (_direction) {
        case InteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        default:
            break;
    }
     NSLog(@"persent == %lf", persent);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:persent];
            break;
        case UIGestureRecognizerStateEnded:
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else {
                [self cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

- (void)startGesture {
    switch (_type) {
        case InteractiveTransitionTypePresent: {
            if (_presentGestureConfig) {
                _presentGestureConfig();
            }
        }
            break;
        case InteractiveTransitionTypeDismiss: {
            [self.vc dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        case InteractiveTransitionTypePush: {
            if (_pushGestureConfig) {
                _pushGestureConfig();
            }
        }
            break;
        case InteractiveTransitionTypePop: {
            [self.vc.navigationController popViewControllerAnimated:YES];
        }
            break;
    }
}
@end
