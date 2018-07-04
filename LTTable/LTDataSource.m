//
//  LTDataSource.m
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/4.
//  Copyright © 2018年 harry. All rights reserved.
//

#import "LTDataSource.h"

NSString *const LTTableDefaultCellIdentifier = @"LTTableDefaultCellIdentifier";
NSString *const LTTableDefaultHeaderFooterIdentifier = @"LTTableDefaultHeaderFooterIdentifier";
NSString *const LTCollectionDefaultCellIdentifier = @"LTCollectionDefaultCellIdentifier";
NSString *const LTCollectionDefaultHeaderIdentifier = @"LTCollectionDefaultHeaderIdentifier";
NSString *const LTCollectionDefaultFooterIdentifier = @"LTCollectionDefaultFooterIdentifier";

@implementation LTKeyValueItem

+(instancetype) itemWithKey:(id)key value:(id)value{
    LTKeyValueItem *item = [[self alloc] init];
    item.key = key;
    item.value = value;
    
    return item;
}

@end


@implementation LTCellObject

-(instancetype)init {
    self = [super init];
    if(self) {
        self.style = UITableViewCellStyleDefault;
        self.size = CGSizeZero;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    LTCellObject *obj = [[LTCellObject allocWithZone:zone] init];
    obj.text = self.text;
    obj.detailText = self.detailText;
    obj.imageName = self.imageName;
    obj.style = self.style;
    obj.selectionStyle = self.selectionStyle;
    obj.accessoryType = self.accessoryType;
    obj.registerClass = self.registerClass;
    obj.size = self.size;
    obj.data = self.data;
    obj.obj = self.obj;
    
    return obj;
}

@end

@implementation LTHeaderFooterObject

-(instancetype)init {
    self = [super init];
    if(self) {
        self.size = CGSizeZero;
    }
    return self;
}

@end

@implementation LTSectionObject

+(instancetype)sectionWithCells:(NSMutableArray<LTCellObject *> *)cells {
    LTSectionObject *obj = [[self alloc] init];
    obj.cells = cells;
    return obj;
}
@end
