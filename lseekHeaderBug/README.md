lseekHeaderBug
==============

rdar://16222529

Summary:
unistd.h should mean that the defines SEEK_SET, SEEK_CUR and SEEK_END are available for use with lseek(). However, if you turn on modules support in the Objective-C compiler, then they are not available.

Steps to Reproduce:
Run the following:

$ /usr/bin/clang -o - -S -x objective-c -fmodules - <<EOF
#include <unistd.h>

void foo(void);
void foo(void)
{
  if (SEEK_SET);
  if (SEEK_CUR);
  if (SEEK_END);
}
EOF
<stdin>:6:7: error: use of undeclared identifier 'SEEK_SET'
  if (SEEK_SET);
      ^
<stdin>:7:7: error: use of undeclared identifier 'SEEK_CUR'
  if (SEEK_CUR);
      ^
<stdin>:8:7: error: use of undeclared identifier 'SEEK_END'
  if (SEEK_END);
      ^
3 errors generated.


Expected Results:
Compile succeeds.

Actual Results:
Compile fails.

Regression:
Unknown.

Notes:
$ clang -v
Apple LLVM version 5.0 (clang-500.2.79) (based on LLVM 3.3svn)
Target: x86_64-apple-darwin13.1.0
Thread model: posix
