//
//  ViewController.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 02/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "ViewController.h"

#import "VideoOutputView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVCaptureMetadataOutput* barcodeCaptureOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.videoOutputView addCaptureOutput:barcodeCaptureOutput];

    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("barcodeScanQueue", NULL);
    [barcodeCaptureOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    NSArray* availableMetadataObjectTypes = [barcodeCaptureOutput availableMetadataObjectTypes];
    [barcodeCaptureOutput setMetadataObjectTypes:availableMetadataObjectTypes];
    

    [self.videoOutputView startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataObject* barcode in metadataObjects) {
        NSLog(@"Found barcode: %@", barcode);
    }
}

@end
