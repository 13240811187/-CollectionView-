//
//  BottomCollectionViewCell.h
//  CollectionView两级联动
//
//  Created by 优站创意 on 2018/5/3.
//  Copyright © 2018年 优站创意. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubCategoryModel;
@interface BottomCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) SubCategoryModel *model;

@end
