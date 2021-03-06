//
//  KSSubscribesViewController.h
//  Autolancer
//
//  Created by user on 14.06.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LPPopupListView/LPPopupListView.h>
#import <LPPopupListViewCell.h>

@interface KSSubscribesViewController : UIViewController<LPPopupListViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIButton *selectTenderType;
@property (nonatomic, retain) IBOutlet UIButton *selectCatrgory;
@property (nonatomic, retain) IBOutlet UIButton *selectPlace;
@property (nonatomic, retain) IBOutlet UITextView *typeTextView;
@property (nonatomic, retain) IBOutlet UITextView *categoryTextView;
@property (nonatomic, retain) IBOutlet UITextView *placeTextView;
@property (nonatomic, retain) IBOutlet UITextView *carmarkTextView;

- (IBAction)buttonClicked:(id)selector;

@end
