NetworkLockup
=============

rdar://13859932

Summary:
I am seeing a problem in `NSURLConnection whereby` if you constantly fire off new connections, eventually all the requests that are in flight will stall, not calling back on their `NSURLConnection` delegate methods even though the request goes out over the wire and comes back successfully.

Interestingly, the connection is started and gets its `connection:willSendRequest:redirectResponse:` delegate method called, but all other subsequent delegate methods including `connection:didReceiveResponse:` and `connection:didReceiveData:` are not called.

I should add that if the number of concurrent connections (i.e. the initial count on the semaphore in the sample project) seems to affect if the bug is hit or not. In the attached project, this is set to 20. If you drop this to 5 then the bug seems to never be hit.

Steps to Reproduce:

  1. Open the attached sample project.
  1. Run it on an iOS device (currently I've seen this on iPad running iOS 6.1, but I'm going to try on other devices as well).
  1. Notice that eventually the network requests will lock up and stall. Only after the TCP connection to the server is yanked for whatever reason do new requests start being processed again.

Expected Results:
All requests are processed successfully.

Actual Results:
Requests time out even though the request goes out over the wire and come back successfully.

Regression:

Notes:

