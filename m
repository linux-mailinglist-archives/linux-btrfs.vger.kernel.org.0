Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE436DE88
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhD1RlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:41:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242177AbhD1RkH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:40:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24A53B165;
        Wed, 28 Apr 2021 17:39:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59143DA783; Wed, 28 Apr 2021 19:36:53 +0200 (CEST)
Date:   Wed, 28 Apr 2021 19:36:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix race leading to unpersisted data and metadata
 on fsync
Message-ID: <20210428173653.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <3afbe2773f00218de9073277f9b56b4f08e7513a.1619518907.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3afbe2773f00218de9073277f9b56b4f08e7513a.1619518907.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 27, 2021 at 11:27:20AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a fast fsync on a file, there is a race which can result in the
> fsync returning success to user space without logging the inode and without
> durably persisting new data.
> 
> The following example shows one possible scenario for this:
> 
>    $ mkfs.btrfs -f /dev/sdc
>    $ mount /dev/sdc /mnt
> 
>    $ touch /mnt/bar
>    $ xfs_io -f -c "pwrite -S 0xab 0 1M" -c "fsync" /mnt/baz
> 
>    # Now we have:
>    # file bar == inode 257
>    # file baz == inode 258
> 
>    $ mv /mnt/baz /mnt/foo
> 
>    # Now we have:
>    # file bar == inode 257
>    # file foo == inode 258
> 
>    $ xfs_io -c "pwrite -S 0xcd 0 1M" /mnt/foo
> 
>    # fsync bar before foo, it is important to trigger the race.
>    $ xfs_io -c "fsync" /mnt/bar
>    $ xfs_io -c "fsync" /mnt/foo
> 
>    # After this:
>    # inode 257, file bar, is empty
>    # inode 258, file foo, has 1M filled with 0xcd
> 
>    <power failure>
> 
>    # Replay the log:
>    $ mount /dev/sdc /mnt
> 
>    # After this point file foo should have 1M filled with 0xcd and not 0xab
> 
> The following steps explain how the race happens:
> 
> 1) Before the first fsync of inode 258, when it has the "baz" name, its
>    ->logged_trans is 0, ->last_sub_trans is 0 and ->last_log_commit is -1.
>    The inode also has the full sync flag set;
> 
> 2) After the first fsync, we set inode 258 ->logged_trans to 6, which is
>    the generation of the current transaction, and set ->last_log_commit
>    to 0, which is the current value of ->last_sub_trans (done at
>    btrfs_log_inode()).
> 
>    The full sync flag is cleared from the inode during the fsync.
> 
>    The log sub transaction that was committed had an ID of 0 and when we
>    synced the log, at btrfs_sync_log(), we incremented root->log_transid
>    from 0 to 1;
> 
> 3) During the rename:
> 
>    We update inode 258, through btrfs_update_inode(), and that causes its
>    ->last_sub_trans to be set to 1 (the current log transaction ID), and
>    ->last_log_commit remains with a value of 0.
> 
>    After updating inode 258, because we have previously logged the inode
>    in the previous fsync, we log again the inode through the call to
>    btrfs_log_new_name(). This results in updating the inode's
>    ->last_log_commit from 0 to 1 (the current value of its
>    ->last_sub_trans).
> 
>    The ->last_sub_trans of inode 257 is updated to 1, which is the ID of
>    the next log transaction;
> 
> 4) Then a buffered write against inode 258 is made. This leaves the value
>    of ->last_sub_trans as 1 (the ID of the current log transaction, stored
>    at root->log_transid);
> 
> 5) Then an fsync against inode 257 (or any other inode other than 258),
>    happens. This results in committing the log transaction with ID 1,
>    which results in updating root->last_log_commit to 1 and bumping
>    root->log_transid from 1 to 2;
> 
> 6) Then an fsync against inode 258 starts. We flush delalloc and wait only
>    for writeback to complete, since the full sync flag is not set in the
>    inode's runtime flags - we do not wait for ordered extents to complete.
> 
>    Then, at btrfs_sync_file(), we call btrfs_inode_in_log() before the
>    ordered extent completes. The call returns true:
> 
>      static inline bool btrfs_inode_in_log(...)
>      {
>          bool ret = false;
> 
>          spin_lock(&inode->lock);
>          if (inode->logged_trans == generation &&
>              inode->last_sub_trans <= inode->last_log_commit &&
>              inode->last_sub_trans <= inode->root->last_log_commit)
>                  ret = true;
>          spin_unlock(&inode->lock);
>          return ret;
>      }
> 
>    generation has a value of 6 (fs_info->generation), ->logged_trans also
>    has a value of 6 (set when we logged the inode during the first fsync
>    and when logging it during the rename), ->last_sub_trans has a value
>    of 1, set during the rename (step 3), ->last_log_commit also has a
>    value of 1 (set in step 3) and root->last_log_commit has a value of 1,
>    which was set in step 5 when fsyncing inode 257.
> 
>    As a consequence we don't log the inode, any new extents and do not
>    sync the log, resulting in a data loss if a power failure happens
>    after the fsync and before the current transaction commits.
>    Also, because we do not log the inode, after a power failure the mtime
>    and ctime of the inode do not match those we had before.
> 
>    When the ordered extent completes before we call btrfs_inode_in_log(),
>    then the call returns false and we log the inode and sync the log,
>    since at the end of ordered extent completion we update the inode and
>    set ->last_sub_trans to 2 (the value of root->log_transid) and
>    ->last_log_commit to 1.
> 
> This problem is found after removing the check for the emptiness of the
> inode's list of modified extents in the recent commit 209ecbb8585bf6
> ("btrfs: remove stale comment and logic from btrfs_inode_in_log()"),
> added in the 5.13 merge window. However checking the emptiness of the
> list is not really the way to solve this problem, and was never intended
> to, because while that solves the problem for COW writes, the problem
> persists for NOCOW writes because in that case the list is always empty.
> 
> In the case of NOCOW writes, even though we wait for the writeback to
> complete before returning from btrfs_sync_file(), we end up not logging
> the inode, which has a new mtime/ctime, and because we don't sync the log,
> we never issue disk barriers (send REQ_PREFLUSH to the device) since that
> only happens when we sync the log (when we write super blocks at
> btrfs_sync_log()). So effectively, for a NOCOW case, when we return from
> btrfs_sync_file() to user space, we are not guaranteering that the data is
> durably persisted on disk.
> 
> Also, while the example above uses a rename exchange to show how the
> problem happens, it is not the only way to trigger it. An alternative
> could be adding a new hard link to inode 258, since that also results
> in calling btrfs_log_new_name() and updating the inode in the log.
> An example reproducer using the addition of a hard link instead of a
> rename operation:
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt
> 
>   $ touch /mnt/bar
>   $ xfs_io -f -c "pwrite -S 0xab 0 1M" -c "fsync" /mnt/foo
> 
>   $ ln /mnt/foo /mnt/foo_link
>   $ xfs_io -c "pwrite -S 0xcd 0 1M" /mnt/foo
> 
>   $ xfs_io -c "fsync" /mnt/bar
>   $ xfs_io -c "fsync" /mnt/foo
> 
>   <power failure>
> 
>   # Replay the log:
>   $ mount /dev/sdc /mnt
> 
>   # After this point file foo often has 1M filled with 0xab and not 0xcd
> 
> The reasons leading to the final fsync of file foo, inode 258, not
> persisting the new data are the same as for the previous example with
> a rename operation.
> 
> So fix by never skipping logging and log syncing when there are still any
> ordered extents in flight. To avoid making the conditional if statement
> that checks if logging an inode is needed harder to read, place all the
> logic into an helper function with separate if statements to make it more
> manageable and easier to read.
> 
> A test case for fstests will follow soon.
> 
> For NOCOW writes, the problem existed before commit b5e6c3e170b770
> ("btrfs: always wait on ordered extents at fsync time"), introduced in
> kernel 4.19, then it went away with that commit since we started to always
> wait for ordered extent completion before logging.
> 
> The problem came back again once the fast fsync path was changed again to
> avoid waiting for ordered extent completion, in commit 487781796d3022
> ("btrfs: make fast fsyncs wait only for writeback"), added in kernel 5.10.
> 
> However, for COW writes, the race only happens after the recent
> commit 209ecbb8585bf6 ("btrfs: remove stale comment and logic from
> btrfs_inode_in_log()"), introduced in the 5.13 merge window. For NOCOW
> writes, the bug existed before that commit. So tag 5.10+ as the release
> for stable backports.

Thanks for the write up.

> CC: stable@vger.kernel.org # 5.10+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next.
