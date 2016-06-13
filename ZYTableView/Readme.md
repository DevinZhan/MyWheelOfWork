#ZYTableView
##简介：
> ZYTableView的目的是为了封装UITableView的代理方法和数据源方法，简化VC中的代码，并且高复用，可用于项目中任何一个需要使用到tableView的类中，在后续的项目中也可以简单的变动即可复用，提升开发效率

## 使用说明
### .h文件

```
- (id)initWithItems:(NSMutableArray *)items





具体的实现在代码中都有写到，这里就简单的说一下几个block的使用

* 第一个地方在cell的注册里面，使用block回调处理cell的逻辑部分
* 第二地方是编辑cell，例如删除cell等
* 第三个地方是点击cell的方法

###具体使用
这里我们就用一个例子即可，导入类创建属性就不多说，看下面代码就简单易懂了

```
// 自定义封装tableView
```


