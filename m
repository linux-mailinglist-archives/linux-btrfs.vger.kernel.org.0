Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2047A26FEE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIRNlj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:41:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgIRNlj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:41:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=RPFx3KusK1gouHi8ZQg5+x3WXo5b3o1BlPAiRD8MVf0=;
        b=CgGBx4jV1oX1XRlG4+iWjlz4B3QLv6WCqWTTfrmI/tMOpm8R4VGkJZrLUHOS55pqkeJgQJ
        yuV2SEhXpGrRxj5deYVUZo2ozchToS23sLctMT3KQv0b9fdKVRGlfVSPQkQvjbJEl3SWnP
        rCiSgnZll8Qm5nFbI82g7xCCOiiktPA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FB30AC79
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 13:42:11 +0000 (UTC)
Subject: Re: [PATCH 1/7] btrfs: Don't call readpage_end_io_hook for the btree
 inode
To:     linux-btrfs@vger.kernel.org
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-2-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <34abb0f8-729d-aca2-295e-5d11057f4fb3@suse.com>
Date:   Fri, 18 Sep 2020 16:41:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918133439.23187-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.09.20 г. 16:34 ч., Nikolay Borisov wrote:
> Instead of relying on indirect calls to implement metadata buffer
> validation simply check if the inode whose page we are processing equals
> the btree inode. If it does call the necessary function.
> 
> This is an improvement in 2 directions:
> 1. We aren't paying the penalty of indirect calls in a post-speculation
>    attacks world.
> 
> 2. The function is now named more explicitly so it's obvious what's
>    going on
> 
> This is in preparation to removing struct extent_io_ops altogether.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---

So this patch does a bit more than it states because it's also modifying
the readpage_end_io_hook for data nodes as well. Other than that the
code is correct. I'd reword the changelog to the following:

Subject: Call readpage_end_io_hook directly

"
Instead of relying on indirect calls to implement post-read processing
simply distinguish between data/metadata pages and call the
corresponding function. This patch also renames and exports the 2 hooks
giving them more clear names.

This is an improvement in 2 directions:
1. We aren't paying the penalty of indirect calls in a post-speculation
   attacks world.

2. The function is now named more explicitly so it's obvious what's
    going on

 This is in preparation to removing struct extent_io_ops altogether.
"

>  fs/btrfs/ctree.h     | 2 ++
>  fs/btrfs/disk-io.c   | 8 ++++----
>  fs/btrfs/disk-io.h   | 4 +++-
>  fs/btrfs/extent_io.c | 9 ++++++---
>  fs/btrfs/inode.c     | 7 +++----
>  5 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e667b0565e0..0c58d96b9fb3 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2962,6 +2962,8 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode,
>  u64 btrfs_file_extent_end(const struct btrfs_path *path);
>  
>  /* inode.c */
> +int btrfs_check_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
> +		     struct page *page, u64 start, u64 end, int mirror);
>  struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
>  					   u64 start, u64 len);
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 160b485d2cc0..5ad11c38230f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -524,9 +524,9 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
>  	return 1;
>  }
>  
> -static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
> -				      u64 phy_offset, struct page *page,
> -				      u64 start, u64 end, int mirror)
> +int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
> +				   struct page *page, u64 start, u64 end,
> +				   int mirror)
>  {
>  	u64 found_start;
>  	int found_level;
> @@ -4639,5 +4639,5 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
>  static const struct extent_io_ops btree_extent_io_ops = {
>  	/* mandatory callbacks */
>  	.submit_bio_hook = btree_submit_bio_hook,
> -	.readpage_end_io_hook = btree_readpage_end_io_hook,
> +	.readpage_end_io_hook = NULL
>  };
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 89b6a709a184..bc2e49246199 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -76,7 +76,9 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
>  void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
>  void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
>  				 struct btrfs_root *root);
> -
> +int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
> +				   struct page *page, u64 start, u64 end,
> +				   int mirror);
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
>  #endif
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index afac70ef0cc5..5e47606f7786 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2851,9 +2851,12 @@ static void end_bio_extent_readpage(struct bio *bio)
>  
>  		mirror = io_bio->mirror_num;
>  		if (likely(uptodate)) {
> -			ret = tree->ops->readpage_end_io_hook(io_bio, offset,
> -							      page, start, end,
> -							      mirror);
> +			if (data_inode)
> +				ret = btrfs_check_csum(io_bio, offset, page,
> +						       start, end, mirror);
> +			else
> +				ret = btrfs_validate_metadata_buffer(io_bio,
> +					offset, page, start, end, mirror);
>  			if (ret)
>  				uptodate = 0;
>  			else
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cb3fdd0798c6..23ac09aa813e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2817,9 +2817,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
>   * if there's a match, we allow the bio to finish.  If not, the code in
>   * extent_io.c will try to find good copies for us.
>   */
> -static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
> -				      u64 phy_offset, struct page *page,
> -				      u64 start, u64 end, int mirror)
> +int btrfs_check_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
> +		     struct page *page, u64 start, u64 end, int mirror)
>  {
>  	size_t offset = start - page_offset(page);
>  	struct inode *inode = page->mapping->host;
> @@ -10249,7 +10248,7 @@ static const struct file_operations btrfs_dir_file_operations = {
>  static const struct extent_io_ops btrfs_extent_io_ops = {
>  	/* mandatory callbacks */
>  	.submit_bio_hook = btrfs_submit_bio_hook,
> -	.readpage_end_io_hook = btrfs_readpage_end_io_hook,
> +	.readpage_end_io_hook = NULL
>  };
>  
>  /*
> 
