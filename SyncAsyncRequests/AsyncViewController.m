//
//  AsyncViewController.m
//  SyncAsyncRequests
//
//  Created by Kaushalya Kularatnam on 06/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AsyncViewController.h"

@implementation AsyncViewController

@synthesize getData = _getData;
@synthesize responseData = _responseData;
@synthesize json_string = _json_string;
@synthesize textView = _textView;

- (void)viewWillAppear:(BOOL)animated
{
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://search.twitter.com/search.json?q=ACDI_CA"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
    _getData = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
    _json_string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"No Connection Error", @"Error message displayed when not connected to the Internet.") forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:userInfo];
        [self handleError:noConnectionError];
    } else {
        // otherwise handle the error generically
        [self handleError:error];
    }
    // Show error message
}

- (void)loadMyView
{
    [super viewDidAppear:YES];
    _textView.text = _json_string;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self loadMyView];
}

- (void)handleError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error Title", @"Title for alert displayed when download or parse error occurs.") message:NSLocalizedString(@"Generic connectivity error", @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
