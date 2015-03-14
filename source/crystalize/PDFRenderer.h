//
//  PDFRenderer.h
//  iOSPDFRenderer
//
//  Created by Tope on 24/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreText/CoreText.h"
@class Idea;

@interface PDFRenderer : NSObject

@property (nonatomic, retain) Idea *idea;

@property (nonatomic) float lastYValue;

-(void)drawPDF:(NSString*)fileName;

-(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;

-(void)drawImage:(UIImage*)image inRect:(CGRect)rect;

@end
