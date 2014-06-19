//
//  KSMapViewController.m
//  Autolancer
//
//  Created by mac-214 on 18.06.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSMapViewController.h"
#import <MapBox/Mapbox.h>

@interface KSMapViewController ()

@end

@implementation KSMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RMMapboxSource *tileSource = [[RMMapboxSource alloc] initWithMapID:@"kazbers.ihp877h9"];
    
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    
    [self.view addSubview:mapView];
    

    
   // [mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
