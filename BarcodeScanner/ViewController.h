//
//  ViewController.h
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 02/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property(nonatomic, strong) AVCaptureDevice* captureDevice;
@property(nonatomic, strong) AVCaptureDeviceInput* captureInput;
@property(nonatomic, strong) AVCaptureSession* captureSession;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer* videoPreview;

@end

