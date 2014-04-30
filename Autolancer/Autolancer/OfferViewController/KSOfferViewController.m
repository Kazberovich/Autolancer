//
//  KSOfferViewController.m
//  Autolancer
//
//  Created by mac-214 on 28.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSOfferViewController.h"

@interface KSOfferViewController ()

@end

@implementation KSOfferViewController

@synthesize offerDescription = _offerDescription;
@synthesize offerPrice = _offerPrice;
@synthesize offerAdditionalPhone = _offerAdditionalPhone;
@synthesize offerAddress = _offerAddress;
@synthesize offerMobilePhone = _offerMobilePhone;
@synthesize offerSkype = _offerSkype;
@synthesize offerWebsite = _offerWebsite;
@synthesize offerWorkTime = _offerWorkTime;
@synthesize offerUserName = _offerUserName;
@synthesize offerEmail = _offerEmail;

- (void)dealloc
{
    [_offerEmail release];
    [_offerUserName release];
    [_offerAddress release];
    [_offerAdditionalPhone release];
    [_offerMobilePhone release];
    [_offerSkype release];
    [_offerWebsite release];
    [_offerWorkTime release];
    [_offerPrice release];
    [_offerDescription release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = @"Предложение к заказу";
    CGRect frameRect = _offerDescription.frame;
    frameRect.size.height = 60;
    _offerDescription.frame = frameRect;
}

- (IBAction)completeOffer:(id)sender
{
  /*  // next step is to implement validateForm
    NSString *errorMessage = [self validateForm];
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return;
    }
    
    //NSDictionary *formValues = @{ @"username" : _offerUserName.text,
    //                              @"email" : _offer.text,
     //                             @"phone" : self.passwordTextField.text};
    // Send the form values to the server here.
   */
}

- (NSString *)validateForm {
    NSString *errorMessage = nil;
    
    NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (!(_offerUserName.text.length >= 1)){
        errorMessage = @"Please enter your name";
    } else if (![emailPredicate evaluateWithObject:_offerEmail.text]){
        errorMessage = @"Please enter a valid email address";
    } else if (! (_offerPrice.text.length >= 1)){
        errorMessage = @"Please enter a valid password";
    }
    
    return errorMessage;
}

@end
