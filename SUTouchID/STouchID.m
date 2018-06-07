//
//  STouchID.m
//  SUTouchID
//
//  Created by Superman on 2018/6/6.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "STouchID.h"

@implementation STouchID

- (void)startSTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<STouchIDDelegate>)delegate {
    LAContext *context=[[LAContext alloc]init];
    
    context.localizedFallbackTitle = fallbackTitle;
    NSError *error=nil;
    self.delegate=delegate;
    NSAssert(self.delegate !=nil,SNotice(@"STouchIDDelegate 不能为空", @"STouchIDDelegate must be non-nil") );
                                         
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil? SNotice(@"默认提示信息", @"The Default Message"):message  reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                if ([self.delegate respondsToSelector:@selector(STouchIDAuthorizeSuccess)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.delegate STouchIDAuthorizeSuccess];
                    }];
                }
            }else if (error){
                switch(error.code){
                    case LAErrorAuthenticationFailed:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeFailure)]){
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeFailure];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserCancel:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorUserCancel)]){
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorUserCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserFallback:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorUserFallback )]){
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorUserFallback];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorSystemCancel:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorSystemCancel)]){
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorSystemCancel];
                            }];
                        }
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorTouchIDNotEnrolled)]){
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorTouchIDNotEnrolled];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorPasscodeNotSet)]){
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorPasscodeNotSet];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotAvailable:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorTouchIDNotAvailable)]){
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorTouchIDNotAvailable];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDLockout:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorTouchIDLockout)]){
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorTouchIDLockout];
                            }];
                        }
                    }
                        break;
                    case LAErrorAppCancel:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorAppCancel)]){
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorAppCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorInvalidContext:{
                        if([self.delegate respondsToSelector:@selector(STouchIDAuthorizeErrorInvalidContext)]){
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate STouchIDAuthorizeErrorInvalidContext];
                            }];
                        }
                    }
                        break;
                        
                }
                
            }
                
        }];
            
            
            
            
    }else{
        
            if ([self.delegate respondsToSelector:@selector(STouchIDIsNotSupport)]) {
                [self.delegate STouchIDIsNotSupport];
            }
        }
         
     
}

@end























