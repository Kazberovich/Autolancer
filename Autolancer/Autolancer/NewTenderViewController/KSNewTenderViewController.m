//
//  KSNewTenderViewController.m
//  Autolancer
//
//  Created by mac-214 on 24.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSNewTenderViewController.h"
#import "ApiLoadService.h"
#import "KSTenderType.h"

@interface KSNewTenderViewController ()

@property (nonatomic, retain) NSMutableArray *loadedTypes;

@end

@implementation KSNewTenderViewController

@synthesize selectTenderType = _selectTenderType;
@synthesize selectCarmark = _selectCarmark;
@synthesize selectCarModel = _selectCarModel;
@synthesize selectCarYear = _selectCarYear;
@synthesize selectCatrgory = _selectCatrgory;
@synthesize selectPlace = _selectPlace;

@synthesize fieldTenderType = _fieldTenderType;
@synthesize fieldCarmark = _fieldCarmark;
@synthesize fieldCarModel = _fieldCarModel;
@synthesize fieldCarYear = _fieldCarYear;
@synthesize fieldCatrgory = _fieldCatrgory;
@synthesize fieldPlace = _fieldPlace;

@synthesize loadedTypes = _loadedTypes;

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.title = @"Новый заказ";
}

- (void)dealloc
{
    [_selectTenderType release];
    [_loadedTypes release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)showActionSheet:(id)sender
{   
    if ([sender tag] == 1)
    {
        [ApiLoadService getResponseForURL:[NSURL URLWithString:@"http://autolancer.by/wp-admin/admin-ajax.php?action=get_tendertypes&uid=rrrr&user_id=3"] callback:^(NSDictionary *dictionary, NSURL *url) {
            
            NSDictionary *data = [dictionary objectForKey:@"data"];
            NSDictionary *tenderTypes = [data objectForKey:@"tendertypes"];
            NSLog(@"%@", tenderTypes);
            
            _loadedTypes = [[[NSMutableArray alloc] init] autorelease];
            
            for(id type in tenderTypes)
            {
                KSTenderType * toaddType = [[KSTenderType alloc] initWithServerResponse:type];
                [_loadedTypes addObject: toaddType];
            }
            
            UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Это ActionSheet"
                                                                     delegate:self
                                                            cancelButtonTitle:nil
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:nil];
        
            for (KSTenderType * type in _loadedTypes)
            {
                [actionSheet addButtonWithTitle:type.title];
            }
            [_loadedTypes retain];
            [actionSheet showInView:self.view];
            
        }];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //[_loadedTypes retain];
    _fieldTenderType.textField.text = ((KSTenderType*)[_loadedTypes objectAtIndex:buttonIndex]).title;
}


@end
