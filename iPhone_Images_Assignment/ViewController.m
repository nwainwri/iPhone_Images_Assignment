//
//  ViewController.m
//  iPhone_Images_Assignment
//
//  Created by Nathan Wainwright on 2018-08-16.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *currentPhoneImagePulled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // BLACK : https://i.imgur.com/bktnImE.png
    // JET BLACK : https://i.imgur.com/zdwdenZ.png
    // GOLD : https://i.imgur.com/CoQ8aNl.png
    // SILVER : https://i.imgur.com/2vQtZBb.png
    // ROSE GOLD : https://i.imgur.com/y9MIaCS.png
    
    // make random between 1 - 5
    // pull said items string for URL...
    // pass into below thing.
    
    
    NSArray *urlsToPass = @[@"https://i.imgur.com/bktnImE.png", @"https://i.imgur.com/zdwdenZ.png", @"https://i.imgur.com/CoQ8aNl.png", @"https://i.imgur.com/2vQtZBb.png", @"https://i.imgur.com/y9MIaCS.png"];
    
    
    //        NSURL *url = [NSURL URLWithString:@"http://i.imgur.com/bktnImE.png"]; // 1 MAIN
    
    NSURL *url = [NSURL URLWithString:urlsToPass[0]]; // 1 MAIN
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2 MAIN
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3 MAIN
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url
                                                        completionHandler:^(NSURL * _Nullable location,
                                                                            NSURLResponse * _Nullable response,
                                                                            NSError * _Nullable error)
                                              {
                                                  
                                                  if (error) { // 1
                                                      // Handle the error
                                                      NSLog(@"error: %@", error.localizedDescription);
                                                      return;
                                                  }
                                                  
                                                  NSData *data = [NSData dataWithContentsOfURL:location];
                                                  UIImage *image = [UIImage imageWithData:data]; // 2
                                                  
                                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                      // This will run on the main queue
                                                      
                                                      self.currentPhoneImagePulled.image = image; // 4
                                                  }];
                                                  
                                              }]; // 4  MAIN
    
    [downloadTask resume]; // 5 MAIN
    
    
    //    1. MAIN Create a new NSURL object from the iPhone image url string.
    
    //    2. MAIN  An NSURLSessionConfiguration object defines the behavior and policies to use when making a request with an NSURLSession object. We can set things like the caching policy on this object. The default system values are good for now, so we'll just grab the default configuration.
    
    //  3.  MAIN      Create an NSURLSession object using our session configuration. Any changes we want to make to our configuration object must be done before this.
    
    //  4.   MAIN     We create a task that will actually download the image from the server. The session creates and configures the task and the task makes the request. Download tasks retrieve data in the form of a file, and support background downloads and uploads while the app is not running. Check out the NSURLSession API Referece for more info on this. We could optionally use a delegate to get notified when the request has completed, but we're going to use a completion block instead. This block will get called when the network request is complete, weather it was successful or not.
    
    //  5.   MAIN       A task is created in a suspended state, so we need to resume it. We can also You can also suspend, resume and cancel tasks whenever we want.
    
    //    The completion handler takes 3 parameters:
    //
    //location: The location of a file we just downloaded on the device.
    //response: Response metadata such as HTTP headers and status codes.
    //error: An NSError that indicates why the request failed, or nil when the request is successful.
    //  1  If there was an error, we want to handle it straight away so we can fix it. Here we're checking if there was an error, logging the description, then returning out of the block since there's no point in continuing.
    //  2  The download task downloads the file to the iPhone then lets us know the location of the download using a local URL. In order to access this as a UIImage object, we need to first convert the file's binary into an NSData object, then create a UIImage from that data.
    //  3  The only thing left to do is display the image on the screen. This is almost as simple as self.iPhoneImageView.image = image; however the networking happens on a background thread and the UI can only be updated on the main thread. This means that we need to make sure that this line of code runs on the main thread.
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
