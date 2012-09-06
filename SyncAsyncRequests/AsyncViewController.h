//
//  AsyncViewController.h
//  SyncAsyncRequests
//
//  Created by Kaushalya Kularatnam on 06/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsyncViewController : UIViewController <NSURLConnectionDelegate>
{
    NSMutableData* responseData;
}

@property (nonatomic, retain) NSURLConnection *getData;
@property (retain, nonatomic) NSMutableData* responseData;
@property (nonatomic, retain) NSString *json_string;
@property (nonatomic,retain) IBOutlet UITextView * textView;

@end
