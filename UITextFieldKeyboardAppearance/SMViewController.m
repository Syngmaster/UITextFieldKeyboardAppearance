//
//  SMViewController.m
//  UITextFieldKeyboardAppearance
//
//  Created by Syngmaster on 18/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMViewController.h"

@interface SMViewController () <UITextFieldDelegate>

@property (assign, nonatomic) BOOL moveUp;
@property (assign, nonatomic) CGFloat moveUpViewHeight;

@end

@implementation SMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
    [self.view setFrame:CGRectMake(0,-self.moveUpViewHeight,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame))];
}

-(void)keyboardDidHide:(NSNotification *)notification {
    
    [self.view setFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame))];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.moveUp = NO;
    CGRect keyboardRect = CGRectMake(0, CGRectGetMaxY(self.view.bounds), CGRectGetWidth(self.view.bounds), -253);
    CGRect textFieldRect = [self.view convertRect:textField.frame fromView:textField.superview];
    
    if (CGRectIntersectsRect(keyboardRect, textFieldRect)) {
        
        self.moveUp = YES;
        CGRect intersection = CGRectZero;
        intersection.size.height = fabs(CGRectGetHeight(keyboardRect)) - (CGRectGetMaxY(self.view.bounds) - textFieldRect.origin.y) + CGRectGetHeight(textField.bounds) + 5;
        self.moveUpViewHeight = CGRectGetHeight(intersection);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    }
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.moveUp) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
