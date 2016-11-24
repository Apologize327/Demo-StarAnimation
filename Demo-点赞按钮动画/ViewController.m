//
//  ViewController.m
//  Demo-点赞按钮动画
//
//  Created by Suning on 16/10/21.
//  Copyright © 2016年 Suning. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"

#define praiseBtnWH 30
#define borkenTime  0.5f
#define toBrokenHeartWH    120/195

@interface ViewController (){
    UIButton *_praiseBtn;
    UIButton *_coverBtn;
    UIImageView *_cancelPraiseImg;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praiseBtn.frame = CGRectMake(100, 200, praiseBtnWH, praiseBtnWH);
    [praiseBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
    [praiseBtn setImage:[UIImage imageNamed:@"icon_likeon"] forState:UIControlStateSelected];
    [self.view addSubview:praiseBtn];
    [praiseBtn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    _praiseBtn = praiseBtn;
    
    _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _coverBtn.frame = praiseBtn.frame;
    _coverBtn.alpha = 0;
    [_coverBtn setImage:[UIImage imageNamed:@"big"] forState:UIControlStateSelected];
    [_coverBtn setImage:[UIImage imageNamed:@"big"] forState:UIControlStateNormal];
    [self.view insertSubview:_coverBtn belowSubview:praiseBtn];
    
    _cancelPraiseImg = [[UIImageView alloc]initWithFrame:CGRectMake(80, 150, praiseBtnWH*2, praiseBtnWH*2*toBrokenHeartWH)];
    _cancelPraiseImg.hidden = YES;
    _cancelPraiseImg.centerX = _praiseBtn.centerX;
    [self.view addSubview:_cancelPraiseImg];
    
}

-(void)clickTheBtn:(UIButton *)btn{
    [self playAnimation];
    btn.selected = !btn.selected;
}

-(void)playAnimation{
    if (!_praiseBtn.selected) {
        _coverBtn.alpha = 1;
        [UIView animateWithDuration:1.0f animations:^{
            _coverBtn.frame = CGRectMake(80, 100, praiseBtnWH*2, praiseBtnWH*2);
            
            CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
            NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*5];
            NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*5];
            NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*5];
            anima.values = @[value1,value2,value3];
            anima.repeatCount = MAXFLOAT;
            [_coverBtn.layer addAnimation:anima forKey:nil];
            
            _coverBtn.alpha = 0;
            _coverBtn.centerX = _praiseBtn.centerX;
        } completion:^(BOOL finished) {
            _coverBtn.frame = _praiseBtn.frame;
        }];
    } else {
        _cancelPraiseImg.hidden = NO;
        NSArray *imgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_like_broken1"],[UIImage imageNamed:@"icon_like_broken2"],[UIImage imageNamed:@"icon_like_broken3"],[UIImage imageNamed:@"icon_like_broken4"], nil];
        _cancelPraiseImg.animationImages = imgArr;
        _cancelPraiseImg.animationDuration = borkenTime;
        _cancelPraiseImg.animationRepeatCount = 1;
        [_cancelPraiseImg startAnimating];
        
        [UIView animateWithDuration:borkenTime animations:^{
            _cancelPraiseImg.frame = CGRectMake(80, 200, praiseBtnWH*2, praiseBtnWH*2*toBrokenHeartWH);
            _cancelPraiseImg.alpha = 0;
        }completion:^(BOOL finished) {
            _cancelPraiseImg.frame = CGRectMake(80, 150, praiseBtnWH*2, praiseBtnWH*2*toBrokenHeartWH);
            _cancelPraiseImg.alpha = 1;
        }];
    }
}


@end
