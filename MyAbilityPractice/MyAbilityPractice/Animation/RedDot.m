//
//  RedDot.m
//  MyAbilityPractice
//
//  Created by 尹东博 on 17/3/8.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "RedDot.h"
#import "NSObject+AnimationComputing.h"

@interface RedDot()
@property (nonatomic, assign) CGFloat circleR2;//!< 圆点2的半径
@property (nonatomic, assign) CGFloat circleR1;// 圆点1的半径
@property (nonatomic, strong) UIView *smallCircleView;// 小圆View
@property (nonatomic, strong) CAShapeLayer *shapeLayer; // 连接层
@property (nonatomic, assign) CGPoint oriCenter; // 原圆中心坐标
@property (nonatomic, assign) BOOL isOverBorder; // 是否超过边界
@property (nonatomic, assign) CGFloat oriSmallRadius; // 原小圆半径
@end


#define maxDistance 200

#define gooRatio 0.9 // 粘性比例 0.9
@implementation RedDot

- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        CAShapeLayer *shapeL = [CAShapeLayer layer];
        shapeL.fillColor = [UIColor redColor].CGColor;
        _shapeLayer = shapeL;
    }
    return _shapeLayer;
}

- (void)layoutSubviews {
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor redColor];
        self.layer.cornerRadius = self.frame.size.width / 2;
        
    }
    return self;
}


- (UIView *)smallCircleView {
    if (_smallCircleView == nil)
    {
        UIView *smallCircleView = [[UIView alloc] init];
        _smallCircleView = smallCircleView;
        _smallCircleView.layer.cornerRadius = _circleR1;
        _smallCircleView.hidden = YES;
        _smallCircleView.backgroundColor = [UIColor redColor];
        
        [self.superview insertSubview:smallCircleView atIndex:0];
    }
    return _smallCircleView;
}



- (void)setUp {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]; // 添加pan手势
    [self addGestureRecognizer:pan];
    
    _circleR1 = self.bounds.size.width * 0.5;
    _circleR2 = _circleR1;
    _oriCenter = self.center;
    self.smallCircleView.center = self.center;
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        CGFloat d = [self centerDistanceWithBigCenter:self.center smallCenter:self.smallCircleView.center];// 获取圆心距离
        
        // 判断是否超出最大圆心距离
        if (d > maxDistance)
        {
            [self setUpBoom];
        }
        else
        {
            [self setUpRestore];
        }
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint transP = [pan translationInView:self];// 获取手指偏移量
        
        CGPoint center = self.center;// 并不会修改中心点
        
        center.x += transP.x;
        center.y += transP.y;
        
        self.center = center;// 设置大圆中心
        
        
        CGFloat d = [self centerDistanceWithBigCenter:self.center smallCenter:self.smallCircleView.center];// 获取圆心距离
        
        CGFloat smallRadius = _circleR2 - d / 10; // 计算小圆半径：随机搞个比例，随着圆心距离增加，圆心半径不断减少。
        
        self.smallCircleView.bounds = CGRectMake(0, 0, smallRadius * 2, smallRadius * 2);
        self.smallCircleView.layer.cornerRadius = smallRadius;
        
        // 超过最大圆心距离,不需要描述形变矩形
        if (d > maxDistance )
        {
            _isOverBorder = YES; // 超过边界
            self.smallCircleView.hidden = YES;// 隐藏小圆
            [self.shapeLayer removeFromSuperlayer];// 没有弹性效果
        }
        else if(d > 0 && _isOverBorder == NO)
        {
            self.smallCircleView.hidden = NO;// 否则设置小圆圆心，并且描述形变矩形
            
            self.shapeLayer.path = [self pathWithBigCenter:self.center bigRadius:_circleR2 smallCenter:self.smallCircleView.center smallRadius:smallRadius].CGPath;
            
            [self.superview.layer insertSublayer:self.shapeLayer below:_smallCircleView.layer];
        }
        [pan setTranslation:CGPointZero inView:self];
    }
}


// 还原
- (void)setUpRestore {
    [self.shapeLayer removeFromSuperlayer];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.center = _oriCenter;
    } completion:^(BOOL finished)
     {
        _isOverBorder = NO;
        self.smallCircleView.hidden = NO;
    }];
}


// 爆炸效果
- (void)setUpBoom {
    // 变成气泡消失
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, _circleR2 * 2, _circleR2 * 2);
    
        [self addSubview:imageView];
    
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 1; i < 9; i++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [arr addObject:image];
        }
    
        imageView.animationImages = arr;
    
        imageView.animationDuration = 1.2;
        imageView.animationRepeatCount = 1;
        [imageView startAnimating];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
        [self removeFromSuperview];
    });
}
@end
