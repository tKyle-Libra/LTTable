//
//  UITableViewCell+Data.h
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/17.
//  Copyright © 2018年 harry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTCellObject;
@interface UITableViewCell (Data)
-(void) setCellData:(LTCellObject *)cellObj indexPath:(NSIndexPath *)indexPath;

@end
