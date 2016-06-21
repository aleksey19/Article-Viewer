//
//  WebService+Articles.h
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "WebService.h"
#import "Article+CoreDataProperties.h"

@interface WebService (Articles)

- (void)getArticlesWithBlock:(completionBlock)block;

@end
