//
//  RequestManager.m
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "RequestManager.h"
#import "WebService.h"
#import "WebService+Articles.h"

@implementation RequestManager

+ (void)getArticlesWithBlock:(completionBlock)block
{
    [[WebService sharedService] getArticlesWithBlock:block];
}

@end
