//
//  UITableViewHeaderFooterView+Data.h
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/17.
//  Copyright © 2018年 harry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTHeaderFooterObject;
@interface UITableViewHeaderFooterView (Data)

-(void) setFillData:(LTHeaderFooterObject *)headerFooterObject indexPath:(NSInteger)section;

@end
