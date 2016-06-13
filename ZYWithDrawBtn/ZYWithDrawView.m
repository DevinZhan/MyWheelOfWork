//
//  ZYWithDrawView.m
//  LeftSlide
//
//  Created by mymac on 16/5/30.
//  Copyright © 2016年 陕西永诺. All rights reserved.
//

#import "ZYWithDrawView.h"
#import "UIColor-Expanded.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define kSpace 7

@interface ZYWithDrawView ()
{
    UIView *_btnView; // 放按钮的view
}

@property (nonatomic, assign) CGPoint origin; // 设置一个起点
@property (nonatomic, assign) CGFloat width; // 视图宽度
@property (nonatomic, assign) NSInteger height; // 视图高度

@end

@implementation ZYWithDrawView
- (instancetype)initWithOrigin:(CGPoint)origin width:(CGFloat)width height:(NSInteger)height
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
        CGFloat btnHeight = height / 2 + height % 2;
        
        // 设置N2按钮
            _n2Button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            _n2Button.backgroundColor = [UIColor whiteColor];
            _n2Button.frame = CGRectMake(0, 0, width, btnHeight);
            _n2Button.tag = 4000;
            [_n2Button setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
            
            [_n2Button.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:14]];
            [_n2Button addTarget:self action:@selector(selectN2Action:) forControlEvents:(UIControlEventTouchUpInside)];
            _n2Button.layer.cornerRadius = 6.f;
            
            [_n2Button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"p2-%d", 0]] forState:(UIControlStateNormal)];
            [_n2Button setImageEdgeInsets:(UIEdgeInsetsMake(6, 7, 8, 77))];
            [_btnView addSubview:_n2Button];
        
        // 设置水位按钮
        _waterButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _waterButton.backgroundColor = [UIColor whiteColor];
        _waterButton.frame = CGRectMake(0, btnHeight, width, btnHeight);
        _waterButton.tag = 4001;
        [_waterButton setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        [_waterButton setTitle:@"撤防水位设备" forState:(UIControlStateNormal)];
        [_waterButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:14]];
        [_waterButton addTarget:self action:@selector(selectN2Action:) forControlEvents:(UIControlEventTouchUpInside)];
        _waterButton.layer.cornerRadius = 6.f;
        
        [_waterButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"p2-%d", 1]] forState:(UIControlStateNormal)];
        [_waterButton setImageEdgeInsets:(UIEdgeInsetsMake(6, 7, 8, 77))];
        [_btnView addSubview:_waterButton];
        
        // 设置分割线
        for (int i = 0; i < 2; i++)
        {
            UILabel *segLine = [[UILabel alloc] initWithFrame:CGRectMake(0, btnHeight * (i + 1), width, 1)];
            segLine.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
            [_btnView addSubview:segLine];
        }
    }
    return self;
}

// 选择事件方法
- (void)selectN2Action:(UIButton *)btn
{
    // 点击按钮时，将点击的按钮的tag值有block传递出去
    if (_selectBlock) {
        
        _selectBlock(btn);
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
    _btnView.frame = CGRectMake(self.origin.x, self.origin.y-self.height / 2, 0, 0);
    
    [UIView animateWithDuration:0.8 delay:0.3 usingSpringWithDamping:0.8
          initialSpringVelocity:0 options:0 animations:^{
              self.alpha = 1;
              _btnView.frame = CGRectMake(self.origin.x - kSpace, self.origin.y-self.height / 2, -self.width, self.height);
              NSArray *result=[_btnView subviews];
              for (UIView *view in result)
              {
                  view.hidden = NO;
              }
          } completion:^(BOOL finished) {
              
              
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
