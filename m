Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5355E6064A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJTPeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJTPeS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:34:18 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2148E1B4C41
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:34:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s17so97478qkj.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+6w/3NyrFIKs/m99suBscNvlTNAXnIf8qfA7M7LUqI=;
        b=HEPEaAmD/+FUUtGi6JW0OG7/U8x9sZAXuQJ3u9pOL6PNYMrLsbvxZiYOThWa78QNMc
         6XNrV+E3tHF0ApBKGa/rnJouP4fCPVK5oAbzURJJkPg6yqMxsrnO6cpzynVRowBbd6pc
         8WFuvOm6mxn+RgC9dq1Bs4rb9KXr+hIqWKaeH36aD4J7V6NAzGOUwvjx1E9KxNX/7u5W
         sb5ZBRPpSuLrekbcJ/DlmYavyMpwyd4Tz0hgnVbWPFW+r+06NRy3AWsqAcoSEjN1ebyh
         EgReiVxHnNI1lXly0Xng89UekZOkdOSU2LxqEgCasGVCKChsFBVxVqz0h539wGajxmQN
         Cmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+6w/3NyrFIKs/m99suBscNvlTNAXnIf8qfA7M7LUqI=;
        b=LFPAYwaBwC7E1ItN/8i0bPYyTcu+P6nrzLy/0DHaP1vvS401nLDmBUPZCaD3wMfinc
         MfI9jJvOn9P5S/J7fb0pAAwRyCx3hPYeA/i2MD0tgSn42rKJD6Ku/Y9xc3uLo+UFcdTt
         8IFnu3RVqdq+ROM3e+v1Elt4/qgl/cs7E0ZLmlZwLnV/irYrCbSICeiVi3TkoaUIevp2
         jP/gIbawn6QKe+rvDcCxo4L/pkWxFTBuY2T6c4E+VDR3Vee2GdG+h+5gVbeQm3xAxqtc
         rBwmRWdUBRFfaPGZqG6jeozUhAf3HDTd9R3iqTPpzFgV6oQLsO9hMmX4V7X6guSCTchF
         UaZg==
X-Gm-Message-State: ACrzQf2zK1lIRl2BntJyZWXeZf+nU+l8HZY9rsemE9Bkd2QsRdjPtJsf
        1dBIC0D0oT4tFbgow/YMloUpCIkCDidYlA==
X-Google-Smtp-Source: AMsMyM60ir6U+A5/vKFThlDBkdlqEbWoFs+O/ABvoQ84DcBANWWaOlb4gQh3nxaqR1daiKDMdyTJLw==
X-Received: by 2002:a37:58d:0:b0:6eb:4148:bed2 with SMTP id 135-20020a37058d000000b006eb4148bed2mr9954075qkf.284.1666280055778;
        Thu, 20 Oct 2022 08:34:15 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bs7-20020ac86f07000000b003998bb7b83asm6282796qtb.90.2022.10.20.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:34:15 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:34:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 05/11] btrfs: lookup physical address from stripe extent
Message-ID: <Y1FqdvFiC2V3FwCa@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <85853887c5f50188e32f879be823c690c33af9d3.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85853887c5f50188e32f879be823c690c33af9d3.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:23AM -0700, Johannes Thumshirn wrote:
> Lookup the physical address from the raid stripe tree when a read on an
> RAID volume formatted with the raid stripe tree was attempted.
> 
> If the requested logical address was not found in the stripe tree, it may
> still be in the in-memory ordered stripe tree, so fallback to searching
> the ordered stripe tree in this case.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 142 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |   3 +
>  fs/btrfs/volumes.c          |  30 ++++++--
>  3 files changed, 168 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 5750857c2a75..91e67600e01a 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -218,3 +218,145 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
>  
>  	return ret;
>  }
> +
> +static bool btrfs_physical_from_ordered_stripe(struct btrfs_fs_info *fs_info,
> +					      u64 logical, u64 *length,
> +					      int num_stripes,
> +					      struct btrfs_io_stripe *stripe)
> +{
> +	struct btrfs_ordered_stripe *os;
> +	u64 offset;
> +	u64 found_end;
> +	u64 end;
> +	int i;
> +
> +	os = btrfs_lookup_ordered_stripe(fs_info, logical);
> +	if (!os)
> +		return false;
> +
> +	end = logical + *length;
> +	found_end = os->logical + os->num_bytes;
> +	if (end > found_end)
> +		*length -= end - found_end;
> +
> +	for (i = 0; i < num_stripes; i++) {
> +		if (os->stripes[i].dev != stripe->dev)
> +			continue;
> +
> +		offset = logical - os->logical;
> +		ASSERT(offset >= 0);
> +		stripe->physical = os->stripes[i].physical + offset;
> +		btrfs_put_ordered_stripe(fs_info, os);
> +		break;
> +	}
> +
> +	return true;
> +}
> +
> +int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> +				 u64 logical, u64 *length, u64 map_type,
> +				 struct btrfs_io_stripe *stripe)
> +{
> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> +	int num_stripes = btrfs_bg_type_to_factor(map_type);
> +	struct btrfs_dp_stripe *raid_stripe;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_key found_key;
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	u64 offset;
> +	u64 found_logical;
> +	u64 found_length;
> +	u64 end;
> +	u64 found_end;
> +	int slot;
> +	int ret;
> +	int i;
> +
> +	/*
> +	 * If we still have the stripe in the ordered stripe tree get it from
> +	 * there
> +	 */
> +	if (btrfs_physical_from_ordered_stripe(fs_info, logical, length,
> +					       num_stripes, stripe))
> +		return 0;
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
> +		goto out;
> +	if (ret) {
> +		if (path->slots[0] != 0)
> +			path->slots[0]--;
> +	}
> +
> +	end = logical + *length;
> +
> +	while (1) {
> +		leaf = path->nodes[0];
> +		slot = path->slots[0];
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +		found_logical = found_key.objectid;
> +		found_length = found_key.offset;
> +

Don't we have fancy new iterators for walking through the btree?  Can that be
used here instead of this old style walk through?

> +		if (found_logical > end)
> +			break;
> +
> +		if (!in_range(logical, found_logical, found_length))
> +			goto next;
> +
> +		offset = logical - found_logical;
> +		found_end = found_logical + found_length;
> +
> +		/*
> +		 * If we have a logically contiguous, but physically
> +		 * noncontinuous range, we need to split the bio. Record the
> +		 * length after which we must split the bio.
> +		 */
> +		if (end > found_end)
> +			*length -= end - found_end;
> +
> +		raid_stripe = btrfs_item_ptr(leaf, slot, struct btrfs_dp_stripe);
> +		for (i = 0; i < num_stripes; i++) {
> +			if (btrfs_stripe_extent_devid_nr(leaf, raid_stripe, i) != 
> +			    stripe->dev->devid)
> +				continue;
> +			stripe->physical = btrfs_stripe_extent_physical_nr(leaf,
> +						   raid_stripe, i) + offset;
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		/*
> +		 * If we're here, we haven't found the requested devid in the
> +		 * stripe.
> +		 */
> +		ret = -ENOENT;
> +		goto out;
> +next:
> +		ret = btrfs_next_item(stripe_root, path);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	if (ret > 0)
> +		ret = -ENOENT;
> +	if (ret) {

Maybe instead

if (ret && ret != -EIO)

I have a lot of boxes, and a given percentage of them have bad disks, which ends
up with a lot of btrfs_print_tree()'s that I don't need.

> +		btrfs_err(fs_info,
> +			  "cannot find raid-stripe for logical [%llu, %llu]",
> +			  logical, logical + *length);
> +		btrfs_print_tree(leaf, 1);
> +	}
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> index 3456251d0739..083e754f5239 100644
> --- a/fs/btrfs/raid-stripe-tree.h
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -16,6 +16,9 @@ struct btrfs_ordered_stripe {
>  	refcount_t ref;
>  };
>  
> +int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> +				 u64 logical, u64 *length, u64 map_type,
> +				 struct btrfs_io_stripe *stripe);
>  int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
>  			     u64 length);
>  int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 261bf6dd17bc..c67d76d93982 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6313,12 +6313,21 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
>  	return U64_MAX;
>  }
>  
> -static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
> -		          u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
> +static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> +		      u64 logical, u64 *length, struct btrfs_io_stripe *dst,
> +		      struct map_lookup *map, u32 stripe_index,
> +		      u64 stripe_offset, u64 stripe_nr)
>  {
>  	dst->dev = map->stripes[stripe_index].dev;
> +
> +	if (fs_info->stripe_root && op == BTRFS_MAP_READ &&
> +	    btrfs_need_stripe_tree_update(fs_info, map->type))

We already check if (fs_info->stripe_root) in here, so this can be simplified to

if (op == BTRFS_MAP_READ && btrfs_need_stripe_tree_update())

Thanks,

Josef
