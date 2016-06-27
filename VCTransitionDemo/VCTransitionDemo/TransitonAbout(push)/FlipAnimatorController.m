//
//  FlipAnimatorController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "FlipAnimatorController.h"

@implementation FlipAnimatorController


-(CATransform3D )yRotation:(CGFloat)angle{
 
//    矢量(0,1,0)旋转angle角度
    return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
    
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
     UIView * containerView = [transitionContext containerView];
    
//    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    
//    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * fromView = fromViewController.view;
    
    UIView * toView = toViewController.view;

    [containerView addSubview:toView];
    
    
    //Defines the identity transform matrix used by Core Animation.
    
    ///* The identity transform: [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]. */
    CATransform3D transform = CATransform3DIdentity;
    
    //矩阵赋值
    //struct CATransform3D
//    {
//        CGFloat m11, m12, m13, m14;
//        CGFloat m21, m22, m23, m24;
//        CGFloat m31, m32, m33, m34;
//        CGFloat m41, m42, m43, m44;
//    };
    
    transform.m34 = -0.0001;
  
    //Typically used as
//    * the projection matrix to add perspective and other viewing effects
//    * into the model. Defaults to identity. Animatable
    
    
    [containerView.layer setSublayerTransform:transform];
    
    
    CGRect  initialFrame = [transitionContext initialFrameForViewController:fromViewController];
    
    
    //设置视图大小
    toView.frame = initialFrame;
    fromView.frame = initialFrame;

    //是否是反面
    float factor = self.reverse ? 1.0 : -1.0;
    
    //push操作 y轴方向顺时针旋转90度 这样第一时间是看不到toView的
    toView.layer.transform = [self yRotation:factor  *  -M_PI_2];
    
    //animate

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
        
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
           
            //fromView-----
            
            fromView.layer.transform = [self yRotation:factor * M_PI_2];
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
           
        
            //toVIew复原 在先前顺时针的基础上 逆时针旋转90度 复原
            toView.layer.transform = [self yRotation:0.0];
            
        }];
        

    } completion:^(BOOL finished) {
        
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
    
}

@end
