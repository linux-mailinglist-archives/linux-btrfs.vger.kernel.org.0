Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4806174562A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjGCHd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjGCHdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64561E4F
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F35C218FF
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7UcBoD8ykDpd7MsZoEk2hGzeznd/vqK1/A/5c0ZlR4=;
        b=AbgMoU6+l3v/z2GgFdhhjo9d1R9uPZrupkYgcaTGiXLd7l9HQGNEI9ljOEYFiamQtACl0g
        zTl+3XxzRrVBhpnf4QLTJKQwjEjd9y8YvB+PIqkpp294S1LJjI7EvBGbzEyvYvUaHH5nsf
        ka/s+2Zaq6agmBRyFs54o2NzHMR1QPM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B4FA13276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eK36DLJ5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/14] btrfs: scrub: extract the common preparation before scrubbing a block group
Date:   Mon,  3 Jul 2023 15:32:32 +0800
Message-ID: <f0cd2611725d035f479a01161dc4afc4d8c07cea.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, prepare_scrub_block_group(), to handle the
checks before scrubbing a block group.

For now the helper is only called by scrub_enumerate_chunks(), but would
be reused by later scrub_logical feature.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 264 ++++++++++++++++++++++++++---------------------
 1 file changed, 147 insertions(+), 117 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ff637f83aa0e..806c4683a7ef 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2343,6 +2343,143 @@ static int finish_extent_writes_for_zoned(struct btrfs_root *root,
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
+	if (ret == 0)
+		ro_set = 1;
+	if (ret == -ENOSPC && !sctx->is_dev_replace &&
+		   !(bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK))
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
+
+	if (ret == -ETXTBSY) {
+		btrfs_warn(fs_info,
+	   "skipping scrub of block group %llu due to active swapfile",
+			   bg->start);
+		btrfs_unfreeze_block_group(bg);
+		scrub_pause_off(fs_info);
+		return ret;
+	}
+	if (ret < 0) {
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
@@ -2353,7 +2490,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	struct btrfs_root *root = fs_info->dev_root;
 	u64 chunk_offset;
 	int ret = 0;
-	int ro_set;
 	int slot;
 	struct extent_buffer *l;
 	struct btrfs_key key;
@@ -2374,6 +2510,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
 	while (1) {
+		bool ro_set = false;
 		u64 dev_extent_len;
 
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
@@ -2455,127 +2592,20 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
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
-- 
2.41.0

