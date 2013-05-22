//
//  MapViewController.m
//  GeoLocation
//
//  Created by ido franindo on 5/20/13.
//  Copyright (c) 2013 suitmedia. All rights reserved.
//

#import "MapViewController.h"

#define area 5000000

@interface MapViewController ()

@end

@implementation MapViewController{
    CLLocationManager *locationManager;
}
@synthesize mapView,locationLabel,latitude,longitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
      self.mapView.delegate = self;
    locationLabel.text=[NSString stringWithFormat:@"latitude->%@, longitude->%@",latitude,longitude];
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
        
    // 1
    CLLocationCoordinate2D zoomLocation;//=CLLocationCoordinate2DMake(49, -107);;
    zoomLocation.latitude = [latitude doubleValue];
    zoomLocation.longitude= [longitude doubleValue];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 1;     // 0.0 is min value u van provide for zooming
    span.longitudeDelta= 1;

    
    // 2
    MKCoordinateRegion viewRegion  = MKCoordinateRegionMakeWithDistance(zoomLocation, area,area);
//  viewRegion.span=span;
//    viewRegion.center = zoomLocation;
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = @"location?";
    point.subtitle = [NSString stringWithFormat:@"latitude->%@, longitude->%@",latitude,longitude];;
    
    [self.mapView addAnnotation:point];
    


    
    // 3
      // [mapView setRegion:viewRegion animated:YES];
   [self.mapView setRegion:[self.mapView regionThatFits:viewRegion] animated:YES];
   
//    [mapView setCenterCoordinate:zoomLocation animated:YES];
    
    
         
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5000000, 5000000);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//
//    // Add an annotation
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    point.title = @"Where am I?";
//    point.subtitle = @"I'm here!!!";
//
//    [self.mapView addAnnotation:point];
//}


@end
