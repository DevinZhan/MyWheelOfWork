//
//  ZYWithDrawView.h
//  LeftSlide
//
//  Created by mymac on 16/5/30.
//  Copyright © 2016年 陕西永诺. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyDrawSelectBlock)(id button);

@interface ZYWithDrawView : UIView

/**
 *  自定义初始化方法
 *
 *  @param origin 三角顶点三角
 *  @param width  视图的宽度
 *  @param height 视图的高度
 *  @param btnArr 传入的数据源
 *
 *  @return 初始化方法
 */
- (instancetype)initWithOrigin:(CGPoint)origin width:(CGFloat)width height:(NSInteger)height;

// 通过block调用点击事件
@property (nonatomic, copy) MyDrawSelectBlock selectBlock;

// N2设备按钮
@property (nonatomic, strong) UIButton *n2Button;
// 水位设备按钮
@property (nonatomic, strong) UIButton *waterButton;

- (void)popView; // 弹出视图
- (void)dismiss; // 隐藏视图

@end
