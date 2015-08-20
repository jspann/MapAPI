//
//  ViewController.m
//  iOS Example
//
//  Created by James Spann on 8/17/15.
//  Copyright (c) 2015 James Spann. All rights reserved.
//

#import "ViewController.h"

#define SERVERPORT 80
NSString *SERVERIP = @"ritmap.jspann.me";

NSString *FROM = @"KGH";
NSString *TO = @"NRH";

NSArray *results;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	NSLog(@"App started");
	[self makeDirectionsRequestStarting:FROM Ending:TO];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

//This custom method sends a directions request from a starting location to an ending location
-(void)makeDirectionsRequestStarting:(NSString *)starting Ending:(NSString *)ending{
	NSLog(@"Directions request between %@ and %@",starting,ending);
	
	NSString *post = [NSString stringWithFormat:@"{\"type\":\"getdirections\",\"from\":\"%@\",\"to\":\"%@\",\"mode\":\"walking\"}",starting,ending];
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d",SERVERIP,SERVERPORT]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if(conn) {
		NSLog(@"Connection Successful");
	} else {
		NSLog(@"Connection could not be made");
	}
	
}


//This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
	NSString *output = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"data:%@",output);
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
	NSString *response = [json valueForKey:@"response"];
	NSLog(@"%@",response);
	
	
	//This loop is called when there is an error
	if ([response isEqualToString:@"Error"]) {
		
		if ([[json valueForKey:@"type"] isEqualToString:@"getdirections"]) {
			
		}else if ([[json valueForKey:@"type"] isEqualToString:@"hello"]) {
			UIAlertView *erralert = [[UIAlertView alloc]initWithTitle:@"Uh oh!" message:@"A connection was not properly made to the server" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
			[erralert show];
		}

	//This loop is calleed when a successful request was sent when requesting directions between buildings
	}else if([response isEqualToString:@"OK"] && [[json valueForKey:@"type"] isEqualToString:@"getdirections"]){
		
		//What the server returns
		results = [json valueForKey:@"directionslist"];
		NSLog(@"Directions: %@",results);
	
	//This loop is calleed when a successful request was sent when requesting the building closest to a latitude and longitude
	}else if([response isEqualToString:@"OK"] && [[json valueForKey:@"type"] isEqualToString:@"getclosestnode"]){
		UIAlertView *localert = [[UIAlertView alloc]initWithTitle:@"The building closest to you is:" message:[json valueForKey:@"Name"] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
		[localert show];
		
	}
}

//This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	UIAlertView *erralert = [[UIAlertView alloc]initWithTitle:@"Uh oh!" message:@"A connection was not properly made to the server" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
	[erralert show];
	NSLog(@"Err: %@",error);
}

//This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
	
}
@end
