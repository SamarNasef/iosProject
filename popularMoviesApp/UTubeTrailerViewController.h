//
//  UTubeTrailerViewController.h
//  popularMoviesApp
//
//  Created by JETS on 3/2/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UTubeTrailerViewController : UIViewController <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property NSString *vedioKey;

@property (weak, nonatomic) IBOutlet UIWebView *uTubeWebView;
//@property (weak, nonatomic) IBOutlet UITextView *textView;


@end
