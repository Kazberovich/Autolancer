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

#import <REFrostedViewController/RECommonFunctions.h>
#import <REFrostedViewController/REFrostedContainerViewController.h>
#import <REFrostedViewController/REFrostedViewController.h>

#import <RNFrostedSidebar/RNFrostedSidebar.h>

@class AFViewShaker;

@interface KSAccountViewController : UIViewController<RNFrostedSidebarDelegate>

@property (nonatomic, retain) RNFrostedSidebar *sideBar;

@end
