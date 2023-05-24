Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99B70F9B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbjEXPD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbjEXPD4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1439119
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kSJtRobl1ttr1aB2H9C+CIkrLgQeh1DiyvqU25dCgew=; b=O/48prWD+nJ5tylksp3lL6AufY
        F3lDm1MGGuRS81+CsVro6tY4QsE8/UqqiBdwY8BEuCE4cRSKoPjYbkomH0qkqnE0MSwicDyeLmlTY
        ZTE9f/5kWlZpVhzORzBPX7sy3+Z9SEs888SMek7RS29v37FC4sxND1PY/HeQKgsQrAs6CD1w/oI9O
        nPiUmb66DS19/p6jNm7n6k9MmyYZjIVqJAcx+SLasitAK3SSdKtXjV3vxF5Rb8LaUkpVhtDJuhJmh
        1N6wy7hJXlxlAj4zZM4PAd1SdY8xZkRW10WgYK7FNfS3Tko7CN1OjojIOAYn+4HAjnn1caW5mua9C
        s/hKpEDQ==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1p-00Dmfz-1F;
        Wed, 24 May 2023 15:03:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 11/14] btrfs: atomically insert the new extent in btrfs_split_ordered_extent
Date:   Wed, 24 May 2023 17:03:14 +0200
Message-Id: <20230524150317.1767981-12-hch@lst.de>
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

Currently there is a small race window in btrfs_split_ordered_extent,
where the reduced old extent can be looked up on the per-inode rbtree
or the per-root list while the newly split out one isn't visible yet.

Fix this by open coding btrfs_alloc_ordered_extent in
btrfs_split_ordered_extent, and holding the tree lock and
root->ordered_extent_lock over the entire tree and extent manipulation.

Note that this introduces new lock ordering because previously
ordered_extent_lock was never held over the tree lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 43 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 54783f67f479ad..bf0a0d67306649 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1135,15 +1135,17 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 struct btrfs_ordered_extent *
 btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 {
-	struct inode *inode = ordered->inode;
-	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 file_offset = ordered->file_offset;
 	u64 disk_bytenr = ordered->disk_bytenr;
 	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
+	struct btrfs_ordered_extent *new;
 	struct rb_node *node;
 
-	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
+	trace_btrfs_ordered_extent_split(inode, ordered);
 
 	ASSERT(!(flags & (1U << BTRFS_ORDERED_COMPRESSED)));
 
@@ -1163,7 +1165,16 @@ btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 	if (WARN_ON_ONCE(!list_empty(&ordered->list)))
 		return ERR_PTR(-EINVAL);
 
-	spin_lock_irq(&tree->lock);
+	new = alloc_ordered_extent(inode, file_offset, len, len, disk_bytenr,
+				   len, 0, flags, ordered->compress_type);
+	if (IS_ERR(new))
+		return new;
+
+	/* one ref for the tree */
+	refcount_inc(&new->refs);
+
+	spin_lock_irq(&root->ordered_extent_lock);
+	spin_lock(&tree->lock);
 	/* Remove from tree once */
 	node = &ordered->rb_node;
 	rb_erase(node, &tree->tree);
@@ -1182,19 +1193,19 @@ btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
 			"zoned: inconsistency in ordered tree at offset %llu",
-			    ordered->file_offset);
+			ordered->file_offset);
 
-	spin_unlock_irq(&tree->lock);
-
-	/*
-	 * The splitting extent is already counted and will be added again in
-	 * btrfs_alloc_ordered_extent(). Subtract len to avoid double counting.
-	 */
-	percpu_counter_add_batch(&fs_info->ordered_bytes, -len, fs_info->delalloc_batch);
+	node = tree_insert(&tree->tree, new->file_offset, &new->rb_node);
+	if (node)
+		btrfs_panic(fs_info, -EEXIST,
+			"zoned: inconsistency in ordered tree at offset %llu",
+			new->file_offset);
+	spin_unlock(&tree->lock);
 
-	return btrfs_alloc_ordered_extent(BTRFS_I(inode), file_offset, len, len,
-					  disk_bytenr, len, 0, flags,
-					  ordered->compress_type);
+	list_add_tail(&new->root_extent_list, &root->ordered_extents);
+	root->nr_ordered_extents++;
+	spin_unlock_irq(&root->ordered_extent_lock);
+	return new;
 }
 
 int __init ordered_data_init(void)
-- 
2.39.2

