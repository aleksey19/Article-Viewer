//
//  RequestManager.h
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebService.h"

@interface RequestManager : NSObject

+ (void)getArticlesWithBlock:(completionBlock)block;

@end
