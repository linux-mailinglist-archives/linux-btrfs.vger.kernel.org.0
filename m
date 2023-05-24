Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108DD70F9AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjEXPDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEXPDv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B21B6
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FtN48NI7aEXGDHKv/29sHWw4zcfCGN2xnTdJnH68sAY=; b=WbP/Ac/ktRps6OyZdodVLnIhyk
        8loFrykZRQRGNp5Azmx7CpOrNtFt8LT3tkTtfPMkZAfHTWTS3uIcnNXOSVRq5fwH6ePB//VFR25mg
        1kWT4y69WABdcOQ2WTa9rBZgbZ3U9DGi1bQwT6LBVycF9lO8JDFoO0R6lStOVVbbEreHgDzzIg1Zi
        HSfv3Au+gxc4cEBQcYXEIKumacs8lJhitwElcWf5rt82J7FWwlqMQ3+zc7v69Wrk181Ef7UXAbZvu
        XWxzXlB+1n/OpcgOeu3PSrbfe3Z7jRMKSyobBKN2pdGRiLrfAY34dVtcGPO6v7puv3DzwFG/f9H9g
        qQSdhhMg==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1b-00DmcE-0t;
        Wed, 24 May 2023 15:03:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 06/14] btrfs: move split_extent_map to extent_map.c
Date:   Wed, 24 May 2023 17:03:09 +0200
Message-Id: <20230524150317.1767981-7-hch@lst.de>
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

split_extent_map doesn't have anything to do with the other code in
inode.c, so move it to extent_map.c.

This also allows marking replace_extent_mapping static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_map.c | 99 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/extent_map.h |  5 +--
 fs/btrfs/inode.c      | 90 ---------------------------------------
 3 files changed, 96 insertions(+), 98 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 138afa955370bc..21cc4991360221 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -502,10 +502,10 @@ void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
 	RB_CLEAR_NODE(&em->rb_node);
 }
 
-void replace_extent_mapping(struct extent_map_tree *tree,
-			    struct extent_map *cur,
-			    struct extent_map *new,
-			    int modified)
+static void replace_extent_mapping(struct extent_map_tree *tree,
+				   struct extent_map *cur,
+				   struct extent_map *new,
+				   int modified)
 {
 	lockdep_assert_held_write(&tree->lock);
 
@@ -959,3 +959,94 @@ int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 
 	return ret;
 }
+
+/*
+ * Split off the first pre bytes from the extent_map at [start, start + len]
+ *
+ * This function is used when an ordered_extent needs to be split.
+ */
+int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre)
+{
+	struct extent_map_tree *em_tree = &inode->extent_tree;
+	struct extent_map *em;
+	struct extent_map *split_pre = NULL;
+	struct extent_map *split_mid = NULL;
+	int ret = 0;
+	unsigned long flags;
+
+	ASSERT(pre != 0);
+	ASSERT(pre < len);
+
+	split_pre = alloc_extent_map();
+	if (!split_pre)
+		return -ENOMEM;
+	split_mid = alloc_extent_map();
+	if (!split_mid) {
+		ret = -ENOMEM;
+		goto out_free_pre;
+	}
+
+	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
+	write_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, start, len);
+	if (!em) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+
+	ASSERT(em->len == len);
+	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
+	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
+	ASSERT(test_bit(EXTENT_FLAG_PINNED, &em->flags));
+	ASSERT(!test_bit(EXTENT_FLAG_LOGGING, &em->flags));
+	ASSERT(!list_empty(&em->list));
+
+	flags = em->flags;
+	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
+
+	/* First, replace the em with a new extent_map starting from * em->start */
+	split_pre->start = em->start;
+	split_pre->len = pre;
+	split_pre->orig_start = split_pre->start;
+	split_pre->block_start = em->block_start;
+	split_pre->block_len = split_pre->len;
+	split_pre->orig_block_len = split_pre->block_len;
+	split_pre->ram_bytes = split_pre->len;
+	split_pre->flags = flags;
+	split_pre->compress_type = em->compress_type;
+	split_pre->generation = em->generation;
+
+	replace_extent_mapping(em_tree, em, split_pre, 1);
+
+	/*
+	 * Now we only have an extent_map at:
+	 *     [em->start, em->start + pre]
+	 */
+
+	/* Insert the middle extent_map. */
+	split_mid->start = em->start + pre;
+	split_mid->len = em->len - pre;
+	split_mid->orig_start = split_mid->start;
+	split_mid->block_start = em->block_start + pre;
+	split_mid->block_len = split_mid->len;
+	split_mid->orig_block_len = split_mid->block_len;
+	split_mid->ram_bytes = split_mid->len;
+	split_mid->flags = flags;
+	split_mid->compress_type = em->compress_type;
+	split_mid->generation = em->generation;
+	add_extent_mapping(em_tree, split_mid, 1);
+
+	/* Once for us */
+	free_extent_map(em);
+	/* Once for the tree */
+	free_extent_map(em);
+
+out_unlock:
+	write_unlock(&em_tree->lock);
+	unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
+	free_extent_map(split_mid);
+out_free_pre:
+	free_extent_map(split_pre);
+	return ret;
+}
+
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index ad311864272a00..7df39112388dde 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -90,10 +90,7 @@ struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 int add_extent_mapping(struct extent_map_tree *tree,
 		       struct extent_map *em, int modified);
 void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
-void replace_extent_mapping(struct extent_map_tree *tree,
-			    struct extent_map *cur,
-			    struct extent_map *new,
-			    int modified);
+int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre);
 
 struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2eee57d07d3632..781bd0d48f02ce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2714,96 +2714,6 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	}
 }
 
-/*
- * Split off the first pre bytes from the extent_map at [start, start + len]
- *
- * This function is intended to be used only for extract_ordered_extent().
- */
-static int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre)
-{
-	struct extent_map_tree *em_tree = &inode->extent_tree;
-	struct extent_map *em;
-	struct extent_map *split_pre = NULL;
-	struct extent_map *split_mid = NULL;
-	int ret = 0;
-	unsigned long flags;
-
-	ASSERT(pre != 0);
-	ASSERT(pre < len);
-
-	split_pre = alloc_extent_map();
-	if (!split_pre)
-		return -ENOMEM;
-	split_mid = alloc_extent_map();
-	if (!split_mid) {
-		ret = -ENOMEM;
-		goto out_free_pre;
-	}
-
-	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
-	write_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
-	if (!em) {
-		ret = -EIO;
-		goto out_unlock;
-	}
-
-	ASSERT(em->len == len);
-	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
-	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
-	ASSERT(test_bit(EXTENT_FLAG_PINNED, &em->flags));
-	ASSERT(!test_bit(EXTENT_FLAG_LOGGING, &em->flags));
-	ASSERT(!list_empty(&em->list));
-
-	flags = em->flags;
-	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
-
-	/* First, replace the em with a new extent_map starting from * em->start */
-	split_pre->start = em->start;
-	split_pre->len = pre;
-	split_pre->orig_start = split_pre->start;
-	split_pre->block_start = em->block_start;
-	split_pre->block_len = split_pre->len;
-	split_pre->orig_block_len = split_pre->block_len;
-	split_pre->ram_bytes = split_pre->len;
-	split_pre->flags = flags;
-	split_pre->compress_type = em->compress_type;
-	split_pre->generation = em->generation;
-
-	replace_extent_mapping(em_tree, em, split_pre, 1);
-
-	/*
-	 * Now we only have an extent_map at:
-	 *     [em->start, em->start + pre]
-	 */
-
-	/* Insert the middle extent_map. */
-	split_mid->start = em->start + pre;
-	split_mid->len = em->len - pre;
-	split_mid->orig_start = split_mid->start;
-	split_mid->block_start = em->block_start + pre;
-	split_mid->block_len = split_mid->len;
-	split_mid->orig_block_len = split_mid->block_len;
-	split_mid->ram_bytes = split_mid->len;
-	split_mid->flags = flags;
-	split_mid->compress_type = em->compress_type;
-	split_mid->generation = em->generation;
-	add_extent_mapping(em_tree, split_mid, 1);
-
-	/* Once for us */
-	free_extent_map(em);
-	/* Once for the tree */
-	free_extent_map(em);
-
-out_unlock:
-	write_unlock(&em_tree->lock);
-	unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
-	free_extent_map(split_mid);
-out_free_pre:
-	free_extent_map(split_pre);
-	return ret;
-}
-
 int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 				 struct btrfs_ordered_extent *ordered)
 {
-- 
2.39.2

