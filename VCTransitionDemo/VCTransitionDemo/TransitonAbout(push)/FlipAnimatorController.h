//
//  FlipAnimatorController.h
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipAnimatorController : NSObject<UIViewControllerAnimatedTransitioning>

/**设置旋转的方向*/

@property (nonatomic, assign) BOOL reverse;



@end
