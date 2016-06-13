//
//  ZYActionSheetView.m
//  DMS
//
//  Created by mymac on 16/3/25.
//  Copyright © 2016年 YangJingchao. All rights reserved.
//

#import "ZYActionSheetView.h"
#import "UIColor-Expanded.h"

@implementation ZYActionSheetView
{
    UIView *_btnView; // 放按钮的view
    UIView *_blackView; // 背景半透明图
}

- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray *)arr{
    
    self = [super initWithFrame:frame];
    if (self) {
     
        self.hidden = YES;
        
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];
        [self addSubview:_blackView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)];
        [_blackView addGestureRecognizer:tap];
        
        _btnView = [[UIView alloc] initWithFrame:(CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, (arr.count + 1) * 50))];
        _btnView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_btnView];
        
        UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        cancelBtn.backgroundColor = [UIColor clearColor];
        cancelBtn.frame = CGRectMake(0, _btnView.frame.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50);
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancelBtn setTitleColor:[UIColor colorWithHexString:@"ff5000"] forState:(UIControlStateNormal)];
        [cancelBtn addTarget:self action:@selector(cancelView) forControlEvents:(UIControlEventTouchUpInside)];
        [_btnView addSubview:cancelBtn];
        
        for (int i = 0; i < arr.count; i++) {
            
            UIButton *actionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            actionBtn.backgroundColor = [UIColor clearColor];
            actionBtn.frame = CGRectMake(0, 50 * i, _btnView.frame.size.width, 50);
            actionBtn.tag = 3000 + i;
            [actionBtn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
            [actionBtn setTitle:arr[i] forState:(UIControlStateNormal)];
            [actionBtn addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [_btnView addSubview:actionBtn];
            
            UILabel *segLine = [[UILabel alloc] initWithFrame:(CGRectMake(10, 50 * (i + 1), _btnView.frame.size.width - 20, 1))];
            segLine.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
            [_btnView addSubview:segLine];
        }
        
    }
    return self;
}

// 选择事件方法
- (void)selectAction:(UIButton *)btn{
 
    if (_myBlock) {
        
        _myBlock(btn.tag - 3000);
    }
    [self cancelView];
}

// 取消按钮方法(私有)
- (void)cancelView{
    
    
    CGFloat height = _btnView.frame.size.height;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        _btnView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, height);
        _blackView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.f];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

// 公有方法,调出界面
- (void)makeViewAppear{
    
    self.hidden = NO;
    CGFloat height = _btnView.frame.size.height;
    
    [UIView animateWithDuration:0.3f animations:^{
       
        _btnView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - height, [UIScreen mainScreen].bounds.size.width, height);
        _blackView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
