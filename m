Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFD03AA4EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhFPUH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 16:07:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFPUHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 16:07:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 319AA1FD49;
        Wed, 16 Jun 2021 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623873918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5DwxrvNXyMu1ffgfHDb+rmiuONMQZw677Enfzf3XTXA=;
        b=iUFaibpvPJ1RCI/mXDoqQyu0y5Qn2KrbhmDHzvf6mbTirpUsWU+ywBfM31gMrjn1+FK3IY
        qhOXFKh7t7p0x79MgoF/uHnG7P9r49J3a0Nx90f7um9HbcHaNOwK7D6zLHbeDXkJ/xY70Y
        p0rn5MPsBlKVcykZ6UczDbsL5XjfBV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623873918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5DwxrvNXyMu1ffgfHDb+rmiuONMQZw677Enfzf3XTXA=;
        b=o/mdhv94rU8f9FiDnJDjIO8y+LvBv57OMPWU6ZLuIpxksTDc5HZjS6PdhealHP2jo8yX3g
        yXMrmHUgu+dKFxCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2A527A3BAC;
        Wed, 16 Jun 2021 20:05:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16602DB225; Wed, 16 Jun 2021 22:02:29 +0200 (CEST)
Date:   Wed, 16 Jun 2021 22:02:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [RFC PATCH 17/31] btrfs: Introduce btrfs_iomap
Message-ID: <20210616200229.GR28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <23b8bc9426ff2de7cf4345c21df8d0c9c36dffa6.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b8bc9426ff2de7cf4345c21df8d0c9c36dffa6.1623567940.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 13, 2021 at 08:39:45AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> A structure which will be used to transfer information from
> iomap_begin() to iomap_end().
> 
> Move all locking information into btrfs_iomap.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/file.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a94ab3c8da1d..a28435a6bb7e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -56,6 +56,15 @@ struct inode_defrag {
>  	int cycled;
>  };
>  
> +struct btrfs_iomap {
> +
> +	/* Locking */
> +	u64 lockstart;
> +	u64 lockend;
> +	struct extent_state *cached_state;
> +	int extents_locked;
> +};
> +
>  static int __compare_inode_defrag(struct inode_defrag *defrag1,
>  				  struct inode_defrag *defrag2)
>  {
> @@ -1599,14 +1608,13 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  	struct page **pages = NULL;
>  	struct extent_changeset *data_reserved = NULL;
>  	u64 release_bytes = 0;
> -	u64 lockstart;
> -	u64 lockend;
>  	size_t num_written = 0;
>  	int nrptrs;
>  	ssize_t ret;
>  	bool only_release_metadata = false;
>  	loff_t old_isize = i_size_read(inode);
>  	unsigned int ilock_flags = 0;
> +	struct btrfs_iomap *bi = NULL;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		ilock_flags |= BTRFS_ILOCK_TRY;
> @@ -1634,6 +1642,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		goto out;
>  	}
>  
> +	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);

This is adding an allocation per write. The struct btrfs_iomap is not
that big so it could be on stack, but as there are more members added to
it in further patches the size could become unsuitable for stack. OTOH
some optimization of the member layout can reduce the size, I haven't
looked closer.

> +	if (!bi) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	while (iov_iter_count(i) > 0) {
>  		struct extent_state *cached_state = NULL;
>  		size_t offset = offset_in_page(pos);
> @@ -1647,7 +1661,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		size_t copied;
>  		size_t dirty_sectors;
>  		size_t num_sectors;
> -		int extents_locked = false;
>  
>  		/*
>  		 * Fault pages before locking them in prepare_pages
> @@ -1658,6 +1671,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  			break;
>  		}
>  
> +		bi->extents_locked = false;
>  		only_release_metadata = false;
>  		sector_offset = pos & (fs_info->sectorsize - 1);
>  
> @@ -1698,11 +1712,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		release_bytes = reserve_bytes;
>  
>  		if (pos < inode->i_size) {
> -			lockstart = round_down(pos, fs_info->sectorsize);
> -			lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
> +			bi->lockstart = round_down(pos, fs_info->sectorsize);
> +			bi->lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
>  			btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
> -					lockstart, lockend, &cached_state);
> -			extents_locked = true;
> +					bi->lockstart, bi->lockend,
> +					&cached_state);
> +			bi->extents_locked = true;
>  		}
>  
>  		/*
> @@ -1715,11 +1730,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		if (ret) {
>  			btrfs_delalloc_release_extents(BTRFS_I(inode),
>  						       reserve_bytes);
> -			if (extents_locked)
> -				unlock_extent_cached(&BTRFS_I(inode)->io_tree,
> -						lockstart, lockend, &cached_state);
> -			else
> -				free_extent_state(cached_state);
>  			break;
>  		}
>  
> @@ -1777,12 +1787,13 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		 * as delalloc through btrfs_dirty_pages(). Therefore free any
>  		 * possible cached extent state to avoid a memory leak.
>  		 */
> -		if (extents_locked)
> +		if (bi->extents_locked)
>  			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
> -					     lockstart, lockend, &cached_state);
> +					     bi->lockstart, bi->lockend,
> +					     &bi->cached_state);
>  		else
> -			free_extent_state(cached_state);
> -		extents_locked = false;
> +			free_extent_state(bi->cached_state);
> +		bi->extents_locked = false;
>  
>  		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
>  		if (ret) {
> @@ -1825,6 +1836,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		iocb->ki_pos += num_written;
>  	}
>  out:
> +	kfree(bi);

It's released in the same function, so that's the lifetime.

>  	btrfs_inode_unlock(inode, ilock_flags);
>  	return num_written ? num_written : ret;
>  }
> -- 
> 2.31.1
