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
@class BarcodeBuffer;

@interface ViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet VideoOutputView *videoOutputView;
@property (weak, nonatomic) IBOutlet UITextView *barcodeTextView;

@property (strong, nonatomic) BarcodeBuffer* barcodeBuffer;

@end

