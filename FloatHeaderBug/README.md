NetworkLockup
=============

rdar://16221981

Summary:
If you import CGBase.h and float.h and use DBL_EPSILON, DBL_MIN, DBL_MAX or FLT_EPSILON, then you get compiler errors on the first build. Subsequent builds complete successfully.

The errors you receive are like this:
FloatHeaderBug.m:7:7: Use of undeclared identifier 'DBL_EPSILON'
FloatHeaderBug.m:8:7: Use of undeclared identifier 'DBL_MIN'
FloatHeaderBug.m:9:7: Use of undeclared identifier 'DBL_MAX'
FloatHeaderBug.m:10:7: Use of undeclared identifier 'FLT_EPSILON'

Steps to Reproduce:
1. Open sample project.
2. Build for iOS simulator 4-inch retina iPhone.
3. Notice errors.
4. Build.
5. Notice success.
6. Delete all derived data and modules cache (very important to delete the modules cache as well).
7. Goto step 2.

Expected Results:
The project builds first time.

Actual Results:
The project fails to build first time, but another build and it works.

Version:
Version 5.0.2 (5A3005)
