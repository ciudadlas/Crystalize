//
//  IdeaDetailTableViewController.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "IdeaDetailTableViewController.h"
#import "Question+Read.h"
#import "QuestionViewController.h"
#import "TableCellCustomColoredAccessory.h"

#define kAlertViewOne 1
#define kAlertViewTwo 2


@interface IdeaDetailTableViewController ()

@end

@implementation IdeaDetailTableViewController

@synthesize idea;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareIdea)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [idea.questions count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Question *question = [idea.questions objectAtIndex:section];
    NSString *headerTitle = question.question;
    return headerTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuestionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Question *question = [idea.questions objectAtIndex:[indexPath section]];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = question.answer;
    cell.contentView.backgroundColor = [UIColor colorWithRed:.89 green:.89 blue:.91 alpha:1.0];

    TableCellCustomColoredAccessory *accessory = [TableCellCustomColoredAccessory accessoryWithColor:cell.textLabel.textColor];
    accessory.highlightedColor = [UIColor whiteColor];
    [accessory setFrame:CGRectMake(300, 26, accessory.frame.size.width, accessory.frame.size.height)];
    [cell.contentView addSubview:accessory];
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:.94 green:.94 blue:.94 alpha:1.0]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 20)];
    Question *question = [self.idea.questions objectAtIndex:section];
    label.text = question.question;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    
    return headerView;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

/*
// Navigation logic may go here. Create and push another view controller.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowQuestion"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Question *question = [self.idea.questions objectAtIndex:[indexPath section]];
        [(QuestionViewController *)[segue destinationViewController] setQuestion:question];
        [(QuestionViewController *)[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - sharing

- (void)shareIdea
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email PDF", @"Print", @"Submit for Review", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
    
    [popupQuery showInView:self.view];

}

#pragma mark - actionSheet delegate functions


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
    {
        [self bringUpMailViewController];
        
    }
    
    else if (buttonIndex == 1)
        
    {

    }
    
    else if (buttonIndex == 2)
    
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"In App Purchase Confirmation" message:@"Do you want to submit your idea for a confidential consultation by one of our experts for $49.99?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        alertView.tag = kAlertViewOne;
        [alertView show];
    }
    
}

- (void)bringUpMailViewController
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:self.idea.name];
    [controller setMessageBody:@"Hey, check out my idea.\n\nSent from Crystalize Idea Catalyst App" isHTML:NO];
    
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[self.idea pdfPath]];
    [controller addAttachmentData:data mimeType:@"application/pdf" fileName:idea.name];
    
    if (controller) [self presentModalViewController:controller animated:YES];
    
}

#pragma mark - mailcomposer delegate functions

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == kAlertViewOne)
    {
        if (buttonIndex == 1)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank you." message:@"An expert will be in touch soon to help crystalize your idea." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            
            self.idea.submitted = [NSNumber numberWithBool:YES];
            
        }
    }
}


@end
