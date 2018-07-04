//
//  ViewController.m
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/4.
//  Copyright © 2018年 harry. All rights reserved.
//

#import "ViewController.h"
#import "LTTable.h"

@interface ViewController ()

@property (strong , nonatomic , null_resettable) LTTable *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(LTTable *) tableView{
    if (!_tableView) {
        _tableView = [[LTTable alloc] init];
    }
    return _tableView;
}

@end
