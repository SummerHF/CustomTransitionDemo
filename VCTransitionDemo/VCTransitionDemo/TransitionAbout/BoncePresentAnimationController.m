//
//  BoncePresentAnimationController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "BoncePresentAnimationController.h"

@implementation BoncePresentAnimationController



// This method specifies the length of the transition animation.
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    return  0.5;
    
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    
    /**1.从当前上下文中获得相应的状态*/
    
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    /**2.获得容器视图*/
    UIView * containerView = [transitionContext containerView];
 
    
    /**3.设置初始状态*/
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    toViewController.view.frame = CGRectOffset(screenBounds, 0, screenBounds.size.height);
    
    
    /**4.添加视图*/
    
    [containerView addSubview:toViewController.view];
    
    /**5.动画*/
    NSTimeInterval  duration = [self transitionDuration:transitionContext];
    
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
       
        fromViewController.view.alpha = 0.5;
        
        toViewController.view.frame = finalFrame;
        
    } completion:^(BOOL finished) {
        
        fromViewController.view.alpha = 1;
        
        // Inform the transition context when the animation completes. The framework then ensures the final state is consistent and removes the from- view from the container.
        [transitionContext completeTransition:YES];
        
    }];
    
}

@end
