//
//  ViewController.m
//  TestMasonry1
//
//  Created by liuyong on 04/01/2017.
//  Copyright © 2017 hongzhi. All rights reserved.
//

#import "ViewController.h"
#import "UIView+EqualMargin.h"
#import "Masonry.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@300);
    }];
    
    
    [self fixSpacing];
    
    [self fixItemLength];
    
    [self differentLengthItems];
    
}

//在红色View里面放三个正方形View, 间距固定，控件大小可变
- (void)fixSpacing {
    NSInteger padding = 30;
    UIView *yellowView1 = [[UIView alloc] init];
    yellowView1.backgroundColor = [UIColor yellowColor];
    [self.redView addSubview:yellowView1];
    
    UIView *yellowView2 = [[UIView alloc] init];
    yellowView2.backgroundColor = [UIColor yellowColor];
    [self.redView addSubview:yellowView2];
    
    UIView *yellowView3 = [[UIView alloc] init];
    yellowView3.backgroundColor = [UIColor yellowColor];
    [self.redView addSubview:yellowView3];
    
    __weak __typeof(self)weakSelf = self;
    //间距固定，控件大小可变(leadSpacing\tailSpacing\FixedSpacing)
    [@[yellowView1, yellowView2, yellowView3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
    
    [@[yellowView1, yellowView2, yellowView3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.redView).offset(20);
        make.height.mas_equalTo(yellowView3.mas_width);
    }];
}

//在红色View里面放三个正方形View, 控件大小固定，间距由计算得来
- (void)fixItemLength {
    UIView *yellowView1 = [[UIView alloc] init];
    yellowView1.backgroundColor = [UIColor yellowColor];
    [self.redView addSubview:yellowView1];
    
    UIView *yellowView2 = [[UIView alloc] init];
    yellowView2.backgroundColor = [UIColor yellowColor];
    [self.redView addSubview:yellowView2];
    
    UIView *yellowView3 = [[UIView alloc] init];
    yellowView3.backgroundColor = [UIColor yellowColor];
    [self.redView addSubview:yellowView3];
    
    __weak __typeof(self)weakSelf = self;
    //控件大小固定，间距由计算得来（leadSpacing\tailSpacing\ItemLength）
    [@[yellowView1, yellowView2, yellowView3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:20 tailSpacing:20];
    
    [@[yellowView1, yellowView2, yellowView3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.redView).offset(150);
        make.height.mas_equalTo(yellowView3.mas_width);
    }];
}

//在红色View里面放三个大小不一样的绿色正方形, 间隙等大, masonry并没提供相关方法
- (void)differentLengthItems {
    
    __weak __typeof(self)weakSelf = self;
    NSMutableArray *greenViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIView *greenView = [[UIView alloc] init];
        greenView.backgroundColor = [UIColor greenColor];
        [self.redView addSubview:greenView];
        [greenViews addObject:greenView];
        [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.redView).offset(-10);
            make.width.mas_equalTo(i*20 + 20);
            make.height.mas_equalTo(greenView.mas_width);
        }];
    }
    [self.redView distributeSpacingHorizontallyWith:greenViews];
}


@end
