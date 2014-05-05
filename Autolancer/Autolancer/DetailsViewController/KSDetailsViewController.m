//
//  KSDetailsViewController.m
//  Autolancer
//
//  Created by user on 27.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSDetailsViewController.h"
#import "KSTender.h"
#import "ApiLoadService.h"
#import "KSOfferViewController.h"

@interface KSDetailsViewController ()

@end

@implementation KSDetailsViewController

@synthesize tender = _tender;
@synthesize tenderCarMark = _tenderCarMark;
@synthesize tenderCarmodel = _tenderCarmodel;
@synthesize tenderCaryear = _tenderCaryear;
@synthesize tenderDescription = _tenderDescription;
@synthesize tenderOffers = _tenderOffers;
@synthesize tenderPostdate = _tenderPostdate;
@synthesize tenderStatus = _tenderStatus;
@synthesize tenderTitle = _tenderTitle;
@synthesize tenderType = _tenderType;
@synthesize tenderViews = _tenderViews;
@synthesize tenderPlace = _tenderPlace;
@synthesize scrollView = _scrollView;

- (void) dealloc
{
    [_scrollView release];
    [_tender release];
    [_tenderCarMark release];
    [_tenderCarmodel release];
    [_tenderCaryear release];
    [_tenderDescription release];
    [_tenderOffers release];
    [_tenderPostdate release];
    [_tenderTitle release];
    [_tenderType release];
    [_tenderViews release];
    [_tenderStatus release];
    [_tenderPlace release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.navigationItem.title = @"Подробная информация";
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    
	_tenderTitle.text = _tender.title;
    _tenderCarMark.text = _tender.carmark;
    _tenderCarmodel.text = _tender.carmodel;
    _tenderCaryear.text = _tender.carYear;
    _tenderType.text = _tender.type;
    _tenderPostdate.text = _tender.postDate;
    _tenderViews.text = _tender.views;
    _tenderOffers.text = [NSString stringWithFormat:@"%@",  _tender.offers];
    _tenderStatus.text = [_tender.status isEqualToString:@"1"] ? @"Не актуально" : @"Актуально";
    _tenderPlace.text = _tender.place;
    
    [NSString stringWithFormat:@"%@", @"s"];
    
    [ApiLoadService getResponseForURL:[NSURL URLWithString: [NSString stringWithFormat: @"http://autolancer.by/wp-admin/admin-ajax.php?action=get_tender&uuid=rrrr&tender_id=%@&user_id=3" , _tender.ID]] callback:^(NSDictionary *dictionary, NSURL *url) {
        
        NSLog(@"%@" , dictionary);
        
        NSDictionary *dataDict = [dictionary objectForKey:@"data"];
        
        if ([dataDict objectForKey:@"description"] != [NSNull null])
        {
            _tenderDescription.text = [dataDict objectForKey:@"description"];
        }
        else
        {
            _tenderDescription.text = @"Нет описания";
        }
        
        

    }];
}

- (IBAction)takeOffer:(id)sender
{
    KSOfferViewController *detailsViewController = [[UIStoryboard  storyboardWithName:@"Main" bundle:nil]
                                                    instantiateViewControllerWithIdentifier:@"offer"];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}
@end
