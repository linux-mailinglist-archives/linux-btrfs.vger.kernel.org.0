Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83F01FB47A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgFPOeb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 10:34:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:58302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPOeb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 10:34:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F6E8ABE4;
        Tue, 16 Jun 2020 14:34:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77C20DA7C3; Tue, 16 Jun 2020 16:34:20 +0200 (CEST)
Date:   Tue, 16 Jun 2020 16:34:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] Btrfs: fix hang on snapshot creation after
 RWF_NOWAIT write
Message-ID: <20200616143420.GC27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200615174601.14559-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615174601.14559-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 06:46:01PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we do a successful RWF_NOWAIT write we end up locking the snapshot lock
> of the inode, through a call to check_can_nocow(), but we never unlock it.
> 
> This means the next attempt to create a snapshot on the subvolume will
> hang forever.
> 
> Trivial reproducer:
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt
> 
>   $ touch /mnt/foobar
>   $ chattr +C /mnt/foobar
>   $ xfs_io -d -c "pwrite -S 0xab 0 64K" /mnt/foobar
>   $ xfs_io -d -c "pwrite -N -V 1 -S 0xfe 0 64K" /mnt/foobar
> 
>   $ btrfs subvolume snapshot -r /mnt /mnt/snap
>     --> hangs
> 
> Fix this by unlocking the snapshot lock if check_can_nocow() returned
> success.
> 
> Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
> CC: stable@vger.kernel.org # 4.13+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 2c14312b05e8..04faa04fccd1 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1914,6 +1914,8 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>  			inode_unlock(inode);
>  			return -EAGAIN;
>  		}
> +		/* check_can_nocow() locks the snapshot lock on success */
> +		btrfs_drew_write_unlock(&root->snapshot_lock);

That's quite ugly that the locking semantics of check_can_nocow is
hidden, this should be cleaned up too.

The whole condition

1909                 if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
1910                                               BTRFS_INODE_PREALLOC)) ||
1911                     check_can_nocow(BTRFS_I(inode), pos, &count) <= 0)

has 2 parts and it's not obvious from the context when the lock actually is
taken. The flags check could be pushed down to check_can_nocow, the
same but negated condition can be found in btrfs_file_write_iter so this
would make it something like:

	if (check_can_nocow(inode, pos, &count) <= 0) {
		/* fallback */
		return ...;
	}
	/*
	 * the lock is taken and needs to be unlocked at the right time
	 */

Suggestions to rename check_can_nocow welcome too.


>  	}
>  
>  	current->backing_dev_info = inode_to_bdi(inode);
> -- 
> 2.26.2
