//
//  KSTenderPlace.m
//  Autolancer
//
//  Created by mac-214 on 22.09.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSTenderPlace.h"

@implementation KSTenderPlace

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
