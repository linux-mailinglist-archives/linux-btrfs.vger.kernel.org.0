Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB374D22B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFTP3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 11:29:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfFTP3z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 11:29:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E67CEAD47;
        Thu, 20 Jun 2019 15:29:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E1522DA846; Thu, 20 Jun 2019 17:30:40 +0200 (CEST)
Date:   Thu, 20 Jun 2019 17:30:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix fsync not persisting dentry deletions due to
 inode evictions
Message-ID: <20190620153040.GL8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190619120539.9775-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619120539.9775-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 01:05:39PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In order to avoid searches on a log tree when unlinking an inode, we check
> if the inode being unlinked was logged in the current transaction, as well
> as the inode of its parent directory. When any of the inodes are logged,
> we proceed to delete directory items and inode reference items from the
> log, to ensure that if a subsequent fsync of only the inode being unlinked
> or only of the parent directory when the other is not fsync'ed as well,
> does not result in the entry still existing after a power failure.
> 
> That check however is not reliable when one of the inodes involved (the
> one being unlinked or its parent directory's inode) is evicted, since the
> logged_trans field is transient, that is, it is not stored on disk, so it
> is lost when the inode is evicted and loaded into memory again (which is
> set to zero on load). As a consequence the checks currently being done by
> btrfs_del_dir_entries_in_log() and btrfs_del_inode_ref_in_log() always
> return true if the inode was evicted before, regardless of the inode
> having been logged or not before (and in the current transaction), this
> results in the dentry being unlinked still existing after a log replay
> if after the unlink operation only one of the inodes involved is fsync'ed.
> 
> Example:
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt
> 
>   $ mkdir /mnt/dir
>   $ touch /mnt/dir/foo
>   $ xfs_io -c fsync /mnt/dir/foo
> 
>   # Keep an open file descriptor on our directory while we evict inodes.
>   # We just want to evict the file's inode, the directory's inode must not
>   # be evicted.
>   $ ( cd /mnt/dir; while true; do :; done ) &
>   $ pid=$!
> 
>   # Wait a bit to give time to background process to chdir to our test
>   # directory.
>   $ sleep 0.5
> 
>   # Trigger eviction of the file's inode.
>   $ echo 2 > /proc/sys/vm/drop_caches
> 
>   # Unlink our file and fsync the parent directory. After a power failure
>   # we don't expect to see the file anymore, since we fsync'ed the parent
>   # directory.
>   $ rm -f $SCRATCH_MNT/dir/foo
>   $ xfs_io -c fsync /mnt/dir
> 
>   <power failure>
> 
>   $ mount /dev/sdb /mnt
>   $ ls /mnt/dir
>   foo
>   $
>    --> file still there, unlink not persisted despite explicit fsync on dir
> 
> Fix this by checking if the inode has the full_sync bit set in its runtime
> flags as well, since that bit is set everytime an inode is loaded from
> disk, or for other less common cases such as after a shrinking truncate
> or failure to allocate extent maps for holes, and gets cleared after the
> first fsync. Also consider the inode as possibly logged only if it was
> last modified in the current transaction (besides having the full_fsync
> flag set).
> 
> Fixes: 3a5f1d458ad161 ("Btrfs: Optimize btree walking while logging inodes")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
