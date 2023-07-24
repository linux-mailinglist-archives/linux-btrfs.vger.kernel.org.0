Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8675F9BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjGXOWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGXOWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:22:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CEBC
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=319R32b0U8OC06DymviRccGHCPYdZ117hoeWCv+aEeI=; b=wWtSKw708n5UK51iPjvd5MNAfA
        uyAlxk3/d4Y7rVGbnbO0S5g9pdPxF0PPFhdvqnM6tQCBEbrcX3NkNRMeTkgtS5uitmeo9cP8C4b1s
        6pX+rpJip/VaXZSKWqOb7v/kl3qx1XJmEfElWLWa7WVw04A/1CC8F8XZQ8DvpJpNKegySfzoZP9uP
        1UH+fnCo5c70roZxLtj1QBDOBt6DB1pH3LLkmHx4VyLVsYRDgqySI9Y/ox6/rlbJsq0v3iM1NI6w7
        GUzVtvzm310Z9WjoFf/cedR0XhB4REJ2RwHxAfdHvn4u1D0gu5+R+IFm4mg2PYo3gJo9CBgFqFW3g
        EKU/oROA==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwSR-004b9d-2w;
        Mon, 24 Jul 2023 14:22:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: cleanup the COW fallback logic in run_delalloc_nocow
Date:   Mon, 24 Jul 2023 07:22:39 -0700
Message-Id: <20230724142243.5742-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
References: <20230724142243.5742-1-hch@lst.de>
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

Use the block group pointer used to track the outstanding NOCOW writes as
a boolean to remove the duplicate nocow variable, and keep it contained
in the main loop to simplify the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 434f82fa4957d3..212aca4eea442b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1976,8 +1976,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	int ret;
 	bool check_prev = true;
 	u64 ino = btrfs_ino(inode);
-	struct btrfs_block_group *bg;
-	bool nocow = false;
 	struct can_nocow_file_extent_args nocow_args = { 0 };
 
 	path = btrfs_alloc_path();
@@ -1995,6 +1993,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	nocow_args.writeback_path = true;
 
 	while (1) {
+		struct btrfs_block_group *nocow_bg = NULL;
 		struct btrfs_ordered_extent *ordered;
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
@@ -2005,8 +2004,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		int extent_type;
 		bool is_prealloc;
 
-		nocow = false;
-
 		ret = btrfs_lookup_file_extent(NULL, root, path, ino,
 					       cur_offset, 0);
 		if (ret < 0)
@@ -2065,7 +2062,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (found_key.offset > cur_offset) {
 			extent_end = found_key.offset;
 			extent_type = 0;
-			goto out_check;
+			goto must_cow;
 		}
 
 		/*
@@ -2098,18 +2095,19 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (ret < 0)
 			goto error;
 		if (ret == 0)
-			goto out_check;
+			goto must_cow;
 
 		ret = 0;
-		bg = btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr);
-		if (bg)
-			nocow = true;
-out_check:
-		/*
-		 * If nocow is false then record the beginning of the range
-		 * that needs to be COWed
-		 */
-		if (!nocow) {
+		nocow_bg = btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr);
+		if (!nocow_bg) {
+must_cow:
+			/*
+			 * If we can't perform NOCOW writeback for the range,
+			 * then record the beginning of the range that needs to
+			 * be COWed.  It will be written out before the next
+			 * NOCOW range if we find one, or when exiting this
+			 * loop.
+			 */
 			if (cow_start == (u64)-1)
 				cow_start = cur_offset;
 			cur_offset = extent_end;
@@ -2130,8 +2128,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			ret = fallback_to_cow(inode, locked_page,
 					      cow_start, found_key.offset - 1);
 			cow_start = (u64)-1;
-			if (ret)
+			if (ret) {
+				btrfs_dec_nocow_writers(nocow_bg);
 				goto error;
+			}
 		}
 
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
@@ -2148,6 +2148,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
+				btrfs_dec_nocow_writers(nocow_bg);
 				ret = PTR_ERR(em);
 				goto error;
 			}
@@ -2161,6 +2162,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				? (1 << BTRFS_ORDERED_PREALLOC)
 				: (1 << BTRFS_ORDERED_NOCOW),
 				BTRFS_COMPRESS_NONE);
+		btrfs_dec_nocow_writers(nocow_bg);
 		if (IS_ERR(ordered)) {
 			if (is_prealloc) {
 				btrfs_drop_extent_map_range(inode, cur_offset,
@@ -2170,11 +2172,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			goto error;
 		}
 
-		if (nocow) {
-			btrfs_dec_nocow_writers(bg);
-			nocow = false;
-		}
-
 		if (btrfs_is_data_reloc_root(root))
 			/*
 			 * Error handled later, as we must prevent
@@ -2215,10 +2212,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			goto error;
 	}
 
-error:
-	if (nocow)
-		btrfs_dec_nocow_writers(bg);
+	btrfs_free_path(path);
+	return 0;
 
+error:
 	/*
 	 * If an error happened while a COW region is outstanding, cur_offset
 	 * needs to be reset to cow_start to ensure the COW region is unlocked
@@ -2226,7 +2223,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	if (cow_start != (u64)-1)
 		cur_offset = cow_start;
-	if (ret && cur_offset < end)
+	if (cur_offset < end)
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
-- 
2.39.2

