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


# pragma mark ViewController life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeBarcodeCapture];
    
    [self.barcodeBuffer setBarcodeExpirationTime:1.5];
    [self.videoOutputView startRunning];
}

- (void)initializeBarcodeCapture
{
    AVCaptureMetadataOutput* barcodeCaptureOutput = [[AVCaptureMetadataOutput alloc] init];
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("barcodeScanQueue", NULL);
    [barcodeCaptureOutput setMetadataObjectsDelegate:self queue:dispatchQueue];

    [self.videoOutputView addCaptureOutput:barcodeCaptureOutput];
    
    [barcodeCaptureOutput setMetadataObjectTypes:@[
                                                   AVMetadataObjectTypeCode128Code,
                                                   AVMetadataObjectTypeCode39Code
                                                   ]];
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


# pragma mark Property implementation

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


# pragma mark AVCaptureMetadataOutputObjectsDelegate implementation

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


# pragma mark Expiration timer callback 

- (void)checkBarcodeExpiration
{
    [self.barcodeBuffer cleanupExpiredBarcodesAt:[NSDate date]];
    [self updateBarcodeTextView];
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

@end
