//
//  ProfileViewController.m
//  RapidGram
//
//  Created by Steve Toosevich on 4/7/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionCell.h"
#import "Parse/Parse.h"


@interface ProfileViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property NSArray* profilePhotos;
@property (weak, nonatomic) IBOutlet UITabBar *profileTabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *thumbNailTabItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *myPicTabItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *mapTabItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *tagsTabItem;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *myCollectionFlowLayout;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery* query = [PFQuery queryWithClassName:@"Kitten"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    self.myCollectionFlowLayout.itemSize = CGSizeMake(99, 99);
//    self.profileImageView.image = [UIImage imageNamed:@"profilePic.png"];
    [[[PFUser currentUser] objectForKey:@"profilePhoto"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.profileImageView.image = [UIImage imageWithData:data];

    }];



    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        self.profilePhotos = [query findObjects];
        [self.myCollectionView reloadData];

    });
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.profilePhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCollectionCell* cell = (ProfileCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCellReuseID" forIndexPath:indexPath];
    if (self.profilePhotos.count != 0) {
        [[[self.profilePhotos objectAtIndex:indexPath.row] objectForKey:@"image"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.photo.image = [UIImage imageWithData:data];
            }
        }];
    }
    return cell;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item == self.thumbNailTabItem) {
        self.myCollectionFlowLayout.itemSize = CGSizeMake(99, 99);
        [self.myCollectionView reloadData];

    }
    else if(item == self.myPicTabItem){
        self.myCollectionFlowLayout.itemSize = CGSizeMake(319, 320);
        [self.myCollectionView reloadData];


    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
