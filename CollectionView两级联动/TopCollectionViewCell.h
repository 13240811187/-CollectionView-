//
//  TopCollectionViewCell.h
//  Linkage
//
//  Created by 优站创意 on 2018/5/3.
//  Copyright © 2018年 LeeJay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionCategoryModel;
@interface TopCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic,strong)CollectionCategoryModel * Model;

@end
