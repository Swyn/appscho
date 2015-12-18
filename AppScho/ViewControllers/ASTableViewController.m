//
//  ASTableViewController.m
//  AppScho
//
//  Created by Alexandre ARRIGHI on 18/12/2015.
//  Copyright © 2015 Alexandre ARRIGHI. All rights reserved.
//

#import "ASTableViewController.h"
#import "ASEnvironment.h"
#import "ASCustomCellTableViewCell.h"

#import <AFNetworking/AFNetworking.h>

static NSString * const BaseURLString = @"https://rec.api.appscho.com/";

@interface ASTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *topViewLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) ASEnvironment *myEnv;

@end

@implementation ASTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set datasources and delegates for the tableView
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //In order to avoid a disgracefull table view moving for nothing we check if the content fit in the table view height and freeze it.
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        self.tableView.scrollEnabled = NO;
    }
    else {
        self.tableView.scrollEnabled = YES;
    }

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {

    //set top text
    [self.topViewLabel setText:[NSString stringWithFormat:@"Bonjour %@", self.userName]];
    
    //And we go fetch the datas
    [self getDatas];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getDatas {
    
    /*  We use AFNetworking 3 (first time... no more requestOperations I need to update my knowledge on this)
        1/ We create an NSURL and init the manager with said URL
        2/ We set the repsonse format for the manager
        3/ Send get method 
        4/ We put our JSON serialized response in a dictionary and send it to the ASEnvironment object setter
        5/ Reload table view data's
    */
    
    //*1*
    NSString *string =  BaseURLString;
    NSURL *url = [NSURL URLWithString:string];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    //*2*
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    //*3*
    [manager GET:@"demo/ping" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"OK");
        
        //*4*
        NSDictionary *dictionary = [(NSDictionary *)responseObject objectForKey:@"response"];
        self.myEnv = [[ASEnvironment alloc] initWithJSONDictionary:dictionary];
        
        //*5*
        [self.tableView reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Nope");
    }];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We only need one section here
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    /* We return our list from ASEnvironment.h in order to know how many row we will need.
       Of course this works only if we already know how many rows we want to display... 
       Here it's the best choice for memory management we avoid creating an array and it's count method.
     */
    return ASEnvCellCount;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Instantiation of our custom cell
    static NSString *contentCellIdentifier = @"Cell";
    ASCustomCellTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier forIndexPath:indexPath];
    
    //We go through our enumerator and display datas with a simple switch
    ASEnvCells environmentCells = indexPath.row;
   
    switch (environmentCells) {
        case ASEnvCellBuild:
            cell.titleLabel.text = @"Build";
            cell.contentLabel.text = self.myEnv.build;
            break;
        case ASEnvCellContext:
            cell.titleLabel.text = @"Context";
            cell.contentLabel.text = self.myEnv.context;
            break;
        case ASEnvCellEnv:
            cell.titleLabel.text = @"Environment";
            cell.contentLabel.text = self.myEnv.env;
            break;
        default:
            break;
    }
    
    return cell;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
