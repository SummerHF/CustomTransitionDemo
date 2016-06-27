//
//  SwipeInteractionController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/27.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "SwipeInteractionController.h"

@interface SwipeInteractionController ()
{
    
    BOOL  _shouldCompleteTransition;
    
    UINavigationController * _navigaitonController;
}

@end

@implementation SwipeInteractionController

-(void)wireToViewController:(UIViewController *)viewController
{
    
    _navigaitonController = viewController.navigationController;
    
    [self prepareGestureRecognizerInView:viewController.view];
    
}

/**
 *  为view添加手势
 *
 *  @param view view
 */
-(void)prepareGestureRecognizerInView:(UIView *)view
{
    
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    
    
    [view addGestureRecognizer:pan];
    
}

-(CGFloat)completionSpeed
{
    return 1-self.percentComplete ;
}


/**
 *  处理手势
 *
 *  @param gestureRecognizer pangestureRecognizer
 */
-(void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    //1.The translation of the pan gesture in the coordinate system of the specified view.
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    
    
    //2.
    
    switch (gestureRecognizer.state) {
            
        case UIGestureRecognizerStateBegan:
            //1.标记转场开始
            self.interactionInProgress = YES;
            
            [_navigaitonController popViewControllerAnimated:YES];
            
            break;
            
            case UIGestureRecognizerStateChanged:  {
      

                CGFloat fraction = - (translation.x / 200.0);
                
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                
                
                _shouldCompleteTransition = fraction > 0.5 ;
                
                
                [self updateInteractiveTransition:fraction];
                
            
            break;
        }
            case UIGestureRecognizerStateEnded:
            
            case UIGestureRecognizerStateCancelled:
        {
            /**
             *  需要判断是结束了还是取消了
             */
            
            self.interactionInProgress = NO;
            
            if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
            {
                //只要有一个不成立 那么就是取消了
                
                [self cancelInteractiveTransition];
            }
            
            else
            {
                [self finishInteractiveTransition];
            }
        }
        default:
            break;
    }
    
}

@end
