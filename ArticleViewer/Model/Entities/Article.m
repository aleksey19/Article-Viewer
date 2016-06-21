//
//  Article.m
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "Article.h"
#import "EKManagedObjectModel.h"

@implementation Article

// Insert code here to add functionality to your managed object subclass

+ (EKManagedObjectMapping *)objectMapping
{
    EKManagedObjectMapping *mapping = [[EKManagedObjectMapping alloc] initWithEntityName:@"Article"];
    [mapping mapPropertiesFromArray:@[@"id", @"title", @"image_medium", @"image_thumb", @"content_url"]];
    
    return mapping;
}

+ (Article *)articleWithDictionary:(NSDictionary *)dictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    Article *article = nil;
    
    NSString *identifier = dictionary[@"id"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Article"];
    request.predicate = [NSPredicate predicateWithFormat:@"id = %@", identifier];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || (matches.count > 1)) {
        // handle error
    } else if (matches.count) {
        article = matches.firstObject;
    } else {
        
        // Mapping
        article = [Article objectWithProperties:dictionary inContext:context];
        article.web_page = [NSData dataWithContentsOfURL:[NSURL URLWithString:article.content_url]];
        article.article_image = [NSData dataWithContentsOfURL:[NSURL URLWithString:article.image_medium]];

        // Native mapping
        /*
        article = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
        article.title = dictionary[@"title"];
        article.image_thumb = dictionary[@"image_thumb"];
        article.image_medium = dictionary[@"image_medium"];
        article.content_url = dictionary[@"content_url"];
         */
    }
    
    return article;
}

+ (void)checkArticlesInArray:(NSArray *)array inManagedObjectContext:(NSManagedObjectContext *)context
{
    // Get all local articles
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Article"];
    request.predicate = nil;
    
    NSError *error;
    NSMutableArray *localArticles = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    // If cached articles count more than requested articles count, delete unnecessary local artilcles
    if (localArticles.count > array.count) {
        for (NSDictionary *article in array) {
            [self checkArticleIfExist:article inArray:localArticles inManagedObjectContext:context];
        }
        
        if (localArticles.count) {
            for (Article *article in localArticles) {
                [context deleteObject:article];
            }
        }
    }
}

+ (void)checkArticleIfExist:(NSDictionary *)article inArray:(NSMutableArray *)localArticles inManagedObjectContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *articleForCheck in localArticles) {
        if ([article[@"id"] integerValue] == [articleForCheck[@"id"] integerValue]) {
            [localArticles removeObject:articleForCheck];
            break;
        }
    }
}

+ (void)loadArticlesFromArray:(NSArray *)array intoManagedObjectContext:(NSManagedObjectContext *)context
{
    [self checkArticlesInArray:array inManagedObjectContext:context];
    
    for (NSDictionary *article in array) {
        [self articleWithDictionary:article inManagedObjectContext:context];
    }
}

@end
