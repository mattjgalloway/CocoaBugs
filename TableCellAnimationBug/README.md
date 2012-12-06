TableCellAnimationBug
=====================

This shows a problem with iOS's table cells animating strangely when new cells are created inside an animation block.

Steps to reproduce:

1. Run on the iPad simulator or iPad device.
1. Rotate to landscape.
1. Tap the "Show Table" button.
1. Tap into the search box.
1. Type in 1 or more letters.
1. Press the search button.
1. Press the hide keyboard button at the bottom right of the keyboard.

Now watch the animation on the cells that appear as the table resizes. Ugly.