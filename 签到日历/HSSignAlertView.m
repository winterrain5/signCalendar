//
//  HSSignAlertView.m
//  签到日历
//
//  Created by 石冬冬 on 16/12/22.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import "HSSignAlertView.h"
#import "CSCommonUtils.h"
@interface HSSignAlertView()
@property (assign,nonatomic) SystemSoundID soundID;
@property (nonatomic, strong)CAEmitterLayer * emitterLayer;//粒子动画
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *btn;



@end
@implementation HSSignAlertView

- (instancetype)init {
    if (self = [super init]) {
        
        [self setupUI];
    }
    return self;
}
- (void) setupUI {
    
    [self initMyEmitter];//初始化粒子发射源
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"wingWithCoin"];
    CGSize size = [UIScreen mainScreen].bounds.size;
    imageView.frame = CGRectMake(30, size.height/2 - 75, size.width - 60, 150);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.masksToBounds = YES;
    self.imageView = imageView;
    [self addSubview:imageView];
    
    UIButton *btn = [[UIButton alloc] init];
    self.btn = btn;
    self.btn.frame = CGRectMake(size.width/2, CGRectGetMaxY(self.imageView.frame),0, 35);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:0/255.0 blue:11.0/255.0 alpha:1]];
    [btn setTitle:@"给新版本点个赞呗" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:btn];
}
- (void)startAnimation{
    CABasicAnimation * effectAnimation = [CABasicAnimation animationWithKeyPath:@"emitterCells.zanShape.birthRate"];
    effectAnimation.fromValue = [NSNumber numberWithFloat:30];
    effectAnimation.toValue = [NSNumber numberWithFloat:0];
    effectAnimation.duration = 2.0f;
    effectAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    effectAnimation.delegate = self;
    [self.emitterLayer addAnimation:effectAnimation forKey:@"zanCount"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        //停止播放音效
        AudioServicesDisposeSystemSoundID(self.soundID);
    }
}
//初始化粒子
-(void)initMyEmitter{
    //发射源
    CAEmitterLayer * emitter = [CAEmitterLayer layer];
    emitter.frame = CGRectMake(0, 0, 100, 100);
    [self.layer addSublayer:self.emitterLayer = emitter];
    //发射源形状
    emitter.emitterShape = kCAEmitterLayerCircle;
    //发射模式
    emitter.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    //    emitter.renderMode = kCAEmitterLayerAdditive;
    //发射位置
    emitter.emitterPosition = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    //发射源尺寸大小
    emitter.emitterSize = CGSizeMake(20, 20);
    
    // 从发射源射出的粒子
    
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    cell.name = @"zanShape";
    //粒子要展现的图片
    cell.contents = (__bridge id)[UIImage imageNamed:@"coin1"].CGImage;
    //    cell.contents = (__bridge id)[UIImage imageNamed:@"EffectImage"].CGImage;
    //            cell.contentsRect = CGRectMake(100, 100, 100, 100);
    //粒子透明度在生命周期内的改变速度
    cell.alphaSpeed = -0.5;
    //生命周期
    cell.lifetime = 3.0;
    //粒子产生系数(粒子的速度乘数因子)
    cell.birthRate = 0;
    //粒子速度
    cell.velocity = 300;
    //速度范围
    cell.velocityRange = 100;
    //周围发射角度
    cell.emissionRange = M_PI / 8;
    //发射的z轴方向的角度
    cell.emissionLatitude = -M_PI;
    //x-y平面的发射方向
    cell.emissionLongitude = -M_PI / 2;
    //粒子y方向的加速度分量
    cell.yAcceleration = 250;
    emitter.emitterCells = @[cell];
}
#pragma mark - 播放音效
-(void)playSound{
    self.soundID = [CSCommonUtils creatSoundIDWithSoundName:@"签到金币音效.mp3"];
    [CSCommonUtils playSoundWithSoundID:self.soundID];
}
#pragma mark ----- private method
- (void) showSignAlertView {
    //动画撒金币效果
    [self startAnimation];
    //播放音效
    [self playSound];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.imageView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.imageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.btn.frame = CGRectMake(30, CGRectGetMaxY(self.imageView.frame),self.frame.size.width - 60, 35);
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
- (void) btnClick {
    NSString  * nsStringToOpen = [NSString  stringWithFormat:@"https://www.baidu.com"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
}
@end
