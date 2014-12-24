FaceTimeMaster
==============


更多iOS技术请关注微信公众账号 iOS开发： iOSDevTip

</br>

	_blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _videoBuffer = [[GPUImageBuffer alloc] init];
    [_videoBuffer setBufferSize:1];
    
    _backgroundImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_backgroundImageView];
    
    _recordView = [[BlurView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _recordView.hidden = YES;
    [self.view addSubview:_recordView];
    
  
  //调用摄像头
    
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