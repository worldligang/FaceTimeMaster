//
//  ViewController.m
//  FaceTime
//
//  Created by ligang on 14/12/24.
//  Copyright (c) 2014年 ligang. All rights reserved.
//  微信公众账号iOS开发：iOSDevTip

#import "ViewController.h"
#import <GPUImage/GPUImage.h>
#import "BlurView.h"

@interface ViewController ()
{
    GPUImageVideoCamera *_liveVideo;
    GPUImageBuffer *_videoBuffer;
    GPUImageiOSBlurFilter *_blurFilter;
    GPUImageView *_backgroundImageView;
    BlurView *_recordView; //Update this!
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _videoBuffer = [[GPUImageBuffer alloc] init];
    [_videoBuffer setBufferSize:1];
    
    _backgroundImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_backgroundImageView];
    
    _recordView = [[BlurView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _recordView.hidden = YES;
    [self.view addSubview:_recordView];
    
    [self useLiveCamera];

    
    // 更多iOS技术分析请关注 微信公众账号iOS开发：iOSDevTip
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)useLiveCamera{
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No camera detected"
                                                        message:@"The current device has no camera"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    _liveVideo = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720
                                                     cameraPosition:AVCaptureDevicePositionFront];
    _liveVideo.outputImageOrientation = UIInterfaceOrientationPortrait;
    //    _blurFilter.blurRadiusInPixels = 40.0f;
    [_liveVideo addTarget:_videoBuffer];           //Update this
    [_videoBuffer addTarget:_backgroundImageView]; //Add this
    [_videoBuffer addTarget:_blurFilter];          //And this
    [_blurFilter addTarget:_recordView];           //And finally this
    
    [_liveVideo startCameraCapture];
    
    _recordView.hidden = NO;
    
}

@end
