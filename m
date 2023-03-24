Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A146C75EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCXCcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXCcq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233F39005
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mSP7ij1hPLNEHDEGDCCk5jPLTCYXKhErARWEZePne1M=; b=JDKodo00lS13Md1/iH2dGBTVCR
        ebM7H+VJf/rdM4fNYSmpDL8ef4gWw1zKQdaBn3CwuYYT6Fjv3sjnqM+WZhZ0I05pr4dOq019dru0D
        QuUTanzX07TdDw+lEJiwelfRm49nyCSDL+1kh8oD2suDqeyxK88el5Ko3sA9ew6ByCfOzkyiiybU4
        +EwpM7mJZr4HmkqPeBJDLtm42Ba167UrOCGM93vBRzxkGp8NLab78M/w+37y2l3KH0Lsw7goRu/OQ
        g6JBv0b8PWjH2XWmV2vjuFgu7N06p45j0uwiHpwNxDjwFGMk0GKoHaWnqX4VOt3dqVbagHrGiCDvr
        f36yeIag==;
Received: from [122.147.159.75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXEP-003PJT-1x;
        Fri, 24 Mar 2023 02:32:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: simplify split_zoned_em
Date:   Fri, 24 Mar 2023 10:32:04 +0800
Message-Id: <20230324023207.544800-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324023207.544800-1-hch@lst.de>
References: <20230324023207.544800-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

split_zoned_em is only ever asked to split out the beginning of an extent
map.  Change it to only take a len to split out instead of a pre and post
region.

Also rename the function to split_extent_map as there is nothing zoned
device specific about it.

Note: this function should probably move to extent_map.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 78 +++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bff23bac85f2ef..5b3d6403363814 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2512,37 +2512,32 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 }
 
 /*
- * Split an extent_map at [start, start + len]
+ * Split off the first pre bytes from the extent_map at [start, start + len]
  *
  * This function is intended to be used only for extract_ordered_extent().
  */
-static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
-			  u64 pre, u64 post)
+static int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len,
+			    u64 pre)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	struct extent_map *split_pre = NULL;
 	struct extent_map *split_mid = NULL;
-	struct extent_map *split_post = NULL;
 	int ret = 0;
 	unsigned long flags;
 
-	/* Sanity check */
-	if (pre == 0 && post == 0)
-		return 0;
+	ASSERT(pre != 0);
+	ASSERT(pre < len);
 
 	split_pre = alloc_extent_map();
-	if (pre)
-		split_mid = alloc_extent_map();
-	if (post)
-		split_post = alloc_extent_map();
-	if (!split_pre || (pre && !split_mid) || (post && !split_post)) {
+	if (!split_pre)
+		return -ENOMEM;
+	split_mid = alloc_extent_map();
+	if (!split_mid) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_free_pre;
 	}
 
-	ASSERT(pre + post < len);
-
 	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	write_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
@@ -2563,7 +2558,7 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 
 	/* First, replace the em with a new extent_map starting from * em->start */
 	split_pre->start = em->start;
-	split_pre->len = (pre ? pre : em->len - post);
+	split_pre->len = pre;
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = em->block_start;
 	split_pre->block_len = split_pre->len;
@@ -2577,38 +2572,21 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 
 	/*
 	 * Now we only have an extent_map at:
-	 *     [em->start, em->start + pre] if pre != 0
-	 *     [em->start, em->start + em->len - post] if pre == 0
+	 *     [em->start, em->start + pre]
 	 */
 
-	if (pre) {
-		/* Insert the middle extent_map */
-		split_mid->start = em->start + pre;
-		split_mid->len = em->len - pre - post;
-		split_mid->orig_start = split_mid->start;
-		split_mid->block_start = em->block_start + pre;
-		split_mid->block_len = split_mid->len;
-		split_mid->orig_block_len = split_mid->block_len;
-		split_mid->ram_bytes = split_mid->len;
-		split_mid->flags = flags;
-		split_mid->compress_type = em->compress_type;
-		split_mid->generation = em->generation;
-		add_extent_mapping(em_tree, split_mid, 1);
-	}
-
-	if (post) {
-		split_post->start = em->start + em->len - post;
-		split_post->len = post;
-		split_post->orig_start = split_post->start;
-		split_post->block_start = em->block_start + em->len - post;
-		split_post->block_len = split_post->len;
-		split_post->orig_block_len = split_post->block_len;
-		split_post->ram_bytes = split_post->len;
-		split_post->flags = flags;
-		split_post->compress_type = em->compress_type;
-		split_post->generation = em->generation;
-		add_extent_mapping(em_tree, split_post, 1);
-	}
+	/* Insert the middle extent_map */
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
 
 	/* Once for us */
 	free_extent_map(em);
@@ -2618,11 +2596,9 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 out_unlock:
 	write_unlock(&em_tree->lock);
 	unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
-out:
-	free_extent_map(split_pre);
 	free_extent_map(split_mid);
-	free_extent_map(split_post);
-
+out_free_pre:
+	free_extent_map(split_pre);
 	return ret;
 }
 
@@ -2653,7 +2629,7 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	ret = btrfs_split_ordered_extent(ordered, len);
 	if (ret)
 		goto out;
-	ret = split_zoned_em(inode, bbio->file_offset, ordered_len, len, 0);
+	ret = split_extent_map(inode, bbio->file_offset, ordered_len, len);
 out:
 	btrfs_put_ordered_extent(ordered);
 	return errno_to_blk_status(ret);
-- 
2.39.2

