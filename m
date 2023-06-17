Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E600733E25
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjFQFHx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjFQFHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:07:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5EC1BDF
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:07:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FCCB1FD63
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686978468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PH0Gis6TXuJxKrYn0R9rJzc6GckiFG+FkOImQ69gFM8=;
        b=gBk3nJyXXoCOSYd6mMJk94RgoSpTyBvHC7NEXLzJlELB6sx0NNgLqurCMdQpF0w9+DrCBg
        3BtFJty6eVMiobVicdeKc58hKvPxkt3eQnTzAMG0i2xZPuMDnCinQrMNJJ7qT7ovHCmLrE
        RVYwWwtsH4fu5PUqo3KpidFeCHjjloE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A72C113915
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wPsCHqM/jWTFEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/5] btrfs: scrub: extract the common preparation before scrubbing a block group
Date:   Sat, 17 Jun 2023 13:07:24 +0800
Message-ID: <8fc39e8af0ce2c335f0e41bdd8b616b30ac2d7b9.1686977659.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686977659.git.wqu@suse.com>
References: <cover.1686977659.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, prepare_scrub_block_group(), to handle the
checks before scrubbing a block group.

The helper would be called by both scrub_enumerate_chunks() and
scrub_logical_chunks().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 328 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 209 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 598754ad7ce6..aa68cda5226f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2349,6 +2349,141 @@ static int finish_extent_writes_for_zoned(struct btrfs_root *root,
 	return btrfs_commit_transaction(trans);
 }
 
+/*
+ * Do the preparation before we scrub the block group.
+ *
+ * Return >0 if we don't need to scrub the block group.
+ * Return 0 if we have done the preparation and set @ro_set_ret.
+ * Return <0 for error and can not scrub the bg.
+ */
+static int prepare_scrub_block_group(struct scrub_ctx *sctx,
+				     struct btrfs_block_group *bg,
+				     bool *ro_set_ret)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_root *root = fs_info->dev_root;
+	bool ro_set = false;
+	int ret;
+
+	if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
+		if (!test_bit(BLOCK_GROUP_FLAG_TO_COPY, &bg->runtime_flags))
+			return 1;
+	}
+
+	/*
+	 * Make sure that while we are scrubbing the corresponding block
+	 * group doesn't get its logical address and its device extents
+	 * reused for another block group, which can possibly be of a
+	 * different type and different profile. We do this to prevent
+	 * false error detections and crashes due to bogus attempts to
+	 * repair extents.
+	 */
+	spin_lock(&bg->lock);
+	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
+		spin_unlock(&bg->lock);
+		return 1;
+	}
+	btrfs_freeze_block_group(bg);
+	spin_unlock(&bg->lock);
+
+	/*
+	 * we need call btrfs_inc_block_group_ro() with scrubs_paused,
+	 * to avoid deadlock caused by:
+	 * btrfs_inc_block_group_ro()
+	 * -> btrfs_wait_for_commit()
+	 * -> btrfs_commit_transaction()
+	 * -> btrfs_scrub_pause()
+	 */
+	scrub_pause_on(fs_info);
+
+	/*
+	 * Don't do chunk preallocation for scrub.
+	 *
+	 * This is especially important for SYSTEM bgs, or we can hit
+	 * -EFBIG from btrfs_finish_chunk_alloc() like:
+	 * 1. The only SYSTEM bg is marked RO.
+	 *    Since SYSTEM bg is small, that's pretty common.
+	 * 2. New SYSTEM bg will be allocated
+	 *    Due to regular version will allocate new chunk.
+	 * 3. New SYSTEM bg is empty and will get cleaned up
+	 *    Before cleanup really happens, it's marked RO again.
+	 * 4. Empty SYSTEM bg get scrubbed
+	 *    We go back to 2.
+	 *
+	 * This can easily boost the amount of SYSTEM chunks if cleaner
+	 * thread can't be triggered fast enough, and use up all space
+	 * of btrfs_super_block::sys_chunk_array
+	 *
+	 * While for dev replace, we need to try our best to mark block
+	 * group RO, to prevent race between:
+	 * - Write duplication
+	 *   Contains latest data
+	 * - Scrub copy
+	 *   Contains data from commit tree
+	 *
+	 * If target block group is not marked RO, nocow writes can
+	 * be overwritten by scrub copy, causing data corruption.
+	 * So for dev-replace, it's not allowed to continue if a block
+	 * group is not RO.
+	 */
+	ret = btrfs_inc_block_group_ro(bg, sctx->is_dev_replace);
+	if (!ret && sctx->is_dev_replace) {
+		ret = finish_extent_writes_for_zoned(root, bg);
+		if (ret) {
+			btrfs_dec_block_group_ro(bg);
+			scrub_pause_off(fs_info);
+			return ret;
+		}
+	}
+
+	if (ret == 0) {
+		ro_set = 1;
+	} else if (ret == -ENOSPC && !sctx->is_dev_replace &&
+		   !(bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
+		/*
+		 * btrfs_inc_block_group_ro return -ENOSPC when it
+		 * failed in creating new chunk for metadata.
+		 * It is not a problem for scrub, because
+		 * metadata are always cowed, and our scrub paused
+		 * commit_transactions.
+		 *
+		 * For RAID56 chunks, we have to mark them read-only
+		 * for scrub, as later we would use our own cache
+		 * out of RAID56 realm.
+		 * Thus we want the RAID56 bg to be marked RO to
+		 * prevent RMW from screwing up out cache.
+		 */
+		ro_set = 0;
+	} else if (ret == -ETXTBSY) {
+		btrfs_warn(fs_info,
+	   "skipping scrub of block group %llu due to active swapfile",
+			   bg->start);
+		btrfs_unfreeze_block_group(bg);
+		scrub_pause_off(fs_info);
+		return ret;
+	} else {
+		btrfs_warn(fs_info,
+			   "failed setting block group ro: %d", ret);
+		btrfs_unfreeze_block_group(bg);
+		scrub_pause_off(fs_info);
+		return ret;
+	}
+
+	/*
+	 * Now the target block is marked RO, wait for nocow writes to
+	 * finish before dev-replace.
+	 * COW is fine, as COW never overwrites extents in commit tree.
+	 */
+	if (sctx->is_dev_replace) {
+		btrfs_wait_nocow_writers(bg);
+		btrfs_wait_ordered_roots(fs_info, U64_MAX, bg->start,
+					 bg->length);
+	}
+	scrub_pause_off(fs_info);
+	*ro_set_ret = ro_set;
+	return 0;
+}
+
 static noinline_for_stack
 int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
@@ -2359,7 +2494,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	struct btrfs_root *root = fs_info->dev_root;
 	u64 chunk_offset;
 	int ret = 0;
-	int ro_set;
 	int slot;
 	struct extent_buffer *l;
 	struct btrfs_key key;
@@ -2380,6 +2514,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
 	while (1) {
+		bool ro_set = false;
 		u64 dev_extent_len;
 
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
@@ -2461,127 +2596,20 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			goto skip;
 		}
 
-		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
-			if (!test_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags)) {
-				btrfs_put_block_group(cache);
-				goto skip;
-			}
+		ret = prepare_scrub_block_group(sctx, cache, &ro_set);
+		if (ret == -ETXTBSY) {
+			ret = 0;
+			goto skip_unfreeze;
 		}
-
-		/*
-		 * Make sure that while we are scrubbing the corresponding block
-		 * group doesn't get its logical address and its device extents
-		 * reused for another block group, which can possibly be of a
-		 * different type and different profile. We do this to prevent
-		 * false error detections and crashes due to bogus attempts to
-		 * repair extents.
-		 */
-		spin_lock(&cache->lock);
-		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &cache->runtime_flags)) {
-			spin_unlock(&cache->lock);
+		if (ret < 0) {
+			btrfs_put_block_group(cache);
+			break;
+		}
+		if (ret > 0) {
 			btrfs_put_block_group(cache);
 			goto skip;
 		}
-		btrfs_freeze_block_group(cache);
-		spin_unlock(&cache->lock);
 
-		/*
-		 * we need call btrfs_inc_block_group_ro() with scrubs_paused,
-		 * to avoid deadlock caused by:
-		 * btrfs_inc_block_group_ro()
-		 * -> btrfs_wait_for_commit()
-		 * -> btrfs_commit_transaction()
-		 * -> btrfs_scrub_pause()
-		 */
-		scrub_pause_on(fs_info);
-
-		/*
-		 * Don't do chunk preallocation for scrub.
-		 *
-		 * This is especially important for SYSTEM bgs, or we can hit
-		 * -EFBIG from btrfs_finish_chunk_alloc() like:
-		 * 1. The only SYSTEM bg is marked RO.
-		 *    Since SYSTEM bg is small, that's pretty common.
-		 * 2. New SYSTEM bg will be allocated
-		 *    Due to regular version will allocate new chunk.
-		 * 3. New SYSTEM bg is empty and will get cleaned up
-		 *    Before cleanup really happens, it's marked RO again.
-		 * 4. Empty SYSTEM bg get scrubbed
-		 *    We go back to 2.
-		 *
-		 * This can easily boost the amount of SYSTEM chunks if cleaner
-		 * thread can't be triggered fast enough, and use up all space
-		 * of btrfs_super_block::sys_chunk_array
-		 *
-		 * While for dev replace, we need to try our best to mark block
-		 * group RO, to prevent race between:
-		 * - Write duplication
-		 *   Contains latest data
-		 * - Scrub copy
-		 *   Contains data from commit tree
-		 *
-		 * If target block group is not marked RO, nocow writes can
-		 * be overwritten by scrub copy, causing data corruption.
-		 * So for dev-replace, it's not allowed to continue if a block
-		 * group is not RO.
-		 */
-		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
-		if (!ret && sctx->is_dev_replace) {
-			ret = finish_extent_writes_for_zoned(root, cache);
-			if (ret) {
-				btrfs_dec_block_group_ro(cache);
-				scrub_pause_off(fs_info);
-				btrfs_put_block_group(cache);
-				break;
-			}
-		}
-
-		if (ret == 0) {
-			ro_set = 1;
-		} else if (ret == -ENOSPC && !sctx->is_dev_replace &&
-			   !(cache->flags & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
-			/*
-			 * btrfs_inc_block_group_ro return -ENOSPC when it
-			 * failed in creating new chunk for metadata.
-			 * It is not a problem for scrub, because
-			 * metadata are always cowed, and our scrub paused
-			 * commit_transactions.
-			 *
-			 * For RAID56 chunks, we have to mark them read-only
-			 * for scrub, as later we would use our own cache
-			 * out of RAID56 realm.
-			 * Thus we want the RAID56 bg to be marked RO to
-			 * prevent RMW from screwing up out cache.
-			 */
-			ro_set = 0;
-		} else if (ret == -ETXTBSY) {
-			btrfs_warn(fs_info,
-		   "skipping scrub of block group %llu due to active swapfile",
-				   cache->start);
-			scrub_pause_off(fs_info);
-			ret = 0;
-			goto skip_unfreeze;
-		} else {
-			btrfs_warn(fs_info,
-				   "failed setting block group ro: %d", ret);
-			btrfs_unfreeze_block_group(cache);
-			btrfs_put_block_group(cache);
-			scrub_pause_off(fs_info);
-			break;
-		}
-
-		/*
-		 * Now the target block is marked RO, wait for nocow writes to
-		 * finish before dev-replace.
-		 * COW is fine, as COW never overwrites extents in commit tree.
-		 */
-		if (sctx->is_dev_replace) {
-			btrfs_wait_nocow_writers(cache);
-			btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start,
-					cache->length);
-		}
-
-		scrub_pause_off(fs_info);
 		down_write(&dev_replace->rwsem);
 		dev_replace->cursor_right = found_key.offset + dev_extent_len;
 		dev_replace->cursor_left = found_key.offset;
@@ -2960,6 +2988,69 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	return ret;
 }
 
+static int scrub_logical_chunks(struct scrub_ctx *sctx, u64 start, u64 end)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u64 cur = start;
+	int ret = 0;
+
+	while (cur < end) {
+		struct btrfs_block_group *bg;
+		bool ro_set = false;
+
+		bg = btrfs_lookup_first_block_group(fs_info, cur);
+
+		/* No more block groups. */
+		if (!bg)
+			break;
+		if (bg->start > end)
+			break;
+
+		ret = prepare_scrub_block_group(sctx, bg, &ro_set);
+		if (ret == -ETXTBSY) {
+			ret = 0;
+			goto next;
+		}
+		if (ret > 0)
+			goto next;
+		if (ret < 0) {
+			btrfs_put_block_group(bg);
+			break;
+		}
+
+		/* The real work starts here. */
+		ret = -EOPNOTSUPP;
+
+		if (ro_set)
+			btrfs_dec_block_group_ro(bg);
+		/*
+		 * We might have prevented the cleaner kthread from deleting
+		 * this block group if it was already unused because we raced
+		 * and set it to RO mode first. So add it back to the unused
+		 * list, otherwise it might not ever be deleted unless a manual
+		 * balance is triggered or it becomes used and unused again.
+		 */
+		spin_lock(&bg->lock);
+		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags) &&
+		    !bg->ro && bg->reserved == 0 && bg->used == 0) {
+			spin_unlock(&bg->lock);
+			if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+				btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
+			else
+				btrfs_mark_bg_unused(bg);
+		} else {
+			spin_unlock(&bg->lock);
+		}
+		btrfs_unfreeze_block_group(bg);
+next:
+		cur = bg->start + bg->length;
+		btrfs_put_block_group(bg);
+		if (ret < 0)
+			break;
+	}
+	return ret;
+}
+
 int btrfs_scrub_logical(struct btrfs_fs_info *fs_info, u64 start, u64 end,
 			struct btrfs_scrub_progress *progress, bool readonly)
 {
@@ -3006,8 +3097,7 @@ int btrfs_scrub_logical(struct btrfs_fs_info *fs_info, u64 start, u64 end,
 	atomic_inc(&fs_info->scrubs_logical_running);
 	mutex_unlock(&fs_info->scrub_lock);
 
-	/* The main work would be implemented. */
-	ret = -EOPNOTSUPP;
+	ret = scrub_logical_chunks(sctx, start, end);
 
 	atomic_dec(&fs_info->scrubs_running);
 	atomic_dec(&fs_info->scrubs_logical_running);
-- 
2.41.0

