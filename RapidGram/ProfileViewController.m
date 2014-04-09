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


@interface ProfileViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property NSArray* profilePhotos;

@end

@implementation ProfileViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery* query = [PFQuery queryWithClassName:@"Kitten"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    //self.profilePhotos = [NSArray new];

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
       // NSLog(@"%lu", (unsigned long)self.profilePhotos.count);
        self.profilePhotos = [query findObjects];
        [self.myCollectionView reloadData];

    });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                // image can now be set on a UIImageView
            }
        }];
    }
    //cell.backgroundColor = [UIColor whiteColor];
    return cell;
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
