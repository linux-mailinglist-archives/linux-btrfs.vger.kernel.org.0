Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6B36152
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfFEQbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 12:31:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfFEQbL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 12:31:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F997AD27
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 16:31:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C59FDA866; Wed,  5 Jun 2019 18:32:00 +0200 (CEST)
Date:   Wed, 5 Jun 2019 18:32:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: Avoid nested chunk allocation call
Message-ID: <20190605163200.GF9896@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190416102144.12173-1-wqu@suse.com>
 <20190416102144.12173-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416102144.12173-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 16, 2019 at 06:21:43PM +0800, Qu Wenruo wrote:
> There is a hidden call loop which can trigger itself:
> 
> btrfs_reserve_extent()             <--|
> |- do_chunk_alloc()                   |
>    |- btrfs_alloc_chunk()             |
>       |- btrfs_insert_item()          |
> 	 |- btrfs_reserve_extent() <--|
> 
> Currently, we're using root->ref_cows to determine whether we should do
> chunk prealloc to avoid such loop.
> 
> But that's still a hidden trap. Instead of solving it using some hidden
> tricks, this patch will make chunk/block group allocation exclusive.
> 
> Now if do_chunk_alloc() determines to alloc chunk, it will set a special
> flag in transaction handler so it new do_chunk_alloc() will refuse to
> allocate new chunk until current chunk allocation finishes.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check/main.c  |  2 +-
>  extent-tree.c | 12 ++++++++++++
>  transaction.c |  3 ++-
>  transaction.h |  3 ++-
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 683c322eba6f..121be4b73c4f 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10185,7 +10185,7 @@ int cmd_check(int argc, char **argv)
>  			goto close_out;
>  		}
>  
> -		trans->reinit_extent_tree = true;
> +		trans->reinit_extent_tree = 1;
>  		if (init_extent_tree) {
>  			printf("Creating a new extent tree\n");
>  			ret = reinit_extent_tree(trans, info,
> diff --git a/extent-tree.c b/extent-tree.c
> index 8c9cdeff3b02..e25ddf02e5cc 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -1873,10 +1873,21 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
>  	    (flags & BTRFS_BLOCK_GROUP_SYSTEM))
>  		return 0;
>  
> +	/*
> +	 * We're going to allocate new chunk, during the process, we will
> +	 * allocate new tree blocks, which can trigger new chunk allocation
> +	 * again.
> +	 * Avoid such loop call
> +	 */
> +	if (trans->allocating_chunk)
> +		return 0;
> +	trans->allocating_chunk = 1;
> +
>  	ret = btrfs_alloc_chunk(trans, fs_info, &start, &num_bytes,
>  	                        space_info->flags);
>  	if (ret == -ENOSPC) {
>  		space_info->full = 1;
> +		trans->allocating_chunk = 0;
>  		return 0;
>  	}
>  
> @@ -1885,6 +1896,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
>  	ret = btrfs_make_block_group(trans, fs_info, 0, space_info->flags,
>  				     start, num_bytes);
>  	BUG_ON(ret);
> +	trans->allocating_chunk = 0;
>  	return 0;
>  }
>  
> diff --git a/transaction.c b/transaction.c
> index 3a63988b0969..21377282f806 100644
> --- a/transaction.c
> +++ b/transaction.c
> @@ -46,7 +46,8 @@ struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
>  	fs_info->generation++;
>  	h->transid = fs_info->generation;
>  	h->blocks_reserved = num_blocks;
> -	h->reinit_extent_tree = false;
> +	h->reinit_extent_tree = 0;
> +	h->allocating_chunk = 0;
>  	root->last_trans = h->transid;
>  	root->commit_root = root->node;
>  	extent_buffer_get(root->node);
> diff --git a/transaction.h b/transaction.h
> index 34060252dd5c..b426cd112447 100644
> --- a/transaction.h
> +++ b/transaction.h
> @@ -28,7 +28,8 @@ struct btrfs_trans_handle {
>  	u64 transid;
>  	u64 alloc_exclude_start;
>  	u64 alloc_exclude_nr;
> -	bool reinit_extent_tree;
> +	unsigned int reinit_extent_tree:1;
> +	unsigned int allocating_chunk:1;

Why do you switch reinit_extent_tree to the bit, this is an unrelated
change. I'll drop it and update changelog with the 2M preallocation
that was discussed.
