//
//  HSCalendarViewFlowLayout.m
//  签到日历
//
//  Created by 石冬冬 on 16/12/21.
//  Copyright © 2016年 sdd. All rights reserved.
//

#import "HSCalendarViewFlowLayout.h"

@implementation HSCalendarViewFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    CGFloat width = [UIScreen mainScreen].bounds.size.width/7;
    CGFloat height = width;
    self.itemSize = CGSizeMake(width, height);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView.bounces = false;
    self.collectionView.pagingEnabled = false;
    self.collectionView.showsVerticalScrollIndicator = false;
    self.collectionView.showsHorizontalScrollIndicator = false;

}
@end
