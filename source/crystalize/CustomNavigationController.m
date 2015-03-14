    //
//  CustomNavigationController.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "CustomNavigationController.h"
#import "QuestionViewController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if (regularPop) {
        regularPop = NO;
        NSLog(@"Pop regular");
        return YES;
    }
    
    if (alertViewClicked) {
        alertViewClicked = NO;
        NSLog(@"Pop after alert");
        return YES;
    }
    
    if ([self.topViewController isMemberOfClass:[QuestionViewController class]]) {
        QuestionViewController *questionVC = (QuestionViewController *)self.topViewController;
        if (questionVC.isEdited) {
            UIAlertView * exitAlert = [[UIAlertView alloc] initWithTitle:@"If you cancel, all changes will be lost."
                                                                 message:nil
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:@"Save", nil];
            
            [exitAlert show];
            
            return NO;
        } else {
            regularPop = YES;
            [self popViewControllerAnimated:YES];
            return NO;
        }
    }
    else {
        regularPop = YES;
        [self popViewControllerAnimated:YES];
        return NO;
    }
    //return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //Cancel button
        alertViewClicked = YES;
        [self popViewControllerAnimated:YES];
    }
    
    else if (buttonIndex == 1) {
        //Save button
        if ([self.topViewController isMemberOfClass:[QuestionViewController class]]) {
            QuestionViewController *questionVC = (QuestionViewController *)self.topViewController;
            [questionVC saveAndExit:self];
        }
    }
    
}
@end
