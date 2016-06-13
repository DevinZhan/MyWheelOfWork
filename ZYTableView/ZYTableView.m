//
//  ArrayDataSource.m
//  LeftSlide
//
//  Created by mymac on 16/5/20.
//  Copyright © 2016年 陕西永诺. All rights reserved.
//

#import "ZYTableView.h"
#import "Devicemodel.h"
#import "WellModel.h"

@interface ZYTableView ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewDataSourceBlock dataSourceBlock;
@property (nonatomic, copy) TableViewDelegateBlock delegateBlock;

@end

@implementation ZYTableView

- (id)init
{
    return nil;
}

- (id)initWithItems:(NSMutableArray *)items
     cellIdentifier:(NSString *)identifier
    dataSourceBlock:(TableViewDataSourceBlock)dataSource
      delegateBlock:(TableViewDelegateBlock)delegate
{
    self = [super init];
    if (self)
    {
        // 可变数组需要初始化
        self.items = [NSMutableArray arrayWithArray:items];
        self.cellIdentifier = identifier;
        self.dataSourceBlock = [dataSource copy];
        self.delegateBlock = [delegate copy];
    }
    
    return self;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    // 取到model
    if (self.items.count > 0) {
        
        id model = [self.items objectAtIndex:indexPath.row];
        self.dataSourceBlock(cell, model, indexPath);
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{//请求数据源提交的插入或删除指定行接收者。
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {//如果编辑样式为删除样式
        if (indexPath.row < [self.items count])
        {
            //调用删除方法
            if (self.editingBlock) {
                self.editingBlock(indexPath);
            }
        }
    }
}


#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self getCellHeightWithType:self.cellIdentifier items:self.items indexPath:indexPath];
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_items.count > 0) {
        self.delegateBlock(indexPath);
    }

}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    
    if ([self.cellIdentifier isEqualToString:@"test"])
    {
        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
    }
    
    return result;
}


#pragma mark - private methods
// 自适应高度
- (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width
{
    CGSize size       = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect rect       = [content boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    
    return rect.size.height;
}

/**
 *  封装获取cell的高度
 *
 *  @param type      cell的重用标识符
 *  @param items     数据源
 *  @param indexPath indexPath
 *
 *  @return 高度
 */
- (CGFloat)getCellHeightWithType:(NSString *)type items:(NSArray *)items indexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"==%@",type);
    CGFloat height;
    if(items.count > 0)
    {
        if ([type isEqualToString:@"test"] || [type isEqualToString:@"withDraw"] || [type isEqualToString:@"wellError"])
        {// 如果是井盖采集界面或者撤防布防界面或者井盖纠错界面
            WellModel *model = [self.items objectAtIndex:indexPath.row];
            if (model.locationstr.length == 0)
            {
                return 110;
            }else{
                height = [self getHeightWithContent:model.locationstr width:[UIScreen mainScreen].bounds.size.width - 60];
                
                return height + 120;
            }
            
        }else if ([type isEqualToString:@"TestCell2"])
        {// 如果是设备安装界面
            Devicemodel *model = [self.items objectAtIndex:indexPath.row];
            if (model.strlocation.length == 0)
            {
                return 110;
            }else{
                height = [self getHeightWithContent:model.strlocation width:[UIScreen mainScreen].bounds.size.width - 60];
                return height + 120;
            }
        }else if ([type isEqualToString:@"dataList"])
        {// 如果是数据分析界面
         
            return 44;
        }else if ([type isEqualToString:@"LogCell"])
        {// 如果是异常报警详情界面
            
            return 88;
        }else
        {
            return 121;
        }
    }else{
        
        return 0;
    }
}

@end
