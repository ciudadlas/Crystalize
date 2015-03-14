//
//  Idea+Read.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "Idea+Read.h"
#import "Question+Read.h"
#import "PDFRenderer.h"

@interface Idea (ReadPrivate)
- (NSString *)fileName;
- (NSString *)tempPathWithfileName:(NSString *)fileName;
- (void)outputIdeaPdfAtPath:(NSString *)path;
- (void)outputEditableIdeaAtPath:(NSString *)path;
- (BOOL)confirmFilepathIsAvailableToWrite:(NSString *)path;
@end

@implementation Idea (Read)

//returns a float between 0.0 and 1.0
- (int)progress {
    float percentCompleted = 0.0;
    int questionsCompleted = 0;
    
    NSOrderedSet *allQuestions = self.questions;
    NSInteger totalQuestions = [allQuestions count];
    
    if (totalQuestions != 0) {
        // add up all completed questions
        for (Question *question in allQuestions) {
            if (question.completed) {
                ++questionsCompleted;
            }
        }
        
        // also add in if the user has submitted the idea
        if ([self.submitted boolValue] == YES) {
            questionsCompleted = questionsCompleted + 1;
        }
        totalQuestions = totalQuestions + 1;
        
    }
    
    return questionsCompleted;
}

//returns a temp path to a rendered PDF document of the idea
- (NSString *)pdfPath {
    NSString *outputPath = nil;
    
    // create fileName
    NSString *fileName = [NSString stringWithFormat:@"%@.pdf",[self fileName]];
    
    // append fileName to temp folder path
    NSString *filePath = [self tempPathWithfileName:fileName];
    
    // export pdf
    @try {
        [self outputIdeaPdfAtPath:filePath];
        outputPath = filePath;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception writing PDF file");
    }
    
    return filePath;
}

//returns a temp path to an editable export of the idea
- (NSString *)editablePath {
    // create fileName
    NSString *fileName = [NSString stringWithFormat:@"%@.idea",[self fileName]];
    
    // append fileName to temp folder path
    NSString *filePath = [self tempPathWithfileName:fileName];
    
    // export editable .idea file
    @try {
        [self outputEditableIdeaAtPath:filePath];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception writing PDF file");
    }

    return filePath;
}

#pragma mark - private methods

// create a filename 
- (NSString *)fileName {
    // create fileName
    NSString *fileName = self.name;
    
    fileName = [[fileName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@"-" ];
    fileName = [[fileName componentsSeparatedByCharactersInSet:[NSCharacterSet illegalCharacterSet]] componentsJoinedByString:@"_" ];
    fileName = [[fileName componentsSeparatedByCharactersInSet:[NSCharacterSet symbolCharacterSet]] componentsJoinedByString:@"_" ];
    
    return fileName;
}

- (NSString *)tempPathWithfileName:(NSString *)fileName {
    NSString *fileURLString = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    
    return fileURLString;
}

- (void)outputIdeaPdfAtPath:(NSString *)path {
    // first, check if there's already a file at this path
    BOOL pathOK = [self confirmFilepathIsAvailableToWrite:path];
    
    if (pathOK) {
        
        PDFRenderer *renderer = [[PDFRenderer alloc] init];
        renderer.idea = self;
        
        [renderer drawPDF:path];
        
        
        // throw exception on failure
    } else {
        // throw exception
    }
}

- (void)outputEditableIdeaAtPath:(NSString *)path {
#warning Implement editable .idea file export here
    // first, check if there's already a file at this path
    BOOL pathOK = [self confirmFilepathIsAvailableToWrite:path];
    
    if (pathOK) {
        // output file to disk
        
        // throw exception on failure
    } else {
        // throw exception
    }
}

- (BOOL)confirmFilepathIsAvailableToWrite:(NSString *)path {
    BOOL filepathIsAvailableToWrite = NO;
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    
    if (fileExists) {
        NSError *error = nil;
        BOOL deletedSuccessfully = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (deletedSuccessfully && !error) {
            filepathIsAvailableToWrite = YES;
        } else {
            // there's a problem, but not really much we can do at this point
            // probably should throw an exception
            NSLog(@"Error clearing filepath: %@\n%@",path,[error localizedDescription]);
        }
    } else {
        filepathIsAvailableToWrite = YES;
    }
    
    return filepathIsAvailableToWrite;
}

@end
