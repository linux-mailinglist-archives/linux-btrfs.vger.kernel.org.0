Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83379EF77
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjIMQ5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjIMQ5Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 12:57:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C0F1BE2;
        Wed, 13 Sep 2023 09:57:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70ADA1F383;
        Wed, 13 Sep 2023 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694624230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCUJIvSAdfq2/FYSl4AeA+MvtXsJkXBjw1qDBWVvC0E=;
        b=m6FXeNKU0el+A4CbL0q8LJTrgsL7x+VelfnZkvubqyUiLjE+KxxdqeFkWdbaC2xEmiVSYU
        2NHQD67GwQUoyp7dfSwKarlRreEQJXA2FTW1lv9Q6jS2sBfC+bc9iqFrPF3SFfB8esN+lV
        DqtFSHHcquBnvuxJ3VBWvZJDcLFMNS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694624230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCUJIvSAdfq2/FYSl4AeA+MvtXsJkXBjw1qDBWVvC0E=;
        b=rPMdukcVliWd+qcxQ32gbOPFHBjD+oQDtdcG7rRVo3P55r2q1vG1R67WmHy4s6WHac8YfB
        hFfG6uigNlw1udBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A3BB13582;
        Wed, 13 Sep 2023 16:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4F+gBebpAWUxLAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 16:57:10 +0000
Date:   Wed, 13 Sep 2023 18:57:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/11] btrfs: add support for inserting raid stripe
 extents
Message-ID: <20230913165708.GR20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 05:52:04AM -0700, Johannes Thumshirn wrote:
> +static int btrfs_insert_striped_mirrored_raid_extents(
> +				      struct btrfs_trans_handle *trans,
> +				      struct btrfs_ordered_extent *ordered,
> +				      u64 map_type)
> +{
> +	struct btrfs_io_context *bioc;
> +	struct btrfs_io_context *rbioc;
> +	const int nstripes = list_count_nodes(&ordered->bioc_list);
> +	const int index = btrfs_bg_flags_to_raid_index(map_type);
> +	const int substripes = btrfs_raid_array[index].sub_stripes;
> +	const int max_stripes = trans->fs_info->fs_devices->rw_devices / 2;
> +	int left = nstripes;
> +	int stripe = 0, j = 0;
> +	int i = 0;

Please move the initialization right before the block that uses the
variables.

> +	int ret = 0;
> +	u64 stripe_end;
> +	u64 prev_end;
> +
> +	if (nstripes == 1)
> +		return btrfs_insert_mirrored_raid_extents(trans, ordered, map_type);
> +
> +	rbioc = kzalloc(struct_size(rbioc, stripes, nstripes * substripes),
> +			GFP_KERNEL);
> +	if (!rbioc)
> +		return -ENOMEM;
> +
> +	rbioc->map_type = map_type;
> +	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
> +					   ordered_entry)->logical;
> +
> +	stripe_end = rbioc->logical;
> +	prev_end = stripe_end;

Like here, initializing i

> +	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
> +
> +		rbioc->size += bioc->size;
> +		for (j = 0; j < substripes; j++) {

And if you don't use 'j' outside of the for cycle you can use the
delcarations inside the for (...).

> +			stripe = i + j;
> +			rbioc->stripes[stripe].dev = bioc->stripes[j].dev;
> +			rbioc->stripes[stripe].physical = bioc->stripes[j].physical;
> +			rbioc->stripes[stripe].length = bioc->size;
> +		}
> +
> +		stripe_end += rbioc->size;
> +		if (i >= nstripes ||
> +		    (stripe_end - prev_end >= max_stripes * BTRFS_STRIPE_LEN)) {
> +			ret = btrfs_insert_one_raid_extent(trans,
> +							   nstripes * substripes,
> +							   rbioc);
> +			if (ret)
> +				goto out;
> +
> +			left -= nstripes;
> +			i = 0;
> +			rbioc->logical += rbioc->size;
> +			rbioc->size = 0;
> +		} else {
> +			i += substripes;
> +			prev_end = stripe_end;
> +		}
> +	}
> +
> +	if (left) {
> +		bioc = list_prev_entry(bioc, ordered_entry);
> +		ret = btrfs_insert_one_raid_extent(trans, substripes, bioc);
> +	}
> +
> +out:
> +	kfree(rbioc);
> +	return ret;
> +}
> +
> +static int btrfs_insert_striped_raid_extents(struct btrfs_trans_handle *trans,
> +				     struct btrfs_ordered_extent *ordered,
> +				     u64 map_type)
> +{
> +	struct btrfs_io_context *bioc;
> +	struct btrfs_io_context *rbioc;
> +	const int nstripes = list_count_nodes(&ordered->bioc_list);
> +	int i = 0;
> +	int ret = 0;
> +
> +	rbioc = kzalloc(struct_size(rbioc, stripes, nstripes), GFP_KERNEL);

You can't use GFP_KERNEL generally in any function that takes a
transaction handle parameter. Either GFP_NOFS or with the
memalloc_nofs_* protection.

> +	if (!rbioc)
> +		return -ENOMEM;
> +	rbioc->map_type = map_type;
> +	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
> +					   ordered_entry)->logical;
> +

Maybe initializing 'i' here would be better so it's consistent with
other code.

> +	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
> +		rbioc->size += bioc->size;
> +		rbioc->stripes[i].dev = bioc->stripes[0].dev;
> +		rbioc->stripes[i].physical = bioc->stripes[0].physical;
> +		rbioc->stripes[i].length = bioc->size;
> +
> +		if (i == nstripes - 1) {
> +			ret = btrfs_insert_one_raid_extent(trans, nstripes, rbioc);
> +			if (ret)
> +				goto out;
> +
> +			i = 0;
> +			rbioc->logical += rbioc->size;
> +			rbioc->size = 0;
> +		} else {
> +			i++;
> +		}
> +	}
> +
> +	if (i && i < nstripes - 1)
> +		ret = btrfs_insert_one_raid_extent(trans, i, rbioc);
> +
> +out:
> +	kfree(rbioc);
> +	return ret;
> +}
> +
> +int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> +			     struct btrfs_ordered_extent *ordered_extent)
> +{
> +	struct btrfs_io_context *bioc;
> +	u64 map_type;
> +	int ret;
> +
> +	if (!trans->fs_info->stripe_root)
> +		return 0;
> +
> +	map_type = list_first_entry(&ordered_extent->bioc_list, typeof(*bioc),
> +				    ordered_entry)->map_type;
> +
> +	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +	case BTRFS_BLOCK_GROUP_DUP:
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +	case BTRFS_BLOCK_GROUP_RAID1C3:
> +	case BTRFS_BLOCK_GROUP_RAID1C4:
> +		ret = btrfs_insert_mirrored_raid_extents(trans, ordered_extent,
> +							 map_type);
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +		ret = btrfs_insert_striped_raid_extents(trans, ordered_extent,
> +							map_type);
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +		ret = btrfs_insert_striped_mirrored_raid_extents(trans, ordered_extent, map_type);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	while (!list_empty(&ordered_extent->bioc_list)) {
> +		bioc = list_first_entry(&ordered_extent->bioc_list,
> +					typeof(*bioc), ordered_entry);
> +		list_del(&bioc->ordered_entry);
> +		btrfs_put_bioc(bioc);
> +	}
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> new file mode 100644
> index 000000000000..f36e4c2d46b0
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef BTRFS_RAID_STRIPE_TREE_H
> +#define BTRFS_RAID_STRIPE_TREE_H
> +
> +#include "disk-io.h"
> +
> +struct btrfs_io_context;
> +struct btrfs_io_stripe;

Please add more forward declarations, btrfs_trans_handle,
btrfs_ordered_extent or fs_info.

> +
> +int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> +			     struct btrfs_ordered_extent *ordered_extent);
> +
> +static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
> +						 u64 map_type)
> +{
> +	u64 type = map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
> +	u64 profile = map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
> +
> +	if (!btrfs_stripe_tree_root(fs_info))
> +		return false;
> +
> +	if (type != BTRFS_BLOCK_GROUP_DATA)
> +		return false;
> +
> +	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
> +		return true;
> +
> +	return false;
> +}
> +#endif
