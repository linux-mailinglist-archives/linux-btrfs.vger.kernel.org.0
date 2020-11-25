Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB42C380E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 05:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKYEYv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 24 Nov 2020 23:24:51 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35792 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgKYEYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 23:24:51 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4A73C8C4829; Tue, 24 Nov 2020 23:24:50 -0500 (EST)
Date:   Tue, 24 Nov 2020 23:24:49 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Snapshots, Dirty Data, and Power Failure
Message-ID: <20201125042449.GE31381@hungrycats.org>
References: <b58c6024-1692-7e43-c0a5-182b1fae1cca@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b58c6024-1692-7e43-c0a5-182b1fae1cca@panasas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 24, 2020 at 11:03:15AM -0500, Ellis H. Wilson III wrote:
> Hi all,
> 
> Back with more esoteric questions.  We find that snapshots on an idle BTRFS
> subvolume are extremely fast, but if there is plenty of data in-flight
> (i.e., in the buffer cache and not yet sync'd down) it can take dozens of
> seconds to a minute or so for the snapshot to return successfully.
> 
> I presume this delay is for the data that was accepted but not yet sync'd to
> disk to get flushed out prior to taking the snapshot. However, I don't have
> details to answer the following questions aside from spending a long time in
> the code:
> 
> 1. Is my presumption just incorrect and there is some other time-consuming
> mechanics taking place during a snapshot that would cause these longer times
> for it to return successfully?

As far as I can tell, the upper limit of snapshot creation time is bounded
only the size of the filesystem divided by the average write speed, i.e.
it's possible to keep 'btrfs sub snapshot' running for as long as it takes
to fill the disk.

I recently observed a process unpacking a compressed image file that
made a 'btrfs sub snap' command run for 3.8 hours, stopping only when
the decompress program ran out of image file to write.

While this is happening, only writes to existing files can proceed.
All other write operations (e.g.  unlink or mkdir) will block.

AIUI there have been attempts to create mechanisms in btrfs that either
throttle writes or defer them to a later transaction to prevent snapshot
creation (and other btrfs write operations) from running indefinitely.
These latency control mechanisms are apparently incomplete or broken on
current kernels.

e.g. commit 3cd24c698004d2f7668e0eb9fc1f096f533c791b "btrfs: use tagged
writepage to mitigate livelock of snapshot" marks writes to inodes
within a subvol so that they are not flushed during the current commit
if that subvol is the origin of a snapshot create and the write occurs
after the snapshot create started; however, this only prevents writes
in the snapshotted subvol from delaying the snapshot--it does nothing
about writes to other subvols on the filesystem, which is what happened
in my 3.8 hour case.

> 2. iF i SNAPShot subvol A and it has dirty data outstanding, what power
> failure guarantees do I have after the snapshot completes?  Is everything
> that was written to subvol A prior to the snapshot guaranteed to be safely
> on-disk following the successful snapshot?

Snapshot create implies transaction commit with delalloc flush, so it will
all be complete on disk as of some point during the snapshot create call
(closer the function return than function entry).

> 3. If I snapshot subvol A, and unrelated subvol B has dirty data outstanding
> in the buffer cache, does the snapshot of A first flush out the dirty data
> to subvol B prior to taking the snapshot?  In other words, does a snapshot
> of a BTRFS subvolume require all dirty data for all other subvolumes in the
> filesystem to be sync'd, and if so, is all previously written data (even to
> subvol B) power-fail protected following the successful snapshot completion
> of A?

Snapshot create implies a transaction commit with delalloc flush,
which puts all previously (or simultaneously) written data on disk.

Since kernel 5.0 is no mechanism to prevent delalloc flush from running
until the disk fills up.

There's an exception to this rule that excludes the origin subvol from
delalloc flush if the extents are added after the snapshot create has
begun; however, this isn't done for the rest of the filesystem.

> 4. Is there any way to efficiently take a snapshot of a bunch of subvolumes
> at once?  If the answer to #2 is that all dirty data is sync'd for all
> subvolumes for a snapshot of any subvolume, we're liable to have
> significantly less to do on the consecutive subvolumes that are getting
> snapshotted right afterwards, but I believe these still imply a BTRFS root
> commit, and as such can be expensive in terms of disk I/O (at least linear
> with the number of 'simultaneous' snapshots).

If the snapshots are being created in the same directory, then each one
will try to hold a VFS-level directory lock to create the new directory
entry, so they can only execute sequentially.

If the snapshots are being created in different directories, then it
should be possible to run the snapshot creates in parallel.  They will
likely all end at close to the same time, though, as they're all trying
to complete a filesystem-wide flush, and none of them can proceed until
that is done.  An aggressive writer process could still add arbitrary
delays.

> Thanks as always,
> 
> ellis
