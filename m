Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA46860644A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJTPYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJTPYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:24:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F9C1C19D1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:24:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g11so13912647qts.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m44HZ0BPfLVKmh1LojtwnPhGHB5BSWPyK6JLg/8ZqB8=;
        b=8H6ux07+eU67KRCdohckUbUrHidDr3I2byF3ck2Ic6aogM6jdsD/PN/ecOWdMV8JIr
         D+47Ir3I1QeBtUmt0iHFl7/E2Sh718pkNtg3Yw6hIZHpr3W8CfgfAxjdQzvGNQ8ypIab
         /zcWctfH3+s2ON0RAMlgk//2qquX0T4rXNMVi6hAPwkGlyv9tANWzcFPm/x34HZD+3x2
         ++Y8Vx9WJvilrHWDlBHLLaT8Gg0OTd5cHvO7heGF6LR3grqUsUSoHwCTPf78YSW33Zf6
         E+DZ1xx2NmjgbF20ZF4Ct4qbViuYb8/31kWPE69EMMqoKOWzrtqJt/epyQDEcPTELpaI
         9BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m44HZ0BPfLVKmh1LojtwnPhGHB5BSWPyK6JLg/8ZqB8=;
        b=QK5aXOKXnF6ZDjaCQ3kPd2aYcPrHBVSognfYR4Z7rOlYM75oy1oo0/KU85SqHloelb
         2Q2QHzKFgpG0tpT0Ktp00G9j51nhqXdGQgjswrRIu7yxdN69OP+x0lG/1lr0RH4RY6D0
         eOdUs/FMIxZpP8rZQhQYDMOafVjvhhxlX4UW1QYYpC4uiQJX1DsRlp3HPcLuxn1ncSxw
         TtaZbv/NB/TepfSXZFWCQvfBLMAq/Rf/mQHts9RpKzebyopXoP8TnklFcbt4on1YgIdf
         Lr06/faKDdN6Y5x5hDvp/vNlxeXRDAxROh5mdN64Zz9DMEMgUaLe3BbfzOHA/KUg0KIr
         2anw==
X-Gm-Message-State: ACrzQf1KGmIaa286lnuYfRAC9F7UGTljblDAqhJfF+ivXSKGG13va5s6
        fRIwR1oCIi0YB5NzkOg5w08KlgoW1CzytA==
X-Google-Smtp-Source: AMsMyM5WdPXlEATilMHseBbUSDmhaNtfoLgVNlmKVTMD6GZFMNzhI3YlIZlO9s5UW0me6ZqhkW8O/Q==
X-Received: by 2002:a05:622a:410:b0:39d:8ed:33e with SMTP id n16-20020a05622a041000b0039d08ed033emr4782060qtx.43.1666279443247;
        Thu, 20 Oct 2022 08:24:03 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b640efe6dasm7460164qkp.132.2022.10.20.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:24:02 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:24:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 03/11] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y1FoEm/XLM80jYX9@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <5c8b4c3005d7c02ca4ab76a1802f14137ae47bda.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c8b4c3005d7c02ca4ab76a1802f14137ae47bda.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:21AM -0700, Johannes Thumshirn wrote:
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
>  fs/btrfs/Makefile           |   2 +-
>  fs/btrfs/ctree.h            |   3 +
>  fs/btrfs/disk-io.c          |   3 +
>  fs/btrfs/extent-tree.c      |  48 +++++++++
>  fs/btrfs/inode.c            |   6 ++
>  fs/btrfs/raid-stripe-tree.c | 189 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  49 ++++++++++
>  fs/btrfs/volumes.c          |  35 ++++++-
>  fs/btrfs/volumes.h          |  14 +--
>  fs/btrfs/zoned.c            |   4 +
>  10 files changed, 345 insertions(+), 8 deletions(-)
>  create mode 100644 fs/btrfs/raid-stripe-tree.c
>  create mode 100644 fs/btrfs/raid-stripe-tree.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 99f9995670ea..4484831ac624 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
>  	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
> -	   subpage.o tree-mod-log.o
> +	   subpage.o tree-mod-log.o raid-stripe-tree.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 430f224743a9..1f75ab8702bb 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1102,6 +1102,9 @@ struct btrfs_fs_info {
>  	struct lockdep_map btrfs_trans_pending_ordered_map;
>  	struct lockdep_map btrfs_ordered_extent_map;
>  
> +	struct mutex stripe_update_lock;
> +	struct rb_root stripe_update_tree;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a166b2602c40..190caabf5fb7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2973,6 +2973,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  
>  	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
>  	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
> +
> +	mutex_init(&fs_info->stripe_update_lock);
> +	fs_info->stripe_update_tree = RB_ROOT;
>  }
>  
>  static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index bcd0e72cded3..061296bcdfb4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -36,6 +36,7 @@
>  #include "rcu-string.h"
>  #include "zoned.h"
>  #include "dev-replace.h"
> +#include "raid-stripe-tree.h"
>  
>  #undef SCRAMBLE_DELAYED_REFS
>  
> @@ -1491,6 +1492,50 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int add_stripe_entry_for_delayed_ref(struct btrfs_trans_handle *trans,
> +					    struct btrfs_delayed_ref_node *node)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +	int ret;
> +
> +	if (!fs_info->stripe_root)
> +		return 0;
> +
> +	em = btrfs_get_chunk_map(fs_info, node->bytenr, node->num_bytes);
> +	if (!em) {
> +		btrfs_err(fs_info,
> +			  "cannot get chunk map for address %llu",
> +			  node->bytenr);
> +		return -EINVAL;
> +	}
> +
> +	map = em->map_lookup;
> +
> +	if (btrfs_need_stripe_tree_update(fs_info, map->type)) {
> +		struct btrfs_ordered_stripe *stripe;
> +
> +		stripe = btrfs_lookup_ordered_stripe(fs_info, node->bytenr);
> +		if (!stripe) {
> +			btrfs_err(fs_info,
> +				  "cannot get stripe extent for address %llu (%llu)",
> +				  node->bytenr, node->num_bytes);
> +			free_extent_map(em);
> +			return -EINVAL;
> +		}
> +		ASSERT(stripe->logical == node->bytenr);
> +		ret = btrfs_insert_raid_extent(trans, stripe);
> +		/* once for us */
> +		btrfs_put_ordered_stripe(fs_info, stripe);
> +		/* once for the tree */
> +		btrfs_put_ordered_stripe(fs_info, stripe);
> +	}
> +	free_extent_map(em);
> +
> +	return ret;
> +}
> +
>  static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>  				struct btrfs_delayed_ref_node *node,
>  				struct btrfs_delayed_extent_op *extent_op,
> @@ -1521,6 +1566,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>  						 flags, ref->objectid,
>  						 ref->offset, &ins,
>  						 node->ref_mod);
> +		if (ret)
> +			return ret;
> +		ret = add_stripe_entry_for_delayed_ref(trans, node);
>  	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
>  		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
>  					     ref->objectid, ref->offset,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5f2d9d4f6d43..5414ba573022 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -55,6 +55,7 @@
>  #include "zoned.h"
>  #include "subpage.h"
>  #include "inode-item.h"
> +#include "raid-stripe-tree.h"
>  
>  struct btrfs_iget_args {
>  	u64 ino;
> @@ -9550,6 +9551,11 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
>  	if (qgroup_released < 0)
>  		return ERR_PTR(qgroup_released);
>  
> +	ret = btrfs_insert_preallocated_raid_stripe(inode->root->fs_info,
> +						    start, len);
> +	if (ret)
> +		goto free_qgroup;
> +
>  	if (trans) {
>  		ret = insert_reserved_file_extent(trans, inode,
>  						  file_offset, &stack_fi,
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> new file mode 100644
> index 000000000000..d8a69060b54b
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/btrfs_tree.h>
> +
> +#include "ctree.h"
> +#include "transaction.h"
> +#include "disk-io.h"
> +#include "raid-stripe-tree.h"
> +#include "volumes.h"
> +#include "misc.h"
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
> +	mutex_lock(&fs_info->stripe_update_lock);
> +	node = rb_find_add(&stripe->rb_node, &fs_info->stripe_update_tree,
> +	       ordered_stripe_less);
> +	mutex_unlock(&fs_info->stripe_update_lock);
> +	if (node) {
> +		btrfs_err(fs_info, "logical: %llu, length: %llu already exists",
> +			  logical, length);
> +		return -EINVAL;
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
> +	mutex_lock(&fs_info->stripe_update_lock);
> +	node = rb_find(&logical, root, ordered_stripe_cmp);
> +	if (node) {
> +		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
> +		refcount_inc(&stripe->ref);
> +	}
> +	mutex_unlock(&fs_info->stripe_update_lock);
> +
> +	return stripe;
> +}
> +
> +void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
> +				 struct btrfs_ordered_stripe *stripe)
> +{
> +	mutex_lock(&fs_info->stripe_update_lock);
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
> +	mutex_unlock(&fs_info->stripe_update_lock);
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
> +	if (!fs_info->stripe_root)
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
> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> +	struct btrfs_dp_stripe *raid_stripe;
> +	size_t item_size;
> +	int ret;
> +
> +	item_size = stripe->num_stripes * sizeof(struct btrfs_stripe_extent);
> +
> +	raid_stripe = kzalloc(item_size, GFP_NOFS);
> +	if (!raid_stripe) {
> +		btrfs_abort_transaction(trans, -ENOMEM);
> +		btrfs_end_transaction(trans);
> +		return -ENOMEM;
> +	}
> +
> +	spin_lock(&stripe->lock);
> +	for (int i = 0; i < stripe->num_stripes; i++) {
> +		u64 devid = stripe->stripes[i].dev->devid;
> +		u64 physical = stripe->stripes[i].physical;
> +		struct btrfs_stripe_extent *stripe_extent =
> +						&raid_stripe->extents[i];
> +
> +		btrfs_set_stack_stripe_extent_devid(stripe_extent, devid);
> +		btrfs_set_stack_stripe_extent_physical(stripe_extent, physical);
> +	}
> +	spin_unlock(&stripe->lock);
> +
> +	stripe_key.objectid = stripe->logical;
> +	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset = stripe->num_bytes;
> +
> +	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, raid_stripe,
> +				item_size);
> +	if (ret)
> +		btrfs_abort_transaction(trans, ret);
> +
> +	kfree(raid_stripe);
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> new file mode 100644
> index 000000000000..fdcaad405742
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_RAID_STRIPE_TREE_H
> +#define BTRFS_RAID_STRIPE_TREE_H
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
> +	if (!fs_info->stripe_root)
> +		return false;
> +
> +	// for now
> +	if (type != BTRFS_BLOCK_GROUP_DATA)
> +		return false;

Yay more nitpicking.  Thanks,

Josef
