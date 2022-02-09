Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30A4AF8A1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiBIRjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiBIRjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 12:39:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA9C05CB82
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:39:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E7F561A97
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 17:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38455C340E7;
        Wed,  9 Feb 2022 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644428373;
        bh=vO5eOEtfi2EOkoZlfUvwK0GMgRQkLCIpEpbdzlKXOMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpNqNnjo4/dCl2tlZJ0A+a2d6++y2arPzEN+jTY2NYv3qYsHV+zNt5/gd7Q0a8MNJ
         bnQvfMLrVc15ptadomseGHeZx0e4OyC43rfYNaWq+l0yniLXDbHPgcKZI2psCJPAbW
         4tNUYsgWJV40NYHcK50/Do/0omUeX6HV6xBYI8J6JSB3pJRM7aWeK70m6R1PqKTtry
         3Kjw2oAXDxUDIToPAlCYuAoN8qioy7IPheyBQTeItP1bUnaAGqAErXpjQ+kVWoghRi
         WgAh5wz9KYdzSMeeNRQgomjLyTfCSo6bnMcBwkXFIG89XLEamYTtW4VbNvsj7yJJTz
         n+9tlCiINFEqw==
Date:   Wed, 9 Feb 2022 17:39:30 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] btrfs: make autodefrag to defrag small writes
 without rescanning the whole file
Message-ID: <YgP8UocVo/yMT2Pj@debian9.Home>
References: <cover.1644398069.git.wqu@suse.com>
 <fc9f897e0859cccf90c33a7a609dc0a2e96ce3c1.1644398069.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc9f897e0859cccf90c33a7a609dc0a2e96ce3c1.1644398069.git.wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 09, 2022 at 05:23:14PM +0800, Qu Wenruo wrote:
> Previously autodefrag works by scanning the whole file with a minimal
> generation threshold.
> 
> Although we have various optimization to skip ranges which don't meet
> the generation requirement, it can still waste some time on scanning the
> whole file, especially if the inode got an almost full overwrite.
> 
> To optimize the autodefrag even further, here we use
> inode_defrag::targets extent io tree to do accurate defrag targets
> search.
> 
> Now we re-use EXTENT_DIRTY flag to mark the small writes, and only
> defrag those ranges.
> 
> This rework brings the following behavior change:
> 
> - Only small write ranges will be defragged
>   Previously if there are new writes after the small writes, but it's
>   not reaching the extent size threshold, it will be defragged.
> 
>   This is because we have a gap between autodefrag extent size threshold
>   and inode_should_defrag() extent size threshold.
>   (uncompressed 64K / compressed 16K vs 256K)
> 
>   Now we won't need to bother the gap, and can only defrag the small
>   writes.
> 
> - Enlarged critical section for fs_info::defrag_inodes_lock
>   The critical section will include extent io tree update, thus
>   it will be larger, and fs_info::defrag_inodes_lock will be upgraded
>   to mutex to handle the possible sleep.
> 
>   This would slightly increase the overhead for autodefrag, but I don't
>   have a benchmark for it.
> 
> - Extra memory usage for autodefrag
>   Now we need to keep an extent io tree for each target inode.
> 
> - No inode re-queue if there are large sectors to defrag
>   Previously if we have defragged 1024 sectors, we will re-queue the
>   inode, and mostly pick another inode to defrag in next run.
> 
>   Now we will defrag the inode until we finished it.
>   The context switch will be triggered by the cond_resche() in
>   btrfs_defrag_file() thus it won't hold CPU for too long.

So there's a huge difference in this last aspect.

Before, if we defrag one range, we requeue the inode for autodefrag - but
we only run the defrag on the next time the cleaner kthread runs. Instead
of defragging multiple ranges of the file in the same run, we move to the
next inode at btrfs_run_defrag_inodes().

With this change, it will defrag all ranges in the same cleaner run. If there
are writes being done to the file all the time, the cleaner will spend a lot of
time defragging ranges for the same file in the same run. That delays other
important work the cleaner does - running delayed iputs, removing empty
block groups, deleting snapshots/subvolumes, etc.

That can have a huge impact system wide.

How have you tested this?

Some user workload like the one reported here:

https://lore.kernel.org/linux-btrfs/KTVQ6R.R75CGDI04ULO2@gmail.com/

Would be a good test. Downloading from Steam is probably not something
we can do, as it probably requires some paid scrubscription.

But something that may be close enough is downloading several large
torrent files and see how it behaves. Things like downloading several
DVD iso images of Linux distros from torrents, in a way that the sum of
the file sizes is much larger then the total RAM of the system. That should
cause a good amount of work that is "real world", and then try later mixing
that with snapshot/subvolume deletions as well and see if it breaks badly
or causes a huge performance problem.

Some more comments inline below.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h   |   4 +-
>  fs/btrfs/disk-io.c |   2 +-
>  fs/btrfs/file.c    | 209 ++++++++++++++++++++++++---------------------
>  fs/btrfs/inode.c   |   2 +-
>  4 files changed, 116 insertions(+), 101 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a5cf845cbe88..9228e8d39516 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -897,7 +897,7 @@ struct btrfs_fs_info {
>  	struct btrfs_free_cluster meta_alloc_cluster;
>  
>  	/* auto defrag inodes go here */
> -	spinlock_t defrag_inodes_lock;
> +	struct mutex defrag_inodes_lock;
>  	struct rb_root defrag_inodes;
>  	atomic_t defrag_running;
>  
> @@ -3356,7 +3356,7 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
>  /* file.c */
>  int __init btrfs_auto_defrag_init(void);
>  void __cold btrfs_auto_defrag_exit(void);
> -int btrfs_add_inode_defrag(struct btrfs_inode *inode);
> +int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start, u64 len);
>  int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
>  void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
>  int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b6a81c39d5f4..87782d1120e7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3126,7 +3126,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	spin_lock_init(&fs_info->trans_lock);
>  	spin_lock_init(&fs_info->fs_roots_radix_lock);
>  	spin_lock_init(&fs_info->delayed_iput_lock);
> -	spin_lock_init(&fs_info->defrag_inodes_lock);
>  	spin_lock_init(&fs_info->super_lock);
>  	spin_lock_init(&fs_info->buffer_lock);
>  	spin_lock_init(&fs_info->unused_bgs_lock);
> @@ -3140,6 +3139,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	mutex_init(&fs_info->reloc_mutex);
>  	mutex_init(&fs_info->delalloc_root_mutex);
>  	mutex_init(&fs_info->zoned_meta_io_lock);
> +	mutex_init(&fs_info->defrag_inodes_lock);
>  	seqlock_init(&fs_info->profiles_lock);
>  
>  	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 2d49336b0321..da6e29a6f387 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -34,7 +34,7 @@
>  static struct kmem_cache *btrfs_inode_defrag_cachep;
>  
>  /* Reuse DIRTY flag for autodefrag */
> -#define EXTENT_FLAG_AUTODEFRAG	EXTENT_FLAG_DIRTY
> +#define EXTENT_FLAG_AUTODEFRAG	EXTENT_DIRTY
>  
>  /*
>   * when auto defrag is enabled we
> @@ -119,7 +119,6 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
>  			return -EEXIST;
>  		}
>  	}
> -	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
>  	rb_link_node(&defrag->rb_node, parent, p);
>  	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
>  	return 0;
> @@ -136,81 +135,80 @@ static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
>  	return 1;
>  }
>  
> +static struct inode_defrag *find_inode_defrag(struct btrfs_fs_info *fs_info,
> +					      u64 root, u64 ino)
> +{
> +
> +	struct inode_defrag *entry = NULL;
> +	struct inode_defrag tmp;
> +	struct rb_node *p;
> +	struct rb_node *parent = NULL;

Neither entry nor parent need to be initialized.

> +	int ret;
> +
> +	tmp.ino = ino;
> +	tmp.root = root;
> +
> +	p = fs_info->defrag_inodes.rb_node;
> +	while (p) {
> +		parent = p;
> +		entry = rb_entry(parent, struct inode_defrag, rb_node);
> +
> +		ret = __compare_inode_defrag(&tmp, entry);
> +		if (ret < 0)
> +			p = parent->rb_left;
> +		else if (ret > 0)
> +			p = parent->rb_right;
> +		else
> +			return entry;
> +	}

It's pointless to have "parent" and "p", one of them is enough.

> +	return NULL;
> +}
> +
>  /*
>   * insert a defrag record for this inode if auto defrag is
>   * enabled
>   */
> -int btrfs_add_inode_defrag(struct btrfs_inode *inode)
> +int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start, u64 len)
>  {
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	struct inode_defrag *defrag;
> +	struct inode_defrag *prealloc;
> +	struct inode_defrag *found;
> +	bool release = true;
>  	int ret;
>  
>  	if (!__need_auto_defrag(fs_info))
>  		return 0;
>  
> -	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
> -		return 0;
> -
> -	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
> -	if (!defrag)
> +	prealloc = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
> +	if (!prealloc)
>  		return -ENOMEM;

So now everytime this is called, it will allocate memory, even if the the
inode is already marked for defrag.

Given that this function is called when running delalloc, this can cause
a lot of extra memory allocations. They come from a dedicated slab, but it
still might have a non-negligible impact.

>  
> -	defrag->ino = btrfs_ino(inode);
> -	defrag->transid = inode->root->last_trans;
> -	defrag->root = root->root_key.objectid;
> -	extent_io_tree_init(fs_info, &defrag->targets, IO_TREE_AUTODEFRAG, NULL);
> -
> -	spin_lock(&fs_info->defrag_inodes_lock);
> -	if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags)) {
> -		/*
> -		 * If we set IN_DEFRAG flag and evict the inode from memory,
> -		 * and then re-read this inode, this new inode doesn't have
> -		 * IN_DEFRAG flag. At the case, we may find the existed defrag.
> -		 */
> -		ret = __btrfs_add_inode_defrag(inode, defrag);
> -		if (ret) {
> -			extent_io_tree_release(&defrag->targets);
> -			kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> -		}
> -	} else {
> -		extent_io_tree_release(&defrag->targets);
> -		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> +	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
> +	prealloc->ino = btrfs_ino(inode);
> +	prealloc->transid = inode->root->last_trans;
> +	prealloc->root = root->root_key.objectid;
> +	extent_io_tree_init(fs_info, &prealloc->targets, IO_TREE_AUTODEFRAG, NULL);
> +
> +	mutex_lock(&fs_info->defrag_inodes_lock);
> +	found = find_inode_defrag(fs_info, prealloc->root, prealloc->ino);
> +	if (!found) {
> +		ret = __btrfs_add_inode_defrag(inode, prealloc);
> +		/* Since we didn't find one previously, the insert must success */
> +		ASSERT(!ret);
> +		found = prealloc;
> +		release = false;
> +	}
> +	set_extent_bits(&found->targets, start, start + len - 1,
> +			EXTENT_FLAG_AUTODEFRAG);

So this can end using a lot of memory and resulting in a deep rbtree.
It's not uncommon to have very large files with random IO happening very
frequently, each one would result in allocating one extent state record
for the tree.

Multiply this by N active files in a system, and it can quickly have a
huge impact on used memory.

Also, if a memory allocation triggers reclaim, it will slow down and
increase the amount of time other tasks wait for the mutex. As the rbtree
that the io tree uses gets larger and larger, it also increases more and
more the critical section's duration.

This means writeback for other inodes is now waiting for a longer period,
as well as the cleaner kthread, which runs autodefrag. Blocking the cleaner
for longer means we are delaying other important work - running delayed
iputs, deleting snapshots/subvolumes, removing empty block groups, and
whatever else the cleaner kthread does besides running autodefrag.

So it can have a very high impact on the system overall.

> +	mutex_unlock(&fs_info->defrag_inodes_lock);
> +	if (release) {
> +		extent_io_tree_release(&prealloc->targets);
> +		kmem_cache_free(btrfs_inode_defrag_cachep, prealloc);
>  	}
> -	spin_unlock(&fs_info->defrag_inodes_lock);
>  	return 0;
>  }
>  
> -/*
> - * Requeue the defrag object. If there is a defrag object that points to
> - * the same inode in the tree, we will merge them together (by
> - * __btrfs_add_inode_defrag()) and free the one that we want to requeue.
> - */
> -static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
> -				       struct inode_defrag *defrag)
> -{
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	int ret;
> -
> -	if (!__need_auto_defrag(fs_info))
> -		goto out;
> -
> -	/*
> -	 * Here we don't check the IN_DEFRAG flag, because we need merge
> -	 * them together.
> -	 */
> -	spin_lock(&fs_info->defrag_inodes_lock);
> -	ret = __btrfs_add_inode_defrag(inode, defrag);
> -	spin_unlock(&fs_info->defrag_inodes_lock);
> -	if (ret)
> -		goto out;
> -	return;
> -out:
> -	extent_io_tree_release(&defrag->targets);
> -	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> -}
> -
>  /*
>   * pick the defragable inode that we want, if it doesn't exist, we will get
>   * the next one.
> @@ -227,7 +225,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
>  	tmp.ino = ino;
>  	tmp.root = root;
>  
> -	spin_lock(&fs_info->defrag_inodes_lock);
> +	mutex_lock(&fs_info->defrag_inodes_lock);
>  	p = fs_info->defrag_inodes.rb_node;
>  	while (p) {
>  		parent = p;
> @@ -252,7 +250,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
>  out:
>  	if (entry)
>  		rb_erase(parent, &fs_info->defrag_inodes);
> -	spin_unlock(&fs_info->defrag_inodes_lock);
> +	mutex_unlock(&fs_info->defrag_inodes_lock);
>  	return entry;
>  }
>  
> @@ -261,7 +259,7 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
>  	struct inode_defrag *defrag;
>  	struct rb_node *node;
>  
> -	spin_lock(&fs_info->defrag_inodes_lock);
> +	mutex_lock(&fs_info->defrag_inodes_lock);
>  	node = rb_first(&fs_info->defrag_inodes);
>  	while (node) {
>  		rb_erase(node, &fs_info->defrag_inodes);
> @@ -269,21 +267,59 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
>  		extent_io_tree_release(&defrag->targets);
>  		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>  
> -		cond_resched_lock(&fs_info->defrag_inodes_lock);
> -
>  		node = rb_first(&fs_info->defrag_inodes);
>  	}
> -	spin_unlock(&fs_info->defrag_inodes_lock);
> +	mutex_unlock(&fs_info->defrag_inodes_lock);
>  }
>  
>  #define BTRFS_DEFRAG_BATCH	1024
> +static int defrag_one_range(struct btrfs_inode *inode, u64 start, u64 len,
> +			    u64 newer_than)
> +{
> +	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	u64 cur = start;
> +	int ret = 0;
> +
> +	while (cur < start + len) {
> +		struct btrfs_defrag_ctrl ctrl = { 0 };
> +
> +		ctrl.start = cur;
> +		ctrl.len = start + len - cur;
> +		ctrl.newer_than = newer_than;
> +		ctrl.extent_thresh = SZ_256K;
> +		ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
> +
> +		sb_start_write(fs_info->sb);
> +		ret = btrfs_defrag_file(&inode->vfs_inode, NULL, &ctrl);
> +		sb_end_write(fs_info->sb);
> +
> +		/* The range is beyond isize, we can safely exit */
> +		if (ret == -EINVAL) {

This is a bit odd. I understand this is because the io tree requires ranges
to be sector aligned, so this should trigger only for inodes with an i_size that
is not sector size aligned.

Assuming every -EINVAL is because of that, makes it a bit fragile.

setting ctrl.len to min(i_size_read(inode) - start, start + len - cur) and
then treating all errors the same way, makes it more bullet proof.

> +			ret = 0;
> +			break;
> +		}
> +		if (ret < 0)
> +			break;
> +
> +		/*
> +		 * Even we didn't defrag anything, the last_scanned should have
> +		 * been increased.
> +		 */
> +		ASSERT(ctrl.last_scanned > cur);
> +		cur = ctrl.last_scanned;
> +	}
> +	return ret;
> +}
>  
>  static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
>  				    struct inode_defrag *defrag)
>  {
>  	struct btrfs_root *inode_root;
>  	struct inode *inode;
> -	struct btrfs_defrag_ctrl ctrl = {};
> +	struct extent_state *cached = NULL;
> +	u64 cur = 0;
> +	u64 found_start;
> +	u64 found_end;
>  	int ret;
>  
>  	/* get the inode */
> @@ -300,40 +336,19 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
>  		goto cleanup;
>  	}
>  
> -	/* do a chunk of defrag */
> -	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
> -	ctrl.len = (u64)-1;
> -	ctrl.start = defrag->last_offset;
> -	ctrl.newer_than = defrag->transid;
> -	ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
> -
> -	sb_start_write(fs_info->sb);
> -	ret = btrfs_defrag_file(inode, NULL, &ctrl);
> -	sb_end_write(fs_info->sb);
> -	/*
> -	 * if we filled the whole defrag batch, there
> -	 * must be more work to do.  Queue this defrag
> -	 * again
> -	 */
> -	if (ctrl.sectors_defragged == BTRFS_DEFRAG_BATCH) {
> -		defrag->last_offset = ctrl.last_scanned;
> -		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
> -	} else if (defrag->last_offset && !defrag->cycled) {
> -		/*
> -		 * we didn't fill our defrag batch, but
> -		 * we didn't start at zero.  Make sure we loop
> -		 * around to the start of the file.
> -		 */
> -		defrag->last_offset = 0;
> -		defrag->cycled = 1;
> -		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
> -	} else {
> -		extent_io_tree_release(&defrag->targets);
> -		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> +	while (!find_first_extent_bit(&defrag->targets,
> +				cur, &found_start, &found_end,
> +				EXTENT_FLAG_AUTODEFRAG, &cached)) {
> +		clear_extent_bit(&defrag->targets, found_start,
> +				 found_end, EXTENT_FLAG_AUTODEFRAG, 0, 0, &cached);
> +		ret = defrag_one_range(BTRFS_I(inode), found_start,
> +				found_end + 1 - found_start, defrag->transid);
> +		if (ret < 0)
> +			break;

Not sure why it makes more sense to break instead of continuing.
Just because there was a failure for one range, it does not mean
the next ranges will fail as well.

Thanks.

> +		cur = found_end + 1;
>  	}
>  
>  	iput(inode);
> -	return 0;
>  cleanup:
>  	extent_io_tree_release(&defrag->targets);
>  	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2049f3ea992d..622e017500bc 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -570,7 +570,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
>  	/* If this is a small write inside eof, kick off a defrag */
>  	if (num_bytes < small_write &&
>  	    (start > 0 || end + 1 < inode->disk_i_size))
> -		btrfs_add_inode_defrag(inode);
> +		btrfs_add_inode_defrag(inode, start, num_bytes);
>  }
>  
>  /*
> -- 
> 2.35.0
> 
