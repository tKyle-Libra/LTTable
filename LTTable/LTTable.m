//
//  LTTable.m
//  LTTable
//
//  Created by zw-bdz-003 on 2018/7/4.
//  Copyright © 2018年 harry. All rights reserved.
//

#import "LTTable.h"
#import "LTDataSource.h"
#import <objc/message.h>
#import "UITableViewCell+Data.h"
#import "UITableViewHeaderFooterView+Data.h"

@implementation LTTable

@dynamic delegate;
@dynamic dataSource;

#pragma mark Left Cycle

-(void) awakeFromNib{
    [super awakeFromNib];
    [self initialize];
}

-(id) init{
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        [self initialize];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark Public Method


#pragma mark Private Method

-(void) initialize{
    [self setDelegateDataSource];
}

-(void) setDelegateDataSource{
    super.delegate = self;
    super.dataSource = self;
}

-(LTHeaderFooterObject*)defaultHeaderFooter {
    LTHeaderFooterObject *headerFooter = [[LTHeaderFooterObject alloc] init];
    if (headerFooter.size.height <= 0) {
        headerFooter.size = self.style == UITableViewStylePlain?CGSizeZero:CGSizeMake(0, 0.1);
    }
    headerFooter.registerClass = [LTKeyValueItem itemWithKey:LTTableDefaultHeaderFooterIdentifier value:[UITableViewHeaderFooterView class]];
    return headerFooter;
}

#pragma mark UITableViewDelegate or UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LTSectionObject *s = self.sections[section];
    return s.cells.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    LTSectionObject *so = self.sections[section];
    return so.header.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LTSectionObject *s = self.sections[section];
    NSString *identifier = LTCollectionDefaultHeaderIdentifier;
    if (s.header.registerClass) {
        LTKeyValueItem<NSString*, Class> *header = s.header.registerClass;
        identifier = header.key;
    }
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    [headerView setFillData:s.header indexPath:section];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    LTSectionObject *so = self.sections[section];
    return so.footer.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LTSectionObject *s = self.sections[section];
    NSString *identifier = LTCollectionDefaultHeaderIdentifier;
    if (s.footer.registerClass) {
        LTKeyValueItem<NSString*, Class> *footer = s.footer.registerClass;
        identifier = footer.key;
    }
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    [footerView setFillData:s.footer indexPath:section];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTSectionObject *s = self.sections[indexPath.section];
    LTCellObject *c = s.cells[indexPath.row];
    CGFloat height = c.size.height;
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTSectionObject *s = self.sections[indexPath.section];
    LTCellObject *c = s.cells[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:c.registerClass.key];
    if(!cell) {
        cell = [[c.registerClass.value alloc] initWithStyle:c.style reuseIdentifier:c.registerClass.key];
    }
    
    cell.textLabel.text = c.text;
    cell.detailTextLabel.text = c.detailText;
    cell.selectionStyle = c.selectionStyle;
    cell.accessoryType = c.accessoryType;
    if (c.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        cell.accessoryView = c.accessoryView;
    }
    if (tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine) {
        cell.separatorInset = c.separatorInset;
    }
    if(c.imageName) {
        cell.imageView.image = [UIImage imageNamed:c.imageName];
    } else {
        cell.imageView.image = nil;
    }
    [cell setCellData:c indexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.willDisplayCellHandler) {
        self.willDisplayCellHandler(self, cell, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTSectionObject *s = self.sections[indexPath.section];
    LTCellObject *c = s.cells[indexPath.row];
    if(c.target && c.selectorString) {
        SEL selector = NSSelectorFromString(c.selectorString);
        if([c.target respondsToSelector:selector]) {
            ((void (*)(void *, SEL, NSIndexPath*))objc_msgSend)((__bridge void *)(c.target), selector, indexPath);
        }
    }
    if (self.deSelectWhenSelected) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    if(self.didSelectRowHandler) {
        self.didSelectRowHandler(self, indexPath);
    }
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if(self.sectionIndexTitlesHandler) {
        return self.sectionIndexTitlesHandler(self);
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if(self.sectionForSectionIndexTitleHandler) {
        return self.sectionForSectionIndexTitleHandler(self, title, index);
    }
    return index;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    LTSectionObject *s = self.sections[section];
    if (s.header) {
        return s.header.text;
    }
    return @"";
}

#pragma mark getters and setters

-(void) setSections:(NSMutableArray<LTSectionObject *> *)sections{
    _sections = sections;
    for (LTSectionObject *s in sections) {
        if(!s.header) {
            s.header = [self defaultHeaderFooter];
        } else {
            if(!s.header.registerClass) {
                s.header.registerClass = [LTKeyValueItem itemWithKey:LTTableDefaultHeaderFooterIdentifier value:[UITableViewHeaderFooterView class]];
            } else {
                [self registerClass:s.header.registerClass.value forHeaderFooterViewReuseIdentifier:s.header.registerClass.key];
            }
        }
        
        if(!s.footer) {
            s.footer = [self defaultHeaderFooter];
        } else {
            if(!s.footer.registerClass) {
                s.footer.registerClass = [LTKeyValueItem itemWithKey:LTTableDefaultHeaderFooterIdentifier value:[UITableViewHeaderFooterView class]];
            } else {
                [self registerClass:s.footer.registerClass.value forHeaderFooterViewReuseIdentifier:s.footer.registerClass.key];
            }
        }
        
        if(s.cells) {
            for (LTCellObject *c in s.cells) {
                if(!c.registerClass) {
                    c.registerClass = [LTKeyValueItem itemWithKey:LTTableDefaultCellIdentifier value:[UITableViewCell class]];
                }
            }
        }
    }
}

@end
