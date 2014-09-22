//
//  KSTenderCategory.m
//  Autolancer
//
//  Created by mac-214 on 22.09.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSTenderCategory.h"

@implementation KSTenderCategory

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
