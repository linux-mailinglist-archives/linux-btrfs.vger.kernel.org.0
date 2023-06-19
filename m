Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81B5734BDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 08:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjFSGsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 02:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSGsG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 02:48:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4AE13D
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jun 2023 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EmHjEGI5RwNCUkQMYYFchukDY4G0WoIisHyFoBWsgr4=; b=Mr5ucVUQFu/hmBy2we7C+Upsuf
        M5sZ/x5aEIyErhXSbvwAZBn9o6Y+OG86q2F5mBw4O5w7Op9VeOqPhxg9NHs5dlh+KkMsZaeUApnLz
        GQg2waSWGVOyMpL97YMzsS9CHgkMboLAQ1qKf/6DY4aM3xE9OJbBK09asnkCQLdZBCqmBT7eOkzNb
        4o4axHacS2DcYnyezKThL3a0rO5kXRefYG3hqe2YEueF4Ceav/BjJCNOoyy+djHSidSqILQReZXef
        WMA8AycCmBhMYa5dqbguiJurpLEz850RwT2x71w4miRYnN5SRDkuV7UdRhOOrxvE2S0vKvGPZaw9e
        szn+g5ug==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qB8gG-007cuV-0Q;
        Mon, 19 Jun 2023 06:48:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: don't create inline extents in fallback_to_cow
Date:   Mon, 19 Jun 2023 08:47:42 +0200
Message-Id: <20230619064742.629345-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619064742.629345-1-hch@lst.de>
References: <20230619064742.629345-1-hch@lst.de>
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

For nodatacow files, run_delalloc_nocow can still fall back to COW
allocations when required and calls to fallback_to_cow helper for
that.  For such an allocation we can have multiple ordered_extents
for existing extents that NOCOW overwrites and new allocations that
fallback_to_cow creates.  If one of the new extents is an inline
extent, the writepages could would have to avoid normal page writeback
for them as indicated by the page_started return argument, which
run_delalloc_nocow can't return.   Fix this by never creating inline
extents from fallback_to_cow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 92a78940991fcb..cddf54bc330c44 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -126,6 +126,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr);
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
 
 #define CFR_KEEP_LOCKED		(1 << 0)
+#define CFR_NOINLINE		(1 << 1)
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
@@ -1426,7 +1427,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * This means we can trigger inline extent even if we didn't want to.
 	 * So here we skip inline extent creation completely.
 	 */
-	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
+	if (start == 0 && fs_info->sectorsize == PAGE_SIZE &&
+	    !(flags & CFR_NOINLINE)) {
 		u64 actual_end = min_t(u64, i_size_read(&inode->vfs_inode),
 				       end + 1);
 
@@ -1889,15 +1891,17 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 }
 
 static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
-			   const u64 start, const u64 end,
-			   int *page_started, unsigned long *nr_written)
+			   const u64 start, const u64 end)
 {
 	const bool is_space_ino = btrfs_is_free_space_inode(inode);
 	const bool is_reloc_ino = btrfs_is_data_reloc_root(inode->root);
 	const u64 range_bytes = end + 1 - start;
 	struct extent_io_tree *io_tree = &inode->io_tree;
+	int page_started = 0;
+	unsigned long nr_written;
 	u64 range_start = start;
 	u64 count;
+	int ret;
 
 	/*
 	 * If EXTENT_NORESERVE is set it means that when the buffered write was
@@ -1950,8 +1954,15 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 					 NULL);
 	}
 
-	return cow_file_range(inode, locked_page, start, end, page_started,
-			      nr_written, NULL, 0);
+	/*
+	 * Don't try to create inline extents, as a mix of inline extent that
+	 * is written out and unlocked directly and a normal nocow extent
+	 * doesn't work.
+	 */
+	ret = cow_file_range(inode, locked_page, start, end, &page_started,
+			     &nr_written, NULL, CFR_NOINLINE);
+	ASSERT(!page_started);
+	return ret;
 }
 
 struct can_nocow_file_extent_args {
@@ -2100,9 +2111,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
  */
 static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				       struct page *locked_page,
-				       const u64 start, const u64 end,
-				       int *page_started,
-				       unsigned long *nr_written)
+				       const u64 start, const u64 end)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -2270,8 +2279,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 */
 		if (cow_start != (u64)-1) {
 			ret = fallback_to_cow(inode, locked_page,
-					      cow_start, found_key.offset - 1,
-					      page_started, nr_written);
+					      cow_start, found_key.offset - 1);
 			if (ret)
 				goto error;
 			cow_start = (u64)-1;
@@ -2352,8 +2360,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (cow_start != (u64)-1) {
 		cur_offset = end;
-		ret = fallback_to_cow(inode, locked_page, cow_start, end,
-				      page_started, nr_written);
+		ret = fallback_to_cow(inode, locked_page, cow_start, end);
 		if (ret)
 			goto error;
 	}
@@ -2412,8 +2419,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		 * preallocated inodes.
 		 */
 		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
-		ret = run_delalloc_nocow(inode, locked_page, start, end,
-					 page_started, nr_written);
+		ret = run_delalloc_nocow(inode, locked_page, start, end);
 		goto out;
 	}
 
-- 
2.39.2

