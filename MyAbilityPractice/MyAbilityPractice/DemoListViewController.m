//
//  DemoListViewController.m
//  MyAbilityPractice
//
//  Created by 尹东博 on 17/3/8.
//  Copyright © 2017年 Yoon. All rights reserved.
//

#import "DemoListViewController.h"
#import "AnimationViewController.h"

@interface DemoListViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *vcArray;
@end

@implementation DemoListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.tableview.delegate =self;
    self.tableview.dataSource =self;
    
    self.nameArray = @[@"animation",@"TransformAnimation"];
    self.vcArray = @[@"AnimationViewController",@"TransformAnimationAViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.vcArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class)
    {
        UIViewController *ctrl = class.new;
        ctrl.title = self.nameArray[indexPath.row];
        ctrl.view.backgroundColor =[UIColor whiteColor];
        ctrl.edgesForExtendedLayout = NO;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID =@"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
    return cell;
}


@end
