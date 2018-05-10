//
//  CategoryModel.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "CollectionCategoryModel.h"

@implementation CollectionCategoryModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"subcategories": [SubCategoryModel class]};
}

@end

@implementation SubCategoryModel

@end
