Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D970F9B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjEXPD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjEXPD4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01D135
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vFT9DIT/710KgU21y1fWb0/ep59degejgmkJl84kUcQ=; b=nhb88pcBdGZgddxRLMBfcymit+
        bB1Q3ITSZY7YHpcwg477PDG0uZBixMyXs4C2i0CuMOTlL0BcAVIj0ByEGRDOL6ueV0DACO+TjYEpB
        Qd4v7C1d5hJpPGmPM68oeP9tJXU4sPnBE66zV8E/KulKAHxYruxBd0Y+FXO3j8Io+hS2ktNCPW/fh
        uMHdOhXE+dCRYNyzv8UtAWAjMKXmC3uBmukG+wc9B/kDNgIlHq1dSHq/2WoJUTluO9P1kSA5Hdz8J
        z4d4JnQlN8DW5a/KM9ioPPGowyllKSzMA5/SOuhpoI3LNudVANNauFeLCDaGBPGAqJs42064iIheh
        4xZ2qTXQ==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1l-00DmfK-2L;
        Wed, 24 May 2023 15:03:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 10/14] btrfs: split btrfs_alloc_ordered_extent
Date:   Wed, 24 May 2023 17:03:13 +0200
Message-Id: <20230524150317.1767981-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Split two low-level helpers out of btrfs_alloc_ordered_extent to allocate
and insert the logic extent.  The pure alloc helper will be used to
improve btrfs_split_ordered_extent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 114 +++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 997d79046d9b62..54783f67f479ad 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -146,35 +146,11 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 	return ret;
 }
 
-/*
- * Add an ordered extent to the per-inode tree.
- *
- * @inode:           Inode that this extent is for.
- * @file_offset:     Logical offset in file where the extent starts.
- * @num_bytes:       Logical length of extent in file.
- * @ram_bytes:       Full length of unencoded data.
- * @disk_bytenr:     Offset of extent on disk.
- * @disk_num_bytes:  Size of extent on disk.
- * @offset:          Offset into unencoded data where file data starts.
- * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
- * @compress_type:   Compression algorithm used for data.
- *
- * Most of these parameters correspond to &struct btrfs_file_extent_item. The
- * tree is given a single reference on the ordered extent that was inserted, and
- * the returned pointer is given a second reference.
- *
- * Return: the new ordered extent or error pointer.
- */
-struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
-			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type)
+static struct btrfs_ordered_extent *
+alloc_ordered_extent(struct btrfs_inode *inode, u64 file_offset, u64 num_bytes,
+		     u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
+		     u64 offset, unsigned long flags, int compress_type)
 {
-	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
-	struct rb_node *node;
 	struct btrfs_ordered_extent *entry;
 	int ret;
 
@@ -184,7 +160,6 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
 		if (ret < 0)
 			return ERR_PTR(ret);
-		ret = 0;
 	} else {
 		/*
 		 * The ordered extent has reserved qgroup space, release now
@@ -209,14 +184,7 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
-
-	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 	entry->flags = flags;
-
-	percpu_counter_add_batch(&fs_info->ordered_bytes, num_bytes,
-				 fs_info->delalloc_batch);
-
-	/* one ref for the tree */
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
 	INIT_LIST_HEAD(&entry->list);
@@ -225,15 +193,40 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 	INIT_LIST_HEAD(&entry->work_list);
 	init_completion(&entry->completion);
 
+	/*
+	 * We don't need the count_max_extents here, we can assume that all of
+	 * that work has been done at higher layers, so this is truly the
+	 * smallest the extent is going to get.
+	 */
+	spin_lock(&inode->lock);
+	btrfs_mod_outstanding_extents(inode, 1);
+	spin_unlock(&inode->lock);
+
+	return entry;
+}
+
+static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
+{
+	struct btrfs_inode *inode = BTRFS_I(entry->inode);
+	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct rb_node *node;
+
 	trace_btrfs_ordered_extent_add(inode, entry);
 
+	percpu_counter_add_batch(&fs_info->ordered_bytes, entry->num_bytes,
+				 fs_info->delalloc_batch);
+
+	/* one ref for the tree */
+	refcount_inc(&entry->refs);
+
 	spin_lock_irq(&tree->lock);
-	node = tree_insert(&tree->tree, file_offset,
-			   &entry->rb_node);
+	node = tree_insert(&tree->tree, entry->file_offset, &entry->rb_node);
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
 				"inconsistency in ordered tree at offset %llu",
-				file_offset);
+				entry->file_offset);
 	spin_unlock_irq(&tree->lock);
 
 	spin_lock(&root->ordered_extent_lock);
@@ -247,19 +240,42 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 		spin_unlock(&fs_info->ordered_root_lock);
 	}
 	spin_unlock(&root->ordered_extent_lock);
+}
 
-	/*
-	 * We don't need the count_max_extents here, we can assume that all of
-	 * that work has been done at higher layers, so this is truly the
-	 * smallest the extent is going to get.
-	 */
-	spin_lock(&inode->lock);
-	btrfs_mod_outstanding_extents(inode, 1);
-	spin_unlock(&inode->lock);
+/*
+ * Add an ordered extent to the per-inode tree.
+ *
+ * @inode:           Inode that this extent is for.
+ * @file_offset:     Logical offset in file where the extent starts.
+ * @num_bytes:       Logical length of extent in file.
+ * @ram_bytes:       Full length of unencoded data.
+ * @disk_bytenr:     Offset of extent on disk.
+ * @disk_num_bytes:  Size of extent on disk.
+ * @offset:          Offset into unencoded data where file data starts.
+ * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
+ * @compress_type:   Compression algorithm used for data.
+ *
+ * Most of these parameters correspond to &struct btrfs_file_extent_item. The
+ * tree is given a single reference on the ordered extent that was inserted, and
+ * the returned pointer is given a second reference.
+ *
+ * Return: the new ordered extent or error pointer.
+ */
+struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset,
+			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			u64 disk_num_bytes, u64 offset, unsigned long flags,
+			int compress_type)
+{
+	struct btrfs_ordered_extent *entry;
 
-	/* One ref for the returned entry to match semantics of lookup. */
-	refcount_inc(&entry->refs);
+	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 
+	entry = alloc_ordered_extent(inode, file_offset, num_bytes, ram_bytes,
+				     disk_bytenr, disk_num_bytes, offset, flags,
+				     compress_type);
+	if (!IS_ERR(entry))
+		insert_ordered_extent(entry);
 	return entry;
 }
 
-- 
2.39.2

