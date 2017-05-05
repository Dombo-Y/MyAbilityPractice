//
//  DonutHUBView.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/25.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "DonutHUBView.h"

@interface DonutHUBView ()

@property (nonatomic, strong)CAShapeLayer *trackLayer;
@property (nonatomic, strong)CAShapeLayer *progressLayer;
@end


@implementation DonutHUBView {
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        self.progressWidth = 5;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

#pragma mark - Lazy Init
- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        CAShapeLayer *trackLayer = [CAShapeLayer new];
        trackLayer.fillColor = nil;
        trackLayer.frame = self.bounds;
        [self.layer addSublayer:trackLayer];
        _trackLayer = trackLayer;
    }
    return _trackLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        CAShapeLayer *progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:progressLayer];
        progressLayer.fillColor = nil;
        progressLayer.lineCap = kCALineCapRound;
        progressLayer.frame = self.bounds;
        _progressLayer = progressLayer;
    }
    return _progressLayer;
}

#pragma mark - Set Property
-(void)setTrackColor{
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50)
                                                             radius:(self.bounds.size.width - _progressWidth)/ 2
                                                         startAngle:0
                                                           endAngle:M_PI * 2
                                                          clockwise:YES];;
    _trackLayer.path = trackPath.CGPath;
}


-(void)setProgress{
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50)
                                                   radius:(self.bounds.size.width - _progressWidth)/2
                                               startAngle:-M_PI_2
                                                 endAngle:(M_PI * 2)*_progress - M_PI_2
                                                clockwise:YES];
    _progressLayer.path = progressPath.CGPath;
}

#pragma mark - Set
-(void)setProgressWidth:(float)progressWidth{
    _progressWidth = progressWidth;
    self.trackLayer.lineWidth = _progressWidth;
    self.progressLayer.lineWidth = _progressWidth;
    
    [self setTrackColor];
    [self setProgress];
}

- (void)setTrackColor:(UIColor *)trackColor{
    self.trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(float)progress {
    _progress = progress;
    [self setProgress];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
}


#pragma mark - ControlMethod
- (void)start {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(addprogress) userInfo:nil repeats:YES];
}

- (void)stop {
    [_timer invalidate];
    _timer = nil;
    [_progressLayer removeFromSuperlayer];
    [_trackLayer removeFromSuperlayer];
    _progressLayer = nil;
    _trackLayer = nil;
}

- (void)addprogress {
    self.trackColor = [UIColor blackColor];
    self.progressColor = [UIColor orangeColor];
    self.progress += 0.001;
    if (self.progress >1) {
        [self stop];
    }
}

- (void)longPress:(UIGestureRecognizer *)longPress {
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"开始");
            [self start];
            break;
            
        case UIGestureRecognizerStateCancelled:
            NSLog(@"取消");
            break;
            
        case UIGestureRecognizerStateEnded:
            NSLog(@"结束");
            [self stop];
            break;
            
        case UIGestureRecognizerStateChanged:
            NSLog(@"移动");
            break;
        default:
            break;
    }
}
@end
