//
//  Idea+Create.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "Idea.h"

@interface Idea (Create)

+ (Idea *)ideaWithTemplateDictionary:(NSDictionary *)templateDict inManagedObjectContext:(NSManagedObjectContext *)context;

@end
