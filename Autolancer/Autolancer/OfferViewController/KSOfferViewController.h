//
//  KSOfferViewController.h
//  Autolancer
//
//  Created by mac-214 on 28.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BZGFormField/BZGFormField.h>

@protocol BZGFormFieldDelegate;

@interface KSOfferViewController : UIViewController <BZGFormFieldDelegate, UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *offerDescription;
@property (nonatomic, retain) IBOutlet BZGFormField *offerPrice;
@property (nonatomic, retain) IBOutlet BZGFormField *offerMobilePhone;
@property (nonatomic, retain) IBOutlet BZGFormField *offerAdditionalPhone;
@property (nonatomic, retain) IBOutlet BZGFormField *offerSkype;
@property (nonatomic, retain) IBOutlet BZGFormField *offerWebsite;
@property (nonatomic, retain) IBOutlet BZGFormField *offerAddress;
@property (nonatomic, retain) IBOutlet BZGFormField *offerWorkTime;
@property (nonatomic, retain) IBOutlet BZGFormField *offerUserName;
@property (nonatomic, retain) IBOutlet BZGFormField *offerEmail;
@property (nonatomic, retain) IBOutlet UIView *mainFormsView;
@property (nonatomic, retain) IBOutlet UIView *additionalFormsView;
@property (nonatomic, retain) IBOutlet UIButton *previousFormButton;
@property (nonatomic, retain) IBOutlet UIButton *nextFormButton;

- (IBAction)completeOffer:(id)sender;
- (IBAction)goToPreviousForm:(id)sender;

@end
