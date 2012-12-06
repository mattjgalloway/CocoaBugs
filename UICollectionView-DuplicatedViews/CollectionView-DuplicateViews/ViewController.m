//
//  ViewController.m
//  CollectionViewMissingCells
//
//  Created by Matt Galloway on 03/12/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "ViewController.h"
#import "BuggyLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    BuggyLayout *_layout;
    UICollectionView *_collectionView;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    frame.origin = CGPointZero;
    
    _layout = [[BuggyLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"sup" withReuseIdentifier:@"sup"];
    
    self.view = _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [(BuggyLayout*)collectionView.collectionViewLayout numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sup" forIndexPath:indexPath];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_collectionView performBatchUpdates:^{
        _layout.scrolling = YES;
    } completion:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [_collectionView performBatchUpdates:^{
            _layout.scrolling = NO;
        } completion:nil];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_collectionView performBatchUpdates:^{
        _layout.scrolling = NO;
    } completion:nil];
}

@end
