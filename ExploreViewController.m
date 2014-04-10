//
//  ExploreViewController.m
//  RapidGram
//
//  Created by Steve Toosevich on 4/7/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import "ExploreViewController.h"
#import "Parse/Parse.h"
#import "ProfileCollectionCell.h"

@interface ExploreViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *myCollectionFlowLayout;
@property NSArray* otherProfilesPhotos;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self load:@""];

}

-(void)load:(NSString*)string{
    if ([string isEqualToString:@""]) {
        PFQuery* query = [PFQuery queryWithClassName:@"Kitten"];
        [query whereKey:@"user" notEqualTo:[PFUser currentUser]];
        [query orderByDescending:@"createdAt"];
        self.myCollectionFlowLayout.itemSize = CGSizeMake(99, 99);
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_async(queue, ^{
            self.otherProfilesPhotos = [query findObjects];
            [self.myCollectionView reloadData];
        
        });
    }
    else{
        PFQuery* query = [PFQuery queryWithClassName:@"Kitten"];
        PFQuery* usersQuery = [PFUser query];
        [usersQuery whereKey:@"username" matchesRegex:string modifiers:@"i"];
        [query whereKey:@"user" matchesKey:@"objectId" inQuery:usersQuery];
        self.otherProfilesPhotos = [query findObjects];
        [self.myCollectionView reloadData];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    [self load:self.mySearchBar.text];
    NSLog(@"hey");
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.otherProfilesPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCollectionCell* cell = (ProfileCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"OtherProfilePhotosReuseCellID" forIndexPath:indexPath];
    if (self.otherProfilesPhotos.count != 0) {
        [[[self.otherProfilesPhotos objectAtIndex:indexPath.row] objectForKey:@"image"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.photo.image = [UIImage imageWithData:data];
            }
        }];
    }
    return cell;
}

@end
