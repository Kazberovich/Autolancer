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

@synthesize mapView = _mapView;

- (void)dealloc
{
    [_mapView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RMMapboxSource *tileSource = [[[RMMapboxSource alloc] initWithMapID:@"kazbers.ihp877h9"] autorelease];
    _mapView = [[[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource] autorelease];
    
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
