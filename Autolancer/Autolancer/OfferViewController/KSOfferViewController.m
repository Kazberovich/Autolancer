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

- (void)dealloc
{
    [_offerPrice release];
    [_offerDescription release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = @"Предложение к заказу";
    CGRect frameRect = _offerDescription.frame;
    frameRect.size.height = 70;
    _offerDescription.frame = frameRect;
}

@end
