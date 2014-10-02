//
//  KSTender.m
//  Autolancer
//
//  Created by mac-214 on 24.04.14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "KSTender.h"

@implementation KSTender

- (id)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super init];
    if (self)
    {
        self.ID = [responseObject objectForKey:@"id"];
        self.title = [responseObject objectForKey:@"title"];
        self.status = [[responseObject objectForKey:@"tender_status"] stringValue];
        self.carmark = [responseObject objectForKey:@"carmark"];
        self.carmodel = [responseObject objectForKey:@"carmodel"];
        self.carYear = [responseObject objectForKey:@"caryear"];
        self.place = [responseObject objectForKey:@"place"];
        self.type = [responseObject objectForKey:@"tender_type"];
        if ([responseObject objectForKey:@"description"]) {
            self.description = [responseObject objectForKey:@"description"];
        }
        self.views = [responseObject objectForKey:@"views"];
        self.offers = [responseObject objectForKey:@"offers"];
        self.postDate = [responseObject objectForKey:@"post_date"];
    }
    return self;
}

@end
