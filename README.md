ios-sidebar-menu
================

#### Description
A Sidebar Menu ViewController for iOS. This ViewController can be used as a starting point for building a 'sidebar menu' user interface.  Wait wuh?

####Visual Examples
In the example below, when the user taps the top left ![icon](https://s3-us-west-1.amazonaws.com/app-static-assets/images/sidebar_example_seattle_bike_paths_button-sm.png) button, the __main content__ slides to the right - revealing a __scrollable list__ (i.e. UITableView) of __menu items__ underneath.  Tapping on a __menu item__ can then make changes to the __main content__.  In the case of the Seattle Bike Paths App example below, tapping a menu item changes the content presented on the map interface.  Get it? :)

![Visual Example 1](https://s3-us-west-1.amazonaws.com/app-static-assets/images/sidebar_example_seattle_bike_paths.png)

Here's another one.  In the example below, when the user taps the ![icon](https://s3-us-west-1.amazonaws.com/app-static-assets/images/sidebar_example_wainv_button-sm.png) button, the __main content__ slides to the right - revealing the App's main navigation options.  Tapping on a __menu item__ replaces the __main content__ with the view hierarchy of another ViewController.    

![Visual Example 1](https://s3-us-west-1.amazonaws.com/app-static-assets/images/sidebar_example_wainv.png)

Note, the SidebarViewController doesn't impose any styling or color pallete to your UI.  Customize as needed to fit the look-and-feel of your App.

####Language
Objective-C

####User Interface Idiom
This version of the solution uses a .xib file to layout the view hierarchy.  

####Code Usage Example
Being a ViewController, simply drop the interface (SidebarMenuViewController.h), implementation (SidebarMenuViewController.m), and 'nib' file (SidebarMenuViewController.xib) into your solution.  These three files can be found in the __SidebarCode__ folder/group in the provided Xcode project.

Then proceed with the following steps:

__Step #1__. In your AppDelegate implementation file (.m), import the SidebarMenuViewController.h interface file.

	#import "SidebarMenuViewController.h"
	
__Step #2__. In your AppDelegate's application:didFinishLaunchingWithOptions method, instantiate a SidebarMenuViewController.

	SidebarMenuViewController *sidebarMenuVC = [[SidebarMenuViewController alloc] initWithNibName:@"SidebarMenuViewController" bundle:nil];

__Step #3__. Create an array of ViewController instances that will be launched when a user taps the associated menu item in the Sidebar menu.  Assign this array to the SideBarMenuViewController.menuItemViewControllers property.

	TestAViewController *testAViewController = [[TestAViewController alloc] initWithNibName:@"TestAViewController" bundle:nil];
    
    TestBViewController *testBViewController = [[TestBViewController alloc] initWithNibName:@"TestBViewController" bundle:nil];
    
    sidebarMenuVC.menuItemViewControllers = [[NSArray alloc] initWithObjects:testAViewController, testBViewController, nil];

__Step #4__. Provide an array of Sidebar menu item names.  These will be the user-friendly names presented in the Sidebar Menu.  Of course, the order of these names should correspond with the order of the ViewControllers in the previous step.  

	sidebarMenuVC.menuItemNames = [[NSArray alloc] initWithObjects:@"Friendly Menu Item Name A", @"Friendly Menu Item Name B", nil];

__Step #5__.  Finally, assign an image to use for your Sidebar menu.

	sidebarMenuVC.sideBarButtonImageName = @"myImage"
	
Okay, that was a lot of steps to follow.  Below is the sample code added to the application:didFinishLaunchingWithOptions method in it's entirety:

	#import "AppDelegate.h"
	#import "SidebarMenuViewController.h"
	#import "TestAViewController.h"
	#import "TestBViewController.h"

	@implementation AppDelegate

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
    	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
 		SidebarMenuViewController *sidebarMenuVC = [[SidebarMenuViewController alloc] initWithNibName:@"SidebarMenuViewController" bundle:nil];
    
    	TestAViewController *testAVC = [[TestAViewController alloc] initWithNibName:@"TestAViewController" bundle:nil];
    
    	TestBViewController *testBVC = [[TestBViewController alloc] initWithNibName:@"TestBViewController" bundle:nil];
    
    	sidebarMenuVC.menuItemViewControllers = [NSArray arrayWithObjects:testAVC, testBVC, nil];
    
    	sidebarMenuVC.menuItemNames = [NSArray arrayWithObjects:@"Test A", @"Test B", nil];

    	sidebarMenuVC.sideBarButtonImageName = @"myImage"

    	self.window.rootViewController = sidebarMenuVC;
    
    	self.window.backgroundColor = [UIColor whiteColor];
    
    	[self.window makeKeyAndVisible];
    
    	return YES;
	}


####Unit Tests
Unit tests are provided in the SidebarMenuViewControllerTest.m file using the XCTest framework.  Optionally add these to your project by:

* Copying the SidebarMenuViewControllerTest.m class to your Test target in Xcode
* Run unit tests via Cmd + U

####Example Xcode Project
This repo is an example Xcode project using the SidebarMenuViewController (see __SidebarCode__ folder).
  
####Contact
* Twitter: [@clintcabanero](http://twitter.com/clintcabanero)
* GitHub: [ccabanero](http:///github.com/ccabanero)


####License
See the LICENSE file for more info.
