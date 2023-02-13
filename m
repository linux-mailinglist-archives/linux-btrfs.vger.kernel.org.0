Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE6693EF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 08:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBMHkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 02:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMHkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 02:40:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482BE3B3
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 23:40:32 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1pQvDQ3W2g-003z6A; Mon, 13
 Feb 2023 08:40:27 +0100
Message-ID: <54c0f200-2598-37e0-efe8-1cb6d65c9774@gmx.com>
Date:   Mon, 13 Feb 2023 15:40:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
In-Reply-To: <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yNwswscllhbaX1y/mZFLUjBf2wsky3TFdXzx+OnWQ66SqYzS9cO
 6hQ8if3mFjFlNvVmSbat75vUUdwALFgKalZAqQK3CxHN0+cwRUZCAOy0g3IXp2S8Q0HPxel
 ThkPPqhb3IRJyAX+y9pNtqblwQwe3z5/hzzlNlW6Fz8bDCYdaQ6wAa4x/9oYcUgkGr8boXm
 jWvrIEBe4cn1fygddqq0g==
UI-OutboundReport: notjunk:1;M01:P0:z7AubDs41Wo=;U0BOaGgseAizyVfYp/UDl8FApi6
 tftV5dfCXZ7hJcETQ7ucOo0Ve2rlPXnlOe7o759nPvvQ0bvoUDwA4TBuZTS4OmsN+owh55mLG
 K41mONlPu1+saVrIILsqIlbcx0M6JBSMnrl2AfLGNskM2yNyTKyirqBpVdhW/t1UWESFnjqGR
 xn7ow+JHhxGA2O4Gve6AoTKoHiMWveXf0fmkESn/VZpfgwKz14EX3eLUG2uht/5QJOesxVa7T
 Rr+yErJ+Nayv2R91a9Iz/EQVluX4iLNRr1qBXbBxjO6ciSV/IvkljYe0l2I6pEUmxBJ1K3djq
 V9hver4FlW2IP9Qngj1UI44Dy1WNHTn8t07V2umNSBz2OtvdWg5AsAbP1DhejxWKusIBSwlUp
 Zg9ePhiXfvgfcSqp74f0ou9WWoHzhKMmc8De3W5yKGKNCNTFtnm7ZIZaz5wVJJv89/NsfBCOh
 TpNi3sfGzvWjaGsy/8d6ko9FQfrjabjIDk7AruHcuhQytr8meu7dFpTG1uMHUC2M7E1bT7Xj8
 qTFhq6DH3Qtk6NpT7EDtPAbhNNn/5C9amPTB6BhYA61cbsnyOh8WlYrSOcRGjQf8KFwi+GFx7
 mmxPZfixOSOquojtJRFLnzvpjy4t1QFUU4o+GOs1b/rpAvFgdEURI+/KCHrw9iq4q0Z5Fgj8b
 gIE9XnzcFXqoYURhYgkwLdxxmzIgWRaCQQI18dWxRBuC0gYnweaGPwy7gipLB1bHCTermbiLZ
 dWdIhynh67X6zSSPfYdc/61lIePzdFRn+QS2uqMXWUWzddZBj3E0aSbVMKeDrp5Hllb9psawB
 rddAQ+gUadvLOq1bf15CbOpS42QAuJIvCQY9tDXHU8sjePJtf9hnjP4ZjsBsKxv7hKa9ZG9N5
 V6GrxpP9LwgWhds5rUwi+DTd3JyIkvfQwkHidAsG+wgbpRKno848LgtL3t/c8Gh93Ja4P3Mp8
 piNA4Ita99t4K6JZhq2dQGj8e1U=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/8 18:57, Johannes Thumshirn wrote:
[...]
>   }
>   
> +static void btrfs_raid_stripe_update(struct work_struct *work)
> +{
> +	struct btrfs_bio *bbio =
> +		container_of(work, struct btrfs_bio, raid_stripe_work);
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
> @@ -372,6 +388,16 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>   	else
>   		bio->bi_status = BLK_STS_OK;
>   
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
> +	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> +		INIT_WORK(&bbio->raid_stripe_work, btrfs_raid_stripe_update);

So the in-memory stripe tree entry insersion is delated.

Could the following race happen?

              T1                  |              T2
---------------------------------+----------------------------------
write_pages()                    |
btrfs_orig_write_end_io()        |
|- INIT_WORK();                  |
`- queue_work();                 |
                                  | btrfs_invalidate_folio()
                                  | `- the pages are no longer cached
                                  |
                                  | btrfs_do_readpage()
                                  | |- do whatever the rst lookup
workqueue                        |
`- btrfs_raid_stripe_update()    |
    `- btrfs_add_ordered_stripe() |

In above case, T2 read will fail as it can not grab the RST mapping.

I really believe the in-memory rst update should not be delayed into a 
workqueue, but done inside the write endio function.

Thanks,
Qu


> +		queue_work(bbio->inode->root->fs_info->raid_stripe_workers,
> +			   &bbio->raid_stripe_work);
> +		return;
> +	}
> +
>   	btrfs_orig_bbio_end_io(bbio);
>   	btrfs_put_bioc(bioc);
>   }
> @@ -383,6 +409,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>   	if (bio->bi_status) {
>   		atomic_inc(&stripe->bioc->error);
>   		btrfs_log_dev_io_error(bio, stripe->dev);
> +	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>   	}
>   
>   	/* Pass on control to the original bio this one was cloned from */
> @@ -442,6 +470,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
>   	bio->bi_private = &bioc->stripes[dev_nr];
>   	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
>   	bioc->stripes[dev_nr].bioc = bioc;
> +	bioc->size = bio->bi_iter.bi_size;
>   	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
>   }
>   
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 20105806c8ac..bf5fbc105148 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -58,6 +58,8 @@ struct btrfs_bio {
>   	atomic_t pending_ios;
>   	struct work_struct end_io_work;
>   
> +	struct work_struct raid_stripe_work;
> +
>   	/*
>   	 * This member must come last, bio_alloc_bioset will allocate enough
>   	 * bytes for entire btrfs_bio but relies on bio being last.
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
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index ad64a79d052a..b130c8dcd8d9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2022,6 +2022,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>   		destroy_workqueue(fs_info->rmw_workers);
>   	if (fs_info->compressed_write_workers)
>   		destroy_workqueue(fs_info->compressed_write_workers);
> +	if (fs_info->raid_stripe_workers)
> +		destroy_workqueue(fs_info->raid_stripe_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_write_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
>   	btrfs_destroy_workqueue(fs_info->delayed_workers);
> @@ -2240,12 +2242,14 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>   		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
>   	fs_info->discard_ctl.discard_workers =
>   		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
> +	fs_info->raid_stripe_workers =
> +		alloc_workqueue("btrfs-raid-stripe", flags, max_active);
>   
>   	if (!(fs_info->workers && fs_info->hipri_workers &&
>   	      fs_info->delalloc_workers && fs_info->flush_workers &&
>   	      fs_info->endio_workers && fs_info->endio_meta_workers &&
>   	      fs_info->compressed_write_workers &&
> -	      fs_info->endio_write_workers &&
> +	      fs_info->endio_write_workers && fs_info->raid_stripe_workers &&
>   	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
>   	      fs_info->caching_workers && fs_info->fixup_workers &&
>   	      fs_info->delayed_workers && fs_info->qgroup_rescan_workers &&
> @@ -3046,6 +3050,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   
>   	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
>   	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
> +
> +	rwlock_init(&fs_info->stripe_update_lock);
> +	fs_info->stripe_update_tree = RB_ROOT;
>   }
>   
>   static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 688cdf816957..50b3a2c3c0dd 100644
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
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 93f2499a9c5b..bee7ed0304cd 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -551,6 +551,7 @@ struct btrfs_fs_info {
>   	struct btrfs_workqueue *endio_write_workers;
>   	struct btrfs_workqueue *endio_freespace_worker;
>   	struct btrfs_workqueue *caching_workers;
> +	struct workqueue_struct *raid_stripe_workers;
>   
>   	/*
>   	 * Fixup workers take dirty pages that didn't properly go through the
> @@ -791,6 +792,9 @@ struct btrfs_fs_info {
>   	struct lockdep_map btrfs_trans_pending_ordered_map;
>   	struct lockdep_map btrfs_ordered_extent_map;
>   
> +	rwlock_t stripe_update_lock;
> +	struct rb_root stripe_update_tree;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 36ae541ad51b..74c0b486e496 100644
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
> @@ -9509,12 +9510,17 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
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
> @@ -9532,7 +9538,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
>   	path = btrfs_alloc_path();
>   	if (!path) {
>   		ret = -ENOMEM;
> -		goto free_qgroup;
> +		goto free_stripe_extent;
>   	}
>   
>   	ret = btrfs_replace_file_extents(inode, path, file_offset,
> @@ -9540,9 +9546,12 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
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
> index 000000000000..d184cd9dc96e
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -0,0 +1,202 @@
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
> +	write_unlock(&fs_info->stripe_update_lock);
> +	if (node) {
> +		struct btrfs_ordered_stripe *old =
> +			rb_entry(node, struct btrfs_ordered_stripe, rb_node);
> +
> +		btrfs_debug(fs_info, "logical: %llu, length: %llu already exists",
> +			  logical, length);
> +		ASSERT(logical == old->logical);
> +		write_lock(&fs_info->stripe_update_lock);
> +		rb_replace_node(node, &stripe->rb_node,
> +				&fs_info->stripe_update_tree);
> +		write_unlock(&fs_info->stripe_update_lock);
> +	}
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
> +	write_lock(&fs_info->stripe_update_lock);
> +	if (refcount_dec_and_test(&stripe->ref)) {
> +		struct rb_node *node = &stripe->rb_node;
> +
> +		rb_erase(node, &fs_info->stripe_update_tree);
> +		RB_CLEAR_NODE(node);
> +
> +		spin_lock(&stripe->lock);
> +		kfree(stripe->stripes);
> +		spin_unlock(&stripe->lock);
> +		kfree(stripe);
> +	}
> +	write_unlock(&fs_info->stripe_update_lock);
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
> index 707dd0456cea..e7c0353e5655 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5885,6 +5885,7 @@ static void sort_parity_stripes(struct btrfs_io_context *bioc, int num_stripes)
>   }
>   
>   static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
> +						       u64 logical,
>   						       int total_stripes,
>   						       int real_stripes)
>   {
> @@ -5908,6 +5909,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>   	refcount_set(&bioc->refs, 1);
>   
>   	bioc->fs_info = fs_info;
> +	bioc->logical = logical;
>   	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
>   	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
>   
> @@ -6513,7 +6515,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   		goto out;
>   	}
>   
> -	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
> +	bioc = alloc_btrfs_io_context(fs_info, logical, num_alloc_stripes,
> +				      tgtdev_indexes);
>   	if (!bioc) {
>   		ret = -ENOMEM;
>   		goto out;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 7e51f2238f72..5d7547b5fa87 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -368,12 +368,10 @@ struct btrfs_fs_devices {
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
> @@ -409,6 +407,8 @@ struct btrfs_io_context {
>   	int mirror_num;
>   	int num_tgtdevs;
>   	int *tgtdev_map;
> +	u64 logical;
> +	u64 size;
>   	/*
>   	 * logical block numbers for the start of each stripe
>   	 * The last one or two are p/q.  These are sorted,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d862477f79f3..ed49150e6e6f 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1687,6 +1687,10 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
>   	u64 *logical = NULL;
>   	int nr, stripe_len;
>   
> +	/* Filesystems with a stripe tree have their own l2p mapping */
> +	if (btrfs_stripe_tree_root(fs_info))
> +		return;
> +
>   	/* Zoned devices should not have partitions. So, we can assume it is 0 */
>   	ASSERT(!bdev_is_partition(ordered->bdev));
>   	if (WARN_ON(!ordered->bdev))
