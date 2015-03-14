//
//  Idea+Create.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "Idea+Create.h"
#import "Question+Create.h"

@interface Idea (CreatePrivate)
@end

@implementation Idea (Create)

+ (Idea *)ideaWithTemplateDictionary:(NSDictionary *)templateDict inManagedObjectContext:(NSManagedObjectContext *)context {
    Idea *idea = nil;
    
    idea = [NSEntityDescription insertNewObjectForEntityForName:@"Idea" inManagedObjectContext:context];

    idea.created = [NSDate date];
    idea.lastModified = [NSDate date];
    idea.name = [templateDict objectForKey:@"Placeholder Name"];
    
    NSArray *questions = [templateDict objectForKey:@"Questions"];
    for (NSDictionary *questionDict in questions) {
        [Question questionForIdea:idea withQuestionDictionary:questionDict inManagedObjectContext:context];
    }
    
    return idea;
}

@end
