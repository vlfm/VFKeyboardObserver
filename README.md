# VFKeyboardObserver

[![CI Status](http://img.shields.io/travis/vlfm/VFKeyboardObserver.svg?style=flat)](https://travis-ci.org/Valery Fomenko/VFKeyboardObserver)
[![Version](https://img.shields.io/cocoapods/v/VFKeyboardObserver.svg?style=flat)](http://cocoapods.org/pods/VFKeyboardObserver)
[![License](https://img.shields.io/cocoapods/l/VFKeyboardObserver.svg?style=flat)](http://cocoapods.org/pods/VFKeyboardObserver)
[![Platform](https://img.shields.io/cocoapods/p/VFKeyboardObserver.svg?style=flat)](http://cocoapods.org/pods/VFKeyboardObserver)

A simple way to observe keyboard notifications and keyboard properties.

Usage
==
1. Start / stop observing keyboard events.
==

```objective-c
// Create new observer, or use shared instance
[[VFKeyboardObserver sharedKeyboardObserver] start];
[[VFKeyboardObserver sharedKeyboardObserver] stop];
```

2. Add / remove delegates
==

Adopt to ```VFKeyboardObserverDelegate``` protocol and add an object as a delegate.

VFKeyboardObserver can have any number of delegates. Delegates are not retained.

```objective-c
@protocol VFKeyboardObserverDelegate <NSObject>

@optional

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardWillShowWithProperties:(VFKeyboardProperties)keyboardProperties interfaceOrientationWillChange:(BOOL)interfaceOrientationWillChange;
- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardDidShowWithProperties:(VFKeyboardProperties)keyboardProperties;

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardWillHideWithProperties:(VFKeyboardProperties)keyboardProperties;
- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardDidHideWithProperties:(VFKeyboardProperties)keyboardProperties;

@end

[[VFKeyboardObserver sharedKeyboardObserver] addDelegate:aDelegate];
[[VFKeyboardObserver sharedKeyboardObserver] removeDelegate:aDelegate];
```

3. Update UI when keyboard appears / disappears
==

It is common to update UI when keyboard will appear / will disappear.

```objective-c
- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardWillShowWithProperties:(VFKeyboardProperties)keyboardProperties interfaceOrientationWillChange:(BOOL)interfaceOrientationWillChange {
    [keyboardObserver animateWithKeyboardProperties:^{
        // ...
    }];
}

- (void)keyboardObserver:(VFKeyboardObserver *)keyboardObserver keyboardWillHideWithProperties:(VFKeyboardProperties)keyboardProperties {
    [keyboardObserver animateWithKeyboardProperties:^{
        // ...
    }];
}
```

VFKeyboardObserver have convenient method ```animateWithKeyboardProperties:``` that performs animations synched with keyboard animation.

4. Rotation
==

If we animate our UI to adjust it to keyboard, for example, attach ```UITextField``` to the top of the keyboard, there is one problem when interface orientation changes. Our ```UITextField``` does not stay attached while the rotation of interface orientation is animated.
See this for details: http://smnh.me/synchronizing-rotation-animation-between-the-keyboard-and-the-attached-view/

To solve this problem, VFKeyboardObserver has ```interfaceOrientationWillChange``` method.
Call it from UIViewController's ```viewWillTransitionToSize:withTransitionCoordinator:```.

```objective-c
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [[VFKeyboardObserver sharedKeyboardObserver] interfaceOrientationWillChange];
}
```

In this case, (only while interface orientation changes):
* ```VFKeyboardObserverDelegate``` will receive only two messages: keyboardWillShow and keyboardDidShow (hide methods will be ignored).
* ```interfaceOrientationWillChange``` argument of ```keyboardWillShow``` delegate method will be YES, so in case of custom UI adjusting animations in this method, you can do it without animation
* ```animateWithKeyboardProperties:```  methods automatically perform ```animations``` and ```completion``` blocks without animation (if you use it, no changes needed).

## Requirements

## Installation

VFKeyboardObserver is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "VFKeyboardObserver"
```

## Author

Valery Fomenko, vlfm@yandex.ru

## License

VFKeyboardObserver is available under the MIT license. See the LICENSE file for more info.
