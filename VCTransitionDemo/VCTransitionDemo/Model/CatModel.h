//
//  CatModel.h
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatModel : NSObject

/**标题*/
@property(nonatomic,strong) NSString * title;

/**描述*/
@property(nonatomic,strong) NSString * attribute;

/**图片*/
@property(nonatomic,strong) NSString * imageName;

/**
 *  工厂方法生成类
 *
 *  @param title     标题
 *  @param attribute 描述
 *  @param imageName 图片名称
 *
 *  @return class
 */
+(CatModel *)catWithTitle:(NSString * )title withAttribute:(NSString *)attribute withImageName:(NSString *)imageName;

@end
