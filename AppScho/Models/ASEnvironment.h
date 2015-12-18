//
//  ASEnvironment.h
//  AppScho
//
//  Created by Alexandre ARRIGHI on 18/12/2015.
//  Copyright © 2015 Alexandre ARRIGHI. All rights reserved.
//

#import <Foundation/Foundation.h>

//Enum in order to list all the cells we will need (very usefull if we need to add or remove cells)

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


//setter method
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;


@end
