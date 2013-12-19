//
//  ASOViewController.m
//  AssociatedObjs
//
//  Created by Chris Stroud on 12/19/13.
//  Copyright (c) 2013 Triangle Cocoa. All rights reserved.
//

#import "ASOTableViewController.h"
#import <objc/runtime.h>

static const char * kPreviousKey = "previousIndexKey";    // Key for the previous index path association
static const char * kCurrentKey  = "currentIndexKey";     // Key for the current index path association

@implementation ASOTableViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the cell to display the current index path. It's just so boring otherwise!
    cell.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];
    
    // Format a string stating the current index
    NSString * marker = [NSString stringWithFormat:@"Current Index: %i", indexPath.row];
    
    // Associate that string with the cell
    objc_setAssociatedObject(cell, kCurrentKey, marker, OBJC_ASSOCIATION_COPY);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Format a string stating the previous index
    NSString * marker = [NSString stringWithFormat:@"Previous Index: %i", indexPath.row];
    
    // Associate that string with the cell
    objc_setAssociatedObject(cell, kPreviousKey, marker, OBJC_ASSOCIATION_COPY);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Get a reference to the selected cell from the table
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // Get the previous index string
    NSString * prevString = objc_getAssociatedObject(cell, kPreviousKey);
    
    // Get the current index string
    NSString * currString = objc_getAssociatedObject(cell, kCurrentKey);
    
    // Just in case either of the object aren't there, handle that.
    // We'll be fine since we made strong associations.
    if (!currString) {
        currString = @"NO MORE";
    }
    if (!prevString) {
        prevString = @"This has all the makings of your lucky day!";
    }
    
    // Show the value
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:currString
                                                     message:prevString
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
}

@end
