Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386072AA212
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 02:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgKGBne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 20:43:34 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42452 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgKGBne (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 20:43:34 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A8527894467; Fri,  6 Nov 2020 20:43:33 -0500 (EST)
Date:   Fri, 6 Nov 2020 20:43:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: raid 5/6 - is this implemented?
Message-ID: <20201107014333.GA31381@hungrycats.org>
References: <emd2373acd-6dfe-4317-bdf7-402cb909bc3f@desktop-g0r648m>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <emd2373acd-6dfe-4317-bdf7-402cb909bc3f@desktop-g0r648m>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 06, 2020 at 07:41:11PM +0000, Hendrik Friedel wrote:
> Hello,
> 
> I stumbled upon this:
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg91938.html
> 
> <<This is why scrub after a crash or powerloss with raid56 is important,
> while the array is still whole (not degraded). The two problems with
> that are:
> 
> a) the scrub isn't initiated automatically, nor is it obvious to the
> user it's necessary

Properly implemented, raid56 should not require scrubs after unclean
shutdown.  Notice none of the other btrfs raid profiles require scrub
after unclean shutdown (and even mdadm doesn't require it with a journal
device or PPL).  It's only btrfs raid56 that needs this workaround.

Scrub is a tool for finding drive failures (especially silent data
corruption) every month--not working around filesystem bugs every reboot.

> b) the scrub can take a long time, Btrfs has no partial scrubbing.

btrfs does have partial scrubbing.  The userspace utilities use it to
implement the pause and resume features.  It should be easy to write a
partial scrubber in userspace with e.g.  python-btrfs, at least at block
group resolution (maybe it can't scrub individual stripes).

> Wheras mdadm arrays offer a write intent bitmap to know what blocks to
> partially scrub, and to trigger it automatically following a crash or
> powerloss.

Write-intent bitmap updates metadata on the disk _before_ data writes,
which is the opposite of the btrfs transaction mechanism (which writes
data first, then metadata).  btrfs would have to write something on
the disk that indicates which block groups will be touched, and flush
it to disk _before_ any other writes to the filesystem occur, and have
that portion of the disk maintained separately from the rest of btrfs
(something like the free space cache).

It's tricky to implement as a bitmap, since new block groups can be
created during a transaction.  It's not impossible, but it requires an
on-disk format change, and whoever is working on it could be spending
their effort better by fixing raid5/6 bugs to make hacks like write-intent
bitmaps unnecessary.

> It seems Btrfs already has enough on-disk metadata to infer a
> functional equivalent to the write intent bitmap, via transid. Just
> scrub the last ~50 generations the next time it's mounted. Either do
> this every time a Btrfs raid56 is mounted. Or create some flag that
> allows Btrfs to know if the filesystem was not cleanly shutdown. >>

It's not the last 50 generations that need to be scrubbed.  Any committed
transaction since mkfs can be affected by write hole.

It's the set of raid5/6 stripes that were touched by the last incomplete
transaction before the crash that need to be scrubbed.  It's tricky to
find those, because no record of the last transaction exists on the disk
until after the transaction is complete.

i.e. the only thing you can't find by looking at transaction history is
the one thing you need to be looking at here.

After an unclean shutdown, we could scrub all stripes that contain at
least one used and at least one free block--those are the possible
stripes that can be corrupted by raid5/6 updates.  All other stripes
cannot be corrupted that way, because completely full stripes cannot be
updated, and completely empty stripes don't contain any data to corrupt.

The portion of the disk that falls into this category depends on average
file size and overall free space fragmentation--it could be less than 1%,
or more than 90%, of the disk.  And it's another time-wasting hack, or
an exercise using python-btrfs in userspace.

> Has this been implemented in the meantime? 

Not much has changed for raid5/6 since 2014, other than the introduction
of raid1c3 for metadata in 2019 to make filesystem with raid6 data usable.
Almost all of the bugs from 2014 still exist today.  Developers have
been fixing more severe and less avoidable bugs in the meantime.

> If not: Are there any plans to?

There are a few solutions to the raid5/6 write hole problem:  deprecate
the current raid5/6 profile and start over with something better,
adjust the allocator to pack allocations into full stripes to close
the raid5/6 write hole, and/or implement raid5/6 stripe journalling
in raid1/raid1c3/raid1c4 metadata.  Any of those ideas would work, all
three can be implemented at once, and they all have various cost/benefit
trade-offs (like whether they work for nodatacow files, and whether they
require on-disk format changes).

The solutions also have one thing in common:  nobody has been working
on them.  There are several other raid5/6 bugs that are much worse than
write hole, and they aren't getting developer attention either.

See this more up to date list, which puts write hole right at the bottom:

	https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

> Regards,
> Hendrik
> 
