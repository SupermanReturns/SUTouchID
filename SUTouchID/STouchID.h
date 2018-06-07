//
//  STouchID.h
//  SUTouchID
//
//  Created by Superman on 2018/6/6.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

#if TARGET_IPHONE_SIMULATOR
#define SNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-US"] ? Chinese : English
#elif TARGET_OS_IPHONE
#define SNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"] ? Chinese : English
#endif

@class STouchID;
@protocol STouchIDDelegate<NSObject>
@required
/**
 *  TouchID验证成功
 */
- (void)STouchIDAuthorizeSuccess;

/**
 *  TouchID验证失败
 */
- (void)STouchIDAuthorizeFailure;

@optional
/**
 *  取消TouchID验证 (用户点击了取消)
 *
 */
- (void)STouchIDAuthorizeErrorUserCancel;

/**
 *  在TouchID对话框中点击输入密码按钮
 *
 */
- (void)STouchIDAuthorizeErrorUserFallback;

/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 *
 */
- (void)STouchIDAuthorizeErrorSystemCancel;

/**
 *  无法启用TouchID,设备没有设置密码
 *
 */
- (void)STouchIDAuthorizeErrorPasscodeNotSet;

/**
 *  设备没有录入TouchID,无法启用TouchID
 *
 */
- (void)STouchIDAuthorizeErrorTouchIDNotEnrolled;

/**
 *  该设备的TouchID无效
 *
 */
- (void)STouchIDAuthorizeErrorTouchIDNotAvailable;

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 *
 */
- (void)STouchIDAuthorizeErrorTouchIDLockout;

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 */
- (void)STouchIDAuthorizeErrorAppCancel;

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
*/
- (void)STouchIDAuthorizeErrorInvalidContext;

/**
 *  当前设备不支持指纹识别
 *
 */
-(void)STouchIDIsNotSupport;

@end
@interface STouchID : LAContext

@property (nonatomic, weak) id<STouchIDDelegate> delegate;

/**
 *  发起TouchID验证 (Initiate TouchID validation)
 *
 *  @param message 提示框需要显示的信息 默认为：输入密码 (Fallback button title. Default is "Enter Password")
 */
- (void)startSTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<STouchIDDelegate>)delegate;

@end






















