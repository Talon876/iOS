//
//  HFCollectionViewController.m
//  homework4
//
//  Created by Talon Daniels on 2/18/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

// Good job, 100%.

#import "HFCollectionViewController.h"
#import "HFCustomCell.h"

@interface HFCollectionViewController ()

@end

@implementation HFCollectionViewController

int selectedCells[10];

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for(int i = 0; i < sizeof(selectedCells); i++) {
        selectedCells[i] = -1;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
    
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HFCustomCell *cell = (HFCustomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    int section = indexPath.section;
    int row = indexPath.row;
    
    if (selectedCells[section] == row) { //selected
        [cell select];
    } else {
        [cell deselect];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HFCustomCell *cell = (HFCustomCell *)[collectionView cellForItemAtIndexPath:indexPath];
    int section = indexPath.section;
    int row = indexPath.row;
    
    if (selectedCells[section] != -1) {
        NSIndexPath *oldPath = [NSIndexPath indexPathForItem:selectedCells[section] inSection:section];
        HFCustomCell *oldCell = (HFCustomCell *)[collectionView cellForItemAtIndexPath:oldPath];
        [oldCell deselect];
    }
    
    [cell select];
    selectedCells[section] = row;
}

@end
