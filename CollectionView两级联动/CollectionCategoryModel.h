//
//  CategoryModel.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface CollectionCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy) NSMutableArray * subcategories;

@end

@interface SubCategoryModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end
