//
//  KSTenderType.m
//  Autolancer
//
//  Created by mac-214 on 08.05.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSTenderType.h"

@implementation KSTenderType

@synthesize ID = _ID;
@synthesize title = _title;

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
