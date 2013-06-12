//
//  ActozBanner.h
//  ActozBanner
//
//  Created by 구정현 on 13. 6. 10..
//  Copyright (c) 2013년 구정현. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ActozBanner <NSObject>



@end
@interface ActozBanner : UIView{
    int arrowtype; //배너 애니메이션 방향 1:top 2:left 3:down 4:right
    int bannertype; //띠배너 전면배너
    id<ActozBanner> delegate; //클라이언트 딜리게이트
    /*
    UIView *bannerview;
    NSTimer *rollingtimer;
    UIButton *closebtn;
    
    UIView *linebannerview;
    */
    
}

@property(nonatomic, assign) int bannertype;
@property(nonatomic, assign)id<ActozBanner>delegate;
@property(nonatomic, assign)int arrowtype;

-(void)fullpageBanner;
-(void)callBanner;
@end
