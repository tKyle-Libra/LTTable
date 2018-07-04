//
//  ViewController.m
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/4.
//  Copyright © 2018年 harry. All rights reserved.
//

#import "ViewController.h"
#import "LTTable.h"
#import "LTDataSource.h"

@interface ViewController ()

@property (strong , nonatomic , null_resettable) LTTable *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 100 ; index++) {
        LTCellObject *co = [[LTCellObject alloc] init];
        co.text = [NSString stringWithFormat:@"text = %ld",index];
        co.size = CGSizeMake(0, 44);
        co.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        co.selectionStyle = UITableViewCellSelectionStyleNone;
        [arr addObject:co];
    }
    LTSectionObject *so = [LTSectionObject sectionWithCells:arr];
    _tableView.sections = [@[so] mutableCopy];
    [_tableView reloadData];
}

-(LTTable *) tableView{
    if (!_tableView) {
        _tableView = [[LTTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor redColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

@end
