//
//  PieView.h
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/6.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PieView;
@protocol CrlViewDelegate <NSObject>
- (CGFloat)centerCircleRadius;

@end

@protocol CrlViewDataSource <NSObject>

@required
- (int)numberOfSlicesInPieChartView:(PieView *)pieChartView;
- (double)pieChartView:(PieView *)pieChartView valueForSliceAtIndex:(NSUInteger)index;
- (UIColor *)pieChartView:(PieView *)pieChartView colorForSliceAtIndex:(NSUInteger)index;

@optional
- (NSString*)pieChartView:(PieView *)pieChartView titleForSliceAtIndex:(NSUInteger)index;
@end


@interface PieView : UIView

@property(weak, nonatomic) id <CrlViewDelegate> delegate;

@property(weak, nonatomic) id <CrlViewDataSource> datasource;
@end
