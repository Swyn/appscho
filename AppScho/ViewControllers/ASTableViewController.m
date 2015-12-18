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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        self.tableView.scrollEnabled = NO;
    }
    else {
        self.tableView.scrollEnabled = YES;
    }

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {

    
    [self.topViewLabel setText:[NSString stringWithFormat:@"Bonjour %@", self.userName]];
    
    [self getDatas];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getDatas {
    
    
    NSString *string =  BaseURLString;
    NSURL *url = [NSURL URLWithString:string];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:@"demo/ping" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"OK");
        NSDictionary *dictionary = [(NSDictionary *)responseObject objectForKey:@"response"];
        self.myEnv = [[ASEnvironment alloc] initWithJSONDictionary:dictionary];
        [self.tableView reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Nope");
    }];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ASEnvCellCount;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *contentCellIdentifier = @"Cell";
    ASCustomCellTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier forIndexPath:indexPath];
    
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
