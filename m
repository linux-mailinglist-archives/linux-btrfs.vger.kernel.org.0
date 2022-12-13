Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2B64B95D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 17:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiLMQOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 11:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiLMQOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 11:14:39 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E1BF2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:14:38 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3b10392c064so199150267b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMazmcjiQAFnDQ9vrChMPkPAoFAMseU+q4kOqhabtTs=;
        b=0cITjzbzacSO35edUk5xXxnDDRB05A95Mg5OavFnA+6mww4euKMW8OMBHl57QWIGzw
         SJYfgbci+leZ0ixgeJgfmcu4EXK5m48MBOvfObCvLPH6q6em55BTYTuGp+5jfXHj25zw
         och6o8X6TjW+x317HEnoXCMrMKaws73N5+eTTIOrPr8JQjDGNozH7ipGHMKzTCV8Ld6u
         6rjJ4T7MGe9alQWkQTAp46zHm9/YyiS0dPbH5ZINto8o9WrkaUA2bBBXnGvD61Lq3L3w
         wSpHUzV7fNWt9PvB0x4kxRLsuKSRYu4SpHfs5qp4qO1mfWO6b1pZlPnrvwtSomEp4bma
         0ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMazmcjiQAFnDQ9vrChMPkPAoFAMseU+q4kOqhabtTs=;
        b=LEZKX3Rh+SqZQvDkq8rnL6oeJLKp7wIVi+cH2vjERyyOfTHrSfyauq5NDKspFJyWty
         dfPZh9qyiXATFoI3qP4X5nsMUqjTR+jOQBKcsBp80yGGr/2S7h88KFQrfHwpRpAzay5o
         IpbB5XcfKA1jFnHhxCMSjDz6/c69ANNucFBQV/5YpgF2pQdb61A+xWhvQ3GbXDhS9/FR
         paNWxskZlwEydta6sxj0nx/wF4TWEaijV5KP6n/z9xEK2X1M0DhjIq3o2pKF49aTWrXC
         rD7SgCFTa9s3QeLZHLP0vHUE56hSf04c3GBTQSYlGRIVjIUSjp2phfwGw9257fpzvhim
         LZqw==
X-Gm-Message-State: ANoB5pljcy1/7HbYt5j8HL3HuqhzcO+gUiybg3Gb1EYjpOloLWmip4nw
        FfM0pdqxm76He7ZF2PzCpybGFJxpoAtSZiVFUNo=
X-Google-Smtp-Source: AA0mqf4d9VtXf27wjGYSJe9/lrp4exYAESP5PVeQvANNGlogt7eCpe7TU1U1NXyWraNERjCGa+VMHA==
X-Received: by 2002:a05:7500:2499:b0:ea:6881:f3c7 with SMTP id ba25-20020a057500249900b000ea6881f3c7mr2103629gab.47.1670948077185;
        Tue, 13 Dec 2022 08:14:37 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006fbaf9c1b70sm8068275qki.133.2022.12.13.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:14:36 -0800 (PST)
Date:   Tue, 13 Dec 2022 11:14:35 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y5ik61/v+1gq9xl/@localhost.localdomain>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 06:22:12AM -0800, Johannes Thumshirn wrote:
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
>  fs/btrfs/Makefile           |   3 +-
>  fs/btrfs/bio.c              |  30 +++++-
>  fs/btrfs/bio.h              |   2 +
>  fs/btrfs/delayed-ref.c      |   5 +-
>  fs/btrfs/disk-io.c          |   3 +
>  fs/btrfs/extent-tree.c      |  49 +++++++++
>  fs/btrfs/fs.h               |   3 +
>  fs/btrfs/inode.c            |   6 ++
>  fs/btrfs/raid-stripe-tree.c | 195 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  69 +++++++++++++
>  fs/btrfs/volumes.c          |   5 +-
>  fs/btrfs/volumes.h          |  12 +--
>  fs/btrfs/zoned.c            |   4 +
>  13 files changed, 376 insertions(+), 10 deletions(-)
>  create mode 100644 fs/btrfs/raid-stripe-tree.c
>  create mode 100644 fs/btrfs/raid-stripe-tree.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 555c962fdad6..63236ae2a87b 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -31,7 +31,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
>  	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
> -	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o
> +	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
> +	   raid-stripe-tree.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 4ccbc120e869..b60a50165703 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -15,6 +15,7 @@
>  #include "rcu-string.h"
>  #include "zoned.h"
>  #include "file-item.h"
> +#include "raid-stripe-tree.h"
>  
>  static struct bio_set btrfs_bioset;
>  static struct bio_set btrfs_clone_bioset;
> @@ -350,6 +351,21 @@ static void btrfs_raid56_end_io(struct bio *bio)
>  	btrfs_put_bioc(bioc);
>  }
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
>  static void btrfs_orig_write_end_io(struct bio *bio)
>  {
>  	struct btrfs_io_stripe *stripe = bio->bi_private;
> @@ -372,6 +388,15 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>  	else
>  		bio->bi_status = BLK_STS_OK;
>  
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
> +	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> +		INIT_WORK(&bbio->raid_stripe_work, btrfs_raid_stripe_update);
> +		schedule_work(&bbio->raid_stripe_work);
> +		return;
> +	}
> +
>  	btrfs_orig_bbio_end_io(bbio);
>  	btrfs_put_bioc(bioc);
>  }
> @@ -383,7 +408,9 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>  	if (bio->bi_status) {
>  		atomic_inc(&stripe->bioc->error);
>  		btrfs_log_dev_io_error(bio, stripe->dev);
> -	}
> +	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> + 	}
>  
>  	/* Pass on control to the original bio this one was cloned from */
>  	bio_endio(stripe->bioc->orig_bio);
> @@ -442,6 +469,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
>  	bio->bi_private = &bioc->stripes[dev_nr];
>  	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
>  	bioc->stripes[dev_nr].bioc = bioc;
> +	bioc->size = bio->bi_iter.bi_size;
>  	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
>  }
>  
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 20105806c8ac..bf5fbc105148 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -58,6 +58,8 @@ struct btrfs_bio {
>  	atomic_t pending_ios;
>  	struct work_struct end_io_work;
>  
> +	struct work_struct raid_stripe_work;
> +
>  	/*
>  	 * This member must come last, bio_alloc_bioset will allocate enough
>  	 * bytes for entire btrfs_bio but relies on bio being last.
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 573ebab886e2..0357f9327cd4 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -14,6 +14,7 @@
>  #include "space-info.h"
>  #include "tree-mod-log.h"
>  #include "fs.h"
> +#include "raid-stripe-tree.h"
>  
>  struct kmem_cache *btrfs_delayed_ref_head_cachep;
>  struct kmem_cache *btrfs_delayed_tree_ref_cachep;
> @@ -640,8 +641,10 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
>  	exist->ref_mod += mod;
>  
>  	/* remove existing tail if its ref_mod is zero */
> -	if (exist->ref_mod == 0)
> +	if (exist->ref_mod == 0) {
> +		btrfs_drop_ordered_stripe(trans->fs_info, exist->bytenr);
>  		drop_delayed_ref(trans, root, href, exist);
> +	}
>  	spin_unlock(&href->lock);
>  	return ret;
>  inserted:
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5784c850a3ec..bdef4e2e4ea3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3033,6 +3033,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  
>  	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
>  	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
> +
> +	rwlock_init(&fs_info->stripe_update_lock);
> +	fs_info->stripe_update_tree = RB_ROOT;
>  }
>  
>  static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 892d78c1853c..de479af062fd 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -43,6 +43,7 @@
>  #include "file-item.h"
>  #include "orphan.h"
>  #include "tree-checker.h"
> +#include "raid-stripe-tree.h"
>  
>  #undef SCRAMBLE_DELAYED_REFS
>  
> @@ -1498,6 +1499,51 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
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
> +	if (!btrfs_stripe_tree_root(fs_info))
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
> +		ASSERT(stripe->num_bytes == node->num_bytes);
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
> @@ -1528,6 +1574,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>  						 flags, ref->objectid,
>  						 ref->offset, &ins,
>  						 node->ref_mod);
> +		if (ret)
> +			return ret;
> +		ret = add_stripe_entry_for_delayed_ref(trans, node);
>  	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
>  		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
>  					     ref->objectid, ref->offset,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index f08b59320645..0dfe8ae2e450 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -780,6 +780,9 @@ struct btrfs_fs_info {
>  	struct lockdep_map btrfs_trans_pending_ordered_map;
>  	struct lockdep_map btrfs_ordered_extent_map;
>  
> +	rwlock_t stripe_update_lock;
> +	struct rb_root stripe_update_tree;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 373b7281f5c7..1299acf52c86 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -70,6 +70,7 @@
>  #include "verity.h"
>  #include "super.h"
>  #include "orphan.h"
> +#include "raid-stripe-tree.h"
>  
>  struct btrfs_iget_args {
>  	u64 ino;
> @@ -9507,6 +9508,11 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
>  	if (qgroup_released < 0)
>  		return ERR_PTR(qgroup_released);
>  
> +	ret = btrfs_insert_preallocated_raid_stripe(inode->root->fs_info,
> +						    start, len);
> +	if (ret)
> +		goto free_qgroup;
> +

Sorry I didn't notice this until I was looking at later patches.  We insert the
preallocated raid stripe here, but if we fail at any point along the way we
still have this raid stripe entry sitting around.  Will this accidentally get
inserted later and mess everything up?  There are failures down this way that
don't result in an abort, but probably should, or at the very least drop this
raid stripe if we haven't modified anything yet.  Thanks,

Josef
