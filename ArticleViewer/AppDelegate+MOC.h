//
//  AppDelegate+MOC.h
//  ArticleViewer
//
//  Created by Aleksey on 6/20/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (MOC)

- (NSManagedObjectContext *)createMainQueueManagedObjectContext;
- (void)saveContext:(NSManagedObjectContext *)managedObjectContext;

@end
