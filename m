Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17F84A55E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 05:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiBAE0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 23:26:49 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:40354 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232890AbiBAE0s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 23:26:48 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id F0D911B3DB1; Mon, 31 Jan 2022 23:26:41 -0500 (EST)
Date:   Mon, 31 Jan 2022 23:26:41 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Chris Murphy <lists@colorremedies.com>,
        Boris Burkov <boris@bur.io>,
        "Apostolos B." <barz621@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        systemd Mailing List <systemd-devel@lists.freedesktop.org>
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Message-ID: <Yfi2gVf5QOXkaM6+@hungrycats.org>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen>
 <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 29, 2022 at 10:53:00AM +0100, Goffredo Baroncelli wrote:
> On 27/01/2022 21.48, Chris Murphy wrote:
> > On Wed, Jan 26, 2022 at 4:19 PM Boris Burkov <boris@bur.io> wrote:
> [...]
> > 
> > systemd-homed by default uses btrfs on LUKS on loop mount, with a
> > backing file. On login, it grows the user home file system with some
> > percentage (I think 80%) of the free space of the underlying file
> > system. And on logout, it does both fstrim and shrinks the fs. I don't
> > know why it does both, it seems adequate to do only fstrim on logout
> > to return unused blocks to the underlying file system; and to do an fs
> > resize on login to either grow or shrink the user home file system.
> > 
> > But also, we don't really have a great estimator of the minimum size a
> > file system can be. `btrfs inspect-internal min-dev-size` is pretty
> > broken right now.
> > https://github.com/kdave/btrfs-progs/issues/271
> 
> I tried the test case, but was unable to get a wrong value. However
> I think that this is due to the fact that btrfs improved the bg reclaiming.
> 
> However tweaking the test case, I was able to trigger the problem (I
> reduced the filesize from 1GB to 256MB, so when some files are
> removed a BG is empty filled)
> 
> 
> 
> > 
> > I'm not sure if systemd folks would use libbtrfsutil facility to
> > determine the minimum device shrink size? But also even the kernel
> > doesn't have a very good idea of how small a file system can be
> > shrunk. Right now it basically has to just start trying, and does it
> > one block group at a time.
> 
> I think that for the systemd uses cases (singled device FS), a simpler
> approach would be:
> 
>     fstatfs(fd, &sfs)
>     needed = sfs.f_blocks - sfs.f_bavail;
>     needed *= sfs.f_bsize
> 
>     needed = roundup_64(needed, 3*(1024*1024*1024))
> 
> Comparing the original systemd-homed code, I made the following changes
> - 1) f_bfree is replaced by f_bavail (which seem to be more consistent to the disk usage; to me it seems to consider also the metadata chunk allocation)
> - 2) the needing value is rounded up of 3GB in order to consider a further 1 data chunk and 2 metadata chunk (DUP))
> 
> Comments ?

This is closer to the right answer but not quite there yet.  A summary
of the issues:

 * Discard (called by systemd-homed in the form of trim) locks a block
 group (makes it read-only and removes it from available space) while
 it runs.

 * Relocation (balance or filesystem resize) locks a block group while
 it runs.

 * Scrub in the worst case locks one block group per disk (but we may
 never run scrub on a systemd-homed filesystem, so ignore this for now).

 * Large (>50GB) filesystems have larger block groups than smaller
 filesystems.  Resizing from >50GB to <50GB can require rewriting the
 _entire_ filesystem to make a sensible number of smaller block groups
 (high enough to be able to lock all the above block groups and still
 have enough free space to run a transaction without them).

 * System chunks aren't the same size as other chunks, which will create
 unusable free space holes between block groups, and (after lots of
 balancing/resizing runs) possibly create a lot of unusable free space
 that existing extents cannot be relocated into without temporarily
 increasing the size of the filesystem.

 * Resize is a fairly dumb algorithm as algorithms go.  It works in one
 pass, in a fixed order, and it can't fragment an extent or a block group.
 The minimum size of a filesystem depends not just on how much data there
 is, but how capable the resize algorithm is at arranging the data into
 the space given all the overlapping constraints btrfs has on allocation.
 Resize makes several size-speed tradeoffs in favor of speed (or at least
 not in favor of size).

 * The minimum filesystem size to store the data is different from
 the minimum filesystem size to run specific btrfs data modification
 operations.  Some metadata operations can require significant amounts
 of space to complete.  If the filesystem is resized too small with
 exactly the right amount of free space, it may become impossible to
 perform metadata-intensive operations like orphan inode cleanup or
 snapshot deletion on the next mount.  It's not possible to predict
 these additional space requirements without doing equivalent work to
 performing the operations and measuring the space required.  This means
 that in order to compute the minimum filesystem size, we need to be
 able to predict (or strongly control) the future of the filesystem,
 at least long enough to grow the filesystem back to its service size.

These combine to make it especially challenging to resize a nearly empty
filesystem from 128GB to smaller than somewhere around 8GB (1GB data +
1GB locked by discard + 1GB locked by relocation + 1GB metadata * 2 for
dup + 2GB trapped free dev_extent space from earlier resize operations).
That could be reduced to about 6GB with single metadata, but that's a
significant resiliency trade-off if the host filesystem doesn't implement
data integrity and self-healing.

It might be doable in multiple resize passes--one to resize the filesystem
to <50GB so that all the data can be moved into smaller block groups,
then again to resize it to the next block group size.  In the worst
case this copies all of the data in the filesystem multiple times, so
it would be faster for systemd-homed to mkfs a new filesystem at the
target size (which would have smaller block groups from the beginning)
and simply copy the data with 'cp -a' to the new filesystem instead of
resizing the old one.

Resizing a filesystem with 1GB of data on it from over 50GB to 16GB is
probably reliable.  8GB is less likely to succeed, and I wouldn't expect
any smaller number to work reliably except on very simple test cases.

It does suck that the kernel handles resizing below the minimum size of
the filesystem so badly; however, even if it rejected the resize request
cleanly with an error, it's not necessarily a good idea to attempt it.
Pushing the lower limits of what is possible in resize to save a handful
of GB is asking for trouble.  It's far better to overestimate generously
than to underestimate the minimum size.

> > 
> > Adding systemd-devel@
> > 
> > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
