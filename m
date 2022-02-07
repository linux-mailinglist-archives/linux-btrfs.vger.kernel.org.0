Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02AC4ABF0E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiBGM5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 07:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446785AbiBGMnz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 07:43:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED1C0401C6
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 04:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A3F8B8121B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 12:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EA7C004E1;
        Mon,  7 Feb 2022 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644237788;
        bh=3tTcF3s4XVuomr4Om2bG5dm7KKAsyoiIJgQEhdprAdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrZPXLaj6S4fv7e0v7tGkWzTRgasPbblMishLs9JHq3Qt+ENGmLm5jsUe2538t//8
         xYd4llkqniURoP+zNIcAWMYoxV+bESJhn4Y5hGiHl6vdSOZrFR9KUL2FePnQtF0UVz
         F7K43YR+e7SgeOhdM93Qrz9Z4s0bYSCaKS8bckwt5+FEPceOmJ3hYEfeyTMDh1Ur0d
         OA0yW68oKdY8y3sDTlwm5RABxS6+hVqvk9A1v29uQ7JD3wN/Y/7krBy396QktBpSQL
         ZyqXAZI+XXNRrLtPYR0fSNtgx/KguZmvLXhXNhiYIqZUVaRLJDEpMwiyOMJJU0SceO
         LLBvE5skn7uVw==
Date:   Mon, 7 Feb 2022 12:43:05 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: defrag: bring back the old file extent search
 behavior
Message-ID: <YgET2UAZmjf+haFJ@debian9.Home>
References: <8cc7928a2097f4d06833c960a33bb5ef0a419337.1644051421.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc7928a2097f4d06833c960a33bb5ef0a419337.1644051421.git.wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 05, 2022 at 05:38:45PM +0800, Qu Wenruo wrote:
> For defrag, we don't really want to use btrfs_get_extent() to iterate
> all extent maps of an inode.
> 
> The reasons are:
> 
> - btrfs_get_extent() can merge extent maps
>   And the result em has the higher generation of the two, causing defrag
>   to mark unnecessary part of such merged large extent map.
> 
>   This in fact results extra IO for autodefrag in v5.16+ kernels.
> 
> - btrfs_get_extent() caches the extent map result
>   Normally it's fine, but for defrag the target inode may not get

target inode -> target range

>   another read/write for a long long time.
>   Such cache would only increase the memory usage.
> 
> - btrfs_get_extent() doesn't skip older extent map
>   Unlike the old find_new_extent() which uses btrfs_search_forward() to
>   skip the older subtree, thus it will pick up unnecessary extent maps.
> 
> This patch will fix the regression by introducing defrag_get_extent() to
> replace the btrfs_get_extent() call.
> 
> This helper will:
> 
> - Not cache the file extent we found
>   It will search the file extent and manually convert it to em.
> 
> - Use btrfs_search_foward() to skip older extents
> 
> This should reduce the IO for autodefrag.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 134 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 130 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0b417d7cefa8..133e3e2e2e79 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1017,8 +1017,128 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
>  	return ret;
>  }
>  
> +/*
> + * Defrag specific helper to get an extent map.
> + *
> + * Differences between this and btrfs_get_extent() are:
> + * - No extent_map will be added to inode->extent_tree
> + *   To reduce memory usage in the long run.
> + *
> + * - Extra optimization to skip file extents older than @newer_than
> + *   By using btrfs_search_forward() we can skip any older tree blocks
> + *   which doesn't meet @newer_than requirement.

"older tree blocks" is not very clear, or what's their relation with
file extents. It should say we can skip entire file ranges that have
extents created in past transactions, because btrfs_search_forward()
will not visit leaves and nodes with a generation smaller than a given
minimum generation treshold (@newer_than).

> + *
> + * Return valid em if we find a file extent matching the requirement.
> + * Return NULL if we can not find a file extent matching the requirement.
> + *
> + * Return ERR_PTR() for error.
> + */
> +static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
> +					    u64 start, u64 newer_than)
> +{
> +	struct btrfs_root *root = inode->root;
> +	struct btrfs_file_extent_item *fi;
> +	struct btrfs_path path = {};
> +	struct extent_map *em = NULL;

There's no need to initialize 'em' here. We do it right below.

> +	struct btrfs_key key;
> +	int ret;
> +
> +	em = alloc_extent_map();
> +	if (!em) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	key.objectid = btrfs_ino(inode);
> +	key.type = BTRFS_EXTENT_DATA_KEY;
> +	key.offset = start;
> +
> +	if (newer_than) {
> +		ret = btrfs_search_forward(root, &key, &path, newer_than);
> +		if (ret < 0)
> +			goto err;
> +		/* Can't find anything newer */
> +		if (ret > 0)
> +			goto not_found;
> +	} else {
> +		ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +		if (ret < 0)
> +			goto err;
> +		/* No direct hit, needs to go one slot back */
> +		if (ret > 0) {
> +			/* */
> +			if (btrfs_header_nritems(path.nodes[0]) == 0)
> +				goto not_found;
> +			path.slots[0]--;
> +		}
> +	}

How can nritems of the leaf be 0?

Also, we can't just decrement path.slots[0] without any checks:

1) In case it's 0, it underflows;

2) You might skip an extent. Lets say 'start' is 0 and this leaves
   at a slot with the first extent of the file, that starts at 4K
   for example, meaning there's an implicit hole (NO_HOLES is used)
   for the file range 0 to 4K. So this unconditional decrement leaves
   at the slot with the inode ref item (or a xattr item for e.g.), so
   this will make us skip the first extent, as right below in the while
   loop we jump into "not_found" in case the key type is not
   BTRFS_EXTENT_DATA_KEY.

   I.e. we want something like what we do at btrfs_drop_extents()
   for example:

	if (ret > 0 && path->slots[0] > 0) {
		leaf = path->nodes[0];
		btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
		if (key.objectid == ino &&
		    key.type == BTRFS_EXTENT_DATA_KEY)
			path->slots[0]--;
	}

This logic to decrement path->slots[0] should also be done in the
case of btrfs_search_forward(), because it might have left us at a
slot pointing to an extent that starts beyond our start offset, due
to an implicit hole.

> +
> +	/* Iterate through the path to find a file extent covering @start */
> +	while (true) {
> +		u64 extent_end;
> +
> +		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
> +			goto next;
> +
> +		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +		if (key.objectid != btrfs_ino(inode))
> +			goto not_found;
> +		if (key.type != BTRFS_EXTENT_DATA_KEY)
> +			goto not_found;
> +
> +		/*
> +		 *	|	|<- File extent ->|
> +		 *	\- start
> +		 *
> +		 * This means there is a hole between start and key.offset.
> +		 */
> +		if (key.offset > start) {
> +			em->start = start;
> +			em->orig_start = start;
> +			em->block_start = EXTENT_MAP_HOLE;
> +			em->len = key.offset - start;
> +			break;
> +		}
> +
> +		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
> +				    struct btrfs_file_extent_item);
> +		extent_end = btrfs_file_extent_end(&path);
> +
> +		/*
> +		 *	|<- file extent ->|	|
> +		 *				\- start
> +		 *
> +		 * We haven't reach start, search next slot.
> +		 */
> +		if (extent_end <= start)
> +			goto next;
> +
> +		/* Now this extent covers @start, convert it to em */
> +		btrfs_extent_item_to_extent_map(inode, &path, fi, false, em);
> +		break;
> +next:
> +		ret = btrfs_next_item(root, &path);
> +		if (ret < 0)
> +			goto err;
> +		if (ret > 0)
> +			goto not_found;
> +	}
> +	btrfs_release_path(&path);
> +	return em;
> +
> +not_found:
> +	btrfs_release_path(&path);
> +	free_extent_map(em);
> +	return NULL;
> +
> +err:
> +	btrfs_release_path(&path);
> +	free_extent_map(em);
> +	return ERR_PTR(ret);
> +}
> +
>  static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
> -					       bool locked)
> +					       u64 newer_than, bool locked)
>  {
>  	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
>  	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> @@ -1040,7 +1160,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>  		/* get the big lock and read metadata off disk */
>  		if (!locked)
>  			lock_extent_bits(io_tree, start, end, &cached);
> -		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, sectorsize);
> +		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
>  		if (!locked)
>  			unlock_extent_cached(io_tree, start, end, &cached);
>  
> @@ -1068,7 +1188,12 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  	if (em->start + em->len >= i_size_read(inode))
>  		return ret;
>  
> -	next = defrag_lookup_extent(inode, em->start + em->len, locked);
> +	/*
> +	 * We may have a single range written and it can only be merged with
> +	 * older extents, thus here we pass 0 as @newer_than to get all mergeable
> +	 * extent for it.

Sounds confusing to me.

Maybe:

We want to check if the next extent can be merged with the current one, which
can be an extent created in a past generation, so we pass a minimum generation
of 0 to defrag_lookup_extent().

Thanks for doing this.

> +	 */
> +	next = defrag_lookup_extent(inode, em->start + em->len, 0, locked);
>  	/* No more em or hole */
>  	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
>  		goto out;
> @@ -1214,7 +1339,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		u64 range_len;
>  
>  		last_is_target = false;
> -		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
> +		em = defrag_lookup_extent(&inode->vfs_inode, cur,
> +					  ctrl->newer_than, locked);
>  		if (!em)
>  			break;
>  
> -- 
> 2.35.0
> 
