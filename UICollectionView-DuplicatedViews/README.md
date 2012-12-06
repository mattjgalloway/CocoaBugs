CollectionView-DuplicateViews
=============================

rdar://12805541

This shows a problem with UICollectionView where supplementary views become duplicated as you scroll around. It appears that the problem is caused by the animation from performBatchUpdates:completion:. If the contents of the updates block is taken outside that call and the call is commented out, then the problem does not show itself.

Steps to reproduce:

1. Run on the iPad simulator or iPad device.
1. Scroll around.
1. Notice the duplicated green views.
