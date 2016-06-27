//
//  RuanDetailViewController.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "RuanDetailViewController.h"
#import "CatModel.h"

@interface RuanDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *catImage;

@property (weak, nonatomic) IBOutlet UILabel *catContent;



@end

@implementation RuanDetailViewController

/**先创建 在准备转场*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.catImage.image = [UIImage imageNamed:self.catModel.imageName];
    
    
    self.catContent.text = self.catModel.attribute;
    
    self.navigationItem.title = self.catModel.title;
    
    
    // Do any additional setup after loading the view.
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
