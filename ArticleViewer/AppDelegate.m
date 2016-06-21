//
//  AppDelegate.m
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "AppDelegate.h"
#import "RequestManager.h"
#import "AppDelegate+MOC.h"
#import "ManagedObjectContextAvailibility.h"
#import "ArticleVC.h"
#import "Article.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.managedObjectContext = [self createMainQueueManagedObjectContext];
    
    [RequestManager getArticlesWithBlock:^(NSError *error, NSDictionary *dicticionary, NSArray *array) {
        if (!error && array.count && self.managedObjectContext) {
            [self.managedObjectContext performBlock:^{
                [Article loadArticlesFromArray:array intoManagedObjectContext:self.managedObjectContext];
            }];
        }
    }];
    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    
    return YES;
}

#pragma mark - Database Context

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    NSDictionary *userInfo = self.managedObjectContext ? @{ MANAGED_OBJECT_CONTEXT : self.managedObjectContext } : nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:MANAGED_OBJECT_CONTEXT_NOTIFICATION
                                                        object:self
                                                      userInfo:userInfo];
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[ArticleVC class]] && ([(ArticleVC *)[(UINavigationController *)secondaryViewController topViewController] article] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
