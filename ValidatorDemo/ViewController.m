//
//  ViewController.m
//  ValidatorDemo
//
//  Created by 新闻 on 15/9/5.
//  Copyright (c) 2015年 新闻. All rights reserved.
//

#import "ViewController.h"
#import "AJWValidator.h"

@interface ViewController ()

@property (weak, nonatomic ) IBOutlet UITextField *userField;
@property (weak, nonatomic ) IBOutlet UITextField *passwordField;
@property (weak, nonatomic ) IBOutlet UITextField *emailField;
@property (strong,nonatomic) UILabel     *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //验证输入内容是否合法
    AJWValidator *userValidator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [userValidator addValidationToEnsureMinimumLength:5 invalidMessage:@"不得小于5位"];
    [userValidator addValidationToEnsureMaximumLength:15 invalidMessage:@"不得大于15位"];
    [self.userField ajw_attachValidator:userValidator];
    
    userValidator.validatorStateChangedHandler = ^(AJWValidatorState state){
        
        switch (state) {
            case AJWValidatorValidationStateValid:
            {
                self.label.hidden            = NO;
                self.label.text              = @"符合条件";
                self.userField.rightView     = _label;
                self.userField.rightViewMode = UITextFieldViewModeAlways;
                [self performSelector:@selector(hideAction) withObject:nil afterDelay:1];
            }
                break;
                
            default:
            {
                self.label.hidden            = NO;
                self.label.text              = @"不符合要求";
                [self performSelector:@selector(hideAction) withObject:nil afterDelay:1];
            }
                break;
        }
    };
    
    //验证邮箱
    AJWValidator *emailValidator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [emailValidator addValidationToEnsureValidEmailWithInvalidMessage:@"格式不正确"];
    [self.emailField ajw_attachValidator:emailValidator];
    emailValidator.validatorStateChangedHandler = ^(AJWValidatorState state){
        
        switch (state) {
            case AJWValidatorValidationStateValid:
            {
                self.label.hidden             = NO;
                self.label.text               = @"完全正确";
                self.emailField.rightView     = _label;
                self.emailField.rightViewMode = UITextFieldViewModeAlways;
                [self performSelector:@selector(hideAction) withObject:nil afterDelay:1];
            }
                break;
                
            default:
            {
                self.label.hidden             = NO;
                self.label.text               = @"格式不对";
                [self performSelector:@selector(hideAction) withObject:nil afterDelay:1];
            }
                break;
        }

    };
}
-(void)hideAction{
   
    self.label.hidden = YES;
}
-(UILabel *)label{
    
    if (_label == nil) {
        _label                 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        _label.textColor       = [UIColor blackColor];
        _label.textAlignment   = NSTextAlignmentRight;
        _label.backgroundColor = [UIColor clearColor];
        _label.font            = [UIFont systemFontOfSize:10];
    }
    return _label;
}

@end
