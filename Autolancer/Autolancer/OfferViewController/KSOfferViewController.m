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

@synthesize scrollView = _scrollView;
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_scrollView release];
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
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    
	self.navigationItem.title = @"Предложение";
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:nil];
    NSArray *actionButtonItems = @[shareItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    CGRect frameRect = _offerDescription.frame;
    frameRect.size.height = 100;
    _offerDescription.frame = frameRect;
    [_additionalFormsView setHidden:YES];
    [_previousFormButton setHidden:YES];
    
    
    
    
    self.offerEmail.textField.placeholder = @"Email";
    
    [self.offerEmail setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:text]) {
            field.alertView.title = @"Invalid email address";
            return NO;
        } else {
            return YES;
        }
    }];
    self.offerEmail.delegate = self;
    
    self.offerUserName.textField.placeholder = @"Ваше имя";
    [self.offerUserName setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        if (text.length < 2) {
            field.alertView.title = @"Username is too short";
            return NO;
        } else {
            return YES;
        }
    }];
    self.offerUserName.delegate = self;
    
    self.offerMobilePhone.textField.placeholder = @"+3753311111111";
    [self.offerMobilePhone setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        NSString *phoneRegex2 = @"^((10|0|((\\+|00)\\d{1,2}))[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{11,12}$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
        if (![emailTest evaluateWithObject:text]) {
            field.alertView.title = @"Invalid email address";
            return NO;
        } else {
            return YES;
        }
        
        return NO;
    }];
    self.offerMobilePhone.delegate = self;
    
    
    self.offerAdditionalPhone.textField.placeholder = @"+3753311111111";
    [self.offerAdditionalPhone setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        NSString *phoneRegex2 = @"^((10|0|((\\+|00)\\d{1,2}))[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{11,12}$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
        if (![emailTest evaluateWithObject:text]) {
            field.alertView.title = @"Invalid email address";
            return NO;
        } else {
            return YES;
        }
        
        return NO;
    }];
    self.offerAdditionalPhone.delegate = self;
    
    self.offerPrice.textField.placeholder = @"Цена (у.е.)";
    [self.offerPrice setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        NSString *phoneRegex2 = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
        if (![emailTest evaluateWithObject:text]) {
            field.alertView.title = @"Invalid price";
            return NO;
        } else {
            return YES;
        }
        
        return NO;
    }];
    self.offerPrice.delegate = self;
}

- (void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, _mainFormsView.frame.origin) )
    {
        CGPoint scrollPoint = CGPointMake(0.0, _mainFormsView.frame.origin.y - (keyboardSize.height));
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    [_scrollView setScrollEnabled:YES];
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
