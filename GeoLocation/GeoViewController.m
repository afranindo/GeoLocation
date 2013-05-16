//
//  GeoViewController.m
//  GeoLocation
//
//  Created by ido franindo on 5/15/13.
//  Copyright (c) 2013 suitmedia. All rights reserved.
//

#import "GeoViewController.h"
#import <AFNetworking.h>

@interface GeoViewController ()

@end

@implementation GeoViewController
@synthesize tableView , activityIndicatorView , photos ;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Setting Up Table View
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    // Initializing Data Source
    self.photos = [[NSArray alloc] init];
    
    //    NSURL *url = [[NSURL alloc] initWithString:@"http://itunes.apple.com/search?term=harry&country=us&entity=movie"];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://geophotonizer.herokuapp.com/photos.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
        self.photos = [JSON objectForKey:@"photos"];
        [self.activityIndicatorView stopAnimating];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        [self.activityIndicatorView stopAnimating];
        //make alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Failed with error"
                                                        message:[NSString stringWithFormat:@"%@",error.userInfo]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }];
    [operation start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.photos && self.photos.count) {
        return self.photos.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell Identifier";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text=[NSString stringWithFormat:@"lat:%@, long:%@", [photo objectForKey:@"lat"], [photo objectForKey:@"lng"]];
    
    cell.detailTextLabel.text = [photo objectForKey:@"updated_at"];
    
    
    
    //    NSURL *url = [[NSURL alloc] initWithString:[photo objectForKey:@"artworkUrl100"]];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    cell.imageView.image = [[UIImage alloc] initWithData:data];
    //    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // *myBuddy = [buddies objectAtIndex:indexPath.row];
    NSLog (@"Buddy selected: %@%d",@"tes",indexPath.row );
     NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"location"
                                                    message:[NSString stringWithFormat:@"lat:%@, long:%@", [photo objectForKey:@"lat"], [photo objectForKey:@"lng"]]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

@end
