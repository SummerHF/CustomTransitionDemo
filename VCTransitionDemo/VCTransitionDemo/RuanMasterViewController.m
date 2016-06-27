//
//  RuanMasterViewController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//


/**modal相关*/
#import "RuanMasterViewController.h"
#import "ShrinkDismissAnimationController.h"
#import "BoncePresentAnimationController.h"

/**push相关*/
#import "FlipAnimatorController.h"

/**interaction相关*/
#import "SwipeInteractionController.h"


#import "PinchInteractionController.h"


#import "RuanDetailViewController.h"

#import "CatModel.h"

#import "AppDelegate.h"


@interface RuanMasterViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

{
    /**modal相关*/
    BoncePresentAnimationController * _bouncePresentAnimationController;
    ShrinkDismissAnimationController * _shrinkDismissAnimatonController;
    
    
    /**push相关*/
    
    FlipAnimatorController * _flipAnimatorController;
    
    
    /**interaction相关--pop相关*/
    SwipeInteractionController * _swipeInteractionController;
    
    /**interaction相关--dismiss相关*/
    PinchInteractionController * _pinchInteractionController;
}

@end

@implementation RuanMasterViewController


/**从storyBoard加载*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        //此处设置背景颜色 程序奔溃---
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background-MidLayer"]];
        
        /**1.确保负责专场的控制器能够被创建当MasterViewController从storyboard加载完毕后*/
        
        
        _bouncePresentAnimationController = [[BoncePresentAnimationController alloc] init];
        _shrinkDismissAnimatonController = [[ShrinkDismissAnimationController alloc] init];
        _flipAnimatorController = [[FlipAnimatorController alloc] init];
        _swipeInteractionController = [[SwipeInteractionController  alloc] init];
        _pinchInteractionController = [[PinchInteractionController alloc] init];
        
        
    };
    
    return self;
    
}

/**模型数组*/
-(NSArray *)catsModel
{
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).catsModelArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cat"]];
 
    self.navigationController.delegate = self;
}



#pragma mark - UIViewControllerTransitioningDelegate(Modal相关)

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    //1.this method simply returns your custom animation controller instance. If you had multiple view controllers wired up, you could also check the view controller presented to switch between different custom animations.
    return _bouncePresentAnimationController;
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _shrinkDismissAnimatonController;
}



//dismiss的交互

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _pinchInteractionController.interactionInProgeress ? _pinchInteractionController: nil;
}


#pragma mark - UINavigationControllerDelegate(push相关)


-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC

{
    _flipAnimatorController.reverse = operation == UINavigationControllerOperationPop;
    
    
    //添加交互
    if (operation == UINavigationControllerOperationPush) {
        
        [_swipeInteractionController wireToViewController:toVC];
    }
    
    return _flipAnimatorController;
}



-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return _swipeInteractionController.interactionInProgress ? _swipeInteractionController : nil;
}






#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self catsModel].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //A UITableViewCell object with the associated reuse identifier. This method always returns a valid cell
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    CatModel * model = [self catsModel][indexPath.row];
    
    cell.textLabel.text = model.title;

    return cell;
}


#pragma mark - 准备转场

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        
        CatModel * model = [self catsModel][indexPath.row];
        
        ((RuanDetailViewController *) segue.destinationViewController).catModel = model;
    
    }
    
    
    if ([segue.identifier isEqualToString:@"showAbout"]) {
        
        UIViewController * toViewController = segue.destinationViewController;
        
        [_pinchInteractionController wireToViewController:toViewController];
        
        toViewController.transitioningDelegate = self;
        
    }
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
