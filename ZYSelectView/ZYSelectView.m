//
//  ZYSelectView.m
//  ZYSelectViewDemo
//
//  Created by mymac on 16/5/28.
//  Copyright © 2016年 Devin. All rights reserved.
//

#import "ZYSelectView.h"
#import "UIColor-Expanded.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define kSpace 7

@interface ZYSelectView ()
{
    UIView *_btnView; // 放按钮的view
}

@property (nonatomic, assign) CGPoint origin; // 设置一个起点
@property (nonatomic, assign) CGFloat width; // 视图宽度
@property (nonatomic, assign) NSInteger height; // 视图高度

@end

@implementation ZYSelectView
- (instancetype)initWithOrigin:(CGPoint)origin width:(CGFloat)width height:(NSInteger)height btnArr:(NSArray *)btnArr
{
    // 定义一个全屏的视图，加载到window上去
    self = [super initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    if (self)
    {
        // 半透明样式，子控件不透明
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
        
        // 定义视图参数
        self.origin = origin;
        self.width = width;
        self.height = height;
        
        // 设置按钮所在视图
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, width, height)];
        _btnView.backgroundColor = [UIColor whiteColor];
        _btnView.layer.cornerRadius = 6.f;
        _btnView.layer.borderColor = [UIColor clearColor].CGColor;
        _btnView.layer.borderWidth = 1.f;
        [self addSubview:_btnView];
        
        // 获取按钮的高度
        CGFloat btnHeight = height / btnArr.count + height % btnArr.count;
        
        // 设置按钮
        for (int i = 0; i < btnArr.count; i++)
        {
            UIButton *actionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            actionBtn.backgroundColor = [UIColor whiteColor];
            actionBtn.frame = CGRectMake(0, i * btnHeight, width, btnHeight);
            actionBtn.tag = 3000 + i;
            [actionBtn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
            [actionBtn setTitle:btnArr[i] forState:(UIControlStateNormal)];
            [actionBtn.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:14]];
            [actionBtn addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
            actionBtn.layer.cornerRadius = 6.f;
            
            [actionBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"p2-%d", i]] forState:(UIControlStateNormal)];
            [actionBtn setImageEdgeInsets:(UIEdgeInsetsMake(6, 7, 8, 77))];
            
            [_btnView addSubview:actionBtn];
        }
        
        // 设置分割线
        for (int i = 0; i < btnArr.count; i++)
        {
            UILabel *segLine = [[UILabel alloc] initWithFrame:CGRectMake(0, btnHeight * (i + 1), width, 1)];
            segLine.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
            [_btnView addSubview:segLine];
        }
    }
    return self;
}

// 选择事件方法
- (void)selectAction:(UIButton *)btn
{
    // 点击按钮时，将点击的按钮的tag值有block传递出去
    if (_selectBlock) {
        
        _selectBlock(btn.tag - 3000);
    }
    [self dismiss];
}

// 显示视图
- (void)popView
{
    // 显示视图前将视图上所有的控件设为不可见
    NSArray *result=[_btnView subviews];
    for (UIView *view in result)
    {
        view.hidden = YES;
    }
    
    // 将视图加载到Window上
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    
    //动画效果弹出
    self.alpha = 0;
    _btnView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alpha = 1;
        _btnView.frame = CGRectMake(self.origin.x - kSpace, self.origin.y-self.height / 2, -self.width, self.height);
    }completion:^(BOOL finished) {
        
        NSArray *result=[_btnView subviews];
        for (UIView *view in result)
        {
            view.hidden = NO;
        }
    }];
}

// 隐藏视图
- (void)dismiss
{
    // 隐藏视图的时候移除所有的控件
    NSArray *result = [_btnView subviews];
    for (UIView *view in result)
    {
        [view removeFromSuperview];
    }
    
    //动画效果淡出
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alpha = 0;
        _btnView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            [self removeFromSuperview];
        }
    }];
}

// 点击屏幕空白处，隐藏视图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:_btnView])
    {
        [self dismiss];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.f);
    
    CGFloat startX = self.origin.x;
    CGFloat startY = self.origin.y;
    CGContextMoveToPoint(context, startX, startY);//设置起点
    CGContextAddLineToPoint(context, startX - kSpace, startY - kSpace);
    CGContextAddLineToPoint(context, startX - kSpace, startY + kSpace);
    
    CGContextClosePath(context);
    [_btnView.backgroundColor setFill];
    [self.backgroundColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
