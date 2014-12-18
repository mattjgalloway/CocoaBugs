TableViewEstimatedRowHeightBug
==============================

rdar://19293967

Summary:
I am seeing an issue where when using estimated row height, a table view will jump its content offset. It appears to be
happening when the table view is readded to the window during a transition. In this case the table view's internal data
structures get marked invalid. Then the table view updates its data by asking for the estimated row heights, which yields
a required content size smaller than the original (because the estimates are lower than the real). When this happens,
table view updates the content size, which adjusts the content offset as well, presumably to try to make the user stay
where they were. But it doesn't do that. It ends up pushing them away from where they were and it's very jarring.

Steps to Reproduce:

  1. Open the attached sample project.
  1. Run it on the iOS simulator.
  1. Scroll down so that the "0:12" row is just at the top of the screen.
  1. Tap on the "0:12" row.
  1. Wait for the view controller to present and dismiss.
  1. Notice that you are not where you were in the table view.

Note that if you change it from a modal being presented, to a view controller being pushed onto the navigation stack,
then the jump in the table view happens just before the view is pushed. Same problem, but ocurring at a different time.

Expected Results:
You should be back where you were in the table view.

Actual Results:
You are further down than where you were before.

Regression:

Notes:

