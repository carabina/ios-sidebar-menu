//
//  SidebarMenuViewControllerTest.m
//  Sidebar
//
//  Created by Clint Cabanero on 9/3/14.
//  Copyright (c) 2014 Big Leaf Mobile LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SidebarMenuViewController.h"
#import "TestAViewController.h"
#import "TestBViewController.h"
#import "TestCViewController.h"

@interface SidebarMenuViewControllerTest : XCTestCase

//system under test
@property (nonatomic, strong) SidebarMenuViewController *viewControllerUnderTest;

@end


@implementation SidebarMenuViewControllerTest

- (void)setUp {
    
    [super setUp];
    
    
    //instantiate the system under test (i.e. SidebarMenu)
    self.viewControllerUnderTest = [[SidebarMenuViewController alloc] initWithNibName:@"SidebarMenuViewController" bundle:nil];
    
    
    //instantiate a collection of ViewControllers - to be launched when user taps a sidebar menu item
    TestAViewController *testAViewController = [[TestAViewController alloc] initWithNibName:@"TestAViewController" bundle:nil];
    
    TestBViewController *testBViewController = [[TestBViewController alloc] initWithNibName:@"TestBViewController" bundle:nil];
    
    TestCViewController *testCViewController = [[TestCViewController alloc] initWithNibName:@"TestCViewController" bundle:nil];
    
    self.viewControllerUnderTest.menuItemViewControllers = [[NSArray alloc] initWithObjects:testAViewController, testBViewController, testCViewController, nil];
    
    
    //set the user-friendly names for each sidebar menu item
    self.viewControllerUnderTest.menuItemNames = [[NSArray alloc] initWithObjects:@"Sidebar menu item 1", @"Sidebar menu item 2", @"Sidebar menu item 3", nil];
    
    
    //load the controller's view hierarchy
    [self.viewControllerUnderTest performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
    [self.viewControllerUnderTest performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
}

- (void)tearDown {
    
    self.viewControllerUnderTest = nil;
    
    [super tearDown];
}


//------------------------------------------------------------------------------------------------
//  Feature: Sidebar Menu Items are presented to the user as a scrollable list (i.e. UITableView)
//------------------------------------------------------------------------------------------------

- (void)testSidebarMenuViewControllerIsComposedOfTableView {
    
    NSArray *subViews = self.viewControllerUnderTest.view.subviews;
    
    XCTAssertTrue([subViews containsObject:self.viewControllerUnderTest.tableView], @"ViewController under test is not composed of a UITableView");
}

- (void)testTableViewHasDataSource {
    
    //the UITableView's DataSource is set as the view controller under test
    XCTAssertNotNil(self.viewControllerUnderTest.tableView.dataSource, @"ViewController under test's UITableViewDataSource is not connected");
}

- (void)testViewControllerConformsToTableViewDataSource {
    
    XCTAssertTrue([self.viewControllerUnderTest conformsToProtocol:@protocol(UITableViewDataSource)], @"ViewController under test does not conform to the UITableViewDataSource prototocol");
}

- (void)testSidebarMenuViewControllerImplementsUITableViewDatasourceProtocolMethods {
    
    //UITableViewDataSource protocol methods of interest
    XCTAssertTrue([self.viewControllerUnderTest respondsToSelector:@selector(numberOfSectionsInTableView:)], @"ViewController under test does not implement numberOfSectionsInTableView protocol method");
    
    XCTAssertTrue([self.viewControllerUnderTest respondsToSelector:@selector(tableView:numberOfRowsInSection:)], @"ViewController under test does not implement numberOfRowsInSection protocol method");
    
    XCTAssertTrue([self.viewControllerUnderTest respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)], @"ViewController under test does not implement cellForRowAtIndexPath");
}

- (void)testTableViewHasDelegate {
    
    //the UITableView's Delegate is set as the view controller under test
    XCTAssertNotNil(self.viewControllerUnderTest.tableView.delegate, @"ViewController under test's UITableViewDelegate is not connected");
}

- (void)testSidebarMenuViewControllerConformsToTableViewDelegate {
    
    XCTAssertTrue([self.viewControllerUnderTest conformsToProtocol:@protocol(UITableViewDelegate)], @"ViewController under test does not conform to the UITableViewDelegate protocol.");
}

- (void)testSidebarMenuViewControllerImplementsUITableViewDelegateProtocolMethods {
    
    //UITableViewDelegate protocol methods
    XCTAssertTrue([self.viewControllerUnderTest respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)], @"ViewController under test does not implement tableView:didSelectRowAtIndexPath: protocol method");
}


//-----------------------------------------------------------------------------------------------
//  Feature: Users (i.e. client code) can explicitly declare the names of each Sidebar Menu Item
//-----------------------------------------------------------------------------------------------

- (void)testSidebarMenuViewControllerHasMenuItemNamesArray {
    
    XCTAssertNotNil(self.viewControllerUnderTest.menuItemNames, @"ViewController under test does not have a collection of sidebar menu item names");
}

- (void)testTableViewCellsHaveCorrectTextLabel {

    NSIndexPath *rowIndex0 = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UITableViewCell *cell0 = [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView cellForRowAtIndexPath:rowIndex0];
    
    XCTAssert([cell0.textLabel.text isEqualToString:@"Sidebar menu item 1"], @"ViewController under test is composed of a UITableView that has improperly initialized UITableViewCell textLabel.text properties");
    
    
    NSIndexPath *rowIndex1 = [NSIndexPath indexPathForRow:1 inSection:0];
    
    UITableViewCell *cell1 = [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView cellForRowAtIndexPath:rowIndex1];
    
    XCTAssert([cell1.textLabel.text isEqualToString:@"Sidebar menu item 2"], @"ViewController under test is composed of a UITableView that has improperly initialized UITableViewCell textLabel.text properties");
    

    NSIndexPath *rowIndex2 = [NSIndexPath indexPathForRow:2 inSection:0];
    
    UITableViewCell *cell2 = [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView cellForRowAtIndexPath:rowIndex2];
    
    XCTAssert([cell2.textLabel.text isEqualToString:@"Sidebar menu item 3"], @"ViewController under test is composed of a UITableView that has improperly initialized UITableViewCell textLabel.text properties");
}


//-------------------------------------------------------------------------------------------------
//  Feature: When a user taps a Sidebar menu item, it will launch the corresponding ViewController
//-------------------------------------------------------------------------------------------------

- (void)testSidebarMenuViewControllerHasACollectionOfViewControllers {
    
    XCTAssertNotNil(self.viewControllerUnderTest.menuItemViewControllers, @"ViewController under test does not have a collection of view controllers for each menu item");
    
    UIViewController *lastViewController = [self.viewControllerUnderTest.menuItemViewControllers lastObject];
    
    XCTAssert([lastViewController isKindOfClass:[UIViewController class]], @"The 'menuItemViewControllers' property of ViewController under test are not of type UIViewController");
}

- (void)testSidebarMenuViewControllerSelectionLauncheCorrectViewController {
    
    //simulate user selecting the FIRST Sidebar menu item (i.e. index 0)
    [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //confirm that the view controller in the container is the correct view controller
    NSArray *childViewControllersAfterFirstSelection = [self.viewControllerUnderTest.containerController childViewControllers];
    
    UIViewController *firstViewController = [childViewControllersAfterFirstSelection lastObject];
    
    XCTAssert([firstViewController isKindOfClass:[TestAViewController class]], @"When user selects the first sidebar menu item, the wrong view controller is presented");
    
    
    //simulate user selecting the SECOND Sidebar menu item (i.e. index 1)
    [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    //confirm that the view controller in the container is the correct view controller
    NSArray *childViewControllersAfterSecondSelection = [self.viewControllerUnderTest.containerController childViewControllers];
    
    UIViewController *secondViewController = [childViewControllersAfterSecondSelection lastObject];
    
    XCTAssert([secondViewController isKindOfClass:[TestBViewController class]], @"When user selects the second sidebar menu item, the wrong view controller is presented");
    
    
    //simulate user selecting the THIRD Sidebar menu item (i.e. index 2)
    [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    //confirm that the view controller in the container is the correct view controller
    NSArray *childViewControllersAfterThirdSelection = [self.viewControllerUnderTest.containerController childViewControllers];
    
    UIViewController *thirdViewController = [childViewControllersAfterThirdSelection lastObject];
    
    XCTAssert([thirdViewController isKindOfClass:[TestCViewController class]], @"When user selects the third sidebar menu item, the wrong view controller is presented");
}

//ensure sidebar menu item selection does add multiple child view controllers to the navigation stack
- (void)testContainerNavigationControllerAlwaysHasOneChild {
    
    //simulate user selecting the FIRST Sidebar menu item (i.e. index 0)
    [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    XCTAssert([self.viewControllerUnderTest.containerController.childViewControllers count] == 1, @"Multiple child view controllers added to the Container Navigation Controller");
    
    
    //simulate user selecting the SECOND Sidebar menu item (i.e. index 1)
    [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    XCTAssert([self.viewControllerUnderTest.containerController.childViewControllers count] == 1, @"Multiple child view controllers added to the Container Navigation Controller");
    
    
    //simulate user selecting the THIRD Sidebar menu item (i.e. index 2)
    [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    XCTAssert([self.viewControllerUnderTest.containerController.childViewControllers count] == 1, @"Multiple child view controllers added to the Container Navigation Controller");
}


//------------------------------------------------------------------------------------------------------------------------
//  Feature: When the selected view controller is presented, it is within a navigation controller with a 'left sidebar button'
//------------------------------------------------------------------------------------------------------------------------
- (void)testTargetViewControllerHasASideBarButton {
    
    //simulate user selecting a sidebar menu item
    [self.viewControllerUnderTest tableView:self.viewControllerUnderTest.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    UIViewController *targetViewController = [[self.viewControllerUnderTest.containerController childViewControllers] lastObject];

    XCTAssert(targetViewController.navigationItem.leftBarButtonItem, @"Target ViewController does not have a leftBarButtonItem");
}

//---------------------------------------------------------------------------------------
//  Feautre: When user taps the 'sidebar button' the target view controller opens/closes
//---------------------------------------------------------------------------------------
- (void)testTargetViewControllerToggleOpenedAndClosed {
    
    //simulate user tapping the sidebar bar button (opening it)
    [self.viewControllerUnderTest toggleSidebar:nil];

    CGFloat xFirstPosition = self.viewControllerUnderTest.containerController.view.frame.origin.x;
    
    NSLog(@"%f", xFirstPosition);
    
    XCTAssert(xFirstPosition > 0, @"TargetViewController did not toggle open");
    
    
    //simulate user tapping the sidebar bar button (closing it)
    [self.viewControllerUnderTest toggleSidebar:nil];
    
    CGFloat xSecondPosition = self.viewControllerUnderTest.containerController.view.frame.origin.x;
    
    NSLog(@"%f", xSecondPosition);
    
    XCTAssert(xSecondPosition == 0, @"TargetViewController did not toggle closed");
}


@end
