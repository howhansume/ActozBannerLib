//
//  ActozBanner.m
//  ActozBanner
//
//  Created by 구정현 on 13. 6. 10..
//  Copyright (c) 2013년 구정현. All rights reserved.
//

#import "ActozBanner.h"
#import <QuartzCore/QuartzCore.h>
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height-20
@interface ActozBanner(){
    UIView *bannerview;
    NSTimer *rollingtimer;
    UIButton *closebtn;
    
    UIView *linebannerview;
}
@property(nonatomic, assign)UIButton *closebtn;

-(void)requestBanner:(NSString*)url;
@end


@implementation ActozBanner
@synthesize arrowtype, delegate,closebtn,bannertype;

#pragma mark 배너 시작
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"1111");
     return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    //return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //처음 실행할때 어디로 열릴것이냐...
    return 0;
}
-(BOOL)shouldAutorotate
{
    return YES;
}

/*
- (void)willAnimateSecondHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                                     duration:(NSTimeInterval)duration
{
    
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"111");
}
 */

#pragma mark 앱 방향 관련
- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration
              curve:(int)curve degrees:(CGFloat)degrees
{
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    /*
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
     */
}
-(CGFloat)landscape
{
    UIInterfaceOrientation o = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    CGFloat angle = 0;
    switch (o) {
        case UIDeviceOrientationLandscapeLeft: angle = 90; break;
        case UIDeviceOrientationLandscapeRight: angle = -90; break;
        case UIDeviceOrientationPortraitUpsideDown: angle = 180; break;
        default: break;
    }
    
    NSLog(@"angle is %f",angle);
    return  angle;
    
}
-(void)rotate
{
    CGFloat angle = [self landscape];
    //왼쪽으로 전환
    if (angle==90 || angle==-90) {
        
        CGSize winsize = CGSizeMake((HEIGHT+20), (WIDTH-20));
        
        bannerview.center=CGPointMake(winsize.width/2, winsize.height/2);
        
       
        
        
    }
    else
    {
        bannerview.center=CGPointMake(WIDTH/2, (HEIGHT)/2);
    }
    
    CGSize newsize=CGSizeZero;
    
    if ([self landscape] != 0) {
        newsize=CGSizeMake(HEIGHT+20, WIDTH-20);
    }
    else
    {
        newsize=CGSizeMake(WIDTH, HEIGHT);
    }
    
    if (!linebannerview) {
        linebannerview = [[UIView alloc] init];
    }
    //lefttop
    if (bannertype==1) {
        linebannerview.frame=CGRectMake(0, 0, 300, 44);
        
    }
    else if(bannertype==2)
    {
        linebannerview.frame=CGRectMake(newsize.width-300, 0, 300, 44);
    }
    else if(bannertype==3)
    {
        linebannerview.frame=CGRectMake(0, newsize.height-44, 300, 44);
        
    }
    else if(bannertype==4)
    {
        linebannerview.frame=CGRectMake(newsize.width-300, newsize.height-44, 300, 44);
    }
    else
    {
        linebannerview.frame=CGRectMake(0, 0, 300, 44);
        
    }
    
    
}



#pragma mark bannerRequest & banner move
-(void)finishBannerMove
{
    //서버로 배너 요청 성공시 배너 롤링한다.
    if (arrowtype==1) {
        bannerview.center=CGPointMake(bannerview.center.x, bannerview.center.y/3);
        
    }
    else if (arrowtype==2) {
        bannerview.center=CGPointMake(bannerview.center.x/3, bannerview.center.y);
    }
    else if (arrowtype==3) {
        bannerview.center=CGPointMake(bannerview.center.x, -1*bannerview.center.y);
    }
    else if (arrowtype==4) {
        bannerview.center=CGPointMake(bannerview.center.x*-1, bannerview.center.y);
    }
    
    
}
-(void)bannerRequest
{
    
    CGFloat angle = [self landscape];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:0];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishBannerMove)];
    
    
    
    //왼쪽
    if (angle==90) {
        
    }
    else if(angle==-90)
    {
        //오른쪽
    }
    else if(angle==0)
    {
        //정면
    }
    
    
    //서버로 배너 요청 성공시 배너 롤링한다.
    if (arrowtype==1) {
        bannerview.center=CGPointMake(bannerview.center.x, bannerview.center.y*3);
        
    }
    else if (arrowtype==2) {
         bannerview.center=CGPointMake(bannerview.center.x*3, bannerview.center.y);
    }
    else if (arrowtype==3) {
        bannerview.center=CGPointMake(bannerview.center.x, -1*bannerview.center.y);
    }
    else if (arrowtype==4) {
           bannerview.center=CGPointMake(bannerview.center.x*-1, bannerview.center.y);
    }
    [UIView commitAnimations];
    
    
    
    
}
-(UIImage*)manAdViewLibBundleImageNamed:(NSString*)imageName {
    
    NSBundle *libBundle = nil;
    
#if (TARGET_IPHONE_SIMULATOR)
    libBundle =[NSBundle  bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"images.bundle"]];
#else
    libBundle = [NSBundle  bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"images.bundle"]];
#endif
    
    if (libBundle) {
        NSLog(@"resouces File Name : %@", [[libBundle resourcePath] stringByAppendingPathComponent:imageName]);
        return [UIImage imageWithContentsOfFile:[[libBundle resourcePath] stringByAppendingPathComponent:imageName]];
    }
    return nil;
}

-(void)closeBanner
{
    [rollingtimer invalidate];
    rollingtimer=nil;
    [bannerview removeFromSuperview];
    
    
}
-(void)goWebView
{
    UIWebView *webview =[[UIWebView alloc] init];
    webview.frame=CGRectMake(0, HEIGHT, WIDTH, HEIGHT);
   // webview.delegate=self;
    [self addSubview:webview];
    [self rotateImage:webview duration:1.0 curve:0 degrees:90];
    
     webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    [UIView animateWithDuration:1.5f animations:^{
     
        webview.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
   //     [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:webview cache:YES];
    } completion:^(BOOL completion){
        
      
     //   [self changeAdBanner];
    }];
    
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.daum.net"]];
    
}
-(void)callBanner
{
    if (![self superview]) {
        return;
    }
    
    if ([self landscape] !=0) {
        self.frame=CGRectMake(0, 0, HEIGHT+20, WIDTH-20);
    }
    else
    {
        self.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
        
    }
    
    CGSize newsize=CGSizeZero;
    
    if ([self landscape] != 0) {
        newsize=CGSizeMake(HEIGHT+20, WIDTH-20);
    }
    else
    {
        newsize=CGSizeMake(WIDTH, HEIGHT);
    }
    
    if (!linebannerview) {
        linebannerview = [[UIView alloc] init];
    }
    //lefttop
    if (bannertype==1) {
        linebannerview.frame=CGRectMake(0, 0, 300, 44);
        
    }
    else if(bannertype==2)
    {
        linebannerview.frame=CGRectMake(newsize.width-300, 0, 300, 44);
    }
    else if(bannertype==3)
    {
        linebannerview.frame=CGRectMake(0, newsize.height-44, 300, 44);
        
    }
    else if(bannertype==4)
    {
        linebannerview.frame=CGRectMake(newsize.width-300, newsize.height-44, 300, 44);
    }
    else
    {
        linebannerview.frame=CGRectMake(0, 0, 300, 44);
        
    }
    UIButton *sampleimgview = [UIButton buttonWithType:UIButtonTypeCustom];
    [sampleimgview setImage:[UIImage imageNamed:@"sampleimg.jpeg"] forState:UIControlStateNormal];
    sampleimgview.frame=CGRectMake(0, 0, 300, 44);
    [sampleimgview addTarget:self action:@selector(goWebView) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:linebannerview];
    [linebannerview release];
    [linebannerview addSubview:sampleimgview];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
   
    
}
#pragma mark 전면배너 호출
-(void)fullpageBanner
{
    self.userInteractionEnabled=YES;
    
    if (![self superview]) {
        return;
    }
    
    self.backgroundColor=[UIColor blueColor];
    if ([self landscape] !=0) {
        self.frame=CGRectMake(0, 0, HEIGHT+20, WIDTH-20);
    }
    else
    {
        self.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
        
    }
    
    
    
    
    bannerview = [[UIView alloc] init];
    // UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    
    
    
    bannerview.frame=CGRectMake((WIDTH-280)/2, (HEIGHT-280)/2, 280, 280);
    bannerview.backgroundColor=[UIColor redColor];
    [self addSubview:bannerview];
    [bannerview release];
    
    
   
    
    
    
    
    UIImageView *testimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bannerview.frame.size.width, bannerview.frame.size.height)];
    testimgview.userInteractionEnabled=YES;
    [testimgview setImage:[UIImage imageNamed:@"sampleimg.jpeg"]];
    [bannerview addSubview:testimgview];
    [testimgview release];
    

    closebtn =[[UIButton buttonWithType:UIButtonTypeCustom] retain];
    closebtn.selected=YES;
    
    [closebtn setImage:[self manAdViewLibBundleImageNamed:@"close.png"] forState:UIControlStateNormal];
    closebtn.frame=CGRectMake(bannerview.frame.size.width-40, 0, 40, 40);
    [closebtn addTarget:self action:@selector(closeBanner) forControlEvents:UIControlEventTouchUpInside];
    [bannerview addSubview:closebtn];
    [self rotate];
    //이미지 롤링
    rollingtimer =[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(bannerRequest) userInfo:nil repeats:YES];
    
    
    
    
    
}
#pragma mark banner request
-(void)requestBanner:(NSString*)url
{
}
-(void)dealloc
{
    [super dealloc];
}

@end
