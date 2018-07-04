//
//  LTTable.h
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/4.
//  Copyright © 2018年 harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTSectionObject;
@class LTTable;

//typedef BOOL(^LTTableCanEditRowHandler)(LTTable *tableView, NSIndexPath *indexPath);
//typedef NSArray<UITableViewRowAction *> * _Nullable (^LTTableEditForRowActionHandler)(LTTable *tableView, NSIndexPath *indexPath);
//typedef NSArray<NSString *> * _Nullable (^LTTableSectionIndexTitlesHandler)(LTTable *tableView);
//typedef void(^LTTableMoveRowCompletedHandler)(LTTable *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
//typedef NSInteger(^LTTableSectionForSectionIndexTitleHandler)(LTTable *tableView, NSString *title, NSInteger index);


typedef void(^LTTableWillDisplayCellHandler)(LTTable *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
typedef void(^LTTableDidSelectRowHandler)(LTTable *tableView, NSIndexPath *indexPath);


@interface LTTable : UITableView <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong , nullable) NSMutableArray<LTSectionObject *> *sections;

@property (nonatomic , weak , nullable) id<UITableViewDelegate> delegate NS_UNAVAILABLE;

@property (nonatomic , weak , nullable) id<UITableViewDataSource> dataSource NS_UNAVAILABLE;

@property (nonatomic , copy , nullable) LTTableWillDisplayCellHandler willDisplayCellHandler;

@property (nonatomic , copy , nullable) LTTableDidSelectRowHandler didSelectRowHandler;

/**
    是否选中后，自动恢复。默认NO
 */
@property(nonatomic, assign) BOOL deSelectWhenSelected;

@end
