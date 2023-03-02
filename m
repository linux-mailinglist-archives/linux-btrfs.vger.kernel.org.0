Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217566A808A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 11:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCBK7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 05:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBK64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 05:58:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50D22003
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 02:58:48 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1pn96u0E48-00FSIe; Thu, 02
 Mar 2023 11:58:40 +0100
Message-ID: <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
Date:   Thu, 2 Mar 2023 18:58:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
In-Reply-To: <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2/j1+WECQVnfE6eh9JoZ3hekrVTtnitXu8y/02PldrhyOrT0pzh
 jR1xX/QfZbLv4JJH7vVwYD8fUzviZpIjdr+y8OQskFYOEoSRTIIN6pKf0+yhR8ZWtUpd3+4
 6/HeaZd4t9BejNXmGT1Nm8gWVbL8+9mJFhygt3MTJYIxhD7ChUE2Ycjj/3VKpuSVkraaC6h
 KBFITXcwjN5N0fZI9Iqyw==
UI-OutboundReport: notjunk:1;M01:P0:aD14U6Hr270=;nk+nchwtiWol+f+8XH/ew4rYCMS
 6qjwW27NOGu0hYf2TmJBZu2RIcgYH/dkjkVbE+WoTyfRHGpxGQY4mJQnQMirCsP+G8KeYYxbG
 0nVoohZH/HRtP2My3MM5K6XRFE3V3Wd9L3QitNP10ZrlLjdOeK+OZM2Gl5ffH1pkAxz1cULb/
 Yqzhtx0mZvINlSZJIkF1iYTx1yTzVC3FWJ2TqpUtHN1zEOaTr1gz1KmyBUfs8OZy7dF+SJLhz
 j/Z9z4GVtRuY89ftbNszvYb3dclsEssom/Luft+4Y972mANaCWWTq7IUqNGYfkNshcMATQcua
 TfriKVMtlOaM74x0o9b0DQNV1JKhuy5RwFc/vRVIBczds7JFIB27UQwIoRU2S08Ze6YuAAb7/
 dGjg7G5Xk3hiiaIIM/W+/oG5hYoTADLkUKfwbRU9vJHFcPK8fsDgvzGSbgmKkzIBAmEZ4BHsJ
 ZZcq/W1jMFus97fqeLn2vqaPmYFNdzYEJYd74fmW5YWiP4kF9+gcZQOlVc1pXWmzBaiDAzaNd
 BpZzgltHo7f9WHejs7c4hYmTw3pnw9eI/l8yvaARN8mkJSyCyMrRxbPX9fmmrutuqKka3h26B
 g4KFzpITZ3+6bGQ9RAvcEMqQBnukTmApMJX5FdCjzsSI3l/co5LHRzpfYPE6acjSsifQ6qqbs
 z5d649Tiv9+L0IGQp9IIwOIL2wZLn9rvO8l/byej82IpqL9Ckqd/hg/7ksdTfgfui1tGtSG4d
 OxLsu++qUsFUNnCNgqKevZngn96I7z/Al+vA38r3yHV5WFwB+n1tKdiLSl/9mrIruaBIoEuhC
 lxtQOEPAlr1InNOn/QFHEGTu06FYMFR3UgFwSASWm1m1/gcGRQpXCpkntMa0wloQV1zS4g/H1
 jTSxKz0g+w55OyzNPFHMtRmqjr4kmQCacGOIdpu92wmpiLWr6XiOIemvveVdu5CG4TrkAub7M
 9fKUL8O9QqU/MWYS4LcwufkZGMw=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/2 17:45, Johannes Thumshirn wrote:
> Add support for inserting stripe extents into the raid stripe tree on
> completion of every write that needs an extra logical-to-physical
> translation when using RAID.
> 
> Inserting the stripe extents happens after the data I/O has completed,
> this is done to a) support zone-append and b) rule out the possibility of
> a RAID-write-hole.
> 
> This is done by creating in-memory ordered stripe extents, just like the
> in memory ordered extents, on I/O completion and the on-disk raid stripe
> extents get created once we're running the delayed_refs for the extent
> item this stripe extent is tied to.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/Makefile           |   2 +-
>   fs/btrfs/bio.c              |  29 +++++
>   fs/btrfs/delayed-ref.c      |   6 +-
>   fs/btrfs/delayed-ref.h      |   2 +
>   fs/btrfs/extent-tree.c      |  60 +++++++++++
>   fs/btrfs/inode.c            |  15 ++-
>   fs/btrfs/raid-stripe-tree.c | 204 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h |  71 +++++++++++++
>   fs/btrfs/volumes.c          |   4 +-
>   fs/btrfs/volumes.h          |  13 +--
>   fs/btrfs/zoned.c            |   3 +
>   11 files changed, 397 insertions(+), 12 deletions(-)
>   create mode 100644 fs/btrfs/raid-stripe-tree.c
>   create mode 100644 fs/btrfs/raid-stripe-tree.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 90d53209755b..3bb869a84e54 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -33,7 +33,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>   	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
>   	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
>   	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
> -	   lru_cache.o
> +	   lru_cache.o raid-stripe-tree.o
>   
>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>   btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 726592868e9c..2b174865d347 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -15,6 +15,7 @@
>   #include "rcu-string.h"
>   #include "zoned.h"
>   #include "file-item.h"
> +#include "raid-stripe-tree.h"
>   
>   static struct bio_set btrfs_bioset;
>   static struct bio_set btrfs_clone_bioset;
> @@ -348,6 +349,21 @@ static void btrfs_raid56_end_io(struct bio *bio)
>   	btrfs_put_bioc(bioc);
>   }
>   
> +static void btrfs_raid_stripe_update(struct work_struct *work)
> +{
> +	struct btrfs_bio *bbio =
> +		container_of(work, struct btrfs_bio, end_io_work);
> +	struct btrfs_io_stripe *stripe = bbio->bio.bi_private;
> +	struct btrfs_io_context *bioc = stripe->bioc;
> +	int ret;
> +
> +	ret = btrfs_add_ordered_stripe(bioc);
> +	if (ret)
> +		bbio->bio.bi_status = errno_to_blk_status(ret);
> +	btrfs_orig_bbio_end_io(bbio);
> +	btrfs_put_bioc(bioc);
> +}
> +
>   static void btrfs_orig_write_end_io(struct bio *bio)
>   {
>   	struct btrfs_io_stripe *stripe = bio->bi_private;
> @@ -370,6 +386,16 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>   	else
>   		bio->bi_status = BLK_STS_OK;
>   
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
> +	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> +		INIT_WORK(&bbio->end_io_work, btrfs_raid_stripe_update);
> +		queue_work(btrfs_end_io_wq(bioc->fs_info, bio),
> +			&bbio->end_io_work);

I'm still having the old question, what would happen if the delayed 
workload happen after the ordered extent finished?

Since we can not ensure the order between this RST update workload and 
finish_ordered_io(), there can be an window where we finish ordered io, 
and then the pages get released (by memory pressure), then a new read 
happen to the range, then our RST workload happened.

In that case, we would have read failure.


Thus I strongly recommened to do the RST tree update inside 
finish_ordered_io().

This has several advantages:

- We don't need in-memory structure as a gap stopper
   Since read would be blocked if there is a running ordered extent,
   we don't need an in-memory RST mapping.

- finish_ordered_io() itself has all the proper context for tree
   updates.
   As that's the main location we update the subvolume tree.

The main concern may be the bioc <-> ordered extent mapping, but IIRC 
for zoned mode one bioc is one ordered extent, thus this shouldn't be a 
super big deal?

Otherwise we may need something to trace all the bioc belong to the 
ordered extent.

Thanks,
Qu
> +		return;
> +	}
> +
>   	btrfs_orig_bbio_end_io(bbio);
>   	btrfs_put_bioc(bioc);
>   }
> @@ -381,6 +407,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>   	if (bio->bi_status) {
>   		atomic_inc(&stripe->bioc->error);
>   		btrfs_log_dev_io_error(bio, stripe->dev);
> +	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>   	}
>   
>   	/* Pass on control to the original bio this one was cloned from */
> @@ -440,6 +468,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
>   	bio->bi_private = &bioc->stripes[dev_nr];
>   	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
>   	bioc->stripes[dev_nr].bioc = bioc;
> +	bioc->size = bio->bi_iter.bi_size;
>   	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
>   }
>   
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 7660ac642c81..261f52ad8e12 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -14,6 +14,7 @@
>   #include "space-info.h"
>   #include "tree-mod-log.h"
>   #include "fs.h"
> +#include "raid-stripe-tree.h"
>   
>   struct kmem_cache *btrfs_delayed_ref_head_cachep;
>   struct kmem_cache *btrfs_delayed_tree_ref_cachep;
> @@ -637,8 +638,11 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
>   	exist->ref_mod += mod;
>   
>   	/* remove existing tail if its ref_mod is zero */
> -	if (exist->ref_mod == 0)
> +	if (exist->ref_mod == 0) {
> +		btrfs_drop_ordered_stripe(trans->fs_info, exist->bytenr);
>   		drop_delayed_ref(root, href, exist);
> +	}
> +
>   	spin_unlock(&href->lock);
>   	return ret;
>   inserted:
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 2eb34abf700f..5096c1a1ed3e 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -51,6 +51,8 @@ struct btrfs_delayed_ref_node {
>   	/* is this node still in the rbtree? */
>   	unsigned int is_head:1;
>   	unsigned int in_tree:1;
> +	/* Do we need RAID stripe tree modifications? */
> +	unsigned int must_insert_stripe:1;
>   };
>   
>   struct btrfs_delayed_extent_op {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 6b6c59e6805c..7441d784fe03 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -42,6 +42,7 @@
>   #include "file-item.h"
>   #include "orphan.h"
>   #include "tree-checker.h"
> +#include "raid-stripe-tree.h"
>   
>   #undef SCRAMBLE_DELAYED_REFS
>   
> @@ -1497,6 +1498,56 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>   	return ret;
>   }
>   
> +static bool delayed_ref_needs_rst_update(struct btrfs_fs_info *fs_info,
> +					 struct btrfs_delayed_ref_head *head)
> +{
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +	bool ret = false;
> +
> +	if (!btrfs_stripe_tree_root(fs_info))
> +		return ret;
> +
> +	em = btrfs_get_chunk_map(fs_info, head->bytenr, head->num_bytes);
> +	if (!em)
> +		return ret;
> +
> +	map = em->map_lookup;
> +
> +	if (btrfs_need_stripe_tree_update(fs_info, map->type))
> +		ret = true;
> +
> +	free_extent_map(em);
> +
> +	return ret;
> +}
> +
> +static int add_stripe_entry_for_delayed_ref(struct btrfs_trans_handle *trans,
> +					    struct btrfs_delayed_ref_node *node)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_ordered_stripe *stripe;
> +	int ret = 0;
> +
> +	stripe = btrfs_lookup_ordered_stripe(fs_info, node->bytenr);
> +	if (!stripe) {
> +		btrfs_err(fs_info,
> +			  "cannot get stripe extent for address %llu (%llu)",
> +			  node->bytenr, node->num_bytes);
> +		return -EINVAL;
> +	}
> +
> +	ASSERT(stripe->logical == node->bytenr);
> +
> +	ret = btrfs_insert_raid_extent(trans, stripe);
> +	/* once for us */
> +	btrfs_put_ordered_stripe(fs_info, stripe);
> +	/* once for the tree */
> +	btrfs_put_ordered_stripe(fs_info, stripe);
> +
> +	return ret;
> +}
> +
>   static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>   				struct btrfs_delayed_ref_node *node,
>   				struct btrfs_delayed_extent_op *extent_op,
> @@ -1527,11 +1578,17 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>   						 flags, ref->objectid,
>   						 ref->offset, &ins,
>   						 node->ref_mod);
> +		if (ret)
> +			return ret;
> +		if (node->must_insert_stripe)
> +			ret = add_stripe_entry_for_delayed_ref(trans, node);
>   	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
>   		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
>   					     ref->objectid, ref->offset,
>   					     node->ref_mod, extent_op);
>   	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
> +		if (node->must_insert_stripe)
> +			btrfs_drop_ordered_stripe(trans->fs_info, node->bytenr);
>   		ret = __btrfs_free_extent(trans, node, parent,
>   					  ref_root, ref->objectid,
>   					  ref->offset, node->ref_mod,
> @@ -1901,6 +1958,8 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct btrfs_delayed_extent_op *extent_op;
>   	struct btrfs_delayed_ref_node *ref;
> +	const bool need_rst_update =
> +		delayed_ref_needs_rst_update(fs_info, locked_ref);
>   	int must_insert_reserved = 0;
>   	int ret;
>   
> @@ -1951,6 +2010,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
>   		locked_ref->extent_op = NULL;
>   		spin_unlock(&locked_ref->lock);
>   
> +		ref->must_insert_stripe = need_rst_update;
>   		ret = run_one_delayed_ref(trans, ref, extent_op,
>   					  must_insert_reserved);
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8f07d59e8193..aaa1db90e58b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -70,6 +70,7 @@
>   #include "verity.h"
>   #include "super.h"
>   #include "orphan.h"
> +#include "raid-stripe-tree.h"
>   
>   struct btrfs_iget_args {
>   	u64 ino;
> @@ -9495,12 +9496,17 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
>   	if (qgroup_released < 0)
>   		return ERR_PTR(qgroup_released);
>   
> +	ret = btrfs_insert_preallocated_raid_stripe(inode->root->fs_info,
> +						    start, len);
> +	if (ret)
> +		goto free_qgroup;
> +
>   	if (trans) {
>   		ret = insert_reserved_file_extent(trans, inode,
>   						  file_offset, &stack_fi,
>   						  true, qgroup_released);
>   		if (ret)
> -			goto free_qgroup;
> +			goto free_stripe_extent;
>   		return trans;
>   	}
>   
> @@ -9518,7 +9524,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
>   	path = btrfs_alloc_path();
>   	if (!path) {
>   		ret = -ENOMEM;
> -		goto free_qgroup;
> +		goto free_stripe_extent;
>   	}
>   
>   	ret = btrfs_replace_file_extents(inode, path, file_offset,
> @@ -9526,9 +9532,12 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
>   				     &trans);
>   	btrfs_free_path(path);
>   	if (ret)
> -		goto free_qgroup;
> +		goto free_stripe_extent;
>   	return trans;
>   
> +free_stripe_extent:
> +	btrfs_drop_ordered_stripe(inode->root->fs_info, start);
> +
>   free_qgroup:
>   	/*
>   	 * We have released qgroup data range at the beginning of the function,
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> new file mode 100644
> index 000000000000..9d3e7bffe6f8
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Western Digital Corporation or its affiliates.
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
> +#include "disk-io.h"
> +#include "print-tree.h"
> +
> +static int ordered_stripe_cmp(const void *key, const struct rb_node *node)
> +{
> +	struct btrfs_ordered_stripe *stripe =
> +		rb_entry(node, struct btrfs_ordered_stripe, rb_node);
> +	const u64 *logical = key;
> +
> +	if (*logical < stripe->logical)
> +		return -1;
> +	if (*logical >= stripe->logical + stripe->num_bytes)
> +		return 1;
> +	return 0;
> +}
> +
> +static int ordered_stripe_less(struct rb_node *rba, const struct rb_node *rbb)
> +{
> +	struct btrfs_ordered_stripe *stripe =
> +		rb_entry(rba, struct btrfs_ordered_stripe, rb_node);
> +	return ordered_stripe_cmp(&stripe->logical, rbb);
> +}
> +
> +int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_fs_info *fs_info = bioc->fs_info;
> +	struct btrfs_ordered_stripe *stripe;
> +	struct btrfs_io_stripe *tmp;
> +	u64 logical = bioc->logical;
> +	u64 length = bioc->size;
> +	struct rb_node *node;
> +	size_t size;
> +
> +	size = bioc->num_stripes * sizeof(struct btrfs_io_stripe);
> +	stripe = kzalloc(sizeof(struct btrfs_ordered_stripe), GFP_NOFS);
> +	if (!stripe)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&stripe->lock);
> +	tmp = kmemdup(bioc->stripes, size, GFP_NOFS);
> +	if (!tmp) {
> +		kfree(stripe);
> +		return -ENOMEM;
> +	}
> +
> +	stripe->logical = logical;
> +	stripe->num_bytes = length;
> +	stripe->num_stripes = bioc->num_stripes;
> +	spin_lock(&stripe->lock);
> +	stripe->stripes = tmp;
> +	spin_unlock(&stripe->lock);
> +	refcount_set(&stripe->ref, 1);
> +
> +	write_lock(&fs_info->stripe_update_lock);
> +	node = rb_find_add(&stripe->rb_node, &fs_info->stripe_update_tree,
> +	       ordered_stripe_less);
> +	if (node) {
> +		struct btrfs_ordered_stripe *old =
> +			rb_entry(node, struct btrfs_ordered_stripe, rb_node);
> +
> +		btrfs_debug(fs_info, "logical: %llu, length: %llu already exists",
> +			  logical, length);
> +		ASSERT(logical == old->logical);
> +
> +		rb_replace_node(node, &stripe->rb_node,
> +				&fs_info->stripe_update_tree);
> +	}
> +	write_unlock(&fs_info->stripe_update_lock);
> +
> +	return 0;
> +}
> +
> +struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *fs_info,
> +							 u64 logical)
> +{
> +	struct rb_root *root = &fs_info->stripe_update_tree;
> +	struct btrfs_ordered_stripe *stripe = NULL;
> +	struct rb_node *node;
> +
> +	read_lock(&fs_info->stripe_update_lock);
> +	node = rb_find(&logical, root, ordered_stripe_cmp);
> +	if (node) {
> +		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
> +		refcount_inc(&stripe->ref);
> +	}
> +	read_unlock(&fs_info->stripe_update_lock);
> +
> +	return stripe;
> +}
> +
> +void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
> +				 struct btrfs_ordered_stripe *stripe)
> +{
> +
> +	if (refcount_dec_and_test(&stripe->ref)) {
> +		struct rb_node *node;
> +
> +		write_lock(&fs_info->stripe_update_lock);
> +
> +		node = &stripe->rb_node;
> +		rb_erase(node, &fs_info->stripe_update_tree);
> +		RB_CLEAR_NODE(node);
> +
> +		spin_lock(&stripe->lock);
> +		kfree(stripe->stripes);
> +		spin_unlock(&stripe->lock);
> +		kfree(stripe);
> +		write_unlock(&fs_info->stripe_update_lock);
> +	}
> +}
> +
> +int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
> +					  u64 start, u64 len)
> +{
> +	struct btrfs_io_context *bioc = NULL;
> +	struct btrfs_ordered_stripe *stripe;
> +	u64 map_length = len;
> +	int ret;
> +
> +	if (!btrfs_stripe_tree_root(fs_info))
> +		return 0;
> +
> +	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, start, &map_length,
> +			      &bioc, 0);
> +	if (ret)
> +		return ret;
> +
> +	bioc->size = len;
> +
> +	stripe = btrfs_lookup_ordered_stripe(fs_info, start);
> +	if (!stripe) {
> +		ret = btrfs_add_ordered_stripe(bioc);
> +		if (ret)
> +			return ret;
> +	} else {
> +		spin_lock(&stripe->lock);
> +		memcpy(stripe->stripes, bioc->stripes,
> +		       bioc->num_stripes * sizeof(struct btrfs_io_stripe));
> +		spin_unlock(&stripe->lock);
> +		btrfs_put_ordered_stripe(fs_info, stripe);
> +	}
> +
> +	return 0;
> +}
> +
> +int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> +			     struct btrfs_ordered_stripe *stripe)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
> +	struct btrfs_stripe_extent *stripe_extent;
> +	size_t item_size;
> +	int ret;
> +
> +	item_size = stripe->num_stripes * sizeof(struct btrfs_raid_stride);
> +
> +	stripe_extent = kzalloc(item_size, GFP_NOFS);
> +	if (!stripe_extent) {
> +		btrfs_abort_transaction(trans, -ENOMEM);
> +		btrfs_end_transaction(trans);
> +		return -ENOMEM;
> +	}
> +
> +	spin_lock(&stripe->lock);
> +	for (int i = 0; i < stripe->num_stripes; i++) {
> +		u64 devid = stripe->stripes[i].dev->devid;
> +		u64 physical = stripe->stripes[i].physical;
> +		struct btrfs_raid_stride *raid_stride =
> +						&stripe_extent->strides[i];
> +
> +		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
> +		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
> +	}
> +	spin_unlock(&stripe->lock);
> +
> +	stripe_key.objectid = stripe->logical;
> +	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset = stripe->num_bytes;
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
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> new file mode 100644
> index 000000000000..60d3f8489cc9
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef BTRFS_RAID_STRIPE_TREE_H
> +#define BTRFS_RAID_STRIPE_TREE_H
> +
> +#include "disk-io.h"
> +#include "messages.h"
> +
> +struct btrfs_io_context;
> +
> +struct btrfs_ordered_stripe {
> +	struct rb_node rb_node;
> +
> +	u64 logical;
> +	u64 num_bytes;
> +	int num_stripes;
> +	struct btrfs_io_stripe *stripes;
> +	spinlock_t lock;
> +	refcount_t ref;
> +};
> +
> +int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> +			     struct btrfs_ordered_stripe *stripe);
> +int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
> +					  u64 start, u64 len);
> +struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(
> +						 struct btrfs_fs_info *fs_info,
> +						 u64 logical);
> +int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc);
> +void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
> +					    struct btrfs_ordered_stripe *stripe);
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
> +
> +static inline void btrfs_drop_ordered_stripe(struct btrfs_fs_info *fs_info,
> +					     u64 logical)
> +{
> +	struct btrfs_ordered_stripe *stripe;
> +
> +	if (!btrfs_stripe_tree_root(fs_info))
> +		return;
> +
> +	stripe = btrfs_lookup_ordered_stripe(fs_info, logical);
> +	if (!stripe)
> +		return;
> +	ASSERT(refcount_read(&stripe->ref) == 2);
> +	/* once for us */
> +	btrfs_put_ordered_stripe(fs_info, stripe);
> +	/* once for the tree */
> +	btrfs_put_ordered_stripe(fs_info, stripe);
> +}
> +#endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9d6775c7196f..fee611d1b01d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5879,6 +5879,7 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   }
>   
>   static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
> +						       u64 logical,
>   						       u16 total_stripes)
>   {
>   	struct btrfs_io_context *bioc;
> @@ -5898,6 +5899,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>   	bioc->fs_info = fs_info;
>   	bioc->replace_stripe_src = -1;
>   	bioc->full_stripe_logical = (u64)-1;
> +	bioc->logical = logical;
>   
>   	return bioc;
>   }
> @@ -6493,7 +6495,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   		goto out;
>   	}
>   
> -	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes);
> +	bioc = alloc_btrfs_io_context(fs_info, logical, num_alloc_stripes);
>   	if (!bioc) {
>   		ret = -ENOMEM;
>   		goto out;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 650e131d079e..114c76c81eda 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -372,12 +372,10 @@ struct btrfs_fs_devices {
>   
>   struct btrfs_io_stripe {
>   	struct btrfs_device *dev;
> -	union {
> -		/* Block mapping */
> -		u64 physical;
> -		/* For the endio handler */
> -		struct btrfs_io_context *bioc;
> -	};
> +	/* Block mapping */
> +	u64 physical;
> +	/* For the endio handler */
> +	struct btrfs_io_context *bioc;
>   };
>   
>   struct btrfs_discard_stripe {
> @@ -410,6 +408,9 @@ struct btrfs_io_context {
>   	atomic_t error;
>   	u16 max_errors;
>   
> +	u64 logical;
> +	u64 size;
> +
>   	/*
>   	 * The total number of stripes, including the extra duplicated
>   	 * stripe for replace.
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index f95b2c94d619..7e6cfc7a2918 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1692,6 +1692,9 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
>   	u64 chunk_start_phys;
>   	u64 logical;
>   
> +	/* Filesystems with a stripe tree have their own l2p mapping */
> +	ASSERT(!btrfs_stripe_tree_root(fs_info));
> +
>   	em = btrfs_get_chunk_map(fs_info, orig_logical, 1);
>   	if (IS_ERR(em))
>   		return;
