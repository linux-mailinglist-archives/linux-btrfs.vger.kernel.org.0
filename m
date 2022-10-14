Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60B5FE95A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 09:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiJNHRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 03:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJNHRh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 03:17:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398A4C6955
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 00:17:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEC9A2201F
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665731854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dp8NxvPfeb2cmoIUSOHSQxUCClGPz6Jekny4F3iSyJk=;
        b=Tbbz1EpsBQyc9oiTtBlVFiukhtmVGcLaH4l1tKdZBjHrIIKK19qxOV/o7wqJBJ10BuuK3e
        3UGzNTS1xy4fSSCUn6kNkP9QFleLH9uiiMv8ebKRt8gETSYRszWe1w/8JQdARDF5EDjJH2
        Wn4pfTyLWLPcZ0w5CNohZbHlzqCZ9VA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B7DF13451
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Iw2AA4NSWOsUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/5] btrfs: introduce a bitmap based csum range search function
Date:   Fri, 14 Oct 2022 15:17:11 +0800
Message-Id: <0c4cd30d323b4e25937849652985391dd666d32e.1665730948.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665730948.git.wqu@suse.com>
References: <cover.1665730948.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we have an existing function, btrfs_lookup_csums_range(), to
find all data checksum for a range, it's based on a btrfs_ordered_sum
list.

For the incoming RAID56 data checksum verification at RMW time, we don't
want to waste time memory allocating the temporary memory.

So this patch will introduce a new helper, btrfs_lookup_csums_bitmap().

The new helper will use bitmap based result, which will be a perfect fit
for later RAID56 usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |   8 ++-
 fs/btrfs/file-item.c  | 127 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/inode.c      |   6 +-
 fs/btrfs/relocation.c |   4 +-
 fs/btrfs/scrub.c      |   8 +--
 fs/btrfs/tree-log.c   |  16 +++---
 6 files changed, 146 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a8b629a166be..7cf011b28c71 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2990,9 +2990,11 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 				u64 offset, bool one_ordered);
-int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
-			     struct list_head *list, int search_commit,
-			     bool nowait);
+int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
+			    struct list_head *list, int search_commit,
+			    bool nowait);
+int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
+			      u8 *csum_buf, unsigned long *csum_bitmap);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 8d9c4488d86a..b52f13a1bb20 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -523,9 +523,9 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	return ret;
 }
 
-int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
-			     struct list_head *list, int search_commit,
-			     bool nowait)
+int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
+			    struct list_head *list, int search_commit,
+			    bool nowait)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
@@ -657,6 +657,127 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 	return ret;
 }
 
+/*
+ * Do the same work as btrfs_lookup_csums_list(), the different is in how
+ * we return the result.
+ *
+ * This version will set the corresponding bits in @csum_bitmap to represent
+ * there is a csum found.
+ * Each bit represents a sector. Thus caller should ensure @csum_buf passed
+ * in is large enough to contain all csums.
+ */
+int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
+			      u8 *csum_buf, unsigned long *csum_bitmap)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_key key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_csum_item *item;
+	const u64 orig_start = start;
+	int ret;
+
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(end + 1, fs_info->sectorsize));
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+	key.offset = start;
+	key.type = BTRFS_EXTENT_CSUM_KEY;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto fail;
+	if (ret > 0 && path->slots[0] > 0) {
+		leaf = path->nodes[0];
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
+
+		/*
+		 * There are two cases we can hit here for the previous
+		 * csum item.
+		 *
+		 *		|<- search range ->|
+		 *	|<- csum item ->|
+		 *
+		 * Or
+		 *				|<- search range ->|
+		 *	|<- csum item ->|
+		 *
+		 * Check if the previous csum item covers the leading part
+		 * of the search range.
+		 * If so we have to start from previous csum item.
+		 */
+		if (key.objectid == BTRFS_EXTENT_CSUM_OBJECTID &&
+		    key.type == BTRFS_EXTENT_CSUM_KEY) {
+			if (bytes_to_csum_size(fs_info, start - key.offset) <
+			    btrfs_item_size(leaf, path->slots[0] - 1))
+				path->slots[0]--;
+		}
+	}
+
+	while (start <= end) {
+		u64 csum_end;
+
+		leaf = path->nodes[0];
+		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(root, path);
+			if (ret < 0)
+				goto fail;
+			if (ret > 0)
+				break;
+			leaf = path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
+		    key.type != BTRFS_EXTENT_CSUM_KEY ||
+		    key.offset > end)
+			break;
+
+		if (key.offset > start)
+			start = key.offset;
+
+		csum_end = key.offset + csum_size_to_bytes(fs_info,
+					btrfs_item_size(leaf, path->slots[0]));
+		if (csum_end <= start) {
+			path->slots[0]++;
+			continue;
+		}
+
+		csum_end = min(csum_end, end + 1);
+		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				      struct btrfs_csum_item);
+		while (start < csum_end) {
+			unsigned long offset;
+			size_t size;
+			u8 *csum_dest = csum_buf + bytes_to_csum_size(fs_info,
+						start - orig_start);
+
+			size = min_t(size_t, csum_end - start, end + 1 - start);
+
+			offset = bytes_to_csum_size(fs_info, start - key.offset);
+
+			read_extent_buffer(path->nodes[0], csum_dest,
+					   ((unsigned long)item) + offset,
+					   bytes_to_csum_size(fs_info, size));
+
+			bitmap_set(csum_bitmap,
+				(start - orig_start) >> fs_info->sectorsize_bits,
+				size >> fs_info->sectorsize_bits);
+
+			start += size;
+		}
+		path->slots[0]++;
+	}
+	ret = 0;
+fail:
+	btrfs_free_path(path);
+	return ret;
+}
+
 /**
  * Calculate checksums of the data contained inside a bio
  *
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d347362a87d3..69ea6bbda293 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1695,9 +1695,9 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 	int ret;
 	LIST_HEAD(list);
 
-	ret = btrfs_lookup_csums_range(csum_root, bytenr,
-				       bytenr + num_bytes - 1, &list, 0,
-				       nowait);
+	ret = btrfs_lookup_csums_list(csum_root, bytenr,
+				      bytenr + num_bytes - 1, &list, 0,
+				      nowait);
 	if (ret == 0 && list_empty(&list))
 		return 0;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 216a4485d914..3cbcf7f010be 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4343,8 +4343,8 @@ int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
 
 	disk_bytenr = file_pos + inode->index_cnt;
 	csum_root = btrfs_csum_root(fs_info, disk_bytenr);
-	ret = btrfs_lookup_csums_range(csum_root, disk_bytenr,
-				       disk_bytenr + len - 1, &list, 0, false);
+	ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
+				      disk_bytenr + len - 1, &list, 0, false);
 	if (ret)
 		goto out;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9e3b2e60e571..ac59493977a9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3238,9 +3238,9 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 		extent_dev = bioc->stripes[0].dev;
 		btrfs_put_bioc(bioc);
 
-		ret = btrfs_lookup_csums_range(csum_root, extent_start,
-					       extent_start + extent_size - 1,
-					       &sctx->csum_list, 1, false);
+		ret = btrfs_lookup_csums_list(csum_root, extent_start,
+					      extent_start + extent_size - 1,
+					      &sctx->csum_list, 1, false);
 		if (ret) {
 			scrub_parity_mark_sectors_error(sparity, extent_start,
 							extent_size);
@@ -3464,7 +3464,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			    cur_logical;
 
 		if (extent_flags & BTRFS_EXTENT_FLAG_DATA) {
-			ret = btrfs_lookup_csums_range(csum_root, cur_logical,
+			ret = btrfs_lookup_csums_list(csum_root, cur_logical,
 					cur_logical + scrub_len - 1,
 					&sctx->csum_list, 1, false);
 			if (ret)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 813986e38258..faf783a3c00b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -799,7 +799,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 					btrfs_file_extent_num_bytes(eb, item);
 			}
 
-			ret = btrfs_lookup_csums_range(root->log_root,
+			ret = btrfs_lookup_csums_list(root->log_root,
 						csum_start, csum_end - 1,
 						&ordered_sums, 0, false);
 			if (ret)
@@ -4400,9 +4400,9 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 
 		csum_root = btrfs_csum_root(trans->fs_info, disk_bytenr);
 		disk_bytenr += extent_offset;
-		ret = btrfs_lookup_csums_range(csum_root, disk_bytenr,
-					       disk_bytenr + extent_num_bytes - 1,
-					       &ordered_sums, 0, false);
+		ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
+					      disk_bytenr + extent_num_bytes - 1,
+					      &ordered_sums, 0, false);
 		if (ret)
 			goto out;
 
@@ -4595,10 +4595,10 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 
 	/* block start is already adjusted for the file extent offset. */
 	csum_root = btrfs_csum_root(trans->fs_info, em->block_start);
-	ret = btrfs_lookup_csums_range(csum_root,
-				       em->block_start + csum_offset,
-				       em->block_start + csum_offset +
-				       csum_len - 1, &ordered_sums, 0, false);
+	ret = btrfs_lookup_csums_list(csum_root,
+				      em->block_start + csum_offset,
+				      em->block_start + csum_offset +
+				      csum_len - 1, &ordered_sums, 0, false);
 	if (ret)
 		return ret;
 
-- 
2.37.3

