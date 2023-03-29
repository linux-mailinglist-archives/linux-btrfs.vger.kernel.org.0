Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8180F6CD2AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 09:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjC2HKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 03:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjC2HKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDADB269E
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 00:10:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD67821A3A
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680073812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVCyEtiRY4T5m13/FXJ+9NKqhj928g+pB9uu7fJFALo=;
        b=YfH2rhmEUkrVrxIkSc+d6LejwA8+siHke6BFCVhK3UPIQEGX652vkbUuv8wLFw98qk55x4
        xz1Ta7qOq9MRwtZzME0snHwLFG8bxoapzmSw+KWk2GNANko0x5eZRNCaiL12/TkvyJYMI1
        FihtAXhRKWEknYnKZmaYKaDLR59K3BU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C286138FF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cOkKN1PkI2T4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: scrub: remove the old scrub recheck code
Date:   Wed, 29 Mar 2023 15:09:48 +0800
Message-Id: <503fd9d09b0954bbde645a2bbeadb3349e443021.1680073696.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680073696.git.wqu@suse.com>
References: <cover.1680073696.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The old scrub code has different entrance to verify the content, and
since we have removed the writeback path, now we can start removing the
re-check part, including:

- scrub_recover structure
- scrub_sector::recover member
- function scrub_setup_recheck_block()
- function scrub_recheck_block()
- function scrub_recheck_block_checksum()
- function scrub_repair_block_group_good_copy()
- function scrub_repair_sector_from_good_copy()
- function scrub_is_page_on_raid56()

- function full_stripe_lock()
- function search_full_stripe_lock()
- function get_full_stripe_logical()
- function insert_full_stripe_lock()
- function lock_full_stripe()
- function unlock_full_stripe()
- btrfs_block_group::full_stripe_locks_root member
- btrfs_full_stripe_locks_tree structure
  This infrastructure is to ensure RAID56 scrub is properly handling
  recovery and P/Q scrub correctly.

  This is no longer needed, before P/Q scrub we will wait for all
  the involved data stripes to be scrubbed first, and RAID56 code has
  internal lock to ensure no race in the same full stripe.

- function scrub_print_warning()
- function scrub_get_recover()
- function scrub_put_recover()
- function scrub_handle_errored_block()
- function scrub_setup_recheck_block()
- function scrub_bio_wait_endio()
- function scrub_submit_raid56_bio_wait()
- function scrub_recheck_block_on_raid56()
- function scrub_recheck_block()
- function scrub_recheck_block_checksum()
- function scrub_repair_block_from_good_copy()
- function scrub_repair_sector_from_good_copy()

And two more functions exported temporarily for later cleanup:

- alloc_scrub_sector()
- alloc_scrub_block()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c |  11 -
 fs/btrfs/block-group.h |   8 -
 fs/btrfs/scrub.c       | 997 +----------------------------------------
 fs/btrfs/scrub.h       |   7 +
 4 files changed, 14 insertions(+), 1009 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46a8ca24afaa..f1dd7ee7ad96 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -160,15 +160,6 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 			btrfs_discard_cancel_work(&cache->fs_info->discard_ctl,
 						  cache);
 
-		/*
-		 * If not empty, someone is still holding mutex of
-		 * full_stripe_lock, which can only be released by caller.
-		 * And it will definitely cause use-after-free when caller
-		 * tries to release full stripe lock.
-		 *
-		 * No better way to resolve, but only to warn.
-		 */
-		WARN_ON(!RB_EMPTY_ROOT(&cache->full_stripe_locks_root.root));
 		kfree(cache->free_space_ctl);
 		kfree(cache->physical_map);
 		kfree(cache);
@@ -2124,8 +2115,6 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
 	atomic_set(&cache->frozen, 0);
 	mutex_init(&cache->free_space_lock);
-	cache->full_stripe_locks_root.root = RB_ROOT;
-	mutex_init(&cache->full_stripe_locks_root.lock);
 
 	return cache;
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 6e4a0b429ac3..c462aa578d61 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -94,11 +94,6 @@ struct btrfs_caching_control {
 /*
  * Tree to record all locked full stripes of a RAID5/6 block group
  */
-struct btrfs_full_stripe_locks_tree {
-	struct rb_root root;
-	struct mutex lock;
-};
-
 struct btrfs_block_group {
 	struct btrfs_fs_info *fs_info;
 	struct inode *inode;
@@ -229,9 +224,6 @@ struct btrfs_block_group {
 	 */
 	int swap_extents;
 
-	/* Record locked full stripes for RAID5/6 block group */
-	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
-
 	/*
 	 * Allocation offset for the block group to implement sequential
 	 * allocation. This is used only on a zoned filesystem.
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6e981b77c73f..63182aed390f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -183,12 +183,6 @@ struct scrub_stripe {
 	struct work_struct work;
 };
 
-struct scrub_recover {
-	refcount_t		refs;
-	struct btrfs_io_context	*bioc;
-	u64			map_length;
-};
-
 struct scrub_sector {
 	struct scrub_block	*sblock;
 	struct list_head	list;
@@ -200,8 +194,6 @@ struct scrub_sector {
 	unsigned int		have_csum:1;
 	unsigned int		io_error:1;
 	u8			csum[BTRFS_CSUM_SIZE];
-
-	struct scrub_recover	*recover;
 };
 
 struct scrub_bio {
@@ -303,13 +295,6 @@ struct scrub_warning {
 	struct btrfs_device	*dev;
 };
 
-struct full_stripe_lock {
-	struct rb_node node;
-	u64 logical;
-	u64 refs;
-	struct mutex mutex;
-};
-
 #ifndef CONFIG_64BIT
 /* This structure is for architectures whose (void *) is smaller than u64 */
 struct scrub_page_private {
@@ -406,11 +391,11 @@ static void wait_scrub_stripe_io(struct scrub_stripe *stripe)
 	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
 }
 
-static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
-					     struct btrfs_device *dev,
-					     u64 logical, u64 physical,
-					     u64 physical_for_dev_replace,
-					     int mirror_num)
+struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
+				     struct btrfs_device *dev,
+				     u64 logical, u64 physical,
+				     u64 physical_for_dev_replace,
+				     int mirror_num)
 {
 	struct scrub_block *sblock;
 
@@ -437,8 +422,7 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
  *
  * Will also allocate new pages for @sblock if needed.
  */
-static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
-					       u64 logical)
+struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock, u64 logical)
 {
 	const pgoff_t page_index = (logical - sblock->logical) >> PAGE_SHIFT;
 	struct scrub_sector *ssector;
@@ -534,17 +518,6 @@ static int bio_add_scrub_sector(struct bio *bio, struct scrub_sector *ssector,
 			    scrub_sector_get_page_offset(ssector));
 }
 
-static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
-				     struct scrub_block *sblocks_for_recheck[]);
-static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
-				struct scrub_block *sblock,
-				int retry_failed_mirror);
-static void scrub_recheck_block_checksum(struct scrub_block *sblock);
-static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
-					     struct scrub_block *sblock_good);
-static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
-					    struct scrub_block *sblock_good,
-					    int sector_num, int force_write);
 static int scrub_checksum_data(struct scrub_block *sblock);
 static int scrub_checksum_tree_block(struct scrub_block *sblock);
 static int scrub_checksum_super(struct scrub_block *sblock);
@@ -555,12 +528,6 @@ static void scrub_bio_end_io_worker(struct work_struct *work);
 static void scrub_block_complete(struct scrub_block *sblock);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
-static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
-{
-	return sector->recover &&
-	       (sector->recover->bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
-}
-
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx)
 {
 	refcount_inc(&sctx->refs);
@@ -606,223 +573,6 @@ static void scrub_blocked_if_needed(struct btrfs_fs_info *fs_info)
 	scrub_pause_off(fs_info);
 }
 
-/*
- * Insert new full stripe lock into full stripe locks tree
- *
- * Return pointer to existing or newly inserted full_stripe_lock structure if
- * everything works well.
- * Return ERR_PTR(-ENOMEM) if we failed to allocate memory
- *
- * NOTE: caller must hold full_stripe_locks_root->lock before calling this
- * function
- */
-static struct full_stripe_lock *insert_full_stripe_lock(
-		struct btrfs_full_stripe_locks_tree *locks_root,
-		u64 fstripe_logical)
-{
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct full_stripe_lock *entry;
-	struct full_stripe_lock *ret;
-
-	lockdep_assert_held(&locks_root->lock);
-
-	p = &locks_root->root.rb_node;
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct full_stripe_lock, node);
-		if (fstripe_logical < entry->logical) {
-			p = &(*p)->rb_left;
-		} else if (fstripe_logical > entry->logical) {
-			p = &(*p)->rb_right;
-		} else {
-			entry->refs++;
-			return entry;
-		}
-	}
-
-	/*
-	 * Insert new lock.
-	 */
-	ret = kmalloc(sizeof(*ret), GFP_KERNEL);
-	if (!ret)
-		return ERR_PTR(-ENOMEM);
-	ret->logical = fstripe_logical;
-	ret->refs = 1;
-	mutex_init(&ret->mutex);
-
-	rb_link_node(&ret->node, parent, p);
-	rb_insert_color(&ret->node, &locks_root->root);
-	return ret;
-}
-
-/*
- * Search for a full stripe lock of a block group
- *
- * Return pointer to existing full stripe lock if found
- * Return NULL if not found
- */
-static struct full_stripe_lock *search_full_stripe_lock(
-		struct btrfs_full_stripe_locks_tree *locks_root,
-		u64 fstripe_logical)
-{
-	struct rb_node *node;
-	struct full_stripe_lock *entry;
-
-	lockdep_assert_held(&locks_root->lock);
-
-	node = locks_root->root.rb_node;
-	while (node) {
-		entry = rb_entry(node, struct full_stripe_lock, node);
-		if (fstripe_logical < entry->logical)
-			node = node->rb_left;
-		else if (fstripe_logical > entry->logical)
-			node = node->rb_right;
-		else
-			return entry;
-	}
-	return NULL;
-}
-
-/*
- * Helper to get full stripe logical from a normal bytenr.
- *
- * Caller must ensure @cache is a RAID56 block group.
- */
-static u64 get_full_stripe_logical(struct btrfs_block_group *cache, u64 bytenr)
-{
-	u64 ret;
-
-	/*
-	 * Due to chunk item size limit, full stripe length should not be
-	 * larger than U32_MAX. Just a sanity check here.
-	 */
-	WARN_ON_ONCE(cache->full_stripe_len >= U32_MAX);
-
-	/*
-	 * round_down() can only handle power of 2, while RAID56 full
-	 * stripe length can be 64KiB * n, so we need to manually round down.
-	 */
-	ret = div64_u64(bytenr - cache->start, cache->full_stripe_len) *
-			cache->full_stripe_len + cache->start;
-	return ret;
-}
-
-/*
- * Lock a full stripe to avoid concurrency of recovery and read
- *
- * It's only used for profiles with parities (RAID5/6), for other profiles it
- * does nothing.
- *
- * Return 0 if we locked full stripe covering @bytenr, with a mutex held.
- * So caller must call unlock_full_stripe() at the same context.
- *
- * Return <0 if encounters error.
- */
-static int lock_full_stripe(struct btrfs_fs_info *fs_info, u64 bytenr,
-			    bool *locked_ret)
-{
-	struct btrfs_block_group *bg_cache;
-	struct btrfs_full_stripe_locks_tree *locks_root;
-	struct full_stripe_lock *existing;
-	u64 fstripe_start;
-	int ret = 0;
-
-	*locked_ret = false;
-	bg_cache = btrfs_lookup_block_group(fs_info, bytenr);
-	if (!bg_cache) {
-		ASSERT(0);
-		return -ENOENT;
-	}
-
-	/* Profiles not based on parity don't need full stripe lock */
-	if (!(bg_cache->flags & BTRFS_BLOCK_GROUP_RAID56_MASK))
-		goto out;
-	locks_root = &bg_cache->full_stripe_locks_root;
-
-	fstripe_start = get_full_stripe_logical(bg_cache, bytenr);
-
-	/* Now insert the full stripe lock */
-	mutex_lock(&locks_root->lock);
-	existing = insert_full_stripe_lock(locks_root, fstripe_start);
-	mutex_unlock(&locks_root->lock);
-	if (IS_ERR(existing)) {
-		ret = PTR_ERR(existing);
-		goto out;
-	}
-	mutex_lock(&existing->mutex);
-	*locked_ret = true;
-out:
-	btrfs_put_block_group(bg_cache);
-	return ret;
-}
-
-/*
- * Unlock a full stripe.
- *
- * NOTE: Caller must ensure it's the same context calling corresponding
- * lock_full_stripe().
- *
- * Return 0 if we unlock full stripe without problem.
- * Return <0 for error
- */
-static int unlock_full_stripe(struct btrfs_fs_info *fs_info, u64 bytenr,
-			      bool locked)
-{
-	struct btrfs_block_group *bg_cache;
-	struct btrfs_full_stripe_locks_tree *locks_root;
-	struct full_stripe_lock *fstripe_lock;
-	u64 fstripe_start;
-	bool freeit = false;
-	int ret = 0;
-
-	/* If we didn't acquire full stripe lock, no need to continue */
-	if (!locked)
-		return 0;
-
-	bg_cache = btrfs_lookup_block_group(fs_info, bytenr);
-	if (!bg_cache) {
-		ASSERT(0);
-		return -ENOENT;
-	}
-	if (!(bg_cache->flags & BTRFS_BLOCK_GROUP_RAID56_MASK))
-		goto out;
-
-	locks_root = &bg_cache->full_stripe_locks_root;
-	fstripe_start = get_full_stripe_logical(bg_cache, bytenr);
-
-	mutex_lock(&locks_root->lock);
-	fstripe_lock = search_full_stripe_lock(locks_root, fstripe_start);
-	/* Unpaired unlock_full_stripe() detected */
-	if (!fstripe_lock) {
-		WARN_ON(1);
-		ret = -ENOENT;
-		mutex_unlock(&locks_root->lock);
-		goto out;
-	}
-
-	if (fstripe_lock->refs == 0) {
-		WARN_ON(1);
-		btrfs_warn(fs_info, "full stripe lock at %llu refcount underflow",
-			fstripe_lock->logical);
-	} else {
-		fstripe_lock->refs--;
-	}
-
-	if (fstripe_lock->refs == 0) {
-		rb_erase(&fstripe_lock->node, &locks_root->root);
-		freeit = true;
-	}
-	mutex_unlock(&locks_root->lock);
-
-	mutex_unlock(&fstripe_lock->mutex);
-	if (freeit)
-		kfree(fstripe_lock);
-out:
-	btrfs_put_block_group(bg_cache);
-	return ret;
-}
-
 static void scrub_free_csums(struct scrub_ctx *sctx)
 {
 	while (!list_empty(&sctx->csum_list)) {
@@ -1103,444 +853,6 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	btrfs_free_path(path);
 }
 
-static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
-{
-	scrub_print_common_warning(errstr, sblock->dev,
-			sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER,
-			sblock->logical, sblock->physical);
-}
-
-static inline void scrub_get_recover(struct scrub_recover *recover)
-{
-	refcount_inc(&recover->refs);
-}
-
-static inline void scrub_put_recover(struct btrfs_fs_info *fs_info,
-				     struct scrub_recover *recover)
-{
-	if (refcount_dec_and_test(&recover->refs)) {
-		btrfs_bio_counter_dec(fs_info);
-		btrfs_put_bioc(recover->bioc);
-		kfree(recover);
-	}
-}
-
-/*
- * scrub_handle_errored_block gets called when either verification of the
- * sectors failed or the bio failed to read, e.g. with EIO. In the latter
- * case, this function handles all sectors in the bio, even though only one
- * may be bad.
- * The goal of this function is to repair the errored block by using the
- * contents of one of the mirrors.
- */
-static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
-{
-	struct scrub_ctx *sctx = sblock_to_check->sctx;
-	struct btrfs_device *dev = sblock_to_check->dev;
-	struct btrfs_fs_info *fs_info;
-	u64 logical;
-	unsigned int failed_mirror_index;
-	unsigned int is_metadata;
-	unsigned int have_csum;
-	/* One scrub_block for each mirror */
-	struct scrub_block *sblocks_for_recheck[BTRFS_MAX_MIRRORS] = { 0 };
-	struct scrub_block *sblock_bad;
-	int ret;
-	int mirror_index;
-	int sector_num;
-	int success;
-	bool full_stripe_locked;
-	unsigned int nofs_flag;
-	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
-				      DEFAULT_RATELIMIT_BURST);
-
-	BUG_ON(sblock_to_check->sector_count < 1);
-	fs_info = sctx->fs_info;
-	if (sblock_to_check->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
-		/*
-		 * If we find an error in a super block, we just report it.
-		 * They will get written with the next transaction commit
-		 * anyway
-		 */
-		scrub_print_warning("super block error", sblock_to_check);
-		spin_lock(&sctx->stat_lock);
-		++sctx->stat.super_errors;
-		spin_unlock(&sctx->stat_lock);
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
-		return 0;
-	}
-	logical = sblock_to_check->logical;
-	ASSERT(sblock_to_check->mirror_num);
-	failed_mirror_index = sblock_to_check->mirror_num - 1;
-	is_metadata = !(sblock_to_check->sectors[0]->flags &
-			BTRFS_EXTENT_FLAG_DATA);
-	have_csum = sblock_to_check->sectors[0]->have_csum;
-
-	if (!sctx->is_dev_replace && btrfs_repair_one_zone(fs_info, logical))
-		return 0;
-
-	/*
-	 * We must use GFP_NOFS because the scrub task might be waiting for a
-	 * worker task executing this function and in turn a transaction commit
-	 * might be waiting the scrub task to pause (which needs to wait for all
-	 * the worker tasks to complete before pausing).
-	 * We do allocations in the workers through insert_full_stripe_lock()
-	 * and scrub_add_sector_to_wr_bio(), which happens down the call chain of
-	 * this function.
-	 */
-	nofs_flag = memalloc_nofs_save();
-	/*
-	 * For RAID5/6, race can happen for a different device scrub thread.
-	 * For data corruption, Parity and Data threads will both try
-	 * to recovery the data.
-	 * Race can lead to doubly added csum error, or even unrecoverable
-	 * error.
-	 */
-	ret = lock_full_stripe(fs_info, logical, &full_stripe_locked);
-	if (ret < 0) {
-		memalloc_nofs_restore(nofs_flag);
-		spin_lock(&sctx->stat_lock);
-		if (ret == -ENOMEM)
-			sctx->stat.malloc_errors++;
-		sctx->stat.read_errors++;
-		sctx->stat.uncorrectable_errors++;
-		spin_unlock(&sctx->stat_lock);
-		return ret;
-	}
-
-	/*
-	 * read all mirrors one after the other. This includes to
-	 * re-read the extent or metadata block that failed (that was
-	 * the cause that this fixup code is called) another time,
-	 * sector by sector this time in order to know which sectors
-	 * caused I/O errors and which ones are good (for all mirrors).
-	 * It is the goal to handle the situation when more than one
-	 * mirror contains I/O errors, but the errors do not
-	 * overlap, i.e. the data can be repaired by selecting the
-	 * sectors from those mirrors without I/O error on the
-	 * particular sectors. One example (with blocks >= 2 * sectorsize)
-	 * would be that mirror #1 has an I/O error on the first sector,
-	 * the second sector is good, and mirror #2 has an I/O error on
-	 * the second sector, but the first sector is good.
-	 * Then the first sector of the first mirror can be repaired by
-	 * taking the first sector of the second mirror, and the
-	 * second sector of the second mirror can be repaired by
-	 * copying the contents of the 2nd sector of the 1st mirror.
-	 * One more note: if the sectors of one mirror contain I/O
-	 * errors, the checksum cannot be verified. In order to get
-	 * the best data for repairing, the first attempt is to find
-	 * a mirror without I/O errors and with a validated checksum.
-	 * Only if this is not possible, the sectors are picked from
-	 * mirrors with I/O errors without considering the checksum.
-	 * If the latter is the case, at the end, the checksum of the
-	 * repaired area is verified in order to correctly maintain
-	 * the statistics.
-	 */
-	for (mirror_index = 0; mirror_index < BTRFS_MAX_MIRRORS; mirror_index++) {
-		/*
-		 * Note: the two members refs and outstanding_sectors are not
-		 * used in the blocks that are used for the recheck procedure.
-		 *
-		 * But alloc_scrub_block() will initialize sblock::ref anyway,
-		 * so we can use scrub_block_put() to clean them up.
-		 *
-		 * And here we don't setup the physical/dev for the sblock yet,
-		 * they will be correctly initialized in scrub_setup_recheck_block().
-		 */
-		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx, NULL,
-							logical, 0, 0, mirror_index);
-		if (!sblocks_for_recheck[mirror_index]) {
-			spin_lock(&sctx->stat_lock);
-			sctx->stat.malloc_errors++;
-			sctx->stat.read_errors++;
-			sctx->stat.uncorrectable_errors++;
-			spin_unlock(&sctx->stat_lock);
-			btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
-			goto out;
-		}
-	}
-
-	/* Setup the context, map the logical blocks and alloc the sectors */
-	ret = scrub_setup_recheck_block(sblock_to_check, sblocks_for_recheck);
-	if (ret) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.read_errors++;
-		sctx->stat.uncorrectable_errors++;
-		spin_unlock(&sctx->stat_lock);
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
-		goto out;
-	}
-	BUG_ON(failed_mirror_index >= BTRFS_MAX_MIRRORS);
-	sblock_bad = sblocks_for_recheck[failed_mirror_index];
-
-	/* build and submit the bios for the failed mirror, check checksums */
-	scrub_recheck_block(fs_info, sblock_bad, 1);
-
-	if (!sblock_bad->header_error && !sblock_bad->checksum_error &&
-	    sblock_bad->no_io_error_seen) {
-		/*
-		 * The error disappeared after reading sector by sector, or
-		 * the area was part of a huge bio and other parts of the
-		 * bio caused I/O errors, or the block layer merged several
-		 * read requests into one and the error is caused by a
-		 * different bio (usually one of the two latter cases is
-		 * the cause)
-		 */
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.unverified_errors++;
-		sblock_to_check->data_corrected = 1;
-		spin_unlock(&sctx->stat_lock);
-
-		goto out;
-	}
-
-	if (!sblock_bad->no_io_error_seen) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.read_errors++;
-		spin_unlock(&sctx->stat_lock);
-		if (__ratelimit(&rs))
-			scrub_print_warning("i/o error", sblock_to_check);
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
-	} else if (sblock_bad->checksum_error) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.csum_errors++;
-		spin_unlock(&sctx->stat_lock);
-		if (__ratelimit(&rs))
-			scrub_print_warning("checksum error", sblock_to_check);
-		btrfs_dev_stat_inc_and_print(dev,
-					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	} else if (sblock_bad->header_error) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.verify_errors++;
-		spin_unlock(&sctx->stat_lock);
-		if (__ratelimit(&rs))
-			scrub_print_warning("checksum/header error",
-					    sblock_to_check);
-		if (sblock_bad->generation_error)
-			btrfs_dev_stat_inc_and_print(dev,
-				BTRFS_DEV_STAT_GENERATION_ERRS);
-		else
-			btrfs_dev_stat_inc_and_print(dev,
-				BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	}
-
-	if (sctx->readonly) {
-		ASSERT(!sctx->is_dev_replace);
-		goto out;
-	}
-
-	/*
-	 * now build and submit the bios for the other mirrors, check
-	 * checksums.
-	 * First try to pick the mirror which is completely without I/O
-	 * errors and also does not have a checksum error.
-	 * If one is found, and if a checksum is present, the full block
-	 * that is known to contain an error is rewritten. Afterwards
-	 * the block is known to be corrected.
-	 * If a mirror is found which is completely correct, and no
-	 * checksum is present, only those sectors are rewritten that had
-	 * an I/O error in the block to be repaired, since it cannot be
-	 * determined, which copy of the other sectors is better (and it
-	 * could happen otherwise that a correct sector would be
-	 * overwritten by a bad one).
-	 */
-	for (mirror_index = 0; ;mirror_index++) {
-		struct scrub_block *sblock_other;
-
-		if (mirror_index == failed_mirror_index)
-			continue;
-
-		/* raid56's mirror can be more than BTRFS_MAX_MIRRORS */
-		if (!scrub_is_page_on_raid56(sblock_bad->sectors[0])) {
-			if (mirror_index >= BTRFS_MAX_MIRRORS)
-				break;
-			if (!sblocks_for_recheck[mirror_index]->sector_count)
-				break;
-
-			sblock_other = sblocks_for_recheck[mirror_index];
-		} else {
-			struct scrub_recover *r = sblock_bad->sectors[0]->recover;
-			int max_allowed = r->bioc->num_stripes - r->bioc->replace_nr_stripes;
-
-			if (mirror_index >= max_allowed)
-				break;
-			if (!sblocks_for_recheck[1]->sector_count)
-				break;
-
-			ASSERT(failed_mirror_index == 0);
-			sblock_other = sblocks_for_recheck[1];
-			sblock_other->mirror_num = 1 + mirror_index;
-		}
-
-		/* build and submit the bios, check checksums */
-		scrub_recheck_block(fs_info, sblock_other, 0);
-
-		if (!sblock_other->header_error &&
-		    !sblock_other->checksum_error &&
-		    sblock_other->no_io_error_seen) {
-			if (sctx->is_dev_replace) {
-				goto corrected_error;
-			} else {
-				ret = scrub_repair_block_from_good_copy(
-						sblock_bad, sblock_other);
-				if (!ret)
-					goto corrected_error;
-			}
-		}
-	}
-
-	if (sblock_bad->no_io_error_seen && !sctx->is_dev_replace)
-		goto did_not_correct_error;
-
-	/*
-	 * In case of I/O errors in the area that is supposed to be
-	 * repaired, continue by picking good copies of those sectors.
-	 * Select the good sectors from mirrors to rewrite bad sectors from
-	 * the area to fix. Afterwards verify the checksum of the block
-	 * that is supposed to be repaired. This verification step is
-	 * only done for the purpose of statistic counting and for the
-	 * final scrub report, whether errors remain.
-	 * A perfect algorithm could make use of the checksum and try
-	 * all possible combinations of sectors from the different mirrors
-	 * until the checksum verification succeeds. For example, when
-	 * the 2nd sector of mirror #1 faces I/O errors, and the 2nd sector
-	 * of mirror #2 is readable but the final checksum test fails,
-	 * then the 2nd sector of mirror #3 could be tried, whether now
-	 * the final checksum succeeds. But this would be a rare
-	 * exception and is therefore not implemented. At least it is
-	 * avoided that the good copy is overwritten.
-	 * A more useful improvement would be to pick the sectors
-	 * without I/O error based on sector sizes (512 bytes on legacy
-	 * disks) instead of on sectorsize. Then maybe 512 byte of one
-	 * mirror could be repaired by taking 512 byte of a different
-	 * mirror, even if other 512 byte sectors in the same sectorsize
-	 * area are unreadable.
-	 */
-	success = 1;
-	for (sector_num = 0; sector_num < sblock_bad->sector_count;
-	     sector_num++) {
-		struct scrub_sector *sector_bad = sblock_bad->sectors[sector_num];
-		struct scrub_block *sblock_other = NULL;
-
-		/* Skip no-io-error sectors in scrub */
-		if (!sector_bad->io_error && !sctx->is_dev_replace)
-			continue;
-
-		if (scrub_is_page_on_raid56(sblock_bad->sectors[0])) {
-			/*
-			 * In case of dev replace, if raid56 rebuild process
-			 * didn't work out correct data, then copy the content
-			 * in sblock_bad to make sure target device is identical
-			 * to source device, instead of writing garbage data in
-			 * sblock_for_recheck array to target device.
-			 */
-			sblock_other = NULL;
-		} else if (sector_bad->io_error) {
-			/* Try to find no-io-error sector in mirrors */
-			for (mirror_index = 0;
-			     mirror_index < BTRFS_MAX_MIRRORS &&
-			     sblocks_for_recheck[mirror_index]->sector_count > 0;
-			     mirror_index++) {
-				if (!sblocks_for_recheck[mirror_index]->
-				    sectors[sector_num]->io_error) {
-					sblock_other = sblocks_for_recheck[mirror_index];
-					break;
-				}
-			}
-			if (!sblock_other)
-				success = 0;
-		}
-
-		if (sctx->is_dev_replace) {
-			/*
-			 * Did not find a mirror to fetch the sector from.
-			 * scrub_write_sector_to_dev_replace() handles this
-			 * case (sector->io_error), by filling the block with
-			 * zeros before submitting the write request
-			 */
-			if (!sblock_other)
-				sblock_other = sblock_bad;
-		} else if (sblock_other) {
-			ret = scrub_repair_sector_from_good_copy(sblock_bad,
-								 sblock_other,
-								 sector_num, 0);
-			if (0 == ret)
-				sector_bad->io_error = 0;
-			else
-				success = 0;
-		}
-	}
-
-	if (success && !sctx->is_dev_replace) {
-		if (is_metadata || have_csum) {
-			/*
-			 * need to verify the checksum now that all
-			 * sectors on disk are repaired (the write
-			 * request for data to be repaired is on its way).
-			 * Just be lazy and use scrub_recheck_block()
-			 * which re-reads the data before the checksum
-			 * is verified, but most likely the data comes out
-			 * of the page cache.
-			 */
-			scrub_recheck_block(fs_info, sblock_bad, 1);
-			if (!sblock_bad->header_error &&
-			    !sblock_bad->checksum_error &&
-			    sblock_bad->no_io_error_seen)
-				goto corrected_error;
-			else
-				goto did_not_correct_error;
-		} else {
-corrected_error:
-			spin_lock(&sctx->stat_lock);
-			sctx->stat.corrected_errors++;
-			sblock_to_check->data_corrected = 1;
-			spin_unlock(&sctx->stat_lock);
-			btrfs_err_rl_in_rcu(fs_info,
-				"fixed up error at logical %llu on dev %s",
-				logical, btrfs_dev_name(dev));
-		}
-	} else {
-did_not_correct_error:
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.uncorrectable_errors++;
-		spin_unlock(&sctx->stat_lock);
-		btrfs_err_rl_in_rcu(fs_info,
-			"unable to fixup (regular) error at logical %llu on dev %s",
-			logical, btrfs_dev_name(dev));
-	}
-
-out:
-	for (mirror_index = 0; mirror_index < BTRFS_MAX_MIRRORS; mirror_index++) {
-		struct scrub_block *sblock = sblocks_for_recheck[mirror_index];
-		struct scrub_recover *recover;
-		int sector_index;
-
-		/* Not allocated, continue checking the next mirror */
-		if (!sblock)
-			continue;
-
-		for (sector_index = 0; sector_index < sblock->sector_count;
-		     sector_index++) {
-			/*
-			 * Here we just cleanup the recover, each sector will be
-			 * properly cleaned up by later scrub_block_put()
-			 */
-			recover = sblock->sectors[sector_index]->recover;
-			if (recover) {
-				scrub_put_recover(fs_info, recover);
-				sblock->sectors[sector_index]->recover = NULL;
-			}
-		}
-		scrub_block_put(sblock);
-	}
-
-	ret = unlock_full_stripe(fs_info, logical, full_stripe_locked);
-	memalloc_nofs_restore(nofs_flag);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
 static inline int scrub_nr_raid_mirrors(struct btrfs_io_context *bioc)
 {
 	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
@@ -1583,224 +895,6 @@ static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 	}
 }
 
-static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
-				     struct scrub_block *sblocks_for_recheck[])
-{
-	struct scrub_ctx *sctx = original_sblock->sctx;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	u64 logical = original_sblock->logical;
-	u64 length = original_sblock->sector_count << fs_info->sectorsize_bits;
-	u64 generation = original_sblock->sectors[0]->generation;
-	u64 flags = original_sblock->sectors[0]->flags;
-	u64 have_csum = original_sblock->sectors[0]->have_csum;
-	struct scrub_recover *recover;
-	struct btrfs_io_context *bioc;
-	u64 sublen;
-	u64 mapped_length;
-	u64 stripe_offset;
-	int stripe_index;
-	int sector_index = 0;
-	int mirror_index;
-	int nmirrors;
-	int ret;
-
-	while (length > 0) {
-		sublen = min_t(u64, length, fs_info->sectorsize);
-		mapped_length = sublen;
-		bioc = NULL;
-
-		/*
-		 * With a length of sectorsize, each returned stripe represents
-		 * one mirror
-		 */
-		btrfs_bio_counter_inc_blocked(fs_info);
-		ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				       logical, &mapped_length, &bioc);
-		if (ret || !bioc || mapped_length < sublen) {
-			btrfs_put_bioc(bioc);
-			btrfs_bio_counter_dec(fs_info);
-			return -EIO;
-		}
-
-		recover = kzalloc(sizeof(struct scrub_recover), GFP_KERNEL);
-		if (!recover) {
-			btrfs_put_bioc(bioc);
-			btrfs_bio_counter_dec(fs_info);
-			return -ENOMEM;
-		}
-
-		refcount_set(&recover->refs, 1);
-		recover->bioc = bioc;
-		recover->map_length = mapped_length;
-
-		ASSERT(sector_index < SCRUB_MAX_SECTORS_PER_BLOCK);
-
-		nmirrors = min(scrub_nr_raid_mirrors(bioc), BTRFS_MAX_MIRRORS);
-
-		for (mirror_index = 0; mirror_index < nmirrors;
-		     mirror_index++) {
-			struct scrub_block *sblock;
-			struct scrub_sector *sector;
-
-			sblock = sblocks_for_recheck[mirror_index];
-			sblock->sctx = sctx;
-
-			sector = alloc_scrub_sector(sblock, logical);
-			if (!sector) {
-				spin_lock(&sctx->stat_lock);
-				sctx->stat.malloc_errors++;
-				spin_unlock(&sctx->stat_lock);
-				scrub_put_recover(fs_info, recover);
-				return -ENOMEM;
-			}
-			sector->flags = flags;
-			sector->generation = generation;
-			sector->have_csum = have_csum;
-			if (have_csum)
-				memcpy(sector->csum,
-				       original_sblock->sectors[0]->csum,
-				       sctx->fs_info->csum_size);
-
-			scrub_stripe_index_and_offset(logical,
-						      bioc->map_type,
-						      bioc->full_stripe_logical,
-						      bioc->num_stripes -
-						      bioc->replace_nr_stripes,
-						      mirror_index,
-						      &stripe_index,
-						      &stripe_offset);
-			/*
-			 * We're at the first sector, also populate @sblock
-			 * physical and dev.
-			 */
-			if (sector_index == 0) {
-				sblock->physical =
-					bioc->stripes[stripe_index].physical +
-					stripe_offset;
-				sblock->dev = bioc->stripes[stripe_index].dev;
-				sblock->physical_for_dev_replace =
-					original_sblock->physical_for_dev_replace;
-			}
-
-			BUG_ON(sector_index >= original_sblock->sector_count);
-			scrub_get_recover(recover);
-			sector->recover = recover;
-		}
-		scrub_put_recover(fs_info, recover);
-		length -= sublen;
-		logical += sublen;
-		sector_index++;
-	}
-
-	return 0;
-}
-
-static void scrub_bio_wait_endio(struct bio *bio)
-{
-	complete(bio->bi_private);
-}
-
-static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
-					struct bio *bio,
-					struct scrub_sector *sector)
-{
-	DECLARE_COMPLETION_ONSTACK(done);
-
-	bio->bi_iter.bi_sector = (sector->offset + sector->sblock->logical) >>
-				 SECTOR_SHIFT;
-	bio->bi_private = &done;
-	bio->bi_end_io = scrub_bio_wait_endio;
-	raid56_parity_recover(bio, sector->recover->bioc, sector->sblock->mirror_num);
-
-	wait_for_completion_io(&done);
-	return blk_status_to_errno(bio->bi_status);
-}
-
-static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
-					  struct scrub_block *sblock)
-{
-	struct scrub_sector *first_sector = sblock->sectors[0];
-	struct bio *bio;
-	int i;
-
-	/* All sectors in sblock belong to the same stripe on the same device. */
-	ASSERT(sblock->dev);
-	if (!sblock->dev->bdev)
-		goto out;
-
-	bio = bio_alloc(sblock->dev->bdev, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
-
-	for (i = 0; i < sblock->sector_count; i++) {
-		struct scrub_sector *sector = sblock->sectors[i];
-
-		bio_add_scrub_sector(bio, sector, fs_info->sectorsize);
-	}
-
-	if (scrub_submit_raid56_bio_wait(fs_info, bio, first_sector)) {
-		bio_put(bio);
-		goto out;
-	}
-
-	bio_put(bio);
-
-	scrub_recheck_block_checksum(sblock);
-
-	return;
-out:
-	for (i = 0; i < sblock->sector_count; i++)
-		sblock->sectors[i]->io_error = 1;
-
-	sblock->no_io_error_seen = 0;
-}
-
-/*
- * This function will check the on disk data for checksum errors, header errors
- * and read I/O errors. If any I/O errors happen, the exact sectors which are
- * errored are marked as being bad. The goal is to enable scrub to take those
- * sectors that are not errored from all the mirrors so that the sectors that
- * are errored in the just handled mirror can be repaired.
- */
-static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
-				struct scrub_block *sblock,
-				int retry_failed_mirror)
-{
-	int i;
-
-	sblock->no_io_error_seen = 1;
-
-	/* short cut for raid56 */
-	if (!retry_failed_mirror && scrub_is_page_on_raid56(sblock->sectors[0]))
-		return scrub_recheck_block_on_raid56(fs_info, sblock);
-
-	for (i = 0; i < sblock->sector_count; i++) {
-		struct scrub_sector *sector = sblock->sectors[i];
-		struct bio bio;
-		struct bio_vec bvec;
-
-		if (sblock->dev->bdev == NULL) {
-			sector->io_error = 1;
-			sblock->no_io_error_seen = 0;
-			continue;
-		}
-
-		bio_init(&bio, sblock->dev->bdev, &bvec, 1, REQ_OP_READ);
-		bio_add_scrub_sector(&bio, sector, fs_info->sectorsize);
-		bio.bi_iter.bi_sector = (sblock->physical + sector->offset) >>
-					SECTOR_SHIFT;
-
-		btrfsic_check_bio(&bio);
-		if (submit_bio_wait(&bio)) {
-			sector->io_error = 1;
-			sblock->no_io_error_seen = 0;
-		}
-
-		bio_uninit(&bio);
-	}
-
-	if (sblock->no_io_error_seen)
-		scrub_recheck_block_checksum(sblock);
-}
-
 static inline int scrub_check_fsid(u8 fsid[], struct scrub_sector *sector)
 {
 	struct btrfs_fs_devices *fs_devices = sector->sblock->dev->fs_devices;
@@ -1810,77 +904,6 @@ static inline int scrub_check_fsid(u8 fsid[], struct scrub_sector *sector)
 	return !ret;
 }
 
-static void scrub_recheck_block_checksum(struct scrub_block *sblock)
-{
-	sblock->header_error = 0;
-	sblock->checksum_error = 0;
-	sblock->generation_error = 0;
-
-	if (sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_DATA)
-		scrub_checksum_data(sblock);
-	else
-		scrub_checksum_tree_block(sblock);
-}
-
-static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
-					     struct scrub_block *sblock_good)
-{
-	int i;
-	int ret = 0;
-
-	for (i = 0; i < sblock_bad->sector_count; i++) {
-		int ret_sub;
-
-		ret_sub = scrub_repair_sector_from_good_copy(sblock_bad,
-							     sblock_good, i, 1);
-		if (ret_sub)
-			ret = ret_sub;
-	}
-
-	return ret;
-}
-
-static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
-					      struct scrub_block *sblock_good,
-					      int sector_num, int force_write)
-{
-	struct scrub_sector *sector_bad = sblock_bad->sectors[sector_num];
-	struct scrub_sector *sector_good = sblock_good->sectors[sector_num];
-	struct btrfs_fs_info *fs_info = sblock_bad->sctx->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
-
-	if (force_write || sblock_bad->header_error ||
-	    sblock_bad->checksum_error || sector_bad->io_error) {
-		struct bio bio;
-		struct bio_vec bvec;
-		int ret;
-
-		if (!sblock_bad->dev->bdev) {
-			btrfs_warn_rl(fs_info,
-				"scrub_repair_page_from_good_copy(bdev == NULL) is unexpected");
-			return -EIO;
-		}
-
-		bio_init(&bio, sblock_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
-		bio.bi_iter.bi_sector = (sblock_bad->physical +
-					 sector_bad->offset) >> SECTOR_SHIFT;
-		ret = bio_add_scrub_sector(&bio, sector_good, sectorsize);
-
-		btrfsic_check_bio(&bio);
-		ret = submit_bio_wait(&bio);
-		bio_uninit(&bio);
-
-		if (ret) {
-			btrfs_dev_stat_inc_and_print(sblock_bad->dev,
-				BTRFS_DEV_STAT_WRITE_ERRS);
-			atomic64_inc(&fs_info->dev_replace.num_write_errors);
-			return -EIO;
-		}
-	}
-
-	return 0;
-}
-
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 {
 	int ret = 0;
@@ -1936,9 +959,6 @@ static int scrub_checksum(struct scrub_block *sblock)
 		ret = scrub_checksum_super(sblock);
 	else
 		WARN_ON(1);
-	if (ret)
-		scrub_handle_errored_block(sblock);
-
 	return ret;
 }
 
@@ -2941,16 +1961,13 @@ static void scrub_bio_end_io_worker(struct work_struct *work)
 
 static void scrub_block_complete(struct scrub_block *sblock)
 {
-	if (!sblock->no_io_error_seen) {
-		scrub_handle_errored_block(sblock);
-	} else {
+	if (sblock->no_io_error_seen)
 		/*
 		 * if has checksum error, write via repair mechanism in
 		 * dev replace case, otherwise write here in dev replace
 		 * case.
 		 */
 		scrub_checksum(sblock);
-	}
 }
 
 static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *sum)
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index f47492e78e1c..7d1982893363 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -16,9 +16,16 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 /* Temporary declaration, would be deleted later. */
 struct scrub_ctx;
 struct scrub_sector;
+struct scrub_block;
 int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum);
 int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 			       struct scrub_sector *sector);
 void scrub_sector_get(struct scrub_sector *sector);
+struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock, u64 logical);
+struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
+				     struct btrfs_device *dev,
+				     u64 logical, u64 physical,
+				     u64 physical_for_dev_replace,
+				     int mirror_num);
 
 #endif
-- 
2.39.2

