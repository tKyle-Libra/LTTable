//
//  LTDataSource.h
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/4.
//  Copyright © 2018年 harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTKeyValueItem<__covariant KeyType, __covariant ObjectType> : NSObject

@property (strong , nonatomic) KeyType key;

@property (strong , nonatomic) ObjectType value;

+(instancetype) itemWithKey:(KeyType)key value:(ObjectType)value;

@end


@interface LTCellObject:NSObject

/**
 注册的类，key 为reuseIdentifier
 */
@property (strong , nonatomic , nullable) LTKeyValueItem<NSString *, Class> *registerClass;

@property (assign , nonatomic) CGSize size;

/**
    自定义
 */
@property (weak , nonatomic , nullable) id obj;

/**
    界面填充数据
 */
@property (strong , nonatomic , nullable) id data;


@property (weak , nonatomic , nullable) id target;

/**
    method for string
 */
@property (strong , nonatomic , nullable) NSString *selectorString;

@property(nonatomic, strong, nullable) NSString *text;
@property(nonatomic, strong, nullable) NSString *detailText;
/**
 本地图片资源名
 */
@property(nonatomic, strong, nullable) NSString *imageName;
@property(nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property(nonatomic, strong, nullable) UIView *accessoryView;
@property(nonatomic, assign) UITableViewCellStyle style;
@property(nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;



@end

@interface LTHeaderFooterObject : NSObject

@property(nonatomic, strong, nullable) NSString *text;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, strong) LTKeyValueItem<NSString*, Class> *registerClass;
@property(nonatomic, strong, nullable) id data;
@property(nonatomic, weak, nullable) id obj;

@end

@interface LTSectionObject : NSObject

@property(nonatomic, strong, nullable) NSMutableArray<LTCellObject*> *cells;
@property(nonatomic, strong, nullable) LTHeaderFooterObject *header;
@property(nonatomic, strong, nullable) LTHeaderFooterObject *footer;

+(instancetype)sectionWithCells:(NSMutableArray<LTCellObject*>*)cells;

@end


@protocol LTCellProtocol

@end

extern NSString *const LTTableDefaultCellIdentifier;
extern NSString *const LTTableDefaultHeaderFooterIdentifier;
extern NSString *const LTCollectionDefaultCellIdentifier;
extern NSString *const LTCollectionDefaultHeaderIdentifier;
extern NSString *const LTCollectionDefaultFooterIdentifier;

NS_ASSUME_NONNULL_END
