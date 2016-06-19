//
//  ArticlesTVC.m
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "ArticlesTVC.h"
#import "RequestManager.h"

@interface ArticlesTVC ()
@property (nonatomic, strong) NSArray *articles;
@end

@implementation ArticlesTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getArticles];
}

- (void)getArticles
{
    [RequestManager getArticlesWithBlock:^(NSError *error, NSDictionary *dicticionary, NSArray *array) {
        self.articles = array;
    }];
}

@end
