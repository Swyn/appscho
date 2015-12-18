//
//  ASLoginViewController.m
//  AppScho
//
//  Created by Alexandre ARRIGHI on 18/12/2015.
//  Copyright © 2015 Alexandre ARRIGHI. All rights reserved.
//

#import "ASLoginViewController.h"
#import "ASTableViewController.h"

@interface ASLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UILabel *emptyTextfieldLabel;

@end

@implementation ASLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)connectButtonTouched:(UIButton *)sender {
    
    if ([self.usernameTextfield.text length] == 0) {
        [self.emptyTextfieldLabel setHidden:NO];
        
    }else    
    [self performSegueWithIdentifier:@"ToNextViewSegue" sender:self];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"ToNextViewSegue"]){
        
        ASTableViewController *nextVC = segue.destinationViewController;
        nextVC.userName = self.usernameTextfield.text;
    }
    
    
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
