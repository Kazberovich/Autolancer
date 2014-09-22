//
//  KSTenderType.m
//  Autolancer
//
//  Created by mac-214 on 22.09.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSTenderType.h"

@implementation KSTenderType

- (void)initWithDictionary:(NSDictionary *)dictionary
{
    self.ID = [dictionary objectForKey:@"id"];
    self.title = [dictionary objectForKey:@"title"];
}

@end
