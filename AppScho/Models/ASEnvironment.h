//
//  ASEnvironment.h
//  AppScho
//
//  Created by Alexandre ARRIGHI on 18/12/2015.
//  Copyright © 2015 Alexandre ARRIGHI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ASEnvCells){
    
    ASEnvCellBuild,
    ASEnvCellContext,
    ASEnvCellEnv,
    ASEnvCellCount
    
};

@interface ASEnvironment : NSObject

@property (strong, nonatomic) NSString *build;
@property (strong, nonatomic) NSString *context;
@property (strong, nonatomic) NSString *env;

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;


@end
