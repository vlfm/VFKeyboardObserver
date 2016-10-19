#import "VFViewController.h"
#import "VFKeyboardObserver.h"

@interface VFViewController () <VFKeyboardObserverDelegate>
@end

@implementation VFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[VFKeyboardObserver sharedKeyboardObserver] start];
    
    [[VFKeyboardObserver sharedKeyboardObserver] addDelegate:self];
    
    textFieldDate.inputView = [UIDatePicker new];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIModalPresentationFormSheet;
    }
    return [super modalPresentationStyle];
}

- (IBAction)resignButtonTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [[VFKeyboardObserver sharedKeyboardObserver] interfaceOrientationWillChange];
}

#pragma mark VFKeyboardObserverDelegate

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardWillShowWithProperties:(VFKeyboardProperties)keyboardProperties interfaceOrientationWillChange:(BOOL)interfaceOrientationWillChange {
    NSLog(@"KeyboardWillShowWithProperties: %@, interfaceOrientationWillChange: %@", NSStringFromVFKeyboardProperties(keyboardProperties), (interfaceOrientationWillChange ? @"YES" : @"NO"));
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        bottomConstraint.constant = keyboardProperties.frame.size.height;
    } else {
        bottomConstraint.constant = keyboardProperties.frame.size.height;
    }
    
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
