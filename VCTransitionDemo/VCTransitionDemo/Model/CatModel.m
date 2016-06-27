//
//  CatModel.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "CatModel.h"

@implementation CatModel


+(CatModel *)catWithTitle:(NSString *)title withAttribute:(NSString *)attribute withImageName:(NSString *)imageName
{
    CatModel *  cat = [[CatModel alloc] init];
    
    cat.title = title;
    
    cat.attribute = attribute;
    
    cat.imageName = imageName;
    
    return cat;
    
}

@end
