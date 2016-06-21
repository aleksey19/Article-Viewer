//
//  ArticlesTVC.m
//  ArticleViewer
//
//  Created by Aleksey on 6/20/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "ArticlesTVC.h"
#import "ManagedObjectContextAvailibility.h"
#import "ArticleCell.h"
#import "Article.h"
#import "ArticleVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RequestManager.h"


@interface ArticlesTVC ()
@property (weak, nonatomic) IBOutlet UIRefreshControl *spinner;
@property (strong, nonatomic) Article *selectedArticle;
@end
@implementation ArticlesTVC

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:MANAGED_OBJECT_CONTEXT_NOTIFICATION
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      self.managedObjectContext = note.userInfo[MANAGED_OBJECT_CONTEXT];
                                                  }];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Article"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"id"
                                                              ascending:YES
                                                               /*selector:@selector(localizedStandardCompare:)*/]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (IBAction)refreshTableView
{
    [self.spinner beginRefreshing];
    [RequestManager getArticlesWithBlock:^(NSError *error, NSDictionary *dicticionary, NSArray *array) {
        if (!error && array.count && self.managedObjectContext) {
            [self.managedObjectContext performBlock:^{
                [Article loadArticlesFromArray:array intoManagedObjectContext:self.managedObjectContext];
                [self.spinner endRefreshing];
                [self.tableView reloadData];
            }];
        }
    }];
}

#pragma mark - Table View DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Article Cell Id"];
    Article *article = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.articleTitleLabel.text = article.title;
    [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:article.image_thumb] placeholderImage:[UIImage imageNamed:@"def.png"] options:SDWebImageCacheMemoryOnly];
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedArticle = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return indexPath;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Article Detail"]) {
        UINavigationController *navVC = segue.destinationViewController;
        ArticleVC *destVC = (ArticleVC *)navVC.topViewController;;
        if ([destVC isMemberOfClass:[ArticleVC class]]) {            
            destVC.article = self.selectedArticle;
        }
    }
}

@end
