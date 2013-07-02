//
//  ViewController.m
//  CollectionViewMissingCells
//
//  Created by Matt Galloway on 03/12/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    UICollectionViewFlowLayout *_layout1;
    UICollectionViewFlowLayout *_layout2;
    UICollectionViewFlowLayout *_currentCollectionViewLayout;
    UICollectionView *_collectionView;
}
@end

@implementation ViewController

- (void)_switchLayouts:(id)sender {
    if (_currentCollectionViewLayout == _layout1) {
        _currentCollectionViewLayout = _layout2;
    } else {
        _currentCollectionViewLayout = _layout1;
    }
    _collectionView.collectionViewLayout = _currentCollectionViewLayout;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    frame.origin = CGPointZero;
    
    _layout1 = [[UICollectionViewFlowLayout alloc] init];
    _layout2 = [[UICollectionViewFlowLayout alloc] init];
    _currentCollectionViewLayout = _layout1;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_layout1];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.view = _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Switch" style:UIBarButtonItemStyleBordered target:self action:@selector(_switchLayouts:)];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100.0f, 100.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end
