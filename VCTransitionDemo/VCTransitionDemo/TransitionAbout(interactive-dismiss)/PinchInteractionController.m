//
//  PinchInteractionController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/27.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "PinchInteractionController.h"

@interface PinchInteractionController ()
{
  
    BOOL  _shouldCompleteTransition;
    
    UIViewController * _viewController;
    
    //开始的缩放比例
    CGFloat  _startScale;
    
}
@end

@implementation PinchInteractionController

-(void)wireToViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    
    
    [self prepareGestureRecognizeInView:viewController.view];
    
}

-(void)prepareGestureRecognizeInView:(UIView *)view
{
    UIPinchGestureRecognizer * gestureRecognize = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    
    [view addGestureRecognizer:gestureRecognize];
}


//The speed of the transition animation.

-(CGFloat)completionSpeed
{
    return 1-self.percentComplete;
}

-(void)handleGesture:(UIPinchGestureRecognizer *)pinchGesture
{
    switch (pinchGesture.state) {
            
        case UIGestureRecognizerStateBegan:
            
            _startScale = pinchGesture.scale;
            
            /**1.开始动画*/
            self.interactionInProgeress = YES;
            
            [_viewController dismissViewControllerAnimated:YES completion:nil];
            
            break;
            
        case UIGestureRecognizerStateChanged:{
            
            CGFloat fraction = 1.0 - pinchGesture.scale / _startScale;
            
            //是否结束
            
            _shouldCompleteTransition = (fraction > 0.5);
            
            [self updateInteractiveTransition:fraction];
            
            break;
        }
            
        case UIGestureRecognizerStateEnded:
            
        case  UIGestureRecognizerStateCancelled:{
            
            
            self.interactionInProgeress = NO;
            
            if (!_shouldCompleteTransition || pinchGesture.state == UIGestureRecognizerStateCancelled) {
                
                [self cancelInteractiveTransition];
                
            }
            else
            {
                [self finishInteractiveTransition];
         
            }
            
            break;
        }
        default:
            break;
    }
}

@end
