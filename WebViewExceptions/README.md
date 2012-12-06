WebViewExceptions
=================

rdar://12826409

This shows a problem with UIWebView where delegate callbacks are run in a @try{}@catch{} block. This is not ideal and I consider this a bug as it is not documented.

Steps to reproduce:

1. Run on the iPhone simulator.
1. Notice the exception does not take down the app - it's caught
