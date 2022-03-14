Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FCA4D8FF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 00:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiCNXBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 19:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiCNXBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 19:01:08 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A022B340D7
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 15:59:57 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 0DDF02599A3; Mon, 14 Mar 2022 18:59:51 -0400 (EDT)
Date:   Mon, 14 Mar 2022 18:59:51 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <Yi/I54pemZzSrNGg@hungrycats.org>
References: <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6dscn20.fsf@vps.thesusis.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon, Mar 14, 2022 at 04:09:08PM -0400, Phillip Susi wrote:
> 
> Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
> 
> > That's more or less expected.
> >
> > Autodefrag has two limitations:
> >
> > 1. Only defrag newer writes
> >    It doesn't defrag older fragments.
> >    This is the existing behavior from the beginning of autodefrag.
> >    Thus it's not that effective against small random writes.
> 
> I don't understand this bit.  The whole point of defrag is to reduce the
> fragmentation of previous writes.  New writes should always attempt to
> follow the previous one if possible.  

New writes are allocated to the first available free space hole large
enough to hold them, starting from the point of the last write (plus
some other details like clustering and alignment).  The goal is that
data writes from memory are sequential as much as possible, even if
many different files were written in the same transaction.

btrfs extents are immutable, so the filesystem can't extend an existing
extent with new data.  Instead, a new extent must be created that contains
both the old and new data to replace the old extent.  At least one new
fragment must be created whenever the filesystem is modified.  (In
zoned mode, this is strictly enforced by the underlying hardware.)

> If auto defrag only changes the
> behavior of new writes, then how does it change it and why is that not
> the way new writes are always done?

Autodefrag doesn't change write behavior directly.  It is a
post-processing thread that rereads and rewrites recently written data,
_after_ it was originally written to disk.

In theory, running defrag after the writes means that the writes can
be fast for low latency--they are a physically sequential stream of
blocks sent to the disk as fast as it can write them, because btrfs does
not have to be concerned with trying to achieve physical contiguity
of logically discontiguous data.  Later on, when latency is no longer an
issue and some IO bandwidth is available, the fragments can be reread
and collected together into larger logically and physically contiguous
extents by a background process.

In practice, autodefrag does only part of that task, badly.

Say we have a program that writes 4K to the end of a file, every 5
seconds, for 5 minutes.

Every 30 seconds (default commit interval), kernel writeback submits all
the dirty pages for writing to btrfs, and in 30 seconds there will be 6
x 4K = 24K of those.  An extent in btrfs is created to hold the pages,
filled with the data blocks, connected to the various filesystem trees,
and flushed out to disk.

Over 5 minutes this will happen 10 times, so the file contains 10
fragments, each about 24K (commits are asynchronous, so it might be
20K in one fragment and 28K in the next).

After each commit, inodes with new extents are appended to a list
in memory.  Each list entry contains an inode, a transid of the commit
where the first write occurred, and the last defrag offset.  That list
is processed by a kernel thread some time after the commits are written
to disk.  The thread searches the inodes for extents created after the
last defrag transid, invokes defrag_range on each of these, and advances
the offset.  If the search offset reaches the end of file, then it is
reset to the beginning and another loop is done, and if the next search
loop over the file doesn't find new extents then the inode is removed
from the defrag list.

If there's a 5 minute delay between the original writes and autodefrag
finally catching up, then autodefrag will detect 10 new extents and
run defrag_range over them.  This is a read-then-write operation, since
the extent blocks may no longer be present in memory after writeback,
so autodefrag can easily fall behind writes if there are a lot of them.
Also the 64K size limit kicks in, so it might write 5 extents (2 x 24K =
48K, but 3 x 24K = 72K, and autodefrag cuts off at 64K).

If there's a 1 minute delay between the original writes and autodefrag,
then autodefrag will detect 1 new extents and run defrag over them
for a total of 5 new extents, about 240K each.  If there's no delay
at all, then there will be 10 extents of 120K each--if autodefrag
runs immediately after commit, it will see only one extent in each
loop, and issue no defrag_range calls.

Seen from the point of view of the disk, there are always at least
10x 120K writes.  In the no-autodefrag case it ends there.  In the
autodefrag cases, some of the data is read and rewritten later to make
larger extents.

In non-appending cases, the kernel autodefrag doesn't do very much useful
at all--random writes aren't logically contiguous, so autodefrag never
sees two adjacent extents in a search result, and therefore never sees
an opportunity to defrag anything.

At the time autodefrag was added to the kernel (May 2011), it was already
possible do to a better job in userspace for over a year (Feb 2010).
Between 2012 and 2021 there are only a handful of bug fixes, mostly of
the form "stop autodefrag from ruining things for the rest of the kernel."
