//
//  RingProcessView.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/25.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "RingProcessView.h"

@implementation RingProcessView {
    UIView *_outerView;
    UIView *_centerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        
        _outerView = [[UIView alloc] initWithFrame:self.bounds];
        _outerView.layer.cornerRadius = self.bounds.size.width/2;
        [self addSubview:_outerView];
        
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.cornerRadius = 30;
        _centerView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:_centerView];
    }
    return self;
}

- (void)longPress:(UIGestureRecognizer *)longPress {
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"开始");
            [UIView animateWithDuration:0.3 animations:^{
                _centerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
                _outerView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            }];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
            NSLog(@"取消");
            break;
            
        case UIGestureRecognizerStateEnded:{
            NSLog(@"结束");
            [UIView animateWithDuration:0.3 animations:^{
                _centerView.transform = CGAffineTransformMakeScale(1, 1);
                 _outerView.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }
            
            break;
        
        case UIGestureRecognizerStateChanged:
            NSLog(@"移动");
            break;
        
        default:
            break;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _outerView.backgroundColor = backgroundColor;
}
@end
