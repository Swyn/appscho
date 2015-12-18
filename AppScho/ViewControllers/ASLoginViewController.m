//
//  ASLoginViewController.m
//  AppScho
//
//  Created by Alexandre ARRIGHI on 18/12/2015.
//  Copyright © 2015 Alexandre ARRIGHI. All rights reserved.
//

/*
  This app take a user name and fetch datas from a server in order to diplay it in a table view.
  The app is compose of four classes :
  
    2 UIView : Login and TableView
    1 Object model : Environment
    1 Custom Cell
 
  Login view ask a user name and send it to the next view in order to show it in a welcome message
  Table view fetch datas and display them
  Environment model has a setter method 
  Custom cell is used to set the labels
 
  What we could do from here :
    Add a constants manager in order to manage different paths
    Perform some modifications on storyboard in order to handle all devices
    Do a way better design...
*/

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

    /* Check if the user did enter his name
       This is a very simple way to check if the string is empty, we usually create a dedicated class in order to check every sort of strings (empty / phone number / emails etc).
     */
    if ([self.usernameTextfield.text length] == 0) {
        [self.emptyTextfieldLabel setHidden:NO];
        
    }else{
        //trigger segue if textfield isn't empty
        [self performSegueWithIdentifier:@"ToNextViewSegue" sender:self];
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //Check if it's the good segue
    if([segue.identifier isEqualToString:@"ToNextViewSegue"]){
        //instantiate the next view and pass it our user name.
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
