//
//  PinchInteractionController.h
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/27.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinchInteractionController : UIPercentDrivenInteractiveTransition

//关联发起转场的控制器
-(void)wireToViewController:(UIViewController *)viewController;


//正在进行转场
@property (nonatomic, assign) BOOL interactionInProgeress;

@end
