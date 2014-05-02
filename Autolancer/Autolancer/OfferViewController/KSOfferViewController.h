//
//  KSOfferViewController.h
//  Autolancer
//
//  Created by mac-214 on 28.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BZGFormField/BZGFormField.h>

@interface KSOfferViewController : UIViewController <BZGFormFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *offerDescription;
@property (nonatomic, retain) IBOutlet UITextField *offerPrice;
@property (nonatomic, retain) IBOutlet UITextField *offerMobilePhone;
@property (nonatomic, retain) IBOutlet UITextField *offerAdditionalPhone;
@property (nonatomic, retain) IBOutlet UITextField *offerSkype;
@property (nonatomic, retain) IBOutlet UITextField *offerWebsite;
@property (nonatomic, retain) IBOutlet UITextField *offerAddress;
@property (nonatomic, retain) IBOutlet UITextField *offerWorkTime;
@property (nonatomic, retain) IBOutlet UITextField *offerUserName;
@property (nonatomic, retain) IBOutlet BZGFormField *offerEmail;
@property (nonatomic, retain) IBOutlet UIView *mainFormsView;
@property (nonatomic, retain) IBOutlet UIView *additionalFormsView;
@property (nonatomic, retain) IBOutlet UIButton *previousFormButton;
@property (nonatomic, retain) IBOutlet UIButton *nextFormButton;

- (IBAction)completeOffer:(id)sender;
- (IBAction)goToPreviousForm:(id)sender;

@end
