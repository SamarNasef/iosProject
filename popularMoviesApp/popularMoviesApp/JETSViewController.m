//
//  JETSViewController.m
//  popularMoviesApp
//
//  Created by JETS on 3/2/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "JETSViewController.h"

@interface JETSViewController ()
{
    NSMutableData *receivedData;
    NSDictionary *dict;
    NSInteger numberOfTrailer;
}

@end

@implementation JETSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
     NSData * imgData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[_moviedata img]]];
    [_img setImage:[UIImage imageWithData: imgData]];
    [_titleLabel setText:[_moviedata title]];
    [_overviewLabel setText:[_moviedata overView]];
    [_releasedDateLabel setText:[_moviedata releasedDate]];
    [_rateLabel setText:[NSString stringWithFormat:@"%@",[_moviedata rate]]];
    
    //req to get trailers
    NSMutableString *apiRequest = [[NSMutableString alloc]initWithString: @"https://api.themoviedb.org/3/movie/"];
    [apiRequest appendString:[NSString stringWithFormat:@"%@",[_moviedata idOfMovie]]];
    [apiRequest appendString:@"?api_key=4e8278327c3d58574a07da7850a08ce3&append_to_response=videos"];
    
    
    NSURL *url = [NSURL URLWithString:apiRequest];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *con = [[NSURLConnection alloc]  initWithRequest:request delegate:self];
    [con start];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return numberOfTrailer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"trailerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell =[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    NSMutableString *cellText =[[NSMutableString alloc] initWithString:@"Trailer "];
    [cellText appendString:[NSString stringWithFormat:@"%i",(indexPath.row)+1]];
    
    cell.textLabel.text=cellText;
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict2= [dict objectForKey:@"videos"];
    NSDictionary *dict3= [dict2 objectForKey:@"results"][indexPath.row];
    NSLog(@"key = %@",[dict3 objectForKey:@"key"]);
    
    
    UTubeTrailerViewController *utubeView = [self.storyboard instantiateViewControllerWithIdentifier:@"uTubeVC"];
   
    [utubeView setVedioKey:[dict3 objectForKey:@"key"]];
    [self.navigationController pushViewController:utubeView animated:YES];
    
    
}




-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    [receivedData appendData:data];
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    receivedData = [NSMutableData new];
   
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    dict = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:nil];
    
    
    NSDictionary *dict2= [dict objectForKey:@"videos"];
    numberOfTrailer =[[dict2 objectForKey:@"results"]count];
    //NSLog(@"len of trailer array: %i",numberOfTrailer);
    
    
    printf("load trailer view");
    _trailerView.dataSource=self;
    _trailerView.delegate=self;
  
    
    
}



@end
