//
//  ArrayDataSource.h
//  LeftSlide
//
//  Created by mymac on 16/5/20.
//  Copyright © 2016年 陕西永诺. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  UITableView DataSource 封装
 *
 *  @param cell      cell
 *  @param model     model
 *  @param indexPath indexPath
 */
typedef void (^TableViewDataSourceBlock) (id cell, id model, NSIndexPath *indexPath);

/**
 *  UITableView Delegate 封装
 *
 *  @param indexPath      indexPath
 */
typedef void (^TableViewDelegateBlock) (NSIndexPath *indexPath);

/**
 *  UITableView DataSource中的编辑
 *
 *  @param indexPath indexPath
 */
typedef void (^TableViewEditingBlock) (NSIndexPath *indexPath);

@interface ZYTableView : NSObject <UITableViewDataSource, UITableViewDelegate>

- (id)initWithItems:(NSMutableArray *)items
     cellIdentifier:(NSString *)identifier
    dataSourceBlock:(TableViewDataSourceBlock)dataSource
      delegateBlock:(TableViewDelegateBlock)delegate;

// 编辑block, 在需要用到的界面去使用
@property (nonatomic, copy) TableViewEditingBlock editingBlock;

// 数据源数组
@property (nonatomic, strong) NSMutableArray *items;

@end
