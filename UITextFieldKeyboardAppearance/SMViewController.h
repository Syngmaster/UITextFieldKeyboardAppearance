//
//  SMViewController.h
//  UITextFieldKeyboardAppearance
//
//  Created by Syngmaster on 18/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

@end

