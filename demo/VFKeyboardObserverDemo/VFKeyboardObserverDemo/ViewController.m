#import "ViewController.h"
#import "VFKeyboardObserver.h"

@interface ViewController () <VFKeyboardObserverDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[VFKeyboardObserver sharedKeyboardObserver] start];
    
    [[VFKeyboardObserver sharedKeyboardObserver] addDelegate:self];
    
    textFieldDate.inputView = [UIDatePicker new];
}

- (IBAction)resignButtonTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [[VFKeyboardObserver sharedKeyboardObserver] interfaceOrientationWillChange];
}

#pragma mark VFKeyboardObserverDelegate

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardWillShowWithProperties:(VFKeyboardProperties)keyboardProperties interfaceOrientationWillChange:(BOOL)interfaceOrientationWillChange {
    NSLog(@"KeyboardWillShowWithProperties: %@, interfaceOrientationWillChange: %@", NSStringFromVFKeyboardProperties(keyboardProperties), (interfaceOrientationWillChange ? @"YES" : @"NO"));
    
    bottomConstraint.constant = keyboardProperties.size.height;
    
    [keyboardObserver animateWithKeyboardProperties:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardDidShowWithProperties:(VFKeyboardProperties)keyboardProperties {
    NSLog(@"KeyboardDidShowWithProperties: %@", NSStringFromVFKeyboardProperties(keyboardProperties));
}

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardWillHideWithProperties:(VFKeyboardProperties)keyboardProperties {
    NSLog(@"KeyboardWillHideWithProperties: %@", NSStringFromVFKeyboardProperties(keyboardProperties));
    
    bottomConstraint.constant = 0;
    
    [keyboardObserver animateWithKeyboardProperties:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardDidHideWithProperties:(VFKeyboardProperties)keyboardProperties {
    NSLog(@"KeyboardDidHideWithProperties: %@", NSStringFromVFKeyboardProperties(keyboardProperties));
}

@end
