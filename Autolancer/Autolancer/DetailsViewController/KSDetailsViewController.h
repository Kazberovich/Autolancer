//
//  KSDetailsViewController.h
//  Autolancer
//
//  Created by user on 27.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSTender;

@interface KSDetailsViewController : UIViewController

@property (nonatomic, retain) KSTender *tender;
@property (nonatomic, retain) IBOutlet UILabel *tenderTitle;
@property (nonatomic, retain) IBOutlet UILabel *tenderCarMark;
@property (nonatomic, retain) IBOutlet UILabel *tenderCarmodel;
@property (nonatomic, retain) IBOutlet UILabel *tenderCaryear;
@property (nonatomic, retain) IBOutlet UILabel *tenderStatus;
@property (nonatomic, retain) IBOutlet UILabel *tenderType;
@property (nonatomic, retain) IBOutlet UITextView *tenderDescription;
@property (nonatomic, retain) IBOutlet UILabel *tenderViews;
@property (nonatomic, retain) IBOutlet UILabel *tenderOffers;
@property (nonatomic, retain) IBOutlet UIImageView *imageView1;
@property (nonatomic, retain) IBOutlet UIImageView *imageView2;
@property (nonatomic, retain) IBOutlet UILabel *tenderPostdate;
@property (nonatomic, retain) IBOutlet UILabel *tenderPlace;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction)takeOffer:(id)sender;


@end
