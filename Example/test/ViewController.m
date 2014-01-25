//
//  ViewController.m
//  test
//
//  Created by Wojtek Siudzinski on 11.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height)];
    
    [self.view addSubview:accordion];
    self.view.backgroundColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1.000];
    
    // Only height is taken into account, so other parameters are just dummy
    UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    [header1 setTitle:@"First row" forState:UIControlStateNormal];
    header1.backgroundColor = [UIColor colorWithRed:0.086 green:0.627 blue:0.522 alpha:1.000];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    view1.backgroundColor = [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.000];
    
    UIButton *removeSecondRowButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 75, 200, 50)];
    [removeSecondRowButton setTitle:@"Remove second row" forState:UIControlStateNormal];
    removeSecondRowButton.backgroundColor = [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1.000];
    [removeSecondRowButton addTarget:self action:@selector(removeSecondRow) forControlEvents:UIControlEventTouchDown];
    [view1 addSubview:removeSecondRowButton];
    
    [accordion addHeader:header1 withView:view1];

    
    UIButton *header2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    [header2 setTitle:@"Second row" forState:UIControlStateNormal];
    header2.backgroundColor = [UIColor colorWithRed:0.557 green:0.267 blue:0.678 alpha:1.000];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    view2.backgroundColor = [UIColor colorWithRed:0.608 green:0.349 blue:0.714 alpha:1.000];
    
    [accordion addHeader:header2 withView:view2];
    
    
    UIButton *header3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    [header3 setTitle:@"Third row" forState:UIControlStateNormal];
    header3.backgroundColor = [UIColor colorWithRed:0.827 green:0.329 blue:0.000 alpha:1.000];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    view3.backgroundColor = [UIColor colorWithRed:0.902 green:0.494 blue:0.133 alpha:1.000];
    
    [accordion addHeader:header3 withView:view3];
    
    
    [accordion setNeedsLayout];
    
    // Set this if you want to allow multiple selection
    [accordion setAllowsMultipleSelection:YES];
    
    // Set this to NO if you want to have at least one open section at all times
    [accordion setAllowsEmptySelection:YES];
}

- (void)removeSecondRow {
    [accordion removeHeaderAtIndex:1];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
