//
//  GeoViewController.h
//  GeoLocation
//
//  Created by ido franindo on 5/15/13.
//  Copyright (c) 2013 suitmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    UIActivityIndicatorView *_activityIndicatorView;
    NSArray *_movies;
}


@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, retain) NSArray *photos;


@end
