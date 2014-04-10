//
//  HomeViewController.m
//  RapidGram
//
//  Created by Steve Toosevich on 4/8/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import "HomeViewController.h"
#import "MyTableViewCel.h"
#import <Parse/Parse.h>


@interface HomeViewController ()
{
    int catPicCount;
    NSMutableArray* catPics;
    NSMutableArray* users;
}
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@end


@implementation HomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError* error = [NSError new];
    [self objectsDidLoad:*&error];
//    UIImage* image = [UIImage imageNamed:@"wheatly_120x120.png"];
//    NSData* data = UIImagePNGRepresentation(image);
//    PFFile* profilePic = [PFFile fileWithData:data];
//    [[PFUser currentUser] setObject:profilePic forKey:@"profilePhoto"];
//    [[PFUser currentUser] saveInBackground];

    NSLog(@"%@", [PFUser currentUser]);
    
}

-(PFQuery *)queryForTable{
    PFQuery* query = [PFQuery queryWithClassName:@"Kitten"];
    [query orderByDescending:@"createdAt"];
    return query;
    
}


-(PFTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object;
{
    MyTableViewCel *cell = (MyTableViewCel*)[tableView dequeueReusableCellWithIdentifier:@"myCellReuseID"];
    
    
    
    PFUser* tempUser = [object objectForKey:@"user"];
    [tempUser fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
       cell.myTextField.text = tempUser.username;
    }];
    cell.myImageView.file = [object objectForKey:@"image"];
    [cell.myImageView loadInBackground];
    if ([object objectForKey:@"Hates"] == NULL) {
        cell.hateNumber.text = @"0";
    }
    else{
    cell.hateNumber.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"Hates"]];
    }
    return cell;

}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender
{
    int width = 270 + arc4random()%100;
    int height = 270 + arc4random()%100;
    NSString *urlString = [NSString stringWithFormat:@"http://placekitten.com/%d/%d", width, height];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    PFObject *object = [PFObject objectWithClassName:@"Kitten"];
    PFFile *file = [PFFile fileWithData:data];
    [object setObject:file forKey:@"image"];
    //[object setObject:hate forKey:@"Hates"];
    [object setObject:[PFUser currentUser] forKey:@"user"];
    [object saveInBackground];
}

- (IBAction)onHateButtonPressed:(id)sender {
    
    MyTableViewCel* cell = (MyTableViewCel*)[[[sender superview] superview] superview];
    NSIndexPath* hatedPic = [self.myTableView indexPathForCell:cell];
    
    PFObject* hatedPhoto = [catPics objectAtIndex:hatedPic.row];
    NSNumber *hateCount = (NSNumber*)[hatedPhoto objectForKey:@"Hates"];
    
    int value = [hateCount intValue];
    hateCount = [NSNumber numberWithInt:value + 1];
    
//    hateCount + 1;
    [hatedPhoto setObject:hateCount forKey:@"Hates"];
    [hatedPhoto saveInBackground];
    [self.myTableView reloadData];
    NSLog(@"%@", hateCount);
    NSLog(@"%@", [hatedPhoto objectForKey:@"Hates"]);
    
    NSLog(@"%@", [[[[sender superview] superview] superview] class]);
    
}


@end
