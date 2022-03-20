Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14DD4E1DEB
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Mar 2022 22:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiCTVQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Mar 2022 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiCTVQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Mar 2022 17:16:27 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 312FEA27F1
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Mar 2022 14:15:03 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 02DC926ED39; Sun, 20 Mar 2022 17:15:01 -0400 (EDT)
Date:   Sun, 20 Mar 2022 17:15:01 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Forza <forza@tnonline.net>
Cc:     Phillip Susi <phill@thesusis.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjeZVZpzElzIslX5@hungrycats.org>
References: <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org>
 <cba5889e-4bb4-fe5e-3ed6-1e970110a934@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cba5889e-4bb4-fe5e-3ed6-1e970110a934@tnonline.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 20, 2022 at 06:50:55PM +0100, Forza wrote:
> 
> 
> 
> On 2022-03-14 23:59, Zygo Blaxell wrote:
> > 
> > On Mon, Mar 14, 2022 at 04:09:08PM -0400, Phillip Susi wrote:
> > > 
> > > Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
> > > 
> > > > That's more or less expected.
> > > > 
> > > > Autodefrag has two limitations:
> > > > 
> > > > 1. Only defrag newer writes
> > > >     It doesn't defrag older fragments.
> > > >     This is the existing behavior from the beginning of autodefrag.
> > > >     Thus it's not that effective against small random writes.
> > > 
> > > I don't understand this bit.  The whole point of defrag is to reduce the
> > > fragmentation of previous writes.  New writes should always attempt to
> > > follow the previous one if possible.
> > 
> 
> This is my assumption as well. I believe that VM images was one of the
> original use cases (though I have no reference to that at the moment).
> 
> The btrfs wiki[1] says the following for autodefrag:
> 
> "Though autodefrag affects newly written data, it can read a few adjacent
> blocks (up to 64k) and write the contiguous extent to a new location. The
> adjacent blocks will be unshared."
> 
> The Btrfs administration manual[2] says the following:
> 
> "When enabled, small random writes into files (in a range of tens of
> kilobytes, currently it’s 64KiB) are detected and queued up for the
> defragmentation process. Not well suited for large database workloads."

These statements are not technically incorrect, but they are an
understatement of the situation.  What's missing is that autodefrag's
very specific behavior isn't useful for typical user workloads prone
to fragmentation.

> > New writes are allocated to the first available free space hole large
> > enough to hold them, starting from the point of the last write (plus
> > some other details like clustering and alignment).  The goal is that
> > data writes from memory are sequential as much as possible, even if
> > many different files were written in the same transaction.
> > 
> > btrfs extents are immutable, so the filesystem can't extend an existing
> > extent with new data.  Instead, a new extent must be created that contains
> > both the old and new data to replace the old extent.  At least one new
> > fragment must be created whenever the filesystem is modified.  (In
> > zoned mode, this is strictly enforced by the underlying hardware.)
> > 
> > > If auto defrag only changes the
> > > behavior of new writes, then how does it change it and why is that not
> > > the way new writes are always done?
> > 
> > Autodefrag doesn't change write behavior directly.  It is a
> > post-processing thread that rereads and rewrites recently written data,
> > _after_ it was originally written to disk.
> > 
> > In theory, running defrag after the writes means that the writes can
> > be fast for low latency--they are a physically sequential stream of
> > blocks sent to the disk as fast as it can write them, because btrfs does
> > not have to be concerned with trying to achieve physical contiguity
> > of logically discontiguous data.  Later on, when latency is no longer an
> > issue and some IO bandwidth is available, the fragments can be reread
> > and collected together into larger logically and physically contiguous
> > extents by a background process.
> > 
> > In practice, autodefrag does only part of that task, badly.
> > 
> > Say we have a program that writes 4K to the end of a file, every 5
> > seconds, for 5 minutes.
> > 
> > Every 30 seconds (default commit interval), kernel writeback submits all
> > the dirty pages for writing to btrfs, and in 30 seconds there will be 6
> > x 4K = 24K of those.  An extent in btrfs is created to hold the pages,
> > filled with the data blocks, connected to the various filesystem trees,
> > and flushed out to disk.
> > 
> > Over 5 minutes this will happen 10 times, so the file contains 10
> > fragments, each about 24K (commits are asynchronous, so it might be
> > 20K in one fragment and 28K in the next).
> > 
> > After each commit, inodes with new extents are appended to a list
> > in memory.  Each list entry contains an inode, a transid of the commit
> > where the first write occurred, and the last defrag offset.  That list
> > is processed by a kernel thread some time after the commits are written
> > to disk.  The thread searches the inodes for extents created after the
> > last defrag transid, invokes defrag_range on each of these, and advances
> > the offset.  If the search offset reaches the end of file, then it is
> > reset to the beginning and another loop is done, and if the next search
> > loop over the file doesn't find new extents then the inode is removed
> > from the defrag list.
> > 
> > If there's a 5 minute delay between the original writes and autodefrag
> > finally catching up, then autodefrag will detect 10 new extents and
> > run defrag_range over them.  This is a read-then-write operation, since
> > the extent blocks may no longer be present in memory after writeback,
> > so autodefrag can easily fall behind writes if there are a lot of them.
> > Also the 64K size limit kicks in, so it might write 5 extents (2 x 24K =
> > 48K, but 3 x 24K = 72K, and autodefrag cuts off at 64K).
> > 
> > If there's a 1 minute delay between the original writes and autodefrag,
> > then autodefrag will detect 1 new extents and run defrag over them
> > for a total of 5 new extents, about 240K each.  If there's no delay
> > at all, then there will be 10 extents of 120K each--if autodefrag
> > runs immediately after commit, it will see only one extent in each
> > loop, and issue no defrag_range calls.
> > 
> > Seen from the point of view of the disk, there are always at least
> > 10x 120K writes.  In the no-autodefrag case it ends there.  In the
> > autodefrag cases, some of the data is read and rewritten later to make
> > larger extents.
> > 
> > In non-appending cases, the kernel autodefrag doesn't do very much useful
> > at all--random writes aren't logically contiguous, so autodefrag never
> > sees two adjacent extents in a search result, and therefore never sees
> > an opportunity to defrag anything.
> 
> I have a worst-case scenario with Netdata. It stores historical data in ndf
> files that are up to 1GiB in size. In addition there is a journal file of
> about 100-200MiB. The extents are extremely small and sequential read speeds
> are around 1-2MiB/s (this is a HDD), which makes fetching historical data
> _extremely_ slow.
> 
> Kernel 5.16.12, 5.16.16
> btrfs-progs v5.16.2
> 
> Files:
> Size       Date         Name
> 1073741824 Mar 15 03:02 datafile-1-0000000113.ndf
> 1024217088 Mar 20 18:10 datafile-1-0000000114.ndf
> 140648448  Mar 15 03:02 journalfile-1-0000000113.njf
> 137732096  Mar 20 18:05 journalfile-1-0000000114.njf
> 
> 
> # compsize datafile-1-0000000113.ndf
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Processed 1 file, 59407 regular extents (59407 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%      1.0G         1.0G         1.0G
> none       100%      1.0G         1.0G         1.0G
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> The average size of the extents is here 17KiB
> 
> 
> # compsize journalfile-1-0000000113.njf
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Processed 1 file, 34338 regular extents (34338 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%      134M         134M         134M
> none       100%      134M         134M         134M
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> The average extent of the journal file is 4KiB.
> 
> I have "mount -o autodefrag" enabled but it has no effect on these files. I
> have also tried enabling compression with "btrfs propterty set compression
> zstd" but it did not reduce the file size or change the amount of extents
> much.
> 
> As a last resort I tried running Netdata behind "eatmydata", but it also
> didn't help.
> 
> It seems that this case is exactly as Zygo describes, that small amounts of
> random writes do not get considered for defragment. It takes about 5 days to
> fill one of these ndf datafiles (about 8-9MiB per hour).
> 
> # filefrag -v datafile-1-0000000114.ndf
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Filesystem type is: 9123683e
> File size of datafile-1-0000000114.ndf is 1028616192 (251127 blocks of 4096
> bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..       0: 15863417202..15863417202:      1:
>    1:        1..       1: 15863417597..15863417597:      1: 15863417203:
>    2:        2..       2: 15874142482..15874142482:      1: 15863417598:
>    3:        3..       8: 16093579003..16093579008:      6: 15874142483:
>    4:        9..      13: 16017881714..16017881718:      5: 16093579009:
>    5:       14..      19: 16095939276..16095939281:      6: 16017881719:
>    6:       20..      27: 16110397810..16110397817:      8: 16095939282:
>    7:       28..      29: 15874165302..15874165303:      2: 16110397818:
>    8:       30..      30: 15874160314..15874160314:      1: 15874165304:
>    9:       31..      31: 15874164808..15874164808:      1: 15874160315:
>   10:       32..      39: 16110399763..16110399770:      8: 15874164809:
>   11:       40..      43: 16017882226..16017882229:      4: 16110399771:
>   12:       44..      47: 16017882292..16017882295:      4: 16017882230:
>   13:       48..      53: 16097265263..16097265268:      6: 16017882296:
>   14:       54..      55: 15877195212..15877195213:      2: 16097265269:
>   15:       56..      60: 16018077866..16018077870:      5: 15877195214:
>   16:       61..      64: 16017882755..16017882758:      4: 16018077871:
>   17:       65..      68: 16017882623..16017882626:      4: 16017882759:
>   18:       69..      69: 15877196587..15877196587:      1: 16017882627:
>   19:       70..      70: 15877198419..15877198419:      1: 15877196588:
>   20:       71..      82: 16110463493..16110463504:     12: 15877198420:
>   21:       83..      83: 15878073533..15878073533:      1: 16110463505:
>   22:       84..      84: 15878073875..15878073875:      1: 15878073534:
>   23:       85..      85: 15878074124..15878074124:      1: 15878073876:
>   24:       86..      86: 15878074958..15878074958:      1: 15878074125:
>   25:       87..      87: 15878268816..15878268816:      1: 15878074959:
>   26:       88..      88: 15878297633..15878297633:      1: 15878268817:
>   27:       89..      89: 15878144045..15878144045:      1: 15878297634:
>   28:       90..      90: 15878144854..15878144854:      1: 15878144046:
>   29:       91..      91: 15880621654..15880621654:      1: 15878144855:
>   30:       92..      92: 15884311220..15884311220:      1: 15880621655:
>   31:       93..      93: 15884314722..15884314722:      1: 15884311221:
>   32:       94..      94: 15884314726..15884314726:      1: 15884314723:
>   33:       95..      95: 15877198895..15877198895:      1: 15884314727:
>   34:       96..      96: 15877199305..15877199305:      1: 15877198896:
>   35:       97..      98: 15877199312..15877199313:      2: 15877199306:
>   36:       99..     101: 15878346833..15878346835:      3: 15877199314:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > At the time autodefrag was added to the kernel (May 2011), it was already
> > possible do to a better job in userspace for over a year (Feb 2010).
> > Between 2012 and 2021 there are only a handful of bug fixes, mostly of
> > the form "stop autodefrag from ruining things for the rest of the kernel."
> 
> Doesn't userspace defragment has the disadvantage that is has to process the
> whole file with all it's extents? 

No.  There's a DEFRAG_RANGE ioctl which will defragment a specific
range of a specific file, with some restrictions.  The restrictions
can be worked around by making a temporary copy and deduping it over
the original data.  It's possible to rearrange extents more or less
arbitrarily from userspace, mostly invisible to applications that might
be reading or writing them at the same time.

I forget exactly what the restrictions are.  We would need defrag to skip
the write permission check for superuser, and skip atime/mtime/ctime
updates, the same way the dedupe ioctl does.  We'd also need to remove
any minimum size limits or second-guessing in DEFRAG_RANGE so that it
does precisely what userspace tells it to do.  Currently there's some
hardcoded assumptions built into DEFRAG_RANGE because 'btrfs fi defrag'
isn't smart enough to issue good DEFRAG_RANGE commands.

Unfortunately both defrag and dedupe have a problem where they will only
operate on one extent reference at a time, so a solution that supports
snapshots will involve a mix of both ioctls (defrag to construct a
defragmented extent, dedupe to install that extent in each affected
snapshot, plus some logic to decide whether it's worthwhile to do that
or leave the old extents alone).  That can be done _after_ getting basic
autodefrag working for the easier single-subvol cases.

> But if it could be used to defrag only the
> last few modified extents could help in situations like this? 

"Last few modified extents" is the broken thing the kernel does.
Autodefrag should start with those (they can be found very quickly using
tree_search), but the defrag region must expand to include some of the
older adjacent extents too.

> Certainly a
> userspace defragment daemon could be used to implement custom policies
> suitable for specific workloads.
> 
> Thanks
> Forza
> 
> 
> [1] https://btrfs.wiki.kernel.org/index.php/Status
> [2] https://btrfs.readthedocs.io/en/latest/Administration.html?highlight=autodefrag#mount-options
> 
