Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF03D329
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404276AbfFKRB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 13:01:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387767AbfFKRBZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 13:01:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 079A0AD8F;
        Tue, 11 Jun 2019 17:01:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 403ECDA905; Tue, 11 Jun 2019 19:02:15 +0200 (CEST)
Date:   Tue, 11 Jun 2019 19:02:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] Btrfs: fix data loss after inode eviction, renaming
 it, and fsync it
Message-ID: <20190611170215.GF3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190606110719.20855-1-fdmanana@kernel.org>
 <20190607102524.32655-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607102524.32655-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 07, 2019 at 11:25:24AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we log an inode, regardless of logging it completely or only that it
> exists, we always update it as logged (logged_trans and last_log_commit
> fields of the inode are updated). This is generally fine and avoids future
> attempts to log it from having to do repeated work that brings no value.
> 
> However, if we write data to a file, then evict its inode after all the
> dealloc was flushed (and ordered extents completed), rename the file and
> fsync it, we end up not logging the new extents, since the rename may
> result in logging that the inode exists in case the parent directory was
> logged before. The following reproducer shows and explains how this can
> happen:
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt
> 
>   $ mkdir /mnt/dir
>   $ touch /mnt/dir/foo
>   $ touch /mnt/dir/bar
> 
>   # Do a direct IO write instead of a buffered write because with a
>   # buffered write we would need to make sure dealloc gets flushed and
>   # complete before we do the inode eviction later, and we can not do that
>   # from user space with call to things such as sync(2) since that results
>   # in a transaction commit as well.
>   $ xfs_io -d -c "pwrite -S 0xd3 0 4K" /mnt/dir/bar
> 
>   # Keep the directory dir in use while we evict inodes. We want our file
>   # bar's inode to be evicted but we don't want our directory's inode to
>   # be evicted (if it were evicted too, we would not be able to reproduce
>   # the issue since the first fsync below, of file foo, would result in a
>   # transaction commit.
>   $ ( cd /mnt/dir; while true; do :; done ) &
>   $ pid=$!
> 
>   # Wait a bit to give time for the background process to chdir.
>   $ sleep 0.1
> 
>   # Evict all inodes, except the inode for the directory dir because it is
>   # currently in use by our background process.
>   $ echo 2 > /proc/sys/vm/drop_caches
> 
>   # fsync file foo, which ends up persisting information about the parent
>   # directory because it is a new inode.
>   $ xfs_io -c fsync /mnt/dir/foo
> 
>   # Rename bar, this results in logging that this inode exists (inode item,
>   # names, xattrs) because the parent directory is in the log.
>   $ mv /mnt/dir/bar /mnt/dir/baz
> 
>   # Now fsync baz, which ends up doing absolutely nothing because of the
>   # rename operation which logged that the inode exists only.
>   $ xfs_io -c fsync /mnt/dir/baz
> 
>   <power failure>
> 
>   $ mount /dev/sdb /mnt
>   $ od -t x1 -A d /mnt/dir/baz
>   0000000
> 
>     --> Empty file, data we wrote is missing.
> 
> Fix this by not updating last_sub_trans of an inode when we are logging
> only that it exists and the inode was not yet logged since it was loaded
> from disk (full_sync bit set), this is enough to make btrfs_inode_in_log()
> return false for this scenario and make us log the inode. The logged_trans
> of the inode is still always setsince that alone is used to track if names
> need to be deleted as part of unlink operations.
> 
> Fixes: 257c62e1bce03e ("Btrfs: avoid tree log commit when there are no changes")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
