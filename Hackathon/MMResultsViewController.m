//
//  MMResultsViewController.m
//  Hackathon
//
//  Created by Roberto on 11/8/13.
//  Copyright (c) 2013 Medallia. All rights reserved.
//

#import "MMResultsViewController.h"

@interface MMResultsViewController ()

@end

@implementation MMResultsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
		//self.className = @"Response";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Response"];
	
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
	
    [query orderByDescending:@"createdAt"];
	
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
	
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = [NSString stringWithFormat:@"%@ years - %@ - %@",
								[object objectForKey:@"YearsOfExperience"],
								[object objectForKey:@"OverallExperience"],
								[object objectForKey:@"ChallengeType"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Created at: %@",
                                 object.createdAt];
	
    return cell;
}
@end
