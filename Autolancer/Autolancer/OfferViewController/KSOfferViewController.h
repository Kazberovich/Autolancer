//
//  KSOfferViewController.h
//  Autolancer
//
//  Created by mac-214 on 28.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSOfferViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *offerDescription;
@property (nonatomic, retain) IBOutlet UITextField *offerPrice;
@property (nonatomic, retain) IBOutlet UITextField *offerMobilePhone;
@property (nonatomic, retain) IBOutlet UITextField *offerAdditionalPhone;
@property (nonatomic, retain) IBOutlet UITextField *offerSkype;
@property (nonatomic, retain) IBOutlet UITextField *offerWebsite;
@property (nonatomic, retain) IBOutlet UITextField *offerAddress;
@property (nonatomic, retain) IBOutlet UITextField *offerWorkTime;
@property (nonatomic, retain) IBOutlet UITextField *offerUserName;
@property (nonatomic, retain) IBOutlet UITextField *offerEmail;

- (IBAction)completeOffer:(id)sender;

@end
