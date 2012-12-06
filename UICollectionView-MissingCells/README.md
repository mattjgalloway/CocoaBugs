CollectionView-MissingViews
===========================

rdar://12795542

This shows a problem where some cells simply do not appear in a UICollectionView. Or they appear and then disappear as you scroll around. The problem seems to be cells whose origin is outside of a certain region.

Steps to reproduce:

1. Run on the iPad simulator or iPad device.
1. Notice row 3 has nothing in it, even though there should be.
1. Scroll around.
1. Notice that row 2's cell disappears suddenly if you keep scrolling to the right.
