//
//  ASEnvironment.m
//  AppScho
//
//  Created by Alexandre ARRIGHI on 18/12/2015.
//  Copyright © 2015 Alexandre ARRIGHI. All rights reserved.
//

#import "ASEnvironment.h"

@implementation ASEnvironment


//We pass the json dictionary in order to init our object

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    
    if(self = [self init]){
        self.build = [jsonDictionary objectForKey:@"build"];
        self.context = [jsonDictionary objectForKey:@"context"];
        self.env = [jsonDictionary objectForKey:@"env"];
    }
    
    return self;
}

@end
