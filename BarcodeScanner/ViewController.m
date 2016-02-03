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
    
    [self.videoOutputView startRunning];
}

@end
