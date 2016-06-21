//
//  ArticlesTVC.h
//  ArticleViewer
//
//  Created by Aleksey on 6/20/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface ArticlesTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
