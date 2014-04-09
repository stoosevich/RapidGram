//
//  CameraViewController.m
//  RapidGram
//
//  Created by Steve Toosevich on 4/7/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Device has no camera"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];

    }
    else
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        picker.mediaTypes = 
        
        [self presentViewController:picker animated:YES completion:NULL];

    }

}

@end
