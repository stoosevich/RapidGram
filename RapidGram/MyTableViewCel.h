//
//  MyTableViewCel.h
//  RapidGram
//
//  Created by Steve Toosevich on 4/8/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import <Parse/Parse.h>

@interface MyTableViewCel : PFTableViewCell

@property (strong, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet PFImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *hateNumber;

@end
