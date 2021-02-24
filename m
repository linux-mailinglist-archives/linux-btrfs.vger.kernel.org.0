Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0491B32448E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 20:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhBXTVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 14:21:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:34438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233844AbhBXTVF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 14:21:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58C2BAB95;
        Wed, 24 Feb 2021 19:20:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80D92DA734; Wed, 24 Feb 2021 20:18:23 +0100 (CET)
Date:   Wed, 24 Feb 2021 20:18:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Erik Jensen <erikjensen@rkjnsn.net>
Subject: Re: [PATCH] btrfs: do more graceful error/warning for 32bit kernel
Message-ID: <20210224191823.GC1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Erik Jensen <erikjensen@rkjnsn.net>
References: <20210220020633.53400-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220020633.53400-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 20, 2021 at 10:06:33AM +0800, Qu Wenruo wrote:
> Due to the pagecache limit of 32bit systems, btrfs can't access metadata
> at or beyond 16T boundary correctly.
> 
> And unlike other fses, btrfs uses internally mapped u64 address space for
> all of its metadata, this is more tricky than other fses.
> 
> Users can have a fs which doesn't have metadata beyond 16T boundary at
> mount time, but later balance can cause btrfs to create metadata beyond
> 16T boundary.

As this is for the interhal logical offsets, it should be fixable by
reusing the range below 16T on 32bit systems. There's some logic relying
on the highest logical offset and block group flags so this needs to be
done with some care, but is possible in principle.

> And modification to MM layer is unrealistic just for such minor use
> case.
> 
> To address such problem, this patch will introduce the following checks:
> 
> - Mount time rejection
>   This will reject any fs which has metadata chunk at or beyond 16T
>   boundary.
> 
> - Mount time early warning
>   If there is any metadata chunk beyond 10T boundary, we do an early
>   warning and hope the end user will see it.
> 
> - Runtime extent buffer rejection
>   If we're going to allocate an extent buffer at or beyond 16T boundary,
>   reject such request with -EOVERFLOW.
> 
> - Runtime extent buffer early warning
>   If an extent buffer beyond 10T is beyond allocated, do an early
>   warning.
> 
> Above error/warning message will only be outputted once for each fs to
> reduce dmesg flood.
> 
> Reported-by: Erik Jensen <erikjensen@rkjnsn.net>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h     | 12 ++++++++++
>  fs/btrfs/extent_io.c | 12 ++++++++++
>  fs/btrfs/super.c     | 24 ++++++++++++++++++++
>  fs/btrfs/volumes.c   | 54 ++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 40ec3393d2a1..91536c3bd5d8 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -572,6 +572,12 @@ enum {
>  
>  	/* Indicate that we can't trust the free space tree for caching yet */
>  	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> +
> +#if BITS_PER_LONG == 32
> +	/* Indicate if we have error/warn message outputted for 32bit system */
> +	BTRFS_FS_32BIT_ERROR,
> +	BTRFS_FS_32BIT_WARN,
> +#endif
>  };
>  
>  /*
> @@ -3405,6 +3411,12 @@ static inline void assertfail(const char *expr, const char* file, int line) { }
>  #define ASSERT(expr)	(void)(expr)
>  #endif
>  
> +#if BITS_PER_LONG == 32
> +#define BTRFS_32BIT_EARLY_WARN_THRESHOLD	(10ULL * 1024 * SZ_1G)
> +void btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info);
> +void btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info);
> +#endif
> +
>  /*
>   * Get the correct offset inside the page of extent buffer.
>   *
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4dfb3ead1175..6af6714d49c1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5554,6 +5554,18 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +#if BITS_PER_LONG == 32
> +	if (start >= MAX_LFS_FILESIZE) {
> +		btrfs_err(fs_info,
> +		"extent buffer %llu is beyond 32bit page cache limit",
> +			  start);
> +		btrfs_err_32bit_limit(fs_info);
> +		return ERR_PTR(-EOVERFLOW);
> +	}
> +	if (start >= BTRFS_32BIT_EARLY_WARN_THRESHOLD)
> +		btrfs_warn_32bit_limit(fs_info);
> +#endif
> +
>  	if (fs_info->sectorsize < PAGE_SIZE &&
>  	    offset_in_page(start) + len > PAGE_SIZE) {
>  		btrfs_err(fs_info,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f8435641b912..bd959fc664b5 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -252,6 +252,30 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
>  }
>  #endif
>  
> +#if BITS_PER_LONG == 32
> +void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
> +{
> +	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
> +		btrfs_warn(fs_info, "btrfs is reaching 32bit kernel limit.");
> +		btrfs_warn(fs_info,
> +"due to 32bit page cache limit, btrfs can't access metadata at or beyond 16T.");
> +		btrfs_warn(fs_info,
> +			   "please consider upgrade to 64bit kernel/hardware.");
> +	}
> +}
> +
> +void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
> +{
> +	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
> +		btrfs_err(fs_info, "btrfs reached 32bit kernel limit.");
> +		btrfs_err(fs_info,
> +"due to 32bit page cache limit, btrfs can't access metadata at or beyond 16T.");
> +		btrfs_err(fs_info,
> +			   "please consider upgrade to 64bit kernel/hardware.");
> +	}
> +}
> +#endif
> +
>  /*
>   * We only mark the transaction aborted and then set the file system read-only.
>   * This will prevent new transactions from starting or trying to join this
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b8fab44394f5..5dc22daa684d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6787,6 +6787,46 @@ static u64 calc_stripe_length(u64 type, u64 chunk_len, int num_stripes)
>  	return div_u64(chunk_len, data_stripes);
>  }
>  
> +#if BITS_PER_LONG == 32
> +/*
> + * Due to page cache limit, btrfs can't access metadata at or beyond
> + * MAX_LFS_FILESIZE (16T) on 32bit systemts.
> + *
> + * This function do mount time check to reject the fs if it already has
> + * metadata chunk beyond that limit.
> + */
> +static int check_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
> +				  u64 logical, u64 length, u64 type)
> +{
> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
> +		return 0;
> +
> +	if (logical + length < MAX_LFS_FILESIZE)
> +		return 0;
> +
> +	btrfs_err_32bit_limit(fs_info);
> +	return -EOVERFLOW;
> +}
> +
> +/*
> + * This is to give early warning for any metadata chunk reaching
> + * 10T boundary.
> + * Although we can still access the metadata, it's a timed bomb thus an early
> + * warning is definitely needed.
> + */
> +static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
> +				  u64 logical, u64 length, u64 type)
> +{
> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
> +		return;
> +
> +	if (logical + length < BTRFS_32BIT_EARLY_WARN_THRESHOLD)
> +		return;
> +
> +	btrfs_warn_32bit_limit(fs_info);
> +}
> +#endif
> +
>  static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>  			  struct btrfs_chunk *chunk)
>  {
> @@ -6797,6 +6837,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>  	u64 logical;
>  	u64 length;
>  	u64 devid;
> +	u64 type;
>  	u8 uuid[BTRFS_UUID_SIZE];
>  	int num_stripes;
>  	int ret;
> @@ -6804,8 +6845,17 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>  
>  	logical = key->offset;
>  	length = btrfs_chunk_length(leaf, chunk);
> +	type = btrfs_chunk_type(leaf, chunk);
>  	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
>  
> +#if BITS_PER_LONG == 32
> +	ret = check_32bit_meta_chunk(fs_info, logical, length, type);
> +	if (ret < 0)
> +		return ret;
> +	warn_32bit_meta_chunk(fs_info, logical, length, type);
> +#endif
> +
> +
>  	/*
>  	 * Only need to verify chunk item if we're reading from sys chunk array,
>  	 * as chunk item in tree block is already verified by tree-checker.
> @@ -6849,10 +6899,10 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>  	map->io_width = btrfs_chunk_io_width(leaf, chunk);
>  	map->io_align = btrfs_chunk_io_align(leaf, chunk);
>  	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
> -	map->type = btrfs_chunk_type(leaf, chunk);
> +	map->type = type;
>  	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
>  	map->verified_stripes = 0;
> -	em->orig_block_len = calc_stripe_length(map->type, em->len,
> +	em->orig_block_len = calc_stripe_length(type, em->len,
>  						map->num_stripes);
>  	for (i = 0; i < num_stripes; i++) {
>  		map->stripes[i].physical =
> -- 
> 2.30.0
