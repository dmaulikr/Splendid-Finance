//
//  AddNewCategoryViewContrroler.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/25/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import "AddNewCategoryViewContrroler.h"
#import "SplendidAppDelegate.h"

@implementation AddNewCategoryViewContrroler

@synthesize managedObjectContext;
@synthesize catTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Add Category";
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveCategory)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [saveButtonItem release];
    
    UIBarButtonItem *cancelSaveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSave)];
    self.navigationItem.leftBarButtonItem = cancelSaveButtonItem;
    [cancelSaveButtonItem release];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.frame;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
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
     [catTextField becomeFirstResponder];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    catTextField = [[UITextField alloc] initWithFrame:CGRectMake(70.0, 12.0, 170.0, 100.0)];
    catTextField.borderStyle = UITextBorderStyleNone;
    catTextField.placeholder = @"e.g Credit Card Billings";
    catTextField.delegate = self;
    catTextField.keyboardType = UIKeyboardTypeDefault;
    catTextField.textColor = [UIColor darkGrayColor];
    catTextField.adjustsFontSizeToFitWidth = YES;
    catTextField.textAlignment = UITextAlignmentCenter;
   
    
    [cell.contentView addSubview:catTextField];
    [catTextField release];
    
    return cell;
}

- (void) saveCategory {
    
    NSManagedObject *newCategory = [NSEntityDescription insertNewObjectForEntityForName:@"ExpenseCategory" inManagedObjectContext:self.managedObjectContext];
    [newCategory setValue:catTextField.text forKey:@"name"];
    
    NSError *error = nil;
    
    if (![newCategory.managedObjectContext save:&error]) {
        
        NSLog(@"error accurred: %@", [error userInfo]);
        abort();
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) cancelSave {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) checkTextFieldContent {
    
    NSLog(@"called");
    
    if ([self.catTextField.text isEqualToString:@""])
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else 
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"tap");
     NSLog(@"replace: %@", string);
    [self performSelector:@selector(checkTextFieldContent) withObject:nil afterDelay:0.3];
    
    return YES;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
