Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71B053A469
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiFALwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbiFALwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 07:52:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE22F3AD
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 04:52:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DDA6221B28;
        Wed,  1 Jun 2022 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654084340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ipvGseej/Tf0PhQ+Tq3tvNwlnLw4GDCvor7cYcucifI=;
        b=YVBf9qmT5VCw/V38ka/+ejD04Tvbo0yY1rJzBOzHW2GjvZ9bhDFEKlgRH2oK7poQ+UhbU5
        stG6YKOjd/KHOG6FFcQWEits333grftHf0ElZEgLl1kzi/ygPRORRqddKWBLByiE5vaMic
        IfUT6zMaHjd6uIGtjhJ+pScSN0yaw0s=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D58F02C141;
        Wed,  1 Jun 2022 11:52:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D8F5DA823; Wed,  1 Jun 2022 13:47:56 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove redundant calls to flush_dcache_page
Date:   Wed,  1 Jun 2022 13:47:54 +0200
Message-Id: <20220601114754.21771-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

memzero_page already calls flush_dcache_page so we can remove the calls
from btrfs code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 2 --
 fs/btrfs/extent_io.c   | 7 +------
 fs/btrfs/inode.c       | 6 ++----
 fs/btrfs/reflink.c     | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6ab82e142f1f..2536754656b6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -760,7 +760,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 				int zeros;
 				zeros = PAGE_SIZE - zero_offset;
 				memzero_page(page, zero_offset, zeros);
-				flush_dcache_page(page);
 			}
 		}
 
@@ -1476,7 +1475,6 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 		ASSERT(copy_start - decompressed < buf_len);
 		memcpy_to_page(bvec.bv_page, bvec.bv_offset,
 			       buf + copy_start - decompressed, copy_len);
-		flush_dcache_page(bvec.bv_page);
 		cur_offset += copy_len;
 
 		bio_advance(orig_bio, copy_len);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b3122700dfbf..b9d431ed20b4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3639,7 +3639,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (zero_offset) {
 			iosize = PAGE_SIZE - zero_offset;
 			memzero_page(page, zero_offset, iosize);
-			flush_dcache_page(page);
 		}
 	}
 	begin_page_read(fs_info, page);
@@ -3654,7 +3653,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 			iosize = PAGE_SIZE - pg_offset;
 			memzero_page(page, pg_offset, iosize);
-			flush_dcache_page(page);
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
@@ -3738,7 +3736,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			struct extent_state *cached = NULL;
 
 			memzero_page(page, pg_offset, iosize);
-			flush_dcache_page(page);
 
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
@@ -4156,10 +4153,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	if (page->index == end_index) {
+	if (page->index == end_index)
 		memzero_page(page, pg_offset, PAGE_SIZE - pg_offset);
-		flush_dcache_page(page);
-	}
 
 	ret = set_page_extent_mapped(page);
 	if (ret < 0) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ba913ea6f4d1..ca7e8214e45b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4872,7 +4872,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		else
 			memzero_page(page, (block_start - page_offset(page)) + offset,
 				     len);
-		flush_dcache_page(page);
 	}
 	btrfs_page_clear_checked(fs_info, page, block_start,
 				 block_end + 1 - block_start);
@@ -8585,10 +8584,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	else
 		zero_start = PAGE_SIZE;
 
-	if (zero_start != PAGE_SIZE) {
+	if (zero_start != PAGE_SIZE)
 		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
-		flush_dcache_page(page);
-	}
+
 	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
 	btrfs_page_set_dirty(fs_info, page, page_start, end + 1 - page_start);
 	btrfs_page_set_uptodate(fs_info, page, page_start, end + 1 - page_start);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c39f8b3a5a4a..c01fcbf22bb5 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -110,7 +110,6 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	if (comp_type == BTRFS_COMPRESS_NONE) {
 		memcpy_to_page(page, offset_in_page(file_offset), data_start,
 			       datal);
-		flush_dcache_page(page);
 	} else {
 		ret = btrfs_decompress(comp_type, data_start, page,
 				       offset_in_page(file_offset),
@@ -132,10 +131,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	 *
 	 * So what's in the range [500, 4095] corresponds to zeroes.
 	 */
-	if (datal < block_size) {
+	if (datal < block_size)
 		memzero_page(page, datal, block_size - datal);
-		flush_dcache_page(page);
-	}
 
 	btrfs_page_set_uptodate(fs_info, page, file_offset, block_size);
 	btrfs_page_clear_checked(fs_info, page, file_offset, block_size);
-- 
2.36.1

