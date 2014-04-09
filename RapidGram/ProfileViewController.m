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
    [query whereKey:@"User" equalTo:[[PFUser currentUser] objectId]];
    self.profilePhotos = [NSArray new];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        self.profilePhotos = [query findObjects];
    });

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileCollectionCell* cell = (ProfileCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCellReuseID" forIndexPath:indexPath];
    
    return nil;
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
