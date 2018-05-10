//
//  TopCollectionViewCell.m
//  Linkage
//
//  Created by 优站创意 on 2018/5/3.
//  Copyright © 2018年 LeeJay. All rights reserved.
//

#import "TopCollectionViewCell.h"
#import "Header.h"
#import "CollectionCategoryModel.h"
@interface TopCollectionViewCell ()
@property (nonatomic, strong) UIView *yellowView;
@end

@implementation TopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,80, 50)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = [UIColor lightGrayColor];
        self.name.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.name];
        
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(0,50,80,5)];
        self.yellowView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.yellowView];
        
        
        
    }
    
    return self;
    
}




- (void)setModel:(CollectionCategoryModel *)Model{
    
    self.name.text = Model.name;
    
    if (Model.isSelected == YES) {
        
         self.yellowView.hidden = NO;
        self.contentView.backgroundColor = [UIColor yellowColor];
        
        self.name.textColor = [UIColor redColor];
        
    }else{
        
         self.yellowView.hidden = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.name.textColor = [UIColor lightGrayColor];
        
    }
    
    
}

//UICollectionView 的选中和取消
//- (void)setSelected:(BOOL)selected{
//
//      [super setSelected:selected];
//
//    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor yellowColor];
//    self.highlighted = selected;
//    self.name.highlighted = selected;
//
//    if (selected) {
//        //选中时
//
//        self.yellowView.hidden = NO;
//
//      }else{
//        //非选中
//
//         self.yellowView.hidden = YES;
//    }
//
//}








@end
