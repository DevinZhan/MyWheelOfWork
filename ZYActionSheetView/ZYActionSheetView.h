//
//  ZYActionSheetView.h
//  DMS
//
//  Created by mymac on 16/3/25.
//  Copyright © 2016年 YangJingchao. All rights reserved.
//


// 注意, 此view需要加载到window上去

#import <UIKit/UIKit.h>

typedef void(^MySelectBlock) (NSInteger);

@interface ZYActionSheetView : UIView

// 通过block调用点击事件
@property (nonatomic, copy) MySelectBlock myBlock;


- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray *)arr;

// 显示方法, 在需要调出的时候执行
- (void)makeViewAppear;

@end
