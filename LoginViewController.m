//
//  LoginViewController.m
//  RapidGram
//
//  Created by Steve Toosevich on 4/10/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [PFUser logOut];
    self.passwordTextField.secureTextEntry = YES;

}

-(void)viewDidAppear:(BOOL)animated{
    
    if ([PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"LoggedInSegue" sender:self];
    }
    
}

- (IBAction)didPressLoginButton:(id)sender
{
    [PFUser logInWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
    if ([PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"LoggedInSegue" sender:self];
    }
}


@end
