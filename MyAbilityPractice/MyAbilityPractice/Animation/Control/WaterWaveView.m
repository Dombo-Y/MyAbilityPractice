//
//  WaterWaveView.m
//  MyAbilityPractice
//
//  Created by 尹东博 on 17/3/9.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "WaterWaveView.h"

@interface WaterWaveView(){
    CGFloat _waveAmplitude;      //!< 振幅
    CGFloat _waveCycle;          //!< 周期
    CGFloat _waveSpeed;          //!< 速度
    CGFloat _waterWaveHeight;
    CGFloat _waterWaveWidth;
    CGFloat _wavePointY;
    CGFloat _waveOffsetX;            //!< 波浪x位移
    UIColor *_waveColor;             //!< 波浪颜色
}

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic,strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic,strong) CAShapeLayer *secondeWaveLayer;
@end

@implementation WaterWaveView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor orangeColor];
        self.layer.masksToBounds = YES;
        
        [self configParams];
        
        [self starWave];
    }
    return self;
}

- (void)configParams {
    _waterWaveWidth = self.frame.size.width;
    _waterWaveHeight = 100;
    _waveColor = [UIColor purpleColor];
    _waveSpeed = 0.25/M_PI;
    _waveOffsetX = 0;
    _wavePointY = _waterWaveHeight - 50;
    _waveAmplitude = 13;
    _waveCycle =  1.29 * M_PI / _waterWaveWidth;
}

- (void)starWave {
    [self.layer addSublayer:self.firstWaveLayer];
    [self.layer addSublayer:self.secondeWaveLayer];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - LazyInit
- (CAShapeLayer *)firstWaveLayer {
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = [_waveColor CGColor];
    }
    return _firstWaveLayer;
}

- (CAShapeLayer *)secondeWaveLayer {
    if (!_secondeWaveLayer) {
        _secondeWaveLayer = [CAShapeLayer layer];
        _secondeWaveLayer.fillColor = [UIColor blueColor].CGColor;
    }
    return _secondeWaveLayer;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    }
    return _displayLink;
}

#pragma mark － 帧刷新事件
- (void)getCurrentWave {
    _waveOffsetX += _waveSpeed;
    [self setFirstWaveLayerPath];
    [self setSecondWaveLayerPath];
}

#pragma mark - shapeLayer动画
- (void)setFirstWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waterWaveWidth; x ++) {
        y = _waveAmplitude * sin(_waveCycle * x + _waveOffsetX - 10) + _wavePointY + 10;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _firstWaveLayer.path = path;
    
    CGPathRelease(path);
}

- (void)setSecondWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY ;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waterWaveWidth; x ++) {
        y = (_waveAmplitude -2) * sin(_waveCycle * x + _waveOffsetX ) + _wavePointY + 20;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _secondeWaveLayer.path = path;
    
    CGPathRelease(path);
}

@end
