Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAB6688C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 01:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjAMA4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 19:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjAMAzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 19:55:50 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432C10DE
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 16:55:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F0955C00CC;
        Thu, 12 Jan 2023 19:55:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 12 Jan 2023 19:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1673571331; x=1673657731; bh=3SCX+Enmdk
        Kv/dtAvW94vvK40rTIBkC7Ii6SP/kG1Tg=; b=WRv7fWi3FG9kKrvnyCJFfgZreR
        QbyNtqa+Rp3RvxNlJTUkxgHGe68U3KMoEbIMqgMfpc9DLfGGC29PNjuJ4mCooXRj
        1afDuHh/CNhdeLAgloMrvs3V4JBJSSciLZrEbED1Wz/RX/UVCQYx2x3HGvtvxyh0
        4LAIgbphdSlj/rP4okqxoo3nRg8KGuFrp5KRcTOuCh81w4FGbxZuSe9S1lAUz7rh
        MlMi5KQqKsxa19jYgFq6JJCYjrHOr5agZ82iXRoDF/DuV2yBo9e2jbnnHKkWK1Ru
        b2YUOEBL0n6+A3AF+QjZ9oOtIjhwVESx/xyE1YtFSKKuT7PbWqrvkn+xHRmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673571331; x=1673657731; bh=3SCX+EnmdkKv/dtAvW94vvK40rTI
        BkC7Ii6SP/kG1Tg=; b=BI5e6UlP9F9adEBM/RumP/WvYgBHwV/Pkr/hctnNy0ec
        ud7+TUheeiq0PJdKE6lp5c6ktGjnYLcSvud11FVv3b2aqiq0c4rn6IzmIQGEHLnj
        i//J3ZzBHAX7drDZZD1PzSqL2tynXMxsdQPS887esJ3YApeMb7uwn4WLH23mEIXp
        NJfHW3/KKCU1JFY9JQte99nHFMkY1b7u1TU1EhdG+pihyaw5zBebWHJ1Q3TpFBeF
        uJk5EpDIO70OGd8fVqVDvsRAcLl9RAgA7Izwc8vH2231xakYisXjnF2y2Y39A827
        HHVAqvbGxMrp1ignVPOJzcgIss6xl8riwrWlxrAn/A==
X-ME-Sender: <xms:A6zAY04Uz85V9kEKVuWRZ3lGaum1c6Er9rkRm0qxuJ6ODLTNveWyTw>
    <xme:A6zAY17VR76QOHVqiodAckjJ5S7e5ZhvJSo35wIKCNhuLDlfTUf9lDt6SMP-JhwWZ
    9G2HHVeu8ns8wuch68>
X-ME-Received: <xmr:A6zAYzelULxkzZKaNyrt1Wai2DnJtUt4eYrtehjXeVj5X4HVZV4JFRo6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:A6zAY5IuXei0KDxqX_yb85iATnrDBsjCrWNnaK73qvJz1r_ZqYpdfQ>
    <xmx:A6zAY4LEX26MkHe1R2BAcoRKVBSZkGqMt9-_Gcnhk2TL9D489gzX2A>
    <xmx:A6zAY6wTEm6Dnv80N-jFeC31Djx-mY_9Fm2QdZuA_2WWpRamPFpYGQ>
    <xmx:A6zAYyySQo8nC7JKxcQQvmWSaClDyrKAxAtmBBnPrEKvNDLTbZEL5Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 19:55:30 -0500 (EST)
Date:   Thu, 12 Jan 2023 16:55:29 -0800
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: update fs features sysfs directory
 asynchronously
Message-ID: <Y8CsAV+xNYg4z8AK@zen>
References: <710733d9fd83b0cc9c7bcf254771add98801b51a.1673513097.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710733d9fd83b0cc9c7bcf254771add98801b51a.1673513097.git.wqu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 12, 2023 at 04:48:18PM +0800, Qu Wenruo wrote:
> [BUG]
> From the introduce of mounted fs feature sysfs interface
> (/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
> updated.
> 
> Thus for the following case, that directory will not show the new
> features like RAID56:
> 
>  # mkfs.btrfs -f $dev1 $dev2 $dev3
>  # mount $dev1 $mnt
>  # btrfs balance start -f -mconvert=raid5 $mnt
>  # ls /sys/fs/btrfs/$uuid/features/
>  extended_iref  free_space_tree  no_holes  skinny_metadata
> 
> While after unmount and mount, we got the correct features:
> 
>  # umount $mnt
>  # mount $dev1 $mnt
>  # ls /sys/fs/btrfs/$uuid/features/
>  extended_iref  free_space_tree  no_holes  raid56 skinny_metadata

Reproduced and confirmed the fix works.

> 
> [CAUSE]
> Because we never really try to update the content of per-fs features/
> directory.
> 
> We had an attempt to update the features directory dynamically in commit
> 14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
> files"), but unfortunately it get reverted in commit e410e34fad91
> ("Revert "btrfs: synchronize incompat feature bits with sysfs files"").
> 
> The exported by never utilized function, btrfs_sysfs_feature_update() is
> the leftover of such attempt.
> 
> The problem in the original patch is, in the context of
> btrfs_create_chunk(), we can not afford to update the sysfs group.
> 
> As even if we go sysfs_update_group(), new files will need extra memory
> allocation, and we have no way to specify the sysfs update to go
> GFP_NOFS.
> 
> [FIX]
> This patch will address the old problem by doing asynchronous sysfs
> update in cleaner thread.
> 
> This involves the following changes:
> 
> - Allow btrfs_(set|clear)_fs_(incompat|compat_ro) functions to return
>   bool
>   This allows us to know if we changed the feature.
> 
> - Introduce a new function btrfs_async_update_feature_change() for
>   callsites which change the fs feature
>   The function itself just set BTRFS_FS_FEATURE_CHANGING flag, and
>   wake up the cleaner kthread.

Rather than detect the return value at every callsite of set|clear
functions, why not incorporate triggering the async update into the
set|clear functions themselves? Assuming that isn't wrong, it also
future proofs it against someone forgetting to trigger the async update
for some future compat/incompat update.

If there are callsites where we don't want to trigger an update, it may
be helpful to create a new wrapper with an evocative name to
differentiate between the two cases?

I quite like this patch, otherwise. It's great to keep sysfs synced up
and accurate.

Thanks,
Boris

> 
> - Update btrfs_sysfs_feature_update() to use sysfs_update_group()
>   And drop unnecessary arguments.
> 
> - Call btrfs_sysfs_feature_update() in cleaner_kthread
>   If we have the BTRFS_FS_FEATURE_CHANGING flag set.
> 
> By this, all the previously dangerous call sites like
> btrfs_create_chunk() can just call the new
> btrfs_async_update_feature_change() and call it a day.
> 
> The real work happens at cleaner_kthread, thus we pay the cost of
> delaying the update to sysfs directory.
> But considering sysfs features is not a time-critical feature, and even
> with delayed operation, above balance has updated the features directory
> just after the balance finished.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix an unused variable in btrfs_parse_options()
>   Add the missing btrfs_async_update_feature_change() call.
> ---
>  fs/btrfs/block-group.c     |  9 +++++++--
>  fs/btrfs/defrag.c          | 10 ++++++++--
>  fs/btrfs/disk-io.c         |  3 +++
>  fs/btrfs/free-space-tree.c |  2 ++
>  fs/btrfs/fs.c              | 28 ++++++++++++++++++++--------
>  fs/btrfs/fs.h              | 32 +++++++++++++++++++++++++++-----
>  fs/btrfs/ioctl.c           |  3 ++-
>  fs/btrfs/props.c           |  7 +++++--
>  fs/btrfs/super.c           |  9 +++++++--
>  fs/btrfs/sysfs.c           | 26 ++++++--------------------
>  fs/btrfs/sysfs.h           |  3 +--
>  fs/btrfs/verity.c          |  3 ++-
>  fs/btrfs/volumes.c         |  6 ++++--
>  13 files changed, 94 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e90800388a41..32f56e14f53a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -828,6 +828,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>  	    (flags & BTRFS_BLOCK_GROUP_RAID1C4)) {
>  		struct list_head *head = &fs_info->space_info;
>  		struct btrfs_space_info *sinfo;
> +		bool feature_changed = false;
>  
>  		list_for_each_entry_rcu(sinfo, head, list) {
>  			down_read(&sinfo->groups_sem);
> @@ -842,9 +843,13 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>  			up_read(&sinfo->groups_sem);
>  		}
>  		if (!found_raid56)
> -			btrfs_clear_fs_incompat(fs_info, RAID56);
> +			feature_changed |= btrfs_clear_fs_incompat(fs_info,
> +								   RAID56);
>  		if (!found_raid1c34)
> -			btrfs_clear_fs_incompat(fs_info, RAID1C34);
> +			feature_changed |= btrfs_clear_fs_incompat(fs_info,
> +								   RAID1C34);
> +		if (feature_changed)
> +			btrfs_async_update_feature_change(fs_info);
>  	}
>  }
>  
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 8065341d831a..00dd3dd5b256 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1336,6 +1336,8 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  	 */
>  	range->start = cur;
>  	if (sectors_defragged) {
> +		bool feature_changed = false;
> +
>  		/*
>  		 * We have defragged some sectors, for compression case they
>  		 * need to be written back immediately.
> @@ -1347,9 +1349,13 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  				filemap_flush(inode->i_mapping);
>  		}
>  		if (range->compress_type == BTRFS_COMPRESS_LZO)
> -			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> +			feature_changed |= btrfs_set_fs_incompat(fs_info,
> +								 COMPRESS_LZO);
>  		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
> -			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> +			feature_changed |= btrfs_set_fs_incompat(fs_info,
> +								 COMPRESS_ZSTD);
> +		if (feature_changed)
> +			btrfs_async_update_feature_change(fs_info);
>  		ret = sectors_defragged;
>  	}
>  	if (do_compress) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7586a8e9b718..a6f89ac1c086 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1914,6 +1914,9 @@ static int cleaner_kthread(void *arg)
>  			goto sleep;
>  		}
>  
> +		if (test_and_clear_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags))
> +			btrfs_sysfs_feature_update(fs_info);
> +
>  		btrfs_run_delayed_iputs(fs_info);
>  
>  		again = btrfs_clean_one_deleted_snapshot(fs_info);
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index c667e878ef1a..1a001de86923 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1195,6 +1195,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
>  
>  	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
>  	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
> +	btrfs_async_update_feature_change(fs_info);
>  	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
>  	ret = btrfs_commit_transaction(trans);
>  
> @@ -1270,6 +1271,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
>  
>  	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE);
>  	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
> +	btrfs_async_update_feature_change(fs_info);
>  
>  	ret = clear_free_space_tree(trans, free_space_root);
>  	if (ret)
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 5553e1f8afe8..a02e6b6cb97c 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -5,15 +5,17 @@
>  #include "fs.h"
>  #include "accessors.h"
>  
> -void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>  			     const char *name)
>  {
>  	struct btrfs_super_block *disk_super;
> +	bool changed;
>  	u64 features;
>  
>  	disk_super = fs_info->super_copy;
>  	features = btrfs_super_incompat_flags(disk_super);
> -	if (!(features & flag)) {
> +	changed = !(features & flag);
> +	if (changed) {
>  		spin_lock(&fs_info->super_lock);
>  		features = btrfs_super_incompat_flags(disk_super);
>  		if (!(features & flag)) {
> @@ -25,17 +27,20 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>  		}
>  		spin_unlock(&fs_info->super_lock);
>  	}
> +	return changed;
>  }
>  
> -void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>  			       const char *name)
>  {
>  	struct btrfs_super_block *disk_super;
> +	bool changed;
>  	u64 features;
>  
>  	disk_super = fs_info->super_copy;
>  	features = btrfs_super_incompat_flags(disk_super);
> -	if (features & flag) {
> +	changed = features & flag;
> +	if (changed) {
>  		spin_lock(&fs_info->super_lock);
>  		features = btrfs_super_incompat_flags(disk_super);
>  		if (features & flag) {
> @@ -47,17 +52,20 @@ void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>  		}
>  		spin_unlock(&fs_info->super_lock);
>  	}
> +	return changed;
>  }
>  
> -void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>  			      const char *name)
>  {
>  	struct btrfs_super_block *disk_super;
> +	bool changed;
>  	u64 features;
>  
>  	disk_super = fs_info->super_copy;
>  	features = btrfs_super_compat_ro_flags(disk_super);
> -	if (!(features & flag)) {
> +	changed = !(features & flag);
> +	if (changed) {
>  		spin_lock(&fs_info->super_lock);
>  		features = btrfs_super_compat_ro_flags(disk_super);
>  		if (!(features & flag)) {
> @@ -69,17 +77,20 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>  		}
>  		spin_unlock(&fs_info->super_lock);
>  	}
> +	return changed;
>  }
>  
> -void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>  				const char *name)
>  {
>  	struct btrfs_super_block *disk_super;
> +	bool changed;
>  	u64 features;
>  
>  	disk_super = fs_info->super_copy;
>  	features = btrfs_super_compat_ro_flags(disk_super);
> -	if (features & flag) {
> +	changed = features & flag;
> +	if (changed) {
>  		spin_lock(&fs_info->super_lock);
>  		features = btrfs_super_compat_ro_flags(disk_super);
>  		if (features & flag) {
> @@ -91,4 +102,5 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>  		}
>  		spin_unlock(&fs_info->super_lock);
>  	}
> +	return changed;
>  }
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 37b86acfcbcf..b6f2201a1571 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -130,6 +130,12 @@ enum {
>  	BTRFS_FS_32BIT_ERROR,
>  	BTRFS_FS_32BIT_WARN,
>  #endif
> +
> +	/*
> +	 * Indicate if we have some features changed, this is mostly for
> +	 * cleaner thread to update the sysfs interface.
> +	 */
> +	BTRFS_FS_FEATURE_CHANGED,
>  };
>  
>  /*
> @@ -868,14 +874,18 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
>  void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
>  			  enum btrfs_exclusive_operation op);
>  
> -/* Compatibility and incompatibility defines */
> -void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +/*
> + * Compatibility and incompatibility defines.
> + *
> + * Return value is whether the operation changed the specified feature.
> + */
> +bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>  			     const char *name);
> -void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>  			       const char *name);
> -void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>  			      const char *name);
> -void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>  				const char *name);
>  
>  #define __btrfs_fs_incompat(fs_info, flags)				\
> @@ -952,6 +962,18 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>  	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
>  }
>  
> +/*
> + * Called when btrfs has feature changed.
> + *
> + * The real work is delayed into cleaner.
> + */
> +static inline void btrfs_async_update_feature_change(struct btrfs_fs_info *fs_info)
> +{
> +	set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
> +	if (fs_info->cleaner_kthread)
> +		wake_up_process(fs_info->cleaner_kthread);
> +}
> +
>  #define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
>  						   &(fs_info)->fs_state)))
>  #define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info)				\
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7e348bd2ccde..f11443578acd 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2942,7 +2942,8 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
>  	btrfs_mark_buffer_dirty(path->nodes[0]);
>  	btrfs_release_path(path);
>  
> -	btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL);
> +	if (btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL))
> +		btrfs_async_update_feature_change(fs_info);
>  	btrfs_end_transaction(trans);
>  out_free:
>  	btrfs_put_root(new_root);
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index 0755af0e53e3..114d567043d7 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -302,6 +302,7 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>  				  size_t len)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	bool feature_changed = false;
>  	int type;
>  
>  	/* Reset to defaults */
> @@ -324,12 +325,12 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>  
>  	if (!strncmp("lzo", value, 3)) {
>  		type = BTRFS_COMPRESS_LZO;
> -		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> +		feature_changed |= btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
>  	} else if (!strncmp("zlib", value, 4)) {
>  		type = BTRFS_COMPRESS_ZLIB;
>  	} else if (!strncmp("zstd", value, 4)) {
>  		type = BTRFS_COMPRESS_ZSTD;
> -		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> +		feature_changed |= btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -337,6 +338,8 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>  	BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
>  	BTRFS_I(inode)->flags |= BTRFS_INODE_COMPRESS;
>  	BTRFS_I(inode)->prop_compress = type;
> +	if (feature_changed)
> +		btrfs_async_update_feature_change(fs_info);
>  
>  	return 0;
>  }
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 433ce221dc5c..c1992aa46d80 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -316,6 +316,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  	bool saved_compress_force;
>  	int no_compress = 0;
>  	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
> +	bool feature_changed = false;
>  
>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>  		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> @@ -431,7 +432,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  				btrfs_set_opt(info->mount_opt, COMPRESS);
>  				btrfs_clear_opt(info->mount_opt, NODATACOW);
>  				btrfs_clear_opt(info->mount_opt, NODATASUM);
> -				btrfs_set_fs_incompat(info, COMPRESS_LZO);
> +				feature_changed |=
> +					btrfs_set_fs_incompat(info, COMPRESS_LZO);
>  				no_compress = 0;
>  			} else if (strncmp(args[0].from, "zstd", 4) == 0) {
>  				compress_type = "zstd";
> @@ -443,7 +445,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  				btrfs_set_opt(info->mount_opt, COMPRESS);
>  				btrfs_clear_opt(info->mount_opt, NODATACOW);
>  				btrfs_clear_opt(info->mount_opt, NODATASUM);
> -				btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
> +				feature_changed |=
> +					btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
>  				no_compress = 0;
>  			} else if (strncmp(args[0].from, "no", 2) == 0) {
>  				compress_type = "no";
> @@ -827,6 +830,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  		ret = -EINVAL;
>  
>  	}
> +	if (!ret && feature_changed)
> +		btrfs_async_update_feature_change(info);
>  	if (!ret)
>  		ret = btrfs_check_mountopts_zoned(info);
>  	if (!ret && !remounting) {
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 45615ce36498..f86c107ea2e4 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2272,36 +2272,22 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>   * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>   * values in superblock. Call after any changes to incompat/compat_ro flags
>   */
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set)
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_fs_devices *fs_devs;
>  	struct kobject *fsid_kobj;
> -	u64 __maybe_unused features;
> -	int __maybe_unused ret;
> +	int ret;
>  
>  	if (!fs_info)
>  		return;
>  
> -	/*
> -	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
> -	 * safe when called from some contexts (eg. balance)
> -	 */
> -	features = get_features(fs_info, set);
> -	ASSERT(bit & supported_feature_masks[set]);
> -
> -	fs_devs = fs_info->fs_devices;
> -	fsid_kobj = &fs_devs->fsid_kobj;
> +	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>  
>  	if (!fsid_kobj->state_initialized)
>  		return;
>  
> -	/*
> -	 * FIXME: this is too heavy to update just one value, ideally we'd like
> -	 * to use sysfs_update_group but some refactoring is needed first.
> -	 */
> -	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
> -	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
> +	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
> +	if (ret < 0)
> +		btrfs_err(fs_info, "failed to update features: %d", ret);
>  }
>  
>  int __init btrfs_init_sysfs(void)
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index bacef43f7267..86c7eef12873 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -19,8 +19,7 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device);
>  int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
>  void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
>  void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set);
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info);
>  void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
>  
>  int __init btrfs_init_sysfs(void);
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index bf9eb693a6a7..998884b57216 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -561,7 +561,8 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
>  	if (ret)
>  		goto end_trans;
>  	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
> -	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
> +	if (btrfs_set_fs_compat_ro(root->fs_info, VERITY))
> +		btrfs_async_update_feature_change(root->fs_info);
>  end_trans:
>  	btrfs_end_transaction(trans);
>  out:
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bcfef75b97da..2ae77516ca3f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5031,7 +5031,8 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
>  	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
>  		return;
>  
> -	btrfs_set_fs_incompat(info, RAID56);
> +	if (btrfs_set_fs_incompat(info, RAID56))
> +		btrfs_async_update_feature_change(info);
>  }
>  
>  static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
> @@ -5039,7 +5040,8 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
>  	if (!(type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)))
>  		return;
>  
> -	btrfs_set_fs_incompat(info, RAID1C34);
> +	if (btrfs_set_fs_incompat(info, RAID1C34))
> +		btrfs_async_update_feature_change(info);
>  }
>  
>  /*
> -- 
> 2.39.0
> 
