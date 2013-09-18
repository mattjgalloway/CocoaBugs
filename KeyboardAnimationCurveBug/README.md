NetworkLockup
=============

rdar://15020425

Summary:
The UIViewAnimationCurve that can be obtained from the notification userInfo dictionary using the UIKeyboardAnimationCurveUserInfoKey key is not a valid UIViewAnimationCurve as of iOS 7.0.

Steps to Reproduce:
  1. Open the sample project
  1. Run it
  1. Tap into the text field
  1. Notice the log line saying the curve is '7'

Expected Results:
A valid curve is printed out. i.e. 0, 1, 2 or 3 since UIViewAnimationCurve is defined thusly:

```
typedef NS_ENUM(NSInteger, UIViewAnimationCurve) {
    UIViewAnimationCurveEaseInOut,         // slow at beginning and end
    UIViewAnimationCurveEaseIn,            // slow at beginning
    UIViewAnimationCurveEaseOut,           // slow at end
    UIViewAnimationCurveLinear
};
```

Actual Results:
'7' is always returned, which is not a valid curve.

Regression:

Notes:

