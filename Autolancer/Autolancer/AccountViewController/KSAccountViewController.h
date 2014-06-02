//
//  KSAccountViewController.h
//  Autolancer
//
//  Created by mac-214 on 24.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import <LPPopupListView/LPPopupListView.h>
#import <LPPopupListViewCell.h>


@interface KSAccountViewController : UIViewController <LPPopupListViewDelegate>

@property (nonatomic, retain) IBOutlet UITextView *textView;

- (IBAction)buttonClicked:(id)selector;

@end
