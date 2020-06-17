Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85C91FD53A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQTOT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 15:14:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQTOT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 15:14:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C158ADF2;
        Wed, 17 Jun 2020 19:14:20 +0000 (UTC)
Subject: Re: [PATCH v2] btrfs: Allow btrfs_truncate_block() to fallback to
 nocow for data space reservation
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Martin Doucha <martin.doucha@suse.com>,
        Filipe Manana <fdmanana@suse.com>
References: <20200603062115.16227-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <da42eea6-bc7a-580e-b936-a98a5c3c7e6f@suse.com>
Date:   Wed, 17 Jun 2020 22:14:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603062115.16227-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.06.20 г. 9:21 ч., Qu Wenruo wrote:
> [BUG]
> When the data space is exhausted, even the inode has NOCOW attribute,
> btrfs will still refuse to truncate unaligned range due to ENOSPC.
> 
> The following script can reproduce it pretty easily:
>   #!/bin/bash
> 
>   dev=/dev/test/test
>   mnt=/mnt/btrfs
> 
>   umount $dev &> /dev/null
>   umount $mnt&> /dev/null
> 
>   mkfs.btrfs -f $dev -b 1G
>   mount -o nospace_cache $dev $mnt
>   touch $mnt/foobar
>   chattr +C $mnt/foobar
> 
>   xfs_io -f -c "pwrite -b 4k 0 4k" $mnt/foobar > /dev/null
>   xfs_io -f -c "pwrite -b 4k 0 1G" $mnt/padding &> /dev/null
>   sync
> 
>   xfs_io -c "fpunch 0 2k" $mnt/foobar
>   umount $mnt
> 
> Current btrfs will fail at the fpunch part.
> 
> [CAUSE]
> Because btrfs_truncate_block() always reserve space without checking the
> NOCOW attribute.
> 
> Since the writeback path follows NOCOW bit, we only need to bother the
> space reservation code in btrfs_truncate_block().
> 
> [FIX]
> Make btrfs_truncate_block() to follow btrfs_buffered_write() to try to
> reserve data space first, and falls back to NOCOW check only when we
> don't have enough space.
> 
> Such always-try-reserve is an optimization introduced in
> btrfs_buffered_write(), to avoid expensive btrfs_check_can_nocow() call.
> 
> Since now check_can_nocow() is needed outside of inode.c, also export it
> and rename it to btrfs_check_can_nocow().
> 
> Reported-by: Martin Doucha <martin.doucha@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> Changelog:
> v2:
> - Rebased to misc-next
>   Only one minor conflict in ctree.h
> ---
>  fs/btrfs/ctree.h |  2 ++
>  fs/btrfs/file.c  | 10 +++++-----
>  fs/btrfs/inode.c | 41 ++++++++++++++++++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 161533040978..40e8c8170d39 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2984,6 +2984,8 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
>  		      size_t num_pages, loff_t pos, size_t write_bytes,
>  		      struct extent_state **cached);
>  int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
> +			  size_t *write_bytes);
>  
>  /* tree-defrag.c */
>  int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fde125616687..a298803e2b08 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1532,8 +1532,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
>  	return ret;
>  }
>  
> -static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
> -				    size_t *write_bytes)
> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
> +			  size_t *write_bytes)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct btrfs_root *root = inode->root;
> @@ -1632,8 +1632,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		if (ret < 0) {
>  			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>  						      BTRFS_INODE_PREALLOC)) &&
> -			    check_can_nocow(BTRFS_I(inode), pos,
> -					&write_bytes) > 0) {
> +			    btrfs_check_can_nocow(BTRFS_I(inode), pos,
> +						  &write_bytes) > 0) {

This function acquires DREW lock and I don't see this lock being
released in the caller. David already raised concerns about
check_can_nocow obscuring this locking. Let's refactor this function
before introducing new callers.

>  				/*
>  				 * For nodata cow case, no need to reserve
>  				 * data space.
> @@ -1950,7 +1950,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>  		 */
>  		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>  					      BTRFS_INODE_PREALLOC)) ||
> -		    check_can_nocow(BTRFS_I(inode), pos, &count) <= 0) {
> +		    btrfs_check_can_nocow(BTRFS_I(inode), pos, &count) <= 0) {
>  			inode_unlock(inode);
>  			return -EAGAIN;
>  		}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1242d0aa108d..6b94ec7369c6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4493,11 +4493,13 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
>  	struct extent_state *cached_state = NULL;
>  	struct extent_changeset *data_reserved = NULL;
>  	char *kaddr;
> +	bool only_release_metadata = false;
>  	u32 blocksize = fs_info->sectorsize;
>  	pgoff_t index = from >> PAGE_SHIFT;
>  	unsigned offset = from & (blocksize - 1);
>  	struct page *page;
>  	gfp_t mask = btrfs_alloc_write_mask(mapping);
> +	size_t write_bytes = blocksize;
>  	int ret = 0;
>  	u64 block_start;
>  	u64 block_end;
> @@ -4509,11 +4511,26 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
>  	block_start = round_down(from, blocksize);
>  	block_end = block_start + blocksize - 1;
>  
> -	ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
> -					   block_start, blocksize);
> -	if (ret)
> +	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
> +					  blocksize);
> +	if (ret < 0) {
> +		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> +					      BTRFS_INODE_PREALLOC)) &&
> +		    btrfs_check_can_nocow(BTRFS_I(inode), block_start,
> +					  &write_bytes) > 0) {
> +			/* For nocow case, no need to reserve data space. */
> +			only_release_metadata = true;
> +		} else {
> +			goto out;
> +		}
> +	}
> +	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), blocksize);
> +	if (ret < 0) {
> +		if (!only_release_metadata)
> +			btrfs_free_reserved_data_space(inode, data_reserved,
> +					block_start, blocksize);
>  		goto out;
> -
> +	}
>  again:
>  	page = find_or_create_page(mapping, index, mask);
>  	if (!page) {
> @@ -4582,10 +4599,20 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
>  	set_page_dirty(page);
>  	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
>  
> +	if (only_release_metadata)
> +		set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,
> +				block_end, EXTENT_NORESERVE, NULL, NULL,
> +				GFP_NOFS);
> +
>  out_unlock:
> -	if (ret)
> -		btrfs_delalloc_release_space(inode, data_reserved, block_start,
> -					     blocksize, true);
> +	if (ret) {
> +		if (!only_release_metadata)
> +			btrfs_delalloc_release_space(inode, data_reserved,
> +					block_start, blocksize, true);
> +		else
> +			btrfs_delalloc_release_metadata(BTRFS_I(inode),
> +					blocksize, true);
> +	}
>  	btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
>  	unlock_page(page);
>  	put_page(page);
> 
