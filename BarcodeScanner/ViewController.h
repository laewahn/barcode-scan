//
//  ViewController.h
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 02/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class VideoOutputView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet VideoOutputView *videoOutputView;

@end

