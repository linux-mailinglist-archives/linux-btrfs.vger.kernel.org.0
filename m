Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9409576BB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGZOfj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 10:35:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:45966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfGZOfj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 10:35:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66E8CAC10;
        Fri, 26 Jul 2019 14:35:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F8A8DA811; Fri, 26 Jul 2019 16:36:13 +0200 (CEST)
Date:   Fri, 26 Jul 2019 16:36:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix incremental send failure after deduplication
Message-ID: <20190726143611.GD2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190717122339.4926-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717122339.4926-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 17, 2019 at 01:23:39PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing an incremental send operation we can fail if we previously did
> deduplication operations against a file that exists in both snapshots. In
> that case we will fail the send operation with -EIO and print a message
> to dmesg/syslog like the following:
> 
>   BTRFS error (device sdc): Send: inconsistent snapshot, found updated \
>   extent for inode 257 without updated inode item, send root is 258, \
>   parent root is 257
> 
> This requires that we deduplicate to the same file in both snapshots for
> the same amount of times on each snapshot. The issue happens because a
> deduplication only updates the iversion of an inode and does not update
> any other field of the inode, therefore if we deduplicate the file on
> each snapshot for the same amount of time, the inode will have the same
> iversion value (stored as the "sequence" field on the inode item) on both
> snapshots, therefore it will be seen as unchanged between in the send
> snapshot while there are new/updated/deleted extent items when comparing
> to the parent snapshot. This makes the send operation return -EIO and
> print an error message.
> 
> Example reproducer:
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt
> 
>   # Create our first file. The first half of the file has several 64Kb
>   # extents while the second half as a single 512Kb extent.
>   $ xfs_io -f -s -c "pwrite -S 0xb8 -b 64K 0 512K" /mnt/foo
>   $ xfs_io -c "pwrite -S 0xb8 512K 512K" /mnt/foo
> 
>   # Create the base snapshot and the parent send stream from it.
>   $ btrfs subvolume snapshot -r /mnt /mnt/mysnap1
>   $ btrfs send -f /tmp/1.snap /mnt/mysnap1
> 
>   # Create our second file, that has exactly the same data as the first
>   # file.
>   $ xfs_io -f -c "pwrite -S 0xb8 0 1M" /mnt/bar
> 
>   # Create the second snapshot, used for the incremental send, before
>   # doing the file deduplication.
>   $ btrfs subvolume snapshot -r /mnt /mnt/mysnap2
> 
>   # Now before creating the incremental send stream:
>   #
>   # 1) Deduplicate into a subrange of file foo in snapshot mysnap1. This
>   #    will drop several extent items and add a new one, also updating
>   #    the inode's iversion (sequence field in inode item) by 1, but not
>   #    any other field of the inode;
>   #
>   # 2) Deduplicate into a different subrange of file foo in snapshot
>   #    mysnap2. This will replace an extent item with a new one, also
>   #    updating the inode's iversion by 1 but not any other field of the
>   #    inode.
>   #
>   # After these two deduplication operations, the inode items, for file
>   # foo, are identical in both snapshots, but we have different extent
>   # items for this inode in both snapshots. We want to check this doesn't
>   # cause send to fail with an error or produce an incorrect stream.
> 
>   $ xfs_io -r -c "dedupe /mnt/bar 0 0 512K" /mnt/mysnap1/foo
>   $ xfs_io -r -c "dedupe /mnt/bar 512K 512K 512K" /mnt/mysnap2/foo
> 
>   # Create the incremental send stream.
>   $ btrfs send -p /mnt/mysnap1 -f /tmp/2.snap /mnt/mysnap2
>   ERROR: send ioctl failed with -5: Input/output error
> 
> This issue started happening back in 2015 when deduplication was updated
> to not update the inode's ctime and mtime and update only the iversion.
> Back then we would hit a BUG_ON() in send, but later in 2016 send was
> updated to return -EIO and print the error message instead of doing the
> BUG_ON().
> 
> A test case for fstests follows soon.
> 
> Fixes: 1c919a5e13702c ("btrfs: don't update mtime/ctime on deduped inodes")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203933
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
