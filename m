Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7966D6A8BBA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCBWZa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCBWZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F891ACFC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8109D2006A;
        Thu,  2 Mar 2023 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XdAe69CcLEJrm69PQqUCtA/hKhTPtcRgz0t4zCDbog=;
        b=MQuDKQ92FhE3w/AeQTY4q47o14dahWyCF0n2ajsmOr/8LQjiQ4cY0ZiftS/FdMztzyir/s
        Tpa+5Dfbk8Vipoc+j5GyFQp4Fhi4C2/1BQO4Uxq1OiygWwl1nxtHo/BFh8lVKSb0nuPcVy
        u9vkbF8Fl9i4cj0BiFx26JU4Q3TGXM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XdAe69CcLEJrm69PQqUCtA/hKhTPtcRgz0t4zCDbog=;
        b=/3eyQDYzFL31eRWEAG5QVmoucVww/rfQ/8Q0O0kcGB5VLLdZDBBnd+/MYtavMsH6msuX4P
        /K/ZRc06wT79uhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A26513349;
        Thu,  2 Mar 2023 22:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oVfBA1YiAWS6SQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:26 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 10/21] btrfs: lock extents before pages in writepages
Date:   Thu,  2 Mar 2023 16:24:55 -0600
Message-Id: <cbfeae924ea1a4afcbb727312c548c54e2c5ab94.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
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

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

writepages() locks the extents in find_lock_delalloc_range() and unlocks
using clear_bit EXTENT_LOCKED operations is cow/delalloc operations.

Call extent locking/unlocking around writepages() sequence as opposed to
while performing delayed allocation.

This converts a range_cyclic wbc to non-range_cyclic wbc with the range
set to start from writeback_index and ending at inode size. This is done
because inode size can change while the writepages() is going on. So,
the number of pages accounted for writeback in wbc are accurate.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c        |  5 ----
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 53 ++++++++++++++++++++++++++++---------
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e44329a84caf..cdce2db82d7e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -483,15 +483,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 		}
 	}
 
-	/* step three, lock the state bits for the whole range */
-	lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
-
 	/* then test to make sure it is all still delalloc */
 	ret = test_range_bit(tree, delalloc_start, delalloc_end,
 			     EXTENT_DELALLOC, 1, cached_state);
 	if (!ret) {
-		unlock_extent(tree, delalloc_start, delalloc_end,
-			      &cached_state);
 		__unlock_for_delalloc(inode, locked_page,
 			      delalloc_start, delalloc_end);
 		cond_resched();
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d250d052487..2373f248d70f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -355,9 +355,9 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_i_size_write(inode, 0);
-	truncate_pagecache(vfs_inode, 0);
 
 	lock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
+	truncate_pagecache(vfs_inode, 0);
 	btrfs_drop_extent_map_range(inode, 0, (u64)-1, false);
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 53bd9a64e803..eeddd7cdff58 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -977,7 +977,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				   struct async_extent *async_extent,
 				   u64 *alloc_hint)
 {
-	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key ins;
@@ -998,7 +997,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 		if (!(start >= locked_page_end || end <= locked_page_start))
 			locked_page = async_chunk->locked_page;
 	}
-	lock_extent(io_tree, start, end, NULL);
 
 	/* We have fall back to uncompressed write */
 	if (!async_extent->pages)
@@ -1052,7 +1050,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 
 	/* Clear dirty, set writeback and unlock the pages. */
 	extent_clear_unlock_delalloc(inode, start, end,
-			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
+			NULL, EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
 	if (btrfs_submit_compressed_write(inode, start,	/* file_offset */
 			    async_extent->ram_size,	/* num_bytes */
@@ -1080,7 +1078,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_free:
 	extent_clear_unlock_delalloc(inode, start, end,
-				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
+				     NULL, EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
@@ -1248,7 +1246,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 */
 			extent_clear_unlock_delalloc(inode, start, end,
 				     locked_page,
-				     EXTENT_LOCKED | EXTENT_DELALLOC |
+				     EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
@@ -1359,7 +1357,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
 					     locked_page,
-					     EXTENT_LOCKED | EXTENT_DELALLOC,
+					     EXTENT_DELALLOC,
 					     page_ops);
 		if (num_bytes < cur_alloc_size)
 			num_bytes = 0;
@@ -1410,7 +1408,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * We process each region below.
 	 */
 
-	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+	clear_bits = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
 	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 
@@ -1560,7 +1558,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	memalloc_nofs_restore(nofs_flag);
 
 	if (!ctx) {
-		unsigned clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
+		unsigned clear_bits = EXTENT_DELALLOC |
 			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 			EXTENT_DO_ACCOUNTING;
 		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
@@ -1940,7 +1938,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	path = btrfs_alloc_path();
 	if (!path) {
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
-					     EXTENT_LOCKED | EXTENT_DELALLOC |
+					     EXTENT_DELALLOC |
 					     EXTENT_DO_ACCOUNTING |
 					     EXTENT_DEFRAG, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
@@ -2154,7 +2152,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 						      nocow_args.num_bytes);
 
 		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
-					     locked_page, EXTENT_LOCKED |
+					     locked_page,
 					     EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
@@ -2190,7 +2188,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (ret && cur_offset < end)
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
-					     locked_page, EXTENT_LOCKED |
+					     locked_page,
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
@@ -7845,7 +7843,38 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 static int btrfs_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
-	return extent_writepages(mapping, wbc);
+	u64 start = 0, end = LLONG_MAX;
+	struct inode *inode = mapping->host;
+	struct extent_state *cached = NULL;
+	int ret;
+	loff_t isize = i_size_read(inode);
+	struct writeback_control new_wbc = *wbc;
+
+	if (new_wbc.range_cyclic) {
+		start = mapping->writeback_index << PAGE_SHIFT;
+		end = round_up(isize, PAGE_SIZE) - 1;
+		wbc->range_cyclic = 0;
+		wbc->range_start = start;
+		wbc->range_end = end;
+	} else {
+		start = round_down(wbc->range_start, PAGE_SIZE);
+		end = round_up(wbc->range_end, PAGE_SIZE) - 1;
+	}
+
+	if (start >= end)
+		return 0;
+
+	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
+	ret = extent_writepages(mapping, wbc);
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
+
+	if (new_wbc.range_cyclic) {
+		wbc->range_start = new_wbc.range_start;
+		wbc->range_end = new_wbc.range_end;
+		wbc->range_cyclic = 1;
+	}
+
+	return ret;
 }
 
 static void btrfs_readahead_begin(struct readahead_control *rac)
-- 
2.39.2

