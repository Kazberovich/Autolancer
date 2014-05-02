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
@synthesize mainFormsView = _mainFormsView;
@synthesize additionalFormsView = _additionalFormsView;
@synthesize previousFormButton = _previousFormButton;
@synthesize nextFormButton = _nextFormButton;

- (void)dealloc
{
    [_nextFormButton release];
    [_previousFormButton release];
    [_mainFormsView release];
    [_additionalFormsView release];
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
    frameRect.size.height = 100;
    _offerDescription.frame = frameRect;
    [_additionalFormsView setHidden:YES];
    [_previousFormButton setHidden:YES];
    
    _offerEmail.textField.placeholder = @"Email";
    [_offerEmail setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        if (text.length < 8) {
            field.alertView.title = @"Password is too short";
            return NO;
        } else {
            return YES;
        }
    }];
    
}

- (IBAction)completeOffer:(id)sender
{
    [_nextFormButton setHidden:YES];
    [_previousFormButton setHidden:NO];
    [_mainFormsView setHidden:YES];
    [_additionalFormsView setHidden:NO];
}

- (IBAction)goToPreviousForm:(id)sender
{
    [_nextFormButton setHidden:NO];
    [_previousFormButton setHidden:YES];
    [_additionalFormsView setHidden:YES];
    [_mainFormsView setHidden:NO];
}

@end
