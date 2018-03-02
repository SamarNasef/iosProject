//
//  JETSViewController.h
//  popularMoviesApp
//
//  Created by JETS on 3/2/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetails.h"
#import "UTubeTrailerViewController.h"

@interface JETSViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@property (weak, nonatomic) IBOutlet UILabel *releasedDateLabel;

@property (weak, nonatomic) IBOutlet UITableView *trailerView;

@property MovieDetails * moviedata;

@end
