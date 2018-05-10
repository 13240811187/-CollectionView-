//
//  ViewController.m
//  CollectionView两级联动
//
//  Created by 优站创意 on 2018/5/3.
//  Copyright © 2018年 优站创意. All rights reserved.
//

#import "ViewController.h"

#import "CollectionCategoryModel.h"
#import "Header.h"
#import "TopCollectionViewCell.h"
#import "CollectionViewHeaderView.h"
#import "BottomCollectionViewCell.h"
#import "LJCollectionViewFlowLayout.h"
#import "CollectionReusableFooterView.h"
static float kLeftTableViewWidth = 80.f;
static float kCollectionViewMargin = 3.f;

@interface ViewController ()<UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *TopCollectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;
@property (nonatomic, strong) LJCollectionViewFlowLayout *flowLayout;
@end

static NSString * const TopReuseIdentifier = @"TOPCollectionView";
static NSString * const BottomReuseIdentifier = @"BottomCollectionView";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.TopCollectionView];
    [self.view addSubview:self.collectionView];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    
     NSArray * dataArray = [CollectionCategoryModel mj_objectArrayWithKeyValuesArray:categories];
    
    
    for (int i = 0;i<dataArray.count;i++) {
        
        CollectionCategoryModel * Model = dataArray[i];
        
        if (i == 0) {
            
           Model.isSelected = YES;
            
        }else{
            
        Model.isSelected = NO;
        
        }
        
        
        [self.dataSource addObject:Model];
        
        NSMutableArray * datas = [SubCategoryModel mj_objectArrayWithKeyValuesArray:Model.subcategories];
        
        [self.collectionDatas addObject:datas];
        
    }
    
  
    
   
    
    [self.TopCollectionView reloadData];
    [self.collectionView reloadData];
    
   
//    [self.TopCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    
    
    
    
    
}


- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)collectionDatas
{
    if (!_collectionDatas)
    {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}



- (LJCollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout)
    {
        _flowLayout = [[LJCollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 2;
        _flowLayout.minimumLineSpacing = 2;
    }
    return _flowLayout;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView)

    {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
       
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,55,SCREEN_WIDTH ,SCREEN_HEIGHT-55) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
       // 注册cell
        [_collectionView registerClass:[BottomCollectionViewCell class] forCellWithReuseIdentifier:BottomReuseIdentifier];
        //注册分区头标题
        [_collectionView registerClass:[CollectionViewHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"CollectionViewHeaderView"];
        
        //最后一个加上Footerview bura
        [_collectionView registerClass:[CollectionReusableFooterView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"CollectionReusableFooterView"];
        
        
        
    }
    return _collectionView;
}




- (UICollectionView *)TopCollectionView{
    
    if (!_TopCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //layout.itemSize = CGSizeMake(80,55);
        // 设置最小行间距
        //layout.minimumLineSpacing = 0;
        // 设置垂直间距
        //layout.minimumInteritemSpacing = 0;
        //layout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
        _TopCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,55) collectionViewLayout:layout];
        _TopCollectionView.showsVerticalScrollIndicator = NO;
        _TopCollectionView.showsHorizontalScrollIndicator = NO;
        _TopCollectionView.delegate = self;
        _TopCollectionView.dataSource = self;
        _TopCollectionView.backgroundColor = [UIColor whiteColor];
        // 注册
        [_TopCollectionView registerClass:[TopCollectionViewCell class] forCellWithReuseIdentifier:TopReuseIdentifier];
        
    }
    
    return _TopCollectionView;
    
    
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    if (self.collectionView == collectionView) {
        return self.dataSource.count;
        
    }else{
        
        return 1;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (self.collectionView == collectionView) {
        CollectionCategoryModel *model = self.dataSource[section];
        return model.subcategories.count;
        
    }else{
        
        return self.dataSource.count;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        if (_collectionView == collectionView) {
            BottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BottomReuseIdentifier forIndexPath:indexPath];
            SubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
            cell.model = model;
    
             return cell;
    
        }else{
    
    TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TopReuseIdentifier forIndexPath:indexPath];
    
    CollectionCategoryModel *model = self.dataSource[indexPath.row];
    cell.Model = model;
   
    return cell;
    
    }
    
    
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(collectionView == self.TopCollectionView){
        
        _selectIndex = indexPath.row;
        
        // http://stackoverflow.com/questions/22100227/scroll-uicollectionview-to-section-header-view
        // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
         [self scrollToTopOfSection:_selectIndex animated:YES];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        
        
        for (int i = 0; i<self.dataSource.count;i++ ) {
            
            CollectionCategoryModel * Model = self.dataSource[i];
            
            if (indexPath.row == i) {
                Model.isSelected = YES;
            }else{
                
                Model.isSelected = NO;
            }
            
        }
        
        [self.TopCollectionView reloadData];
       
        
    }
    
    
}


- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    
    CGRect headerRect = [self frameForHeaderForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:animated];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}



- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionView == collectionView) {
        return CGSizeMake((SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3,
                          (SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3 + 30);
    }else{
        
        
        return CGSizeMake(80, 55);
    }

    
}
    
    
    
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
viewForSupplementaryElementOfKind:(NSString *)kind
atIndexPath:(NSIndexPath *)indexPath
    {
        NSString *reuseIdentifier;
        if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        { // header
            reuseIdentifier = @"CollectionViewHeaderView";
    
        CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:reuseIdentifier
                                                                                   forIndexPath:indexPath];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            CollectionCategoryModel *model = self.dataSource[indexPath.section];
            view.title.text = model.name;
        }
        return view;
        
        }else{
            
            if (indexPath.section == self.dataSource.count -1 && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
                
                 NSString * FooterReuseIdentifier;
                 FooterReuseIdentifier = @"CollectionReusableFooterView";
                CollectionReusableFooterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                    withReuseIdentifier:FooterReuseIdentifier
                                                                                           forIndexPath:indexPath];
                
                return view;

            }
        

        }
        

        return nil;
    }



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.collectionView == collectionView) {
        
        return CGSizeMake(SCREEN_WIDTH, 30);
    }
    
    return CGSizeMake(0, 0);
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == self.dataSource.count -1 && self.collectionView == collectionView) {
        
        return CGSizeMake(SCREEN_WIDTH, 200);
    }
    
    return CGSizeMake(0, 0);
    
}



// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    //  当前CollectionView滚动的方向向下，CollectionView是用户collectionView.dragging拖拽 而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是 点击collectionView而滚动 的collectionView.decelerating）
    
    if (!_isScrollDown && (collectionView.dragging|| collectionView.decelerating))
    {
//
//        if (self.dataSource.count-3 == indexPath.section) {
//
//            [self selectRowAtIndexPath:indexPath.section + 1];
//
//        }else{

        
           [self selectRowAtIndexPath:indexPath.section];
            
            
//      }
        
       NSLog(@"111111=====%ld",indexPath.section);
       
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向下，CollectionView是用户collectionView.dragging拖拽 而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是 点击collectionView而滚动 的collectionView.decelerating）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
     
//        if (self.dataSource.count-3 == indexPath.section) {
//
//            [self selectRowAtIndexPath:indexPath.section + 2];
//
//        }else{
//
        
        [self selectRowAtIndexPath:indexPath.section + 1];
 
        
        //}
        
        NSLog(@"222222=====%ld",indexPath.section);
       
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.TopCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    
    for (int i = 0; i<self.dataSource.count; i++) {
        
        
        CollectionCategoryModel * Model = self.dataSource[i];
        
        if (index == i) {
            
            Model.isSelected = YES;
            
        }else{
            
            Model.isSelected = NO;
        }
        
    }
    
    
    [self.TopCollectionView reloadData];
    
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.collectionView == scrollView) {
        
        static float lastOffsetY = 0;
        
        if (self.collectionView == scrollView)
        {
            _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
            lastOffsetY = scrollView.contentOffset.y;
        }
    }

   
}










//实现scrollView代理
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    //全局变量记录滑动前的contentOffset
//    lastContentOffset = scrollView.contentOffset.y;//判断上下滑动时
//
//    //    lastContentOffset = scrollView.contentOffset.x;//判断左右滑动时
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.y < lastContentOffset ){
//        //向上
//        NSLog(@"上滑");
//    } else if (scrollView.contentOffset.y > lastContentOffset ){
//        //向下
//        NSLog(@"下滑");
//    }

    //判断左右滑动时
    //    if (scrollView.contentOffset.x < lastContentOffset ){
    //        //向右
    //        NSLog(@"左滑");
    //    } else if (scrollView. contentOffset.x > lastContentOffset ){
    //        //向左
    //        NSLog(@"右滑");
    //    }
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
