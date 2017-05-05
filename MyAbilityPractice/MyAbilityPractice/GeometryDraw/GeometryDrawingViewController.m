//
//  GeometryDrawingViewController.m
//  MyAbilityPractice
//
//  Created by yindongbo on 2017/4/6.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "GeometryDrawingViewController.h"
#import "PieView.h"
#import "DonutHUBView.h"
#import "RingProcessView.h"
@interface GeometryDrawingViewController ()<
CrlViewDelegate,
CrlViewDataSource
>

@property (nonatomic, strong) PieView *pieView;
@property (nonatomic, strong) DonutHUBView *donutHUBView;
@property (nonatomic, strong) RingProcessView *ringProcessView;
@end

#define kRadius 50
@implementation GeometryDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pieView];
//    [self.view addSubview:self.donutHUBView];
    [self.view addSubview:self.ringProcessView];
    self.ringProcessView.layer.cornerRadius = 50;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 50, 50, 50)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor brownColor];
    view.layer.cornerRadius = 25;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Lazy Init
- (PieView *)pieView {
    if (!_pieView) {
        PieView *pieView = [[PieView alloc]init];
        
        pieView.backgroundColor = [UIColor whiteColor];
        
        pieView.frame = CGRectMake(10, 10, 2 * kRadius, 2 * kRadius);
        
        pieView.delegate = self;
        pieView.datasource = self;
        _pieView = pieView;
    }
    return _pieView;
}

- (DonutHUBView *)donutHUBView {
    if (!_donutHUBView) {
        _donutHUBView = [[DonutHUBView alloc] initWithFrame:CGRectMake(150, 10, 100, 100)];
        _donutHUBView.backgroundColor = [UIColor purpleColor];
    }
    return _donutHUBView;
}

- (RingProcessView *)ringProcessView {
    if (!_ringProcessView) {
        _ringProcessView = [[RingProcessView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _ringProcessView.center = CGPointMake(CGRectGetWidth(self.view.frame) /2, CGRectGetHeight(self.view.frame) / 2);
        _ringProcessView.backgroundColor =[UIColor purpleColor];
    }
    return _ringProcessView;
}

/*======================================================*/
#pragma mark - CenterCircleRadius
// 有几个部分
- (int)numberOfSlicesInPieChartView:(PieView *)pieChartView {
    return 2;
}

#pragma mark - CrlViewDataSource
// 每一部分占的比例,相加可以不等于1
- (double)pieChartView:(PieView *)pieChartView valueForSliceAtIndex:(NSUInteger)index {
    if (index == 0) {
        return 0.6;
    }
    else {
        return 0.35;
    }
}
- (UIColor *)pieChartView:(PieView *)pieChartView colorForSliceAtIndex:(NSUInteger)index {
    if (index == 0) {
        return [UIColor greenColor];
    }
    else {
        return [UIColor redColor];
    }
}

- (NSString*)pieChartView:(PieView *)pieChartView titleForSliceAtIndex:(NSUInteger)index {
    if (index == 0) {
        return @"男";
    }
    else {
        return @"女";
    }
}

- (CGFloat)centerCircleRadius {
    return kRadius;// 半径
}

/*======================================================*/



@end
