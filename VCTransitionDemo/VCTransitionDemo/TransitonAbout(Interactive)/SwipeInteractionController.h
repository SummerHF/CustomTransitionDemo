//
//  SwipeInteractionController.h
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/27.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeInteractionController : UIPercentDrivenInteractiveTransition



-(void)wireToViewController:(UIViewController *)viewController;

@property (nonatomic, assign) BOOL interactionInProgress;

@end
