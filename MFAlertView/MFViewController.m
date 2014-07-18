//
//  MFViewController.m
//  MFAlertView
//
//  Created by moflo on 7/18/14.
//  Copyright (c) 2014 Mobile Flow LLC. All rights reserved.
//

#import "MFViewController.h"
#import "MF_UIAlertView.h"

@interface MFViewController ()

@end

@implementation MFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *rows = @[@7];
    return [rows[section] integerValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            // Simple Alert
            [MF_UIAlertView showWithTitle:@"Hello!" message:@"Test of a single button" cancelButtonTitle:@"Cancel" defaultButtonTitle:nil otherButtonTitle:nil withBlock:^(int selectedButton) {
                // Button selected
                NSLog(@"Simple alert, button selected: %d",selectedButton);
            }];
            
            break;
            
        case 1:
            // Simple Alert
            [MF_UIAlertView showWithTitle:@"Hello!" message:@"Test of two buttons" cancelButtonTitle:@"Cancel" defaultButtonTitle:@"Default" otherButtonTitle:nil withBlock:^(int selectedButton) {
                // Button selected
                NSLog(@"Simple alert, button selected: %d",selectedButton);
            }];
            
            break;
        case 2:
            // Simple Alert
            [MF_UIAlertView showWithTitle:@"Hello!" message:@"Test of three buttons" cancelButtonTitle:@"Cancel" defaultButtonTitle:@"Default" otherButtonTitle:@"Other" withBlock:^(int selectedButton) {
                // Button selected
                NSLog(@"Simple alert, button selected: %d",selectedButton);
            }];
            
            break;
        case 3:
            // Simple Alert - spinner
            [MF_UIAlertView showSpinnerWithTitle:@"Hello!" cancelButtonTitle:@"Cancel" withBlock:^(int selectedButton) {
                // Button selected
                NSLog(@"Simple alert, button selected: %d",selectedButton);
            }];
            
            break;
            
        case 4:
            // Simple Alert, long text
            [MF_UIAlertView showWithTitle:@"Hello!" message:@"Test of some incredibly long text string, which should, hopefully, split across multiple lines within the dialog itself." cancelButtonTitle:@"Cancel" defaultButtonTitle:@"Default" otherButtonTitle:nil withBlock:^(int selectedButton) {
                // Button selected
                NSLog(@"Simple alert, button selected: %d",selectedButton);
            }];
            
            break;
        case 5:
            // Simple Alert
            [MF_UIAlertView showWithTitle:@"Hello!" message:@"Test of one button with long text" cancelButtonTitle:@"HERE IT IS THE LONGEST TEXT ON A BUTTON EVER!" defaultButtonTitle:nil otherButtonTitle:nil withBlock:^(int selectedButton) {
                // Button selected
                NSLog(@"Simple alert, button selected: %d",selectedButton);
            }];
            
            break;
        case 6:
            // Simple Alert
            [MF_UIAlertView showWithTitle:@"LONG TITLE TEXT MESSAGE TESTING GOING ON NOW" message:@"Test of one button with long text" cancelButtonTitle:@"HERE IT IS THE LONGEST TEXT ON A BUTTON EVER!" defaultButtonTitle:nil otherButtonTitle:nil withBlock:^(int selectedButton) {
                // Button selected
                NSLog(@"Simple alert, button selected: %d",selectedButton);
            }];
            
            break;
        default:
            break;
    }
}

@end
