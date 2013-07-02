NavigationControllerPushPop
===========================

rdar://14332021

Summary:
If you push a view controller onto a navigation controller's stack while a pop animation is in progress then the navigation controller gets into an inconsistent state. The inconsistent state comprises a navigation title bar that has 2 items on it, one super-imposed on the other.

Steps to Reproduce:
1) Open the attached sample project and run it
2) Press "Push"
3) Press "PopPush"

Expected Results:
Navigation controller with a consistent state.

Actual Results:
Navigation controller with super-imposed title bar.

Regression:

Notes:
