//
//  Article+CoreDataProperties.h
//  ArticleViewer
//
//  Created by Aleksey on 6/21/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

@interface Article (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content_url;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *image_medium;
@property (nullable, nonatomic, retain) NSString *image_thumb;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSData *web_page;
@property (nullable, nonatomic, retain) NSData *article_image;

@end

NS_ASSUME_NONNULL_END
