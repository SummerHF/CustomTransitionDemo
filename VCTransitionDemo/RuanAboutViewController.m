//
//  RuanAboutViewController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "RuanAboutViewController.h"

@interface RuanAboutViewController ()

@end

@implementation RuanAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)doneBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
