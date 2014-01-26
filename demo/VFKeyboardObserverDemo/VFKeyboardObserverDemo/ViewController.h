#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet NSLayoutConstraint *bottomConstraint;
    
    // on ipad UIDatePicker height is different from keyboard's
    
    IBOutlet UITextField *textField;
    IBOutlet UITextField *textFieldDate;
}

@end
