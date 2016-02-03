//
//  ViewController.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 02/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.videoOutputView.layer addSublayer:[self videoPreview]];
    [self.captureSession startRunning];
}

- (void)viewDidLayoutSubviews
{
    CGRect videoOutputBounds = [self.videoOutputView bounds];
    [self.videoPreview setFrame:videoOutputBounds];
}

# pragma mark Property initializers

- (AVCaptureDevice *)captureDevice
{
    if (_captureDevice == nil) {
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return _captureDevice;
}

- (AVCaptureDeviceInput *)captureInput
{
    if (_captureInput == nil) {
        NSError* inputDeviceCreationError;
        _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:[self captureDevice] error:&inputDeviceCreationError];
        
        if (inputDeviceCreationError != nil) {
            NSLog(@"Creating input device failed with error: %@", inputDeviceCreationError);
        }
    }
    
    return _captureInput;
}

- (AVCaptureSession *)captureSession
{
    if (_captureSession == nil) {
        _captureSession = [[AVCaptureSession alloc] init];
        [_captureSession addInput:[self captureInput]];
    }
    
    return _captureSession;
}

- (AVCaptureVideoPreviewLayer *)videoPreview
{
    if (_videoPreview == nil) {
        _videoPreview = [AVCaptureVideoPreviewLayer layerWithSession:[self captureSession]];
        [_videoPreview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    }
    
    return _videoPreview;
}

@end
