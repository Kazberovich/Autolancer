//
//  KSNewTenderViewController.h
//  Autolancer
//
//  Created by mac-214 on 24.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BZGFormField/BZGFormField.h>

@protocol BZGFormFieldDelegate;

@interface KSNewTenderViewController : UIViewController<BZGFormFieldDelegate, UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet UIButton *selectTenderType;
@property (nonatomic, retain) IBOutlet UIButton *selectCatrgory;
@property (nonatomic, retain) IBOutlet UIButton *selectCarmark;
@property (nonatomic, retain) IBOutlet UIButton *selectCarModel;
@property (nonatomic, retain) IBOutlet UIButton *selectCarYear;
@property (nonatomic, retain) IBOutlet UIButton *selectPlace;
@property (nonatomic, retain) IBOutlet UITextField *details;

@property (nonatomic, retain) IBOutlet BZGFormField *fieldTenderType;
@property (nonatomic, retain) IBOutlet BZGFormField *fieldCatrgory;
@property (nonatomic, retain) IBOutlet BZGFormField *fieldCarmark;
@property (nonatomic, retain) IBOutlet BZGFormField *fieldCarModel;
@property (nonatomic, retain) IBOutlet BZGFormField *fieldCarYear;
@property (nonatomic, retain) IBOutlet BZGFormField *fieldPlace;

- (IBAction)showActionSheet:(id)sender;

@end
