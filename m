Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430664B1EA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 07:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbiBKGmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 01:42:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbiBKGmJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 01:42:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C38E7B
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 22:42:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DAD2A1F3A6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 06:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644561726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DG2iG+mtCzQ6aIw5eCA4CmjcqC2z2wBoFg2sPtE8xKA=;
        b=t3aWDKadus5F4jLr8dfT0TGKFSaE4uLfHKk3WjuyIFi+x7AhWMA70zCkIppxUJMmfOh/vL
        0QHG9EWjRw+Neu8Z3oZ0L4HuZB10EjeEj7QXRCQuJ7QTXKpoTGmrtyyw9ol8GvFm05VY8v
        5uQOyhN0TH9civLTvaSMFic6CmL9tT4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EC4B13345
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 06:42:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CPcRAz4FBmLmUAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 06:42:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 4/5] btrfs: defrag: use btrfs_defrag_ctrl to replace btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
Date:   Fri, 11 Feb 2022 14:41:42 +0800
Message-Id: <fa04631c4ccce78a6e5fad0283360920c54e1b22.1644561438.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644561438.git.wqu@suse.com>
References: <cover.1644561438.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This brings the following benefits:

- No more strange range->start update to indicate last scanned bytenr
  We have btrfs_defrag_ctrl::last_scanned (exclusive) for it directly.

- No more return value to indicate defragged sectors
  Now btrfs_defrag_file() will just return 0 if no error happened.
  And btrfs_defrag_ctrl::sectors_defragged will show that value.

- Less parameters to carry around
  Now most defrag_* functions only need to fetch its policy parameters
  from btrfs_defrag_ctrl directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |   3 +-
 fs/btrfs/file.c  |  21 +++---
 fs/btrfs/ioctl.c | 165 ++++++++++++++++++++---------------------------
 3 files changed, 82 insertions(+), 107 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 670622fddd62..ac222a9ce166 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3338,8 +3338,7 @@ int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
 				    struct btrfs_defrag_ctrl *ctrl,
 				    u64 max_sectors_to_defrag, u64 newer_than);
 int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
-		      struct btrfs_ioctl_defrag_range_args *range,
-		      u64 newer_than, unsigned long max_to_defrag);
+		      struct btrfs_defrag_ctrl *ctrl);
 void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c462896122dc..12e63be6a35b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -277,8 +277,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_root *inode_root;
 	struct inode *inode;
-	struct btrfs_ioctl_defrag_range_args range;
-	int num_defrag;
+	struct btrfs_defrag_ctrl ctrl = {0};
 	int ret;
 
 	/* get the inode */
@@ -297,21 +296,23 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 
 	/* do a chunk of defrag */
 	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
-	memset(&range, 0, sizeof(range));
-	range.len = (u64)-1;
-	range.start = defrag->last_offset;
+	ctrl.len = (u64)-1;
+	ctrl.start = defrag->last_offset;
+	ctrl.newer_than = defrag->transid;
+	ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
 
 	sb_start_write(fs_info->sb);
-	num_defrag = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
-				       BTRFS_DEFRAG_BATCH);
+	ret = btrfs_defrag_file(inode, NULL, &ctrl);
 	sb_end_write(fs_info->sb);
+	if (ret < 0)
+		goto out;
 	/*
 	 * if we filled the whole defrag batch, there
 	 * must be more work to do.  Queue this defrag
 	 * again
 	 */
-	if (num_defrag == BTRFS_DEFRAG_BATCH) {
-		defrag->last_offset = range.start;
+	if (ctrl.sectors_defragged == BTRFS_DEFRAG_BATCH) {
+		defrag->last_offset = ctrl.last_scanned;
 		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
 	} else if (defrag->last_offset && !defrag->cycled) {
 		/*
@@ -325,7 +326,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	} else {
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	}
-
+out:
 	iput(inode);
 	return 0;
 cleanup:
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c6a971033336..28c81ac7b837 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1191,23 +1191,20 @@ struct defrag_target_range {
 /*
  * Collect all valid target extents.
  *
+ * @ctrl:	   extra defrag policy control
  * @start:	   file offset to lookup
  * @len:	   length to lookup
- * @extent_thresh: file extent size threshold, any extent size >= this value
- *		   will be ignored
- * @newer_than:    only defrag extents newer than this value
- * @do_compress:   whether the defrag is doing compression
- *		   if true, @extent_thresh will be ignored and all regular
- *		   file extents meeting @newer_than will be targets.
  * @locked:	   if the range has already held extent lock
  * @target_list:   list of targets file extents
+ *
+ * Will update ctrl::last_scanned.
  */
 static int defrag_collect_targets(struct btrfs_inode *inode,
-				  u64 start, u64 len, u32 extent_thresh,
-				  u64 newer_than, bool do_compress, bool locked,
-				  struct list_head *target_list,
-				  u64 *last_scanned_ret)
+				  struct btrfs_defrag_ctrl *ctrl,
+				  u64 start, u32 len, bool locked,
+				  struct list_head *target_list)
 {
+	bool do_compress = ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
 	bool last_is_target = false;
 	u64 cur = start;
 	int ret = 0;
@@ -1229,7 +1226,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			goto next;
 
 		/* Skip older extent */
-		if (em->generation < newer_than)
+		if (em->generation < ctrl->newer_than)
 			goto next;
 
 		/* This em is under writeback, no need to defrag */
@@ -1273,7 +1270,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			goto add;
 
 		/* Skip too large extent */
-		if (range_len >= extent_thresh)
+		if (range_len >= ctrl->extent_thresh)
 			goto next;
 
 		/*
@@ -1345,16 +1342,21 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			kfree(entry);
 		}
 	}
-	if (!ret && last_scanned_ret) {
+	if (!ret) {
 		/*
 		 * If the last extent is not a target, the caller can skip to
 		 * the end of that extent.
 		 * Otherwise, we can only go the end of the spcified range.
+		 *
+		 * And we may got a range smaller than current
+		 * ctrl->last_scanned (e.g. executed in the defrag_one_range
+		 * call), so we have to ensure we didn't decrease
+		 * ctrl->last_scanned.
 		 */
 		if (!last_is_target)
-			*last_scanned_ret = max(cur, *last_scanned_ret);
+			ctrl->last_scanned = max(cur, ctrl->last_scanned);
 		else
-			*last_scanned_ret = max(start + len, *last_scanned_ret);
+			ctrl->last_scanned = max(start + len, ctrl->last_scanned);
 	}
 	return ret;
 }
@@ -1414,9 +1416,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	return ret;
 }
 
-static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
-			    u32 extent_thresh, u64 newer_than, bool do_compress,
-			    u64 *last_scanned_ret)
+static int defrag_one_range(struct btrfs_inode *inode,
+			    struct btrfs_defrag_ctrl *ctrl, u64 start, u32 len)
 {
 	struct extent_state *cached_state = NULL;
 	struct defrag_target_range *entry;
@@ -1460,9 +1461,8 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	 * And this time we have extent locked already, pass @locked = true
 	 * so that we won't relock the extent range and cause deadlock.
 	 */
-	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, true,
-				     &target_list, last_scanned_ret);
+	ret = defrag_collect_targets(inode, ctrl, start, len, true,
+				     &target_list);
 	if (ret < 0)
 		goto unlock_extent;
 
@@ -1492,13 +1492,17 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	return ret;
 }
 
+/*
+ * Return <0 for error.
+ * Return >0 if we hit the ctrl->max_sectors_to_defrag limit
+ * Return 0 if we finished the range without error.
+ *
+ * For >= 0 case, ctrl->last_scanned and ctrl->sectors_defragged will be updated.
+ */
 static int defrag_one_cluster(struct btrfs_inode *inode,
 			      struct file_ra_state *ra,
-			      u64 start, u32 len, u32 extent_thresh,
-			      u64 newer_than, bool do_compress,
-			      unsigned long *sectors_defragged,
-			      unsigned long max_sectors,
-			      u64 *last_scanned_ret)
+			      struct btrfs_defrag_ctrl *ctrl,
+			      u64 start, u32 len)
 {
 	const u32 sectorsize = inode->root->fs_info->sectorsize;
 	struct defrag_target_range *entry;
@@ -1506,9 +1510,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	LIST_HEAD(target_list);
 	int ret;
 
-	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, false,
-				     &target_list, NULL);
+	ret = defrag_collect_targets(inode, ctrl, start, len, false,
+				     &target_list);
 	if (ret < 0)
 		goto out;
 
@@ -1516,23 +1519,16 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		u32 range_len = entry->len;
 
 		/* Reached or beyond the limit */
-		if (max_sectors && *sectors_defragged >= max_sectors) {
+		if (ctrl->max_sectors_to_defrag &&
+		    ctrl->sectors_defragged >= ctrl->max_sectors_to_defrag) {
 			ret = 1;
 			break;
 		}
 
-		if (max_sectors)
+		if (ctrl->max_sectors_to_defrag)
 			range_len = min_t(u32, range_len,
-				(max_sectors - *sectors_defragged) * sectorsize);
-
-		/*
-		 * If defrag_one_range() has updated last_scanned_ret,
-		 * our range may already be invalid (e.g. hole punched).
-		 * Skip if our range is before last_scanned_ret, as there is
-		 * no need to defrag the range anymore.
-		 */
-		if (entry->start + range_len <= *last_scanned_ret)
-			continue;
+				(ctrl->max_sectors_to_defrag -
+				 ctrl->sectors_defragged) * sectorsize);
 
 		if (ra)
 			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
@@ -1545,21 +1541,17 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		 * But that's fine, it only affects the @sectors_defragged
 		 * accounting.
 		 */
-		ret = defrag_one_range(inode, entry->start, range_len,
-				       extent_thresh, newer_than, do_compress,
-				       last_scanned_ret);
+		ret = defrag_one_range(inode, ctrl, entry->start, range_len);
 		if (ret < 0)
 			break;
-		*sectors_defragged += range_len >>
-				      inode->root->fs_info->sectorsize_bits;
+		ctrl->sectors_defragged += range_len >>
+					   inode->root->fs_info->sectorsize_bits;
 	}
 out:
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
 		list_del_init(&entry->list);
 		kfree(entry);
 	}
-	if (ret >= 0)
-		*last_scanned_ret = max(*last_scanned_ret, start + len);
 	return ret;
 }
 
@@ -1609,59 +1601,47 @@ int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
  *
  * @inode:	   inode to be defragged
  * @ra:		   readahead state (can be NUL)
- * @range:	   defrag options including range and flags
- * @newer_than:	   minimum transid to defrag
- * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
- *		   will be defragged.
+ * @ctrl:	   defrag options including range and various policy parameters
  *
  * Return <0 for error.
- * Return >=0 for the number of sectors defragged, and range->start will be updated
- * to indicate the file offset where next defrag should be started at.
- * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
- *  defragging all the range).
+ * Return 0 if the defrag is done without error, ctrl->last_scanned and
+ * ctrl->sectors_defragged will be updated.
  */
 int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
-		      struct btrfs_ioctl_defrag_range_args *range,
-		      u64 newer_than, unsigned long max_to_defrag)
+		      struct btrfs_defrag_ctrl *ctrl)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	unsigned long sectors_defragged = 0;
 	u64 isize = i_size_read(inode);
 	u64 cur;
 	u64 last_byte;
-	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
+	bool do_compress = ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
 	bool ra_allocated = false;
-	int compress_type = BTRFS_COMPRESS_ZLIB;
 	int ret = 0;
-	u32 extent_thresh = range->extent_thresh;
 	pgoff_t start_index;
 
 	if (isize == 0)
 		return 0;
 
-	if (range->start >= isize)
+	if (ctrl->start >= isize)
 		return -EINVAL;
 
-	if (do_compress) {
-		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
-			return -EINVAL;
-		if (range->compress_type)
-			compress_type = range->compress_type;
-	}
+	if (do_compress)
+		ASSERT(ctrl->compress < BTRFS_NR_COMPRESS_TYPES);
 
-	if (extent_thresh == 0)
-		extent_thresh = SZ_256K;
+	if (ctrl->extent_thresh == 0)
+		ctrl->extent_thresh = SZ_256K;
 
-	if (range->start + range->len > range->start) {
+	if (ctrl->start + ctrl->len > ctrl->start) {
 		/* Got a specific range */
-		last_byte = min(isize, range->start + range->len);
+		last_byte = min(isize, ctrl->start + ctrl->len);
 	} else {
 		/* Defrag until file end */
 		last_byte = isize;
 	}
 
 	/* Align the range */
-	cur = round_down(range->start, fs_info->sectorsize);
+	cur = round_down(ctrl->start, fs_info->sectorsize);
+	ctrl->last_scanned = cur;
 	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
 
 	/*
@@ -1685,8 +1665,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		inode->i_mapping->writeback_index = start_index;
 
 	while (cur < last_byte) {
-		const unsigned long prev_sectors_defragged = sectors_defragged;
-		u64 last_scanned = cur;
+		const unsigned long prev_sectors_defragged = ctrl->sectors_defragged;
 		u64 cluster_end;
 
 		if (btrfs_defrag_cancelled(fs_info)) {
@@ -1710,19 +1689,17 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			break;
 		}
 		if (do_compress)
-			BTRFS_I(inode)->defrag_compress = compress_type;
-		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
-				cluster_end + 1 - cur, extent_thresh,
-				newer_than, do_compress, &sectors_defragged,
-				max_to_defrag, &last_scanned);
+			BTRFS_I(inode)->defrag_compress = ctrl->compress;
+		ret = defrag_one_cluster(BTRFS_I(inode), ra, ctrl, cur,
+				cluster_end + 1 - cur);
 
-		if (sectors_defragged > prev_sectors_defragged)
+		if (ctrl->sectors_defragged > prev_sectors_defragged)
 			balance_dirty_pages_ratelimited(inode->i_mapping);
 
 		btrfs_inode_unlock(inode, 0);
 		if (ret < 0)
 			break;
-		cur = max(cluster_end + 1, last_scanned);
+		cur = max(cluster_end + 1, ctrl->last_scanned);
 		if (ret > 0) {
 			ret = 0;
 			break;
@@ -1732,27 +1709,21 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 
 	if (ra_allocated)
 		kfree(ra);
-	/*
-	 * Update range.start for autodefrag, this will indicate where to start
-	 * in next run.
-	 */
-	range->start = cur;
-	if (sectors_defragged) {
+	if (ctrl->sectors_defragged) {
 		/*
 		 * We have defragged some sectors, for compression case they
 		 * need to be written back immediately.
 		 */
-		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
+		if (ctrl->flags & BTRFS_DEFRAG_RANGE_START_IO) {
 			filemap_flush(inode->i_mapping);
 			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 				     &BTRFS_I(inode)->runtime_flags))
 				filemap_flush(inode->i_mapping);
 		}
-		if (range->compress_type == BTRFS_COMPRESS_LZO)
+		if (ctrl->compress == BTRFS_COMPRESS_LZO)
 			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
-		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
+		else if (ctrl->compress == BTRFS_COMPRESS_ZSTD)
 			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
-		ret = sectors_defragged;
 	}
 	if (do_compress) {
 		btrfs_inode_lock(inode, 0);
@@ -3267,6 +3238,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 	struct inode *inode = file_inode(file);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ioctl_defrag_range_args range = {0};
+	struct btrfs_defrag_ctrl ctrl = {0};
 	int ret;
 
 	ret = mnt_want_write_file(file);
@@ -3312,8 +3284,11 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			/* the rest are all set to zero by kzalloc */
 			range.len = (u64)-1;
 		}
-		ret = btrfs_defrag_file(file_inode(file), &file->f_ra,
-					&range, BTRFS_OLDEST_GENERATION, 0);
+		ret = btrfs_defrag_ioctl_args_to_ctrl(root->fs_info, &range,
+						      &ctrl, 0, BTRFS_OLDEST_GENERATION);
+		if (ret < 0)
+			break;
+		ret = btrfs_defrag_file(file_inode(file), &file->f_ra, &ctrl);
 		if (ret > 0)
 			ret = 0;
 		break;
-- 
2.35.0

