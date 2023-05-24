Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4570F9B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjEXPEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjEXPEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:04:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46D119
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ul6qBjh2whd5ArtSwRKT+q24tekO/xv0TlkJHKaAP7w=; b=t+xHlesWkhT0RukzW2wnM0waWf
        YI1UsJfFou11gsdz3dd3ha02W9oGCmMkbU34g7fYK0kZcTJYuHjs3p3Dunsq0rU2cdoIOZ4MwvEJ1
        DBkG3igbhUg3PX79cQcsxSIhtwV/J4kTNFJ6017O9RXPNz5bEevgzRoniG8Xjc06bQZNmnSv2tW24
        1rXpre0Pxwv2dtiwn5lX08IPQ/ueGMAlSNtxHlSDUgZn78ZLeS8vgQHmQ3sXLSDc8XUVMT/+AjIv0
        wVkVe5DOHc7/7YMj2Iwsy9f9VxD0exiXji2gb4it0T9LJtyTDsPyacNsj4xoQqTm3yYIFBL+hMdCd
        w0e5C1Og==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1x-00DmiB-2n;
        Wed, 24 May 2023 15:04:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 14/14] btrfs: pass the new logical address to split_extent_map
Date:   Wed, 24 May 2023 17:03:17 +0200
Message-Id: <20230524150317.1767981-15-hch@lst.de>
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

split_extent_map splits off the first chunk of an extent map into a new
one.  One of the two users is the zoned I/O completion code that wants to
rewrite the logical block start address right after this split.  Pass in
the logical address to be set in the split off first extent_map as an
argument to avoid an extra extent tree lookup for this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_map.c | 8 +++++---
 fs/btrfs/extent_map.h | 3 ++-
 fs/btrfs/inode.c      | 3 ++-
 fs/btrfs/zoned.c      | 6 ++----
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 21cc4991360221..b7373fb03898f2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -961,11 +961,13 @@ int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 }
 
 /*
- * Split off the first pre bytes from the extent_map at [start, start + len]
+ * Split off the first pre bytes from the extent_map at [start, start + len],
+ * and set the block_addr for it to new_logical.
  *
  * This function is used when an ordered_extent needs to be split.
  */
-int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre)
+int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
+		     u64 new_logical)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
@@ -1008,7 +1010,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre)
 	split_pre->start = em->start;
 	split_pre->len = pre;
 	split_pre->orig_start = split_pre->start;
-	split_pre->block_start = em->block_start;
+	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
 	split_pre->orig_block_len = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 7df39112388dde..35d27c756e0808 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -90,7 +90,8 @@ struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 int add_extent_mapping(struct extent_map_tree *tree,
 		       struct extent_map *em, int modified);
 void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
-int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre);
+int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
+		     u64 new_logical);
 
 struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eee4eefb279780..5e2315d78ea0cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2736,7 +2736,8 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	 */
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags)) {
 		ret = split_extent_map(bbio->inode, bbio->file_offset,
-				       ordered->num_bytes, len);
+				       ordered->num_bytes, len,
+				       ordered->disk_bytenr);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 92363fafc3a648..bc437259d2a06a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1689,15 +1689,13 @@ static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags) &&
 	    split_extent_map(BTRFS_I(ordered->inode), ordered->file_offset,
-			     ordered->num_bytes, len))
+			     ordered->num_bytes, len, logical))
 		return false;
 
 	new = btrfs_split_ordered_extent(ordered, len);
 	if (IS_ERR(new))
 		return false;
-
-	if (new->disk_bytenr != logical)
-		btrfs_rewrite_logical_zoned(new, logical);
+	new->disk_bytenr = logical;
 	btrfs_finish_one_ordered(new);
 	return true;
 }
-- 
2.39.2

