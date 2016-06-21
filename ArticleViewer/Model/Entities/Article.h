//
//  Article.h
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EasyMapping.h"

NS_ASSUME_NONNULL_BEGIN

@interface Article : EKManagedObjectModel <EKManagedMappingProtocol>

// Insert code here to declare functionality of your managed object subclass

+ (Article *)articleWithDictionary:(NSDictionary *)dictionary
              inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)loadArticlesFromArray:(NSArray *)array
         intoManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Article+CoreDataProperties.h"
