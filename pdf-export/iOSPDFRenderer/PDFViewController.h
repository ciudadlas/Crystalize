//
//  PDFViewController.h
//  iOSPDFRenderer
//
//  Created by Tope on 21/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface PDFViewController : UIViewController <MFMailComposeViewControllerDelegate>


-(void)showPDFFile;

-(NSString*)getPDFFileName;
@end
