//
//  ViewController.h
//  iOS Example
//
//  Created by James Spann on 8/17/15.
//  Copyright (c) 2015 James Spann. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface ViewController : UIViewController<CLLocationManagerDelegate>{
	CLLocationManager *locationManager;
	CLLocation *mylocation;
}


@end

