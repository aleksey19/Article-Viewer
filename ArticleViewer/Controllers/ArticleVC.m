//
//  ArticleVC.m
//  ArticleViewer
//
//  Created by Aleksey on 6/20/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "ArticleVC.h"

@interface ArticleVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ArticleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self displayDetailArticle];
}

- (void)setupView
{
    self.navigationController.topViewController.title = @"Detail Article";
    UIBarButtonItem *shareBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareContent)];
    self.navigationController.navigationItem.rightBarButtonItems = @[shareBarButtonItem];
}

-(void)shareContent
{
    NSArray *activityItems = @[self.article.content_url, [UIImage imageWithData:self.article.article_image]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:^{
        ;
    }];
}

- (void)displayDetailArticle
{
    NSMutableData *data = [[NSMutableData alloc] init];
    [data appendData:self.article.web_page];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
}

@end
