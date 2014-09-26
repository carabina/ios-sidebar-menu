//
//  AppDelegate.m
//  sidebar-menu-ios
//
//  Created by Clint Cabanero on 9/3/14.
//  Copyright (c) 2014 Big Leaf Mobile LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "TestAViewController.h"
#import "TestBViewController.h"
#import "TestCViewController.h"
//----------------------------------------------
//STEP 1: IMPORT THE SIDEBARMENU VIEWCONTROLLER
//----------------------------------------------
#import "SidebarMenuViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //---------------------------------------------------
    //  STEP 2: INSTANTIATE A SIDEBARMENU VIEWCONTROLLER
    //---------------------------------------------------
    SidebarMenuViewController *sidebarMenuVC = [[SidebarMenuViewController alloc] initWithNibName:@"SidebarMenuViewController" bundle:nil];

    //--------------------------------------------------------------------------------
    //  STEP 3: ADD A COLLECTION OF VIEWCONTROLLERS TO THE SIDEBARMENU VIEWCONTROLLER
    //--------------------------------------------------------------------------------
    TestAViewController *testAViewController = [[TestAViewController alloc] initWithNibName:@"TestAViewController" bundle:nil];
    TestBViewController *testBViewController = [[TestBViewController alloc] initWithNibName:@"TestBViewController" bundle:nil];
    TestCViewController *testCViewController = [[TestCViewController alloc] initWithNibName:@"TestCViewController" bundle:nil];
    sidebarMenuVC.menuItemViewControllers = [[NSArray alloc] initWithObjects:testAViewController, testBViewController, testCViewController, nil];

    //---------------------------------------------------------------------------------------------------
    //  STEP 4: ADD USER-FRIENDLY NAMES FOR EACH SIDEBAR MENU ITEM (FOR EACH ASSOCIATED VIEW CONTROLLER)
    //---------------------------------------------------------------------------------------------------
    sidebarMenuVC.menuItemNames = [[NSArray alloc] initWithObjects:@"Sidebar menu item 1", @"Sidebar menu item 2", @"Sidebar menu item 3", nil];

    //---------------------------------------------------------------------------------------------------
    //  STEP 5: DECLARE THE IMAGE NAME FOR THE SIDEBAR BUTTON (USER WILL TAP THIS TO OPEN/CLOSE SIDEBAR)
    //---------------------------------------------------------------------------------------------------
    sidebarMenuVC.sideBarButtonImageName = @"sidebarMenuImage";
    
    
    [self.window setRootViewController:sidebarMenuVC];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
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
}

@end
