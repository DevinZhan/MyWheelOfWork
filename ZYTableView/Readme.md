#ZYTableView
##简介：
> ZYTableView的目的是为了封装UITableView的代理方法和数据源方法，简化VC中的代码，并且高复用，可用于项目中任何一个需要使用到tableView的类中，在后续的项目中也可以简单的变动即可复用，提升开发效率

## 使用说明
### .h文件

```
- (id)initWithItems:(NSMutableArray *)items     cellIdentifier:(NSString *)identifier    dataSourceBlock:(TableViewDataSourceBlock)dataSourcedelegateBlock:(TableViewDelegateBlock)delegate;```
这里items是数据源数组，identifier是重用标识符，dataSource和delegate就是替代代理方法的block，block的重命名在源码中可以看到
**我们还需要一个属性，特殊处理某些使用到编辑cell功能的tableView，数据源数组也需要使用到属性，很多时候刷新表格需要刷新数据源数组**
```
// 编辑block, 在需要用到的界面去使用@property (nonatomic, copy) TableViewEditingBlock editingBlock;@property (nonatomic, strong) NSMutableArray *items;```
###简单介绍
具体的实现在代码中都有写到，这里就简单的说一下几个block的使用

* 第一个地方在cell的注册里面，使用block回调处理cell的逻辑部分
* 第二地方是编辑cell，例如删除cell等
* 第三个地方是点击cell的方法

###具体使用
这里我们就用一个例子即可，导入类创建属性就不多说，看下面代码就简单易懂了

```
// 自定义封装tableView    _zyTableView = [[ZYTableView alloc] initWithItems:self.arrProduct cellIdentifier:identifier dataSourceBlock:^(TestCell2 *cell, id model, NSIndexPath *indexPath) {                cell.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];        cell.model = model;    } delegateBlock:^(NSIndexPath *indexPath) {                // 自定义点击单元格方法        [self selectRowAtIndexPath:indexPath];    }];
```就这样一句话即可实现，当然需要在刷新表格之前重置数组，如下
```_zyTableView.items = categoryArr;[self.myTB reloadData];```
**更多信息请参考项目源码**
