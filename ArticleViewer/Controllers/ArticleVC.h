//
//  ArticleVC.h
//  ArticleViewer
//
//  Created by Aleksey on 6/20/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleVC : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) Article *article;

@end
