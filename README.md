-----------------------------------

# MyZone 
* [My blog](http://summerhf.github.io/)
* [My github url](https://github.com/SummerHF)
* [My csdn url ](http://blog.csdn.net/zhuhaifei391565521)

-----------------------------------
> 先看效果图

![效果图.gif](http://upload-images.jianshu.io/upload_images/1622863-27afcd01b193437e.gif?imageMogr2/auto-orient/strip)
-----------------------------------
> 你可以从这篇文章中学到:

* modal相关
    * 如何创建一个自定义的`modal`转场
    * 如何创建一个自定义的`dismiss`转场
    * 如何创建一个自定义的可交互的`dismiss`转场
* push && pop 相关
    * 如何创建一个自定义的`push`转场
    * 如何创建一个自定义的`pop`转场
    * 如何创建一个自定义的可交互的`pop`转场
-----------------------------------

> 如果你想实现更多的转场效果,可以深入研究下[facebook 的 pop开源框架,大有裨益](https://github.com/facebook/pop.git)

-----------------------------------
> 项目目录结构如下-转场相关:

![转场相关的类.png](http://upload-images.jianshu.io/upload_images/1622863-e8c31c7154ba83b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
-----------------------------------

限于篇幅的缘故,这里着重介绍下如何自定义一个`modal`的转场

##创建一个自定义的`modal`转场

####实现自定义的转场,一般遵循三个步骤

> 1.首先创建一个专门负责动画的控制器 `animation controller`，此控制器遵循`
UIViewControllerAnimatedTransitioning protocol`.该控制器负责转场动画的实现.

该例中具体代码如下:

```objc
#import <UIKit/UIKit.h>

@interface BoncePresentAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

@end
```

实现协议中两个非常重要的方法
```objc

//1.该方法指定动画时长
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext

```

```objc
//2.该方法指定转场动画的具体实现
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
```
------------------------------------
结合到具体实例代码如下

```objc
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
```
>2.在modal出目标控制器之前，指定目标控制器的转场代理，并且遵循`UIViewControllerTransitioningDelegate`协议

本例中代码如下

```objc
if ([segue.identifier isEqualToString:@"showAbout"]) {
        
        UIViewController * toViewController = segue.destinationViewController;
        
        [_pinchInteractionController wireToViewController:toViewController];
        
        toViewController.transitioningDelegate = self;
        
    }
   
```

3.在代理方法中，返回转场动画控制器

```objc

#pragma mark - UIViewControllerTransitioningDelegate(Modal相关)

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    //1.this method simply returns your custom animation controller instance. If you had multiple view controllers wired up, you could also check the view controller presented to switch between different custom animations.
    return _bouncePresentAnimationController;
    
}
```
#### notice

> 下图可能更清晰的描述上文所述

![流程 2016-06-28 上午12.41.26.png](http://upload-images.jianshu.io/upload_images/1622863-21a593668a96cc6e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 首先不管你是通过代码还是StoryBoard来创建一个实例,并且进行`push/pop/modal`操作，其运行流程一般如下

  * 系统框架会首先查看这个目标控制器,其是否设置了转场代理,并遵循相应的协议.如果没有,则会使用默认的转场样式.

 *  如果有,那么系统就会调用协议中的方法，返回一个专门的转场控制器,该控制器负责转场时相关的动画以及逻辑.如果未返回,依旧使用默认的转场样式

  *  如果返回了转场控制器,那么就会执行`UIViewControllerAnimatedTransitioning`协议中的方法**因为该控制器遵循这个协议（如图）**

>综上所述，一个简单的自定义`modal`专场基本实现






