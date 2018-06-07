//
//  ViewController.m
//  SUTouchID
//
//  Created by Superman on 2018/6/6.
//  Copyright © 2018年 Superman. All rights reserved.
//
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width

#import "ViewController.h"
#import "STouchID.h"

@interface ViewController ()<STouchIDDelegate>
@property (nonatomic, strong) STouchID *touchID;
@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat wid=75;
    CGFloat hei=75;

    UIButton *button=[[UIButton alloc]init];
    button.frame=CGRectMake((SCREENWIDTH-wid)*0.5,(SCREENHEIGHT-hei)*0.5 , wid, hei);
    [button setBackgroundImage:[UIImage imageNamed:@"fingerprint"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(startTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    STouchID *touchId=[[STouchID alloc]init];
    [touchId startSTouchIDWithMessage:SNotice(@"自定义信息", @"The Custom Message") fallbackTitle:SNotice(@"按钮标题", @"Fallback Title") delegate:self];
    self.touchID = touchId;
    
    UILabel *noticeLabel=[[UILabel alloc]init];
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    noticeLabel.frame=CGRectMake(0, 50, SCREENWIDTH, 60);
    noticeLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:noticeLabel];
    _noticeLabel=noticeLabel;
}

-(void)startTouch{
    [self.touchID startSTouchIDWithMessage:SNotice(@"自定义信息", @"The Custom Message") fallbackTitle:SNotice(@"按钮标题", @"Fallback Title") delegate:self];
}

/**
 *  TouchID验证成功
 *
 */
- (void) STouchIDAuthorizeSuccess {
    self.noticeLabel.text = SNotice(@"TouchID验证成功", @"Authorize Success");
}

/**
 *  TouchID验证失败
 *
 */
- (void) STouchIDAuthorizeFailure {
    self.noticeLabel.text = SNotice(@"TouchID验证失败", @"Authorize Failure");
}
/**
 *  取消TouchID验证 (用户点击了取消)
 *
 */
- (void) STouchIDAuthorizeErrorUserCancel {
    
    self.noticeLabel.text = SNotice(@"取消TouchID验证 (用户点击了取消)", @"Authorize Error User Cancel");
}

/**
 *  在TouchID对话框中点击输入密码按钮
 *
 */
- (void) STouchIDAuthorizeErrorUserFallback {
    self.noticeLabel.text = SNotice(@"在TouchID对话框中点击输入密码按钮", @"Authorize Error User Fallback ");
}

/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 *
 */
- (void) STouchIDAuthorizeErrorSystemCancel {
    self.noticeLabel.text = SNotice(@"在验证的TouchID的过程中被系统取消 ", @"Authorize Error System Cancel");
}

/**
 *  无法启用TouchID,设备没有设置密码
 *
 */
- (void) STouchIDAuthorizeErrorPasscodeNotSet {
    self.noticeLabel.text = SNotice(@"无法启用TouchID,设备没有设置密码", @"Authorize Error Passcode Not Set");
}

/**
 *  设备没有录入TouchID,无法启用TouchID
 *
 */
- (void) STouchIDAuthorizeErrorTouchIDNotEnrolled {
    self.noticeLabel.text = SNotice(@"设备没有录入TouchID,无法启用TouchID", @"Authorize Error TouchID Not Enrolled");
}

/**
 *  该设备的TouchID无效
 *
 */
- (void) STouchIDAuthorizeErrorTouchIDNotAvailable {
    self.noticeLabel.text = SNotice(@"该设备的TouchID无效", @"Authorize Error TouchID Not Available");
}

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 *
 *
 */
- (void) STouchIDAuthorizeLAErrorTouchIDLockout {
    self.noticeLabel.text = SNotice(@"多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁", @"Authorize LAError TouchID Lockout");
}

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 *
 */
- (void) STouchIDAuthorizeLAErrorAppCancel {
    self.noticeLabel.text = SNotice(@"当前软件被挂起取消了授权", @"Authorize LAError AppCancel");
}

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 *
 */
- (void) STouchIDAuthorizeLAErrorInvalidContext {
    self.noticeLabel.text = SNotice(@"当前软件被挂起取消了授权", @"Authorize LAError Invalid Context");
}
/**
 *  当前设备不支持指纹识别
 *
 */
-(void)STouchIDIsNotSupport {
    self.noticeLabel.text = SNotice(@"当前设备不支持指纹识别", @"The Current Device Does Not Support");
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
