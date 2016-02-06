//
//  ViewController.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 02/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "ViewController.h"

#import "VideoOutputView.h"
#import "BarcodeBuffer.h"
#import "Barcode.h"

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
    
    [self.barcodeBuffer setBarcodeExpirationTime:1.5];
    [self.videoOutputView startRunning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSRunLoop currentRunLoop] addTimer:[self barcodeExpirationCheckTimer] forMode:NSDefaultRunLoopMode];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.barcodeExpirationCheckTimer invalidate];
    [self setBarcodeExpirationCheckTimer:nil];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataObject* foundMetaObject in metadataObjects) {
        if ([foundMetaObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            AVMetadataMachineReadableCodeObject* foundBarcode = (AVMetadataMachineReadableCodeObject *)foundMetaObject;
            Barcode* barcode = [[Barcode alloc] initWithValue:[foundBarcode stringValue]
                                                         type:[foundBarcode type]
                                                       bounds:[foundBarcode bounds]
                                timestamp:[NSDate date]];
            [self.barcodeBuffer registerOrUpdateBarcode:barcode];
        }
    }
}

- (void)updateBarcodeTextView
{
    NSString* textViewText = @"";
    for (Barcode* barcode in [self.barcodeBuffer barcodes]) {
        NSString* barcodeDescription = [NSString stringWithFormat:@"%@: %@ (%@)", [barcode type], [barcode value], [barcode timestamp]];
        textViewText = [textViewText stringByAppendingString:barcodeDescription];
        textViewText = [textViewText stringByAppendingString:@"\n"];
    }
    
    [self.barcodeTextView setText:textViewText];
}

- (void)checkBarcodeExpiration
{
    NSDate* now = [NSDate date];
    [self.barcodeBuffer cleanupExpiredBarcodesAt:now];
    assert([NSRunLoop currentRunLoop] == [NSRunLoop mainRunLoop]);
    [self performSelectorOnMainThread:@selector(updateBarcodeTextView) withObject:nil waitUntilDone:YES];
}

- (BarcodeBuffer *)barcodeBuffer
{
    if (_barcodeBuffer == nil) {
        _barcodeBuffer = [[BarcodeBuffer alloc] init];
    }
    
    return _barcodeBuffer;
}

- (NSTimer *)barcodeExpirationCheckTimer
{
    if (_barcodeExpirationCheckTimer == nil) {
        _barcodeExpirationCheckTimer = [NSTimer timerWithTimeInterval:.5
                                                               target:self
                                                             selector:@selector(checkBarcodeExpiration)
                                                             userInfo:nil
                                                              repeats:YES];
    }
    
    return _barcodeExpirationCheckTimer;
}

@end
