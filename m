Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A523A4AF56C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 16:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiBIPf4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiBIPfh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 10:35:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713BBC05CB87
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 07:35:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9566130F
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 15:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D45FC340E7;
        Wed,  9 Feb 2022 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644420932;
        bh=x4AcUnfPP2FyiLkAdkCblbnVa79HtXS809HVCCll8c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BayZD0NLx9VrN7/bLM+b9+/1Vx3XS0ZlJv0H0CyflWFdxxQ9u0bJP3nHzoOlVfg2S
         7BomLuV+mBgq9pwZSdtK0joTLz4CDA1J111ksw3BXHWdr0TnWEAcis/JgWtm0hoZai
         GjY7UUBXlGedqKFDUVuwAJT0Ix7gLNX7/PD73MErGGdIVlnskiBkjfQJsflw373QmV
         jvjSyZXhxOBByiCwk7UB+TtV0N6iREabN+W8Z6ZfsDpVepT7VDlJvCMxi//qgVox+1
         JAy9iueU/JrYCZkCpDELCis7RfJUtt25W4qHFMOQzFc0iwv3V2mClDuO0cGbCKnb2C
         UG2x/ZuOHAz6g==
Date:   Wed, 9 Feb 2022 15:35:28 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 1/2] btrfs: defrag: bring back the old file extent
 search behavior
Message-ID: <YgPfQKpcmLPlsAzZ@debian9.Home>
References: <cover.1644301903.git.wqu@suse.com>
 <342f827cc636b27472a7e8c7981eb7ef00a4deb2.1644301903.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342f827cc636b27472a7e8c7981eb7ef00a4deb2.1644301903.git.wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 08, 2022 at 02:36:30PM +0800, Qu Wenruo wrote:
> For defrag, we don't really want to use btrfs_get_extent() to iterate
> all extent maps of an inode.
> 
> The reasons are:
> 
> - btrfs_get_extent() can merge extent maps
>   And the result em has the higher generation of the two, causing defrag
>   to mark unnecessary part of such merged large extent map.
> 
>   This in fact can result extra IO for autodefrag in v5.16+ kernels.
> 
>   However this patch is not going to completely solve the problem, as
>   one can still using read() to trigger extent map reading, and got
>   them merged.
> 
>   The completely solution for the extent map merging generation problem
>   will come as an standalone fix.
> 
> - btrfs_get_extent() caches the extent map result
>   Normally it's fine, but for defrag the target range may not get
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
> - Use btrfs_search_foward() to skip entire ranges which is modified in
>   the past
> 
> This should reduce the IO for autodefrag.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 150 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 146 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0b417d7cefa8..fb4c25e5ff5f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1017,8 +1017,144 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
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
> + *   By using btrfs_search_forward() we can skip entire file ranges that
> + *   have extents created in past transactions, because btrfs_search_forward()
> + *   will not visit leaves and nodes with a generation smaller than given
> + *   minimal generation threshold (@newer_than).
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
> +	struct extent_map *em;
> +	struct btrfs_key key;
> +	u64 ino = btrfs_ino(inode);
> +	int ret;
> +
> +	em = alloc_extent_map();
> +	if (!em) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	key.objectid = ino;
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
> +	}
> +	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);

This isn't safe, because in case an exact key was not found (btrfs_search_slot()
returned 1), path.slots[0] may point to a slot beyond the last item in a leaf.

> +	/* Perfect match, no need to go one slot back */
> +	if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY &&
> +	    key.offset == start)
> +		goto iterate;
> +
> +	/* We didn't find a perfect match, needs to go one slot back */
> +	if (path.slots[0] > 0) {
> +		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
> +			path.slots[0]--;
> +	}
> +
> +iterate:
> +	/* Iterate through the path to find a file extent covering @start */
> +	while (true) {
> +		u64 extent_end;
> +
> +		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
> +			goto next;
> +
> +		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +
> +		/*
> +		 * We may go one slot back to INODE_REF/XATTR item, then
> +		 * need to go forward until we reach an EXTENT_DATA.
> +		 */
> +		if (key.objectid < ino || key.type < BTRFS_EXTENT_DATA_KEY)
> +			goto next;

I would make it:

if (WARN_ON(key.objectid < ino) || key.type < ...)

If we end up at a key with a lower objectid, than something went seriously
wrong somewhere else. In case a key does not exists, btrfs_search_slot() (and
search_forward(), or anything that uses the common binary search), always
leaves us at the first key greater then the one we want or at one slot past
the last item in a leaf (i.e. the location where the key should be at).

So if an inode exists, we should always at least have its inode item, and in
case it has no extent items, btrfs_search_slot() will leave us at the slot where
the key should be at, which can not have an objectid less than 'ino', and should
be the next inode, as we don't key types > BTRFS_EXTENT_DATA_KEY in subvolume
trees associated with inodes.

We do such warning like that at btrfs_drop_extents() for example. It's not a
critical error, as we can safely proceed and then exit and do nothing, but it
helps to signal that something odd (but harmless for this code) happened.

The rest looks fine.
Thanks.

> +
> +		/* It's beyond our target range, definitely not extent found */
> +		if (key.objectid > ino || key.type > BTRFS_EXTENT_DATA_KEY)
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
> @@ -1040,7 +1176,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>  		/* get the big lock and read metadata off disk */
>  		if (!locked)
>  			lock_extent_bits(io_tree, start, end, &cached);
> -		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, sectorsize);
> +		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
>  		if (!locked)
>  			unlock_extent_cached(io_tree, start, end, &cached);
>  
> @@ -1068,7 +1204,12 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  	if (em->start + em->len >= i_size_read(inode))
>  		return ret;
>  
> -	next = defrag_lookup_extent(inode, em->start + em->len, locked);
> +	/*
> +	 * We want to check if the next extent can be merged with the current
> +	 * one, which can be an extent created in a past generation, so we pass
> +	 * a minimum generation of 0 to defrag_lookup_extent().
> +	 */
> +	next = defrag_lookup_extent(inode, em->start + em->len, 0, locked);
>  	/* No more em or hole */
>  	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
>  		goto out;
> @@ -1214,7 +1355,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
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
