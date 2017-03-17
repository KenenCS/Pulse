//
//  ViewController.m
//  Pulse
//
//  Created by kenen on 2017/3/17.
//  Copyright © 2017年 kenen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startAnimation];
}

- (void)startAnimation
{
    CALayer *layer = [[CALayer alloc] init];
    layer.cornerRadius = [UIScreen mainScreen].bounds.size.width/2;
    layer.frame = CGRectMake(0, 0, layer.cornerRadius * 2, layer.cornerRadius * 2);
    layer.position = self.view.layer.position;
    UIColor *color = [UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:1];
    layer.backgroundColor = color.CGColor;
    [self.view.layer addSublayer:layer];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 2;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = 2;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 2;
    opencityAnimation.values = @[@0.8,@0.4,@0];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    
    NSArray *animations = @[scaleAnimation,opencityAnimation];
    _animaTionGroup.animations = animations;
    [layer addAnimation:_animaTionGroup forKey:nil];
    
    [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:1.5];
}

- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
    _disPlayLink.frameInterval = 40;
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)delayAnimation
{
    [self startAnimation];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
