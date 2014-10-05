//
//  KSCarModel.m
//  Autolancer
//
//  Created by user on 05.10.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSCarModel.h"

@implementation KSCarModel

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super init];
    if (self)
    {
        self.ID = [responseObject objectForKey:@"id"];
        self.title = [responseObject objectForKey:@"title"];
    }
    return self;
}

@end
