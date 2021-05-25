Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D139065D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhEYQPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 12:15:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233235AbhEYQPw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 12:15:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621959262;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psS28WF+ZcFHjH62yflSirSQ16bOQfcoFKAEUSUXyuw=;
        b=iazdDzOj6MtLMutvjJeylxOvx+Xyh4H5n3Z1s5Z+V3aTkA+r+sj5UrD/jF9MZjDrvxrQmZ
        0dkUhHQrLJkQ9hr+Ra0J5qRSzz+kWNKXMstpQdE+cNYDP57LrX8pBLgqy23jad92qbzh9I
        xKOqhBYPkbld75rXnDHMP6Tmn6l5B3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621959262;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psS28WF+ZcFHjH62yflSirSQ16bOQfcoFKAEUSUXyuw=;
        b=1b0W4MarlKWEKONBJCiVQWGIM+rhB5yKe9X1gQdRYtxc/eJefJz4cXepN2B6j/nNvAo/ky
        /S1PY1APukZfM7Bw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B09BAE99;
        Tue, 25 May 2021 16:14:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 935C0DA70B; Tue, 25 May 2021 18:11:45 +0200 (CEST)
Date:   Tue, 25 May 2021 18:11:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix deadlock when cloning inline extents and low
 on available space
Message-ID: <20210525161145.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <fe861a6c4f23f3980fcf198bdbd7e92cdc6847b9.1621936270.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe861a6c4f23f3980fcf198bdbd7e92cdc6847b9.1621936270.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 25, 2021 at 11:05:28AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are a few cases where cloning an inline extent requires copying data
> into a page of the destination inode. For these cases we are allocating
> the required data and metadata space while holding a leaf locked. This can
> result in a deadlock when we are low on available space because allocating
> the space may flush delalloc and two deadlock scenarios can happen:
> 
> 1) When starting writeback for an inode with a very small dirty range that
>    fits in an inline extent, we deadlock during the writeback when trying
>    to insert the inline extent, at cow_file_range_inline(), if the extent
>    is going to be located in the leaf for which we are already holding a
>    read lock;
> 
> 2) After successfully starting writeback, for non-inline extent cases,
>    the async reclaim thread will hang waiting for an ordered extent to
>    complete if the ordered extent completion needs to modify the leaf
>    for which the clone task is holding a read lock (for adding or
>    replacing file extent items). So the cloning task will wait forever
>    on the async reclaim thread to make progress, which in turn is
>    waiting for the ordered extent completion which in turn is waiting
>    to acquire a write lock on the same leaf.
> 
> So fix this by making sure we release the path (and therefore the leaf)
> everytime we need to copy the inline extent's data into a page of the
> destination inode, as by that time we do not need to have the leaf locked.
> 
> Fixes: 05a5a7621ce66c ("Btrfs: implement full reflink support for inline extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/reflink.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 06682128d8fa..58ddc7ed9e84 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -207,10 +207,7 @@ static int clone_copy_inline_extent(struct inode *dst,
>  			 * inline extent's data to the page.
>  			 */
>  			ASSERT(key.offset > 0);
> -			ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
> -						  inline_data, size, datal,
> -						  comp_type);
> -			goto out;
> +			goto copy_to_page;
>  		}
>  	} else if (i_size_read(dst) <= datal) {
>  		struct btrfs_file_extent_item *ei;
> @@ -226,13 +223,10 @@ static int clone_copy_inline_extent(struct inode *dst,
>  		    BTRFS_FILE_EXTENT_INLINE)
>  			goto copy_inline_extent;
>  
> -		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
> -					  inline_data, size, datal, comp_type);
> -		goto out;
> +		goto copy_to_page;
>  	}
>  
>  copy_inline_extent:
> -	ret = 0;
>  	/*
>  	 * We have no extent items, or we have an extent at offset 0 which may
>  	 * or may not be inlined. All these cases are dealt the same way.
> @@ -244,11 +238,13 @@ static int clone_copy_inline_extent(struct inode *dst,
>  		 * clone. Deal with all these cases by copying the inline extent
>  		 * data into the respective page at the destination inode.
>  		 */
> -		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
> -					  inline_data, size, datal, comp_type);
> -		goto out;
> +		goto copy_to_page;
>  	}
>  
> +	/*
> +	 * Release path before starting a new transaction so we don't hold locks
> +	 * that would confuse lockdep.
> +	 */
>  	btrfs_release_path(path);
>  	/*
>  	 * If we end up here it means were copy the inline extent into a leaf
> @@ -285,11 +281,6 @@ static int clone_copy_inline_extent(struct inode *dst,
>  	ret = btrfs_inode_set_file_extent_range(BTRFS_I(dst), 0, aligned_end);
>  out:
>  	if (!ret && !trans) {
> -		/*
> -		 * Release path before starting a new transaction so we don't
> -		 * hold locks that would confuse lockdep.
> -		 */
> -		btrfs_release_path(path);
>  		/*
>  		 * No transaction here means we copied the inline extent into a
>  		 * page of the destination inode.
> @@ -310,6 +301,21 @@ static int clone_copy_inline_extent(struct inode *dst,
>  		*trans_out = trans;
>  
>  	return ret;
> +
> +copy_to_page:
> +	/*
> +	 * Release our path because we don't need it anymore and also because
> +	 * copy_inline_to_page() needs to reserve data and metadata, which may
> +	 * need to flush delalloc when we are low on available space and
> +	 * therefore cause a deadlock if writeback of an inline extent needs to
> +	 * write to the same leaf or an ordered extent completion needs to write
> +	 * to the same leaf.
> +	 */
> +	btrfs_release_path(path);
> +
> +	ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
> +				  inline_data, size, datal, comp_type);
> +	goto out;
>  }

I don't like to see the pattern with the chained labels but in this case
I don't see a better way, so ok.
