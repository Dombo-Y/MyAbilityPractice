//
//  PieView.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/6.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "PieView.h"

@implementation PieView

- (void)drawRect:(CGRect)rect {
    // layer上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat theHalf = rect.size.width/2;
    CGFloat lineWidth = theHalf;
    
    // 宽度的一半 - 半径
    lineWidth -= [self.delegate centerCircleRadius];
    CGFloat radius = theHalf-lineWidth/2;
    
    /*圆心坐标*/
    CGPoint center = CGPointMake(theHalf, rect.size.height/2);
    
    float startAngle = - M_PI_2;
    float endAngle = 0.0f;
    
    double sum = 0.0f;
    
    /*饼状图中切片个数*/
    int slicesCount = [self.datasource numberOfSlicesInPieChartView:self];
    
    for (int i = 0; i < slicesCount; i++) {
        sum += [self.datasource pieChartView:self valueForSliceAtIndex:i];
    }
    
    
    for (int i = 0; i < slicesCount; i ++) {
        static double blckAngle = 0.0f;
        
        double nextAngle = [self.datasource pieChartView:self valueForSliceAtIndex:i] * (2 * M_PI)/ sum; // 精准的弧度
        
        UIColor *fillColor = [self.datasource pieChartView:self colorForSliceAtIndex:i];
        
        NSString *title;
        if ([self.datasource respondsToSelector:@selector(pieChartView:titleForSliceAtIndex:)]) {
            title = [self.datasource pieChartView:self titleForSliceAtIndex:i];
        }
        
        UIBezierPath *path;
        if (i == 0) {
            path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:nextAngle clockwise:YES];
            [fillColor setFill];
        }
        else if(i == slicesCount - 1) {
            path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:nextAngle endAngle:endAngle clockwise:YES];
        }
        else {
            path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:blckAngle endAngle:nextAngle clockwise:YES];
        }
        
        blckAngle = nextAngle;
        
        [path addLineToPoint:center];
        
        [path closePath];
        [fillColor setFill];
        
        CGContextAddPath(context, path.CGPath);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

@end
