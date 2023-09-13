Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FBF79EF5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjIMQuY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 12:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjIMQuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 12:50:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26AB7;
        Wed, 13 Sep 2023 09:50:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A17D1F385;
        Wed, 13 Sep 2023 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694623817;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEDylc6Q+vP4LACrE432bUao8n4Rpm17QzWar3DLHqk=;
        b=tgu7/MgWtkLg8uEyZS4QfEmc+5qs8gYwbxdrQ2sbo8Hp+g325gXG/CG7XeGWC5X80iMTxj
        6ilXtp9gaZ5pieyBac0WFilHtv7bKw+dpoB0GmUwjnqORuZbiDu/TYygN9vk2lbELpykS2
        gM2MoGclgTvEojrsJyMh1iZDAkPvlrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694623817;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEDylc6Q+vP4LACrE432bUao8n4Rpm17QzWar3DLHqk=;
        b=LktuC4K+Ne95kAA1uyJ/R3qXdnh0OZsRgUw5J6Sv5GTatgLYJO1LopA6Gsu6dCGN8cC6rg
        8zHiawxspHFzL4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1C2213582;
        Wed, 13 Sep 2023 16:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9LR7LkjoAWXrKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 16:50:16 +0000
Date:   Wed, 13 Sep 2023 18:50:14 +0200
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
Message-ID: <20230913165014.GQ20408@twin.jikos.cz>
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
> Add support for inserting stripe extents into the raid stripe tree on
> completion of every write that needs an extra logical-to-physical
> translation when using RAID.
> 
> Inserting the stripe extents happens after the data I/O has completed,
> this is done to a) support zone-append and b) rule out the possibility of
> a RAID-write-hole.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/Makefile           |   2 +-
>  fs/btrfs/bio.c              |  23 ++++
>  fs/btrfs/extent-tree.c      |   1 +
>  fs/btrfs/inode.c            |   8 +-
>  fs/btrfs/ordered-data.c     |   1 +
>  fs/btrfs/ordered-data.h     |   2 +
>  fs/btrfs/raid-stripe-tree.c | 266 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  34 ++++++
>  fs/btrfs/volumes.c          |   4 +-
>  fs/btrfs/volumes.h          |  15 ++-
>  10 files changed, 347 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index c57d80729d4f..525af975f61c 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -33,7 +33,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
>  	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
>  	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
> -	   lru_cache.o
> +	   lru_cache.o raid-stripe-tree.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 31ff36990404..ddbe6f8d4ea2 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -14,6 +14,7 @@
>  #include "rcu-string.h"
>  #include "zoned.h"
>  #include "file-item.h"
> +#include "raid-stripe-tree.h"
>  
>  static struct bio_set btrfs_bioset;
>  static struct bio_set btrfs_clone_bioset;
> @@ -415,6 +416,9 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>  	else
>  		bio->bi_status = BLK_STS_OK;
>  
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
>  	btrfs_orig_bbio_end_io(bbio);
>  	btrfs_put_bioc(bioc);
>  }
> @@ -426,6 +430,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>  	if (bio->bi_status) {
>  		atomic_inc(&stripe->bioc->error);
>  		btrfs_log_dev_io_error(bio, stripe->dev);
> +	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>  	}
>  
>  	/* Pass on control to the original bio this one was cloned from */
> @@ -487,6 +493,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
>  	bio->bi_private = &bioc->stripes[dev_nr];
>  	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
>  	bioc->stripes[dev_nr].bioc = bioc;
> +	bioc->size = bio->bi_iter.bi_size;
>  	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
>  }
>  
> @@ -496,6 +503,8 @@ static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
>  	if (!bioc) {
>  		/* Single mirror read/write fast path. */
>  		btrfs_bio(bio)->mirror_num = mirror_num;
> +		if (bio_op(bio) != REQ_OP_READ)
> +			btrfs_bio(bio)->orig_physical = smap->physical;
>  		bio->bi_iter.bi_sector = smap->physical >> SECTOR_SHIFT;
>  		if (bio_op(bio) != REQ_OP_READ)
>  			btrfs_bio(bio)->orig_physical = smap->physical;
> @@ -688,6 +697,20 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  			bio->bi_opf |= REQ_OP_ZONE_APPEND;
>  		}
>  
> +		if (is_data_bbio(bbio) && bioc &&
> +		    btrfs_need_stripe_tree_update(bioc->fs_info,
> +						  bioc->map_type)) {
> +			/*
> +			 * No locking for the list update, as we only add to
> +			 * the list in the I/O submission path, and list
> +			 * iteration only happens in the completion path,
> +			 * which can't happen until after the last submission.
> +			 */
> +			btrfs_get_bioc(bioc);
> +			list_add_tail(&bioc->ordered_entry,
> +				      &bbio->ordered->bioc_list);
> +		}
> +
>  		/*
>  		 * Csum items for reloc roots have already been cloned at this
>  		 * point, so they are handled as part of the no-checksum case.
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 6f6838226fe7..2e11a699ab77 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -42,6 +42,7 @@
>  #include "file-item.h"
>  #include "orphan.h"
>  #include "tree-checker.h"
> +#include "raid-stripe-tree.h"
>  
>  #undef SCRAMBLE_DELAYED_REFS
>  
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index bafca05940d7..6f71630248da 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -71,6 +71,7 @@
>  #include "super.h"
>  #include "orphan.h"
>  #include "backref.h"
> +#include "raid-stripe-tree.h"
>  
>  struct btrfs_iget_args {
>  	u64 ino;
> @@ -3091,6 +3092,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
>  
>  	trans->block_rsv = &inode->block_rsv;
>  
> +	ret = btrfs_insert_raid_extent(trans, ordered_extent);
> +	if (ret)
> +		goto out;
> +
>  	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
>  		compress_type = ordered_extent->compress_type;
>  	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
> @@ -3224,7 +3229,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
>  int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
>  {
>  	if (btrfs_is_zoned(btrfs_sb(ordered->inode->i_sb)) &&
> -	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
> +	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags) &&
> +	    list_empty(&ordered->bioc_list))
>  		btrfs_finish_ordered_zoned(ordered);
>  	return btrfs_finish_one_ordered(ordered);
>  }
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 345c449d588c..55c7d5543265 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -191,6 +191,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
>  	INIT_LIST_HEAD(&entry->log_list);
>  	INIT_LIST_HEAD(&entry->root_extent_list);
>  	INIT_LIST_HEAD(&entry->work_list);
> +	INIT_LIST_HEAD(&entry->bioc_list);
>  	init_completion(&entry->completion);
>  
>  	/*
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 173bd5c5df26..1c51ac57e5df 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -151,6 +151,8 @@ struct btrfs_ordered_extent {
>  	struct completion completion;
>  	struct btrfs_work flush_work;
>  	struct list_head work_list;
> +
> +	struct list_head bioc_list;
>  };
>  
>  static inline void
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> new file mode 100644
> index 000000000000..2415698a8fef
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/btrfs_tree.h>
> +
> +#include "ctree.h"
> +#include "fs.h"
> +#include "accessors.h"
> +#include "transaction.h"
> +#include "disk-io.h"
> +#include "raid-stripe-tree.h"
> +#include "volumes.h"
> +#include "misc.h"
> +#include "print-tree.h"
> +
> +static u8 btrfs_bg_type_to_raid_encoding(u64 map_type)
> +{
> +	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +	case BTRFS_BLOCK_GROUP_DUP:
> +		return BTRFS_STRIPE_DUP;
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +		return BTRFS_STRIPE_RAID0;
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +		return BTRFS_STRIPE_RAID1;
> +	case BTRFS_BLOCK_GROUP_RAID1C3:
> +		return BTRFS_STRIPE_RAID1C3;
> +	case BTRFS_BLOCK_GROUP_RAID1C4:
> +		return BTRFS_STRIPE_RAID1C4;
> +	case BTRFS_BLOCK_GROUP_RAID5:
> +		return BTRFS_STRIPE_RAID5;
> +	case BTRFS_BLOCK_GROUP_RAID6:
> +		return BTRFS_STRIPE_RAID6;
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +		return BTRFS_STRIPE_RAID10;
> +	default:
> +		ASSERT(0);
> +	}
> +}
> +
> +static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
> +				 int num_stripes,
> +				 struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
> +	u8 encoding = btrfs_bg_type_to_raid_encoding(bioc->map_type);
> +	struct btrfs_stripe_extent *stripe_extent;
> +	size_t item_size;
> +	int ret;
> +
> +	item_size = struct_size(stripe_extent, strides, num_stripes);
> +
> +	stripe_extent = kzalloc(item_size, GFP_NOFS);
> +	if (!stripe_extent) {
> +		btrfs_abort_transaction(trans, -ENOMEM);
> +		btrfs_end_transaction(trans);
> +		return -ENOMEM;
> +	}
> +
> +	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
> +	for (int i = 0; i < num_stripes; i++) {
> +		u64 devid = bioc->stripes[i].dev->devid;
> +		u64 physical = bioc->stripes[i].physical;
> +		u64 length = bioc->stripes[i].length;
> +		struct btrfs_raid_stride *raid_stride =
> +						&stripe_extent->strides[i];
> +
> +		if (length == 0)
> +			length = bioc->size;
> +
> +		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
> +		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
> +		btrfs_set_stack_raid_stride_length(raid_stride, length);
> +	}
> +
> +	stripe_key.objectid = bioc->logical;
> +	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset = bioc->size;
> +
> +	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
> +				item_size);
> +	if (ret)
> +		btrfs_abort_transaction(trans, ret);
> +
> +	kfree(stripe_extent);
> +
> +	return ret;
> +}
> +
> +static int btrfs_insert_mirrored_raid_extents(struct btrfs_trans_handle *trans,
> +				      struct btrfs_ordered_extent *ordered,
> +				      u64 map_type)
> +{
> +	int num_stripes = btrfs_bg_type_to_factor(map_type);
> +	struct btrfs_io_context *bioc;
> +	int ret;
> +
> +	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
> +		ret = btrfs_insert_one_raid_extent(trans, num_stripes, bioc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
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

This could use the table based mirroring factor, right? Though we have
only raid10 and not the other C3 and C4 it's better to avoid the
hard coded constants.
