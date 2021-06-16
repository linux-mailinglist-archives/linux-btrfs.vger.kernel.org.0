Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2BB3AA4EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhFPUIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 16:08:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39862 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFPUIf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 16:08:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 933D021A77;
        Wed, 16 Jun 2021 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623873987;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jiU+tSGs5s7u2AfQMUzgHdMP4FON88TLCsmwtU80ys=;
        b=t0IUuz3NG3vLNz1cOHthcK4wxhrczpQKaMriXxK74Gopafq5VY4og9jXDZRcrpQfsvgH1y
        OPGXHC/fdKBaydbBYxhs88dyrEbmibylJKwFVlvXi0pea9icX4Eafrhmc/30iTrSx/0OtM
        4jcjgxxpDpAyzm9LXGINl6cOJ/fYwzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623873987;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jiU+tSGs5s7u2AfQMUzgHdMP4FON88TLCsmwtU80ys=;
        b=to9n/gR25StHP4CmJjuFlUEMEMerFTDXGN8BGXAQclSrAJw1CdpwsPWalJIv4+BnKCnKmd
        IwZCzsDZPSl//HCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8B2B4A3B91;
        Wed, 16 Jun 2021 20:06:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD2BBDB225; Wed, 16 Jun 2021 22:03:39 +0200 (CEST)
Date:   Wed, 16 Jun 2021 22:03:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [RFC PATCH 19/31] btrfs: Add reservation information to
 btrfs_iomap
Message-ID: <20210616200339.GS28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <d92db79ce8a41b7e0775f68f498ee6941264a0fd.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92db79ce8a41b7e0775f68f498ee6941264a0fd.1623567940.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 13, 2021 at 08:39:47AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Move reservation information into btrfs_iomap.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/file.c | 49 +++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 3d4b8fde47f4..ccae8ce7ec4f 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -63,6 +63,11 @@ struct btrfs_iomap {
>  	u64 lockend;
>  	struct extent_state *cached_state;
>  	int extents_locked;
> +
> +	/* Reservation */
> +	bool metadata_only;
> +	struct extent_changeset *data_reserved;
> +	size_t reserved_bytes;
>  };
>  
>  static int __compare_inode_defrag(struct inode_defrag *defrag1,
> @@ -1630,12 +1635,10 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct page **pages = NULL;
> -	struct extent_changeset *data_reserved = NULL;
>  	u64 release_bytes = 0;
>  	size_t num_written = 0;
>  	int nrptrs;
> -	ssize_t ret;
> -	bool only_release_metadata = false;
> +	int ret;
>  	loff_t old_isize = i_size_read(inode);
>  	unsigned int ilock_flags = 0;
>  	struct btrfs_iomap *bi = NULL;
> @@ -1673,14 +1676,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  	}
>  
>  	while (iov_iter_count(i) > 0) {
> -		struct extent_state *cached_state = NULL;
>  		size_t offset = offset_in_page(pos);
>  		size_t sector_offset;
>  		size_t write_bytes = min(iov_iter_count(i),
>  					 nrptrs * (size_t)PAGE_SIZE -
>  					 offset);
>  		size_t num_pages;
> -		size_t reserve_bytes;
>  		size_t dirty_pages;
>  		size_t copied;
>  		size_t dirty_sectors;
> @@ -1696,12 +1697,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		}
>  
>  		bi->extents_locked = false;
> -		only_release_metadata = false;
> +		bi->metadata_only = false;
>  		sector_offset = pos & (fs_info->sectorsize - 1);
>  
> -		extent_changeset_release(data_reserved);
> +		extent_changeset_release(bi->data_reserved);
>  		ret = btrfs_check_data_free_space(BTRFS_I(inode),
> -						  &data_reserved, pos,
> +						  &bi->data_reserved, pos,
>  						  write_bytes);
>  		if (ret < 0) {
>  			/*
> @@ -1711,36 +1712,36 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  			 */
>  			if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
>  						   &write_bytes) > 0)
> -				only_release_metadata = true;
> +				bi->metadata_only = true;
>  			else
>  				break;
>  		}
>  
>  		num_pages = DIV_ROUND_UP(write_bytes + offset, PAGE_SIZE);
>  		WARN_ON(num_pages > nrptrs);
> -		reserve_bytes = round_up(write_bytes + sector_offset,
> +		bi->reserved_bytes = round_up(write_bytes + sector_offset,
>  					 fs_info->sectorsize);
> -		WARN_ON(reserve_bytes == 0);
> +		WARN_ON(bi->reserved_bytes == 0);
>  		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
> -				reserve_bytes);
> +				bi->reserved_bytes);
>  		if (ret) {
> -			if (!only_release_metadata)
> +			if (!bi->metadata_only)
>  				btrfs_free_reserved_data_space(BTRFS_I(inode),
> -						data_reserved, pos,
> +						bi->data_reserved, pos,
>  						write_bytes);
>  			else
>  				btrfs_check_nocow_unlock(BTRFS_I(inode));
>  			break;
>  		}
>  
> -		release_bytes = reserve_bytes;
> +		release_bytes = bi->reserved_bytes;
>  
>  		if (pos < inode->i_size) {
>  			bi->lockstart = round_down(pos, fs_info->sectorsize);
>  			bi->lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
>  			btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
>  					bi->lockstart, bi->lockend,
> -					&cached_state);
> +					&bi->cached_state);
>  			bi->extents_locked = true;
>  		}
>  
> @@ -1753,13 +1754,13 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  				    pos, write_bytes);
>  		if (ret) {
>  			btrfs_delalloc_release_extents(BTRFS_I(inode),
> -						       reserve_bytes);
> +						       bi->reserved_bytes);
>  			break;
>  		}
>  
>  		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
>  
> -		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
> +		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bi->reserved_bytes);
>  		dirty_sectors = round_up(copied + sector_offset,
>  					fs_info->sectorsize);
>  		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
> @@ -1782,7 +1783,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		if (num_sectors > dirty_sectors) {
>  			/* release everything except the sectors we dirtied */
>  			release_bytes -= dirty_sectors << fs_info->sectorsize_bits;
> -			if (only_release_metadata) {
> +			if (bi->metadata_only) {
>  				btrfs_delalloc_release_metadata(BTRFS_I(inode),
>  							release_bytes, true);
>  			} else {
> @@ -1792,7 +1793,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  						   fs_info->sectorsize) +
>  					(dirty_pages << PAGE_SHIFT);
>  				btrfs_delalloc_release_space(BTRFS_I(inode),
> -						data_reserved, __pos,
> +						bi->data_reserved, __pos,
>  						release_bytes, true);
>  			}
>  		}
> @@ -1802,7 +1803,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  
>  		ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
>  					dirty_pages, pos, copied,
> -					&cached_state, only_release_metadata);
> +					&bi->cached_state,
> +					bi->metadata_only);
>  
>  		/*
>  		 * If we have not locked the extent range, because the range's
> @@ -1819,14 +1821,14 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  			free_extent_state(bi->cached_state);
>  		bi->extents_locked = false;
>  
> -		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
> +		btrfs_delalloc_release_extents(BTRFS_I(inode), bi->reserved_bytes);
>  		if (ret) {
>  			btrfs_drop_pages(pages, num_pages);
>  			break;
>  		}
>  
>  		release_bytes = 0;
> -		if (only_release_metadata)
> +		if (bi->metadata_only)
>  			btrfs_check_nocow_unlock(BTRFS_I(inode));
>  
>  		btrfs_drop_pages(pages, num_pages);
> @@ -1850,7 +1852,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		btrfs_check_nocow_unlock(BTRFS_I(inode));
>  	btrfs_iomap_release(inode, pos, release_bytes, bi);
>  out:
> -	kfree(bi);

Is this intentional? Or I don't see the pairing kfree that happens
elsewhere.

>  	btrfs_inode_unlock(inode, ilock_flags);
>  	return num_written ? num_written : ret;
>  }
> -- 
> 2.31.1
