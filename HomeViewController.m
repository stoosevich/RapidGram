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


@end

@implementation HomeViewController



- (void)viewDidLoad
{
    self.parseClassName = @"Kitten";
    [super viewDidLoad];
    [PFUser enableAutomaticUser];
    
}


-(PFTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object;
{
    MyTableViewCel *cell = (MyTableViewCel*)[super tableView:tableView cellForRowAtIndexPath:indexPath object:object];
    cell.imageView.file = [object objectForKey:@"image"];
//    [cell.imageView addSubview:cell.myView];
    [cell.imageView loadInBackground];
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
    [object setObject:[PFUser currentUser] forKey:@"user"];
    [object saveInBackground];
}



@end
