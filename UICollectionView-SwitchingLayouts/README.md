UICollectionView-SwitchingLayouts
=================================

rdar://12805628

If you have two different, standard UICollectionViewFlowLayouts and want to switch a UICollectionView between them then it doesn't work. The second layout you switch to simply doesn't show the items.

Steps to Reproduce:
1) Open sample project.
2) Run on iPhone simulator.
3) Notice red cell shown.
4) Tap 'Switch'.

Expected Results:
The red cell should still be shown, since the layout being switched to it the exact same type of layout as the first.

Actual Results:
The red cell disappears.
