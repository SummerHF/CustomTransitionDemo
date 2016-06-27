//
//  ShrinkDismissAnimationController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "ShrinkDismissAnimationController.h"

@implementation ShrinkDismissAnimationController

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1 ;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    

    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    UIView * containerView  = [transitionContext containerView];
    
    
    toViewController.view.frame = finalFrame;
    toViewController.view.alpha = 0.5;
    
    
    [containerView addSubview:toViewController.view];
    
    //This method moves the specified view to the beginning of the array of views in the subviews property.
    [containerView sendSubviewToBack:toViewController.view];
    
    //warning changing the frame for a view doesn’t affect the view’s children
//You could fix this by using a scale transform on the view; however, this gives you an excuse to try out another new iOS 7 feature: UIView snapshots. Hmm, it’s almost as if the author planned it this way!


    //1.add animate
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    CGRect shrinkFrame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width / 4 , fromViewController.view.frame.size.height / 4);
    
    CGRect fromFinalFrame = CGRectOffset(shrinkFrame, 0, screenBounds.size.height);
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    //2.add keyframe animate
    
//    UIView * intermediateView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
//    
//    intermediateView.frame = fromViewController.view.frame;
//    
//    [containerView addSubview:intermediateView];
//    
//    
//    //移除真正的视图
//    [fromViewController.view removeFromSuperview];
    

    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        //keyframe one
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            
            fromViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
            
            toViewController.view.alpha = 0.5;
            
            
        }];
        
        
        //keyframe two
        
        [UIView  addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            
            fromViewController.view.frame = fromFinalFrame;
            
            toViewController.view.alpha = 1.0;
            
            
        }];
        
        
    } completion:^(BOOL finished) {
        
//        
//        [intermediateView removeFromSuperview];
        
     [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        
    }];
    

}


@end
