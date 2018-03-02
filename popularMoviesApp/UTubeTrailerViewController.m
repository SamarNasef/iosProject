//
//  UTubeTrailerViewController.m
//  popularMoviesApp
//
//  Created by JETS on 3/2/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "UTubeTrailerViewController.h"

@interface UTubeTrailerViewController ()
{
    
    NSMutableData *receivedData;
}


@end

@implementation UTubeTrailerViewController

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
    
    NSLog(@"VEDIO key : %@",_vedioKey);
    
    
    NSMutableString *trailerUrl= [[NSMutableString alloc] initWithString:@"https://www.youtube.com/watch?v="];
    [trailerUrl appendString:_vedioKey];
   
    
    
    NSURL *url = [NSURL URLWithString:trailerUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *con = [[NSURLConnection alloc]  initWithRequest:request delegate:self];
    [con start];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receivedData appendData:data];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    receivedData = [NSMutableData new];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *resp = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
   
    [_uTubeWebView loadHTMLString:resp baseURL:nil];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
