//
//  NavControllerAppDelegate.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "NavControllerAppDelegate.h"
#import "DAO.h"

@implementation NavControllerAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    // Override point for customization after application launch.
    TheMainViewController *tMVC = [[[TheMainViewController alloc]init]autorelease];
    self.navigationController = [[[UINavigationController alloc]initWithRootViewController:tMVC]autorelease];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];

    [_window setRootViewController:_navigationController];
    [_window makeKeyAndVisible];
    [_window release];
    [self.navigationController release];
    
    //SET UP NSMANAGED OBJECT CONTEXT FOR CORE DATA, REFERE TO HERE FROM DAO
    self.managedObjectContext = [[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType]autorelease];

    return YES;
    
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
     */
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    DAO *dataManager = [DAO sharedManager];
//    [dataManager saveContext];
    [self saveContext];
}

//SAVE CONTEXT
#pragma mark - Save Context
//ONLY USE IN APPDELEGATE APP TERMINATES, SAVING CONTEXT OTHERWISE DISALLOWS UNDO/REDO
- (void)saveContext
{
    NSError *error = nil;
    
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            
            NSLog(@"Saving didn't work so well.. Error: %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)dealloc{
    [_window release];
    [_navigationController release];
    [_managedObjectContext release];
    [super dealloc];
}


@end
