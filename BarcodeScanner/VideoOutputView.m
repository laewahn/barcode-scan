//
//  VideoOutputView.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 03/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "VideoOutputView.h"

@implementation VideoOutputView

- (void)awakeFromNib
{
    [self.layer addSublayer:[self videoPreview]];
}

- (void)layoutSubviews
{
    CGRect bounds = [self bounds];
    [self.videoPreview setFrame:bounds];
}

- (void)startRunning
{
    [self.captureSession startRunning];
}

- (void)addCaptureOutput:(AVCaptureOutput *)output
{
    [self.captureSession addOutput:output];
}

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
