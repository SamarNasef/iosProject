//
//  MoviesCollectionView.m
//  popularMoviesApp
//
//  Created by JETS on 3/2/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "MoviesCollectionView.h"

@interface MoviesCollectionView ()
{
    NSMutableData *receivedData;
    NSMutableArray *postersArray;
    
}

@end

@implementation MoviesCollectionView

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
   
    NSString *apiRequest = @"https://api.themoviedb.org/3/movie/upcoming?api_key=4e8278327c3d58574a07da7850a08ce3";
    
    
    
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


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
 
    return [postersArray count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    static NSString *CellIdentifier = @"cell";
    UICollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [postersArray objectAtIndex:indexPath.row]  ]];
    
    
   UIImageView *imgView= (UIImageView *)[cell viewWithTag:1];
    
    
    [imgView setImage:[UIImage imageWithData: imageData]];
    
    return cell;
    
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
  
    [receivedData appendData:data];
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    receivedData = [NSMutableData new];
    postersArray=[NSMutableArray array];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:nil];
    
    
for(int i=0;i<10;i++){
    
    NSMutableString *imgPath=[[NSMutableString alloc]initWithString:@"http://image.tmdb.org/t/p/w185/"];
    NSDictionary *dict2= [dict objectForKey:@"results"][i];
    [imgPath appendString:[dict2 objectForKey:@"poster_path"]];
    
    
    [postersArray addObject:imgPath];
}
     [self.collectionView reloadData];

    
    
    
}



@end
