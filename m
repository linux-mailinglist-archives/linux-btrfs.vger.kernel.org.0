Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11A7A0C0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbjINR5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjINR5P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 13:57:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE81FF5;
        Thu, 14 Sep 2023 10:57:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 949772183B;
        Thu, 14 Sep 2023 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694714229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzgmO2bKqcW0F2Qtps8c2xmVQEbiNB6QHQCr0bblrYs=;
        b=dcVd2qmVA4V6KEv3sTh8HbCLfuKV8UqVklLrOyOc8DnnvdkTzFNvbv0OzLX435byROd79Q
        gHEoN0LsR3r+jw0vW5BvhliJR1dT01KgRbicPCvECfyY8hccwB7p7wAo1rZ5PBfMIJPyjG
        xRlRyI+0SpCfDbn4oVZcTeT5cpcsvQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694714229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzgmO2bKqcW0F2Qtps8c2xmVQEbiNB6QHQCr0bblrYs=;
        b=ls3a3o0GSRp+qlkzmijfcKpuB1bfCXkdwWOBuzNNcitC5SZ4fAXqL1g/y1oLRSWc74Lz6p
        ccnzqv1D1LaMuxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A98D13580;
        Thu, 14 Sep 2023 17:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lz9wEXVJA2VwWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Sep 2023 17:57:09 +0000
Date:   Thu, 14 Sep 2023 19:57:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/11] btrfs: lookup physical address from stripe
 extent
Message-ID: <20230914175706.GZ20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-5-15d423829637@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-raid-stripe-tree-v9-5-15d423829637@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 09:07:00AM -0700, Johannes Thumshirn wrote:
> Lookup the physical address from the raid stripe tree when a read on an
> RAID volume formatted with the raid stripe tree was attempted.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 130 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  11 ++++
>  fs/btrfs/volumes.c          |  37 ++++++++++---
>  3 files changed, 169 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 517bc08803f1..697a6e1fd255 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -303,3 +303,133 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
>  
>  	return ret;
>  }
> +
> +int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> +				 u64 logical, u64 *length, u64 map_type,
> +				 u32 stripe_index,
> +				 struct btrfs_io_stripe *stripe)
> +{
> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> +	struct btrfs_stripe_extent *stripe_extent;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_key found_key;
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	const u64 end = logical + *length;
> +	int num_stripes;
> +	u8 encoding;
> +	u64 offset;
> +	u64 found_logical;
> +	u64 found_length;
> +	u64 found_end;
> +	int slot;
> +	int ret;
> +	int i;
> +
> +	stripe_key.objectid = logical;
> +	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset = 0;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
> +	if (ret < 0)
> +		goto free_path;
> +	if (ret) {
> +		if (path->slots[0] != 0)
> +			path->slots[0]--;
> +	}
> +
> +
> +	while (1) {
> +		leaf = path->nodes[0];
> +		slot = path->slots[0];
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +		found_logical = found_key.objectid;
> +		found_length = found_key.offset;
> +		found_end = found_logical + found_length;
> +
> +		if (found_logical > end) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +
> +		if (in_range(logical, found_logical, found_length))
> +			break;
> +
> +		ret = btrfs_next_item(stripe_root, path);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	offset = logical - found_logical;
> +
> +	/*
> +	 * If we have a logically contiguous, but physically noncontinuous
> +	 * range, we need to split the bio. Record the length after which we
> +	 * must split the bio.
> +	 */
> +	if (end > found_end)
> +		*length -= end - found_end;
> +
> +	num_stripes = btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +	stripe_extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
> +	encoding = btrfs_stripe_extent_encoding(leaf, stripe_extent);
> +
> +	if (encoding != btrfs_bg_flags_to_raid_index(map_type)) {
> +		ret = -EUCLEAN;
> +		btrfs_handle_fs_error(fs_info, ret,
> +				      "on-disk stripe encoding %d doesn't match RAID index %d",
> +				      encoding,
> +				      btrfs_bg_flags_to_raid_index(map_type));
> +		goto out;
> +	}
> +
> +	for (i = 0; i < num_stripes; i++) {
> +		struct btrfs_raid_stride *stride = &stripe_extent->strides[i];
> +		u64 devid = btrfs_raid_stride_devid(leaf, stride);
> +		u64 len = btrfs_raid_stride_length(leaf, stride);
> +		u64 physical = btrfs_raid_stride_physical(leaf, stride);
> +
> +		if (offset >= len) {
> +			offset -= len;
> +
> +			if (offset >= BTRFS_STRIPE_LEN)
> +				continue;
> +		}
> +
> +		if (devid != stripe->dev->devid)
> +			continue;
> +
> +		if ((map_type & BTRFS_BLOCK_GROUP_DUP) && stripe_index != i)
> +			continue;
> +
> +		stripe->physical = physical + offset;
> +
> +		ret = 0;
> +		goto free_path;
> +	}
> +
> +	/*
> +	 * If we're here, we haven't found the requested devid in the stripe.
> +	 */
> +	ret = -ENOENT;
> +out:
> +	if (ret > 0)
> +		ret = -ENOENT;
> +	if (ret && ret != -EIO) {
> +		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +			btrfs_print_tree(leaf, 1);
> +		btrfs_err(fs_info,
> +			  "cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
> +			  logical, logical + *length, stripe->dev->devid,
> +			  btrfs_bg_type_to_raid_name(map_type));
> +	}
> +free_path:
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> index b3a127c997c8..5d9629a815c1 100644
> --- a/fs/btrfs/raid-stripe-tree.h
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -13,6 +13,10 @@ struct btrfs_trans_handle;
>  
>  int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
>  			     u64 length);
> +int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> +				 u64 logical, u64 *length, u64 map_type,
> +				 u32 stripe_index,
> +				 struct btrfs_io_stripe *stripe);
>  int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
>  			     struct btrfs_ordered_extent *ordered_extent);
>  
> @@ -33,4 +37,11 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
>  
>  	return false;
>  }
> +
> +static inline int btrfs_num_raid_stripes(u32 item_size)
> +{
> +	return (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
> +		sizeof(struct btrfs_raid_stride);
> +}
> +
>  #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c2bac87912c7..2326dbcf85f6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -35,6 +35,7 @@
>  #include "relocation.h"
>  #include "scrub.h"
>  #include "super.h"
> +#include "raid-stripe-tree.h"
>  
>  #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
>  					 BTRFS_BLOCK_GROUP_RAID10 | \
> @@ -6309,12 +6310,22 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
>  	return U64_MAX;
>  }
>  
> -static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
> -			  u32 stripe_index, u64 stripe_offset, u32 stripe_nr)
> +static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> +		      u64 logical, u64 *length, struct btrfs_io_stripe *dst,
> +		      struct map_lookup *map, u32 stripe_index,
> +		      u64 stripe_offset, u64 stripe_nr)
>  {
>  	dst->dev = map->stripes[stripe_index].dev;
> +
> +	if (op == BTRFS_MAP_READ &&
> +	    btrfs_need_stripe_tree_update(fs_info, map->type))
> +		return btrfs_get_raid_extent_offset(fs_info, logical, length,
> +						    map->type, stripe_index,
> +						    dst);
> +
>  	dst->physical = map->stripes[stripe_index].physical +
>  			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
> +	return 0;
>  }
>  
>  /*
> @@ -6531,11 +6542,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  	 */
>  	if (smap && num_alloc_stripes == 1 &&
>  	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
> -		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
> +		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
> +				    stripe_index, stripe_offset, stripe_nr);

>  		if (mirror_num_ret)
>  			*mirror_num_ret = mirror_num;
>  		*bioc_ret = NULL;
> -		ret = 0;
>  		goto out;
>  	}
>  
> @@ -6566,21 +6577,29 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  		bioc->full_stripe_logical = em->start +
>  			btrfs_stripe_nr_to_offset(stripe_nr * data_stripes);
>  		for (i = 0; i < num_stripes; i++)
> -			set_io_stripe(&bioc->stripes[i], map,
> -				      (i + stripe_nr) % num_stripes,
> -				      stripe_offset, stripe_nr);
> +			ret = set_io_stripe(fs_info, op, logical, length,
> +					    &bioc->stripes[i], map,
> +					    (i + stripe_nr) % num_stripes,
> +					    stripe_offset, stripe_nr);

You've added error value but it's not checked and the whole for-loop
continues, is that intentional?

>  	} else {
>  		/*
>  		 * For all other non-RAID56 profiles, just copy the target
>  		 * stripe into the bioc.
>  		 */
>  		for (i = 0; i < num_stripes; i++) {
> -			set_io_stripe(&bioc->stripes[i], map, stripe_index,
> -				      stripe_offset, stripe_nr);
> +			ret = set_io_stripe(fs_info, op, logical, length,
> +					    &bioc->stripes[i], map, stripe_index,
> +					    stripe_offset, stripe_nr);

Same here.

>  			stripe_index++;
>  		}
>  	}
>  
> +	if (ret) {
> +		*bioc_ret = NULL;
> +		btrfs_put_bioc(bioc);
> +		goto out;
> +	}

This handles ret != 0 but after the whole loop is done.

> +
>  	if (op != BTRFS_MAP_READ)
>  		max_errors = btrfs_chunk_max_errors(map);
>  
> 
> -- 
> 2.41.0
