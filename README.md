luagctest
=========

gc performance test for lua 5.2.3

Lua provides a mark-sweep garbage collector, the GC leads to some overhead to the manual
memory management. And for the mark-sweep GC, how much CPU time is occupied by the mark
phase, how much by the sweep phase?

From 5.1, lua provides incremental garbage collector. The incremental GC is most valuable
for soft real time applications such as game engine, but it will add some overhead to
the normal stop-the-world full GC.

lua 5.2.3 provides an experimental generational garbage collector. In the maillist, 
the auther said it's performance is not good.

This test is based on callgrind in valgrind, to determine all the above overhead.

summary
=======

1. the run time used by GC for different garbage collector:
   * full GC:         20%
   * incremental GC:  29%
   * generational GC: 29%
   the overhead of 'super' GC is one half of the normal stop-the-world full GC.
2. the run time of mark phase in the whole GC:
   * full GC:         16%
   * incremental GC:  25%
   * generational GC: 21.7%
   in lua_close(), the sweep phase of GC is used to free all the remain object.
   The free run time is about 84% of one full GC, is similar to the mark time.
3. The implementation of generational GC in lua5.2.3 is not very good, full GC
   is triggered from time to time. So big delay may occur. And the overall 
   performance is not better than incremental GC.
