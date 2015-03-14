//
//  PDFRenderer.h
//  iOSPDFRenderer
//
//  Created by Tope on 24/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreText/CoreText.h"

@interface PDFRenderer : NSObject

@property (nonatomic, retain) NSOrderedSet *questions;
@property (nonatomic, retain) NSOrderedSet *answers;

@property (nonatomic) float lastYValue;

-(void)drawPDF:(NSString*)fileName;

-(void)drawText;

-(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;

-(void)drawImage:(UIImage*)image inRect:(CGRect)rect;

-(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect fontRef:(CTFontRef)font;

-(void)drawLabels;

-(void)drawLogo;


-(void)drawTableAt:(CGPoint)origin 
     withRowHeight:(int)rowHeight 
    andColumnWidth:(int)columnWidth 
       andRowCount:(int)numberOfRows 
    andColumnCount:(int)numberOfColumns;


-(void)drawTableDataAt:(CGPoint)origin 
         withRowHeight:(int)rowHeight 
        andColumnWidth:(int)columnWidth 
           andRowCount:(int)numberOfRows 
        andColumnCount:(int)numberOfColumns;

@end
