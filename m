Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE38F630
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfHOVEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 17:04:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42205 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbfHOVEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 17:04:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so1926817pfk.9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQD1Wzh+eK794Ap752FKwUYZlZQqcmk1MAQEbQF6Cfs=;
        b=Qb/Cna7hlQtJp4MOaWoONYB7V/Md5Jly/TUSenRnJGPaFK3oXo3dEJdQc7yvXRU6Yp
         pAMxRRhE0nn6lJ8gt3ZWdsWo/VHvGPb2kl18iuGuw88EaXkakcLPz3R7jSyOrsysLSlR
         oGbArVhQ5i9DForD4RSS5nMCp7UH0ouI49UNkIUgNbSvc8FO9UUhQj4T7ywNsIXnrQQV
         8Nhi1ssGM05v5fmUMbuH/EoRtzODo3Evmvxeb7mLaF1E0+5dE09J9reG2HheuHtdRVK2
         sGr2+FIaaYFxY2UVx/nEQ0AxG/kCwNfQofp9uBOuYvtkVeRKUcExBB+q94XrmejN60Es
         7ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQD1Wzh+eK794Ap752FKwUYZlZQqcmk1MAQEbQF6Cfs=;
        b=eq3mI7U7deBb+SCbH+4t+uUSGmVO9zMhaoHwNnAFlIm5ExWDa3hCPIA57cIHVFwolF
         O/FLq0xkIODDoOzwfUNNOL3ZFByJMuMk44dIzzeG20tCTfuxvqB+0FhTGr53TQliXWpC
         Vy2jH4w2hegfbOeHXglivImaLLbygPtc2jBl5IDCQbm48/bOV2znbBcMzkUFnqmeBbg8
         GKuydIGUqVNgh5bsdEcemUfpjgcl0rBAm1Dwmtr+XQxdeQlVASIS4r1sxbBGbiuZA/AK
         fe4soVxHcOX9l+hqdmbkB+XlzAFPazMKxGUGmUort7s5kCWv+v+oguQ5U+82glVdlc38
         adLg==
X-Gm-Message-State: APjAAAWfyUQFMtGPGT8Tf2wMh0lp5E6lSNKlRTExepO6OqR8/BP40J+1
        ZD8MDesM1u6j1PEC0VkNDm9shXfg2sM=
X-Google-Smtp-Source: APXvYqz1xCalV8EyNBjtVCbeB/rukt9cthsA2yP1xNHCATz8QkQssW3c6/4BNOgRcvm9A9QaAcYEIQ==
X-Received: by 2002:a63:c84d:: with SMTP id l13mr4969070pgi.154.1565903060986;
        Thu, 15 Aug 2019 14:04:20 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:2aa9])
        by smtp.gmail.com with ESMTPSA id i124sm4073230pfe.61.2019.08.15.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:04:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 3/5] Btrfs: stop clearing EXTENT_DIRTY in inode I/O tree
Date:   Thu, 15 Aug 2019 14:04:04 -0700
Message-Id: <8aa3a13a33ef65994613409ea605e22280a23480.1565900769.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565900769.git.osandov@fb.com>
References: <cover.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Since commit fee187d9d9dd ("Btrfs: do not set EXTENT_DIRTY along with
EXTENT_DELALLOC"), we never set EXTENT_DIRTY in inode->io_tree, so we
can simplify and stop trying to clear it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c         |  6 ++----
 fs/btrfs/file.c              |  4 ++--
 fs/btrfs/free-space-cache.c  |  9 ++++----
 fs/btrfs/inode.c             | 41 ++++++++++++++----------------------
 fs/btrfs/ioctl.c             |  5 ++---
 fs/btrfs/tests/inode-tests.c | 12 ++++-------
 6 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bac59d721b54..4dc5e6939856 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4322,10 +4322,8 @@ int extent_invalidatepage(struct extent_io_tree *tree,
 
 	lock_extent_bits(tree, start, end, &cached_state);
 	wait_on_page_writeback(page);
-	clear_extent_bit(tree, start, end,
-			 EXTENT_LOCKED | EXTENT_DIRTY | EXTENT_DELALLOC |
-			 EXTENT_DO_ACCOUNTING,
-			 1, 1, &cached_state);
+	clear_extent_bit(tree, start, end, EXTENT_LOCKED | EXTENT_DELALLOC |
+			 EXTENT_DO_ACCOUNTING, 1, 1, &cached_state);
 	return 0;
 }
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 27223753da7b..c080fbcbda11 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -537,8 +537,8 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 	 * we can set things up properly
 	 */
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos, end_of_last_block,
-			 EXTENT_DIRTY | EXTENT_DELALLOC |
-			 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 0, 0, cached);
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
+			 0, 0, cached);
 
 	if (!btrfs_is_free_space_inode(BTRFS_I(inode))) {
 		if (start_pos >= isize &&
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index faaf57a7c289..96cf1e2dc388 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1005,7 +1005,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DIRTY | EXTENT_DELALLOC, 0, 0, NULL);
+				 EXTENT_DELALLOC, 0, 0, NULL);
 		goto fail;
 	}
 	leaf = path->nodes[0];
@@ -1017,9 +1017,8 @@ update_cache_item(struct btrfs_trans_handle *trans,
 		if (found_key.objectid != BTRFS_FREE_SPACE_OBJECTID ||
 		    found_key.offset != offset) {
 			clear_extent_bit(&BTRFS_I(inode)->io_tree, 0,
-					 inode->i_size - 1,
-					 EXTENT_DIRTY | EXTENT_DELALLOC, 0, 0,
-					 NULL);
+					 inode->i_size - 1, EXTENT_DELALLOC, 0,
+					 0, NULL);
 			btrfs_release_path(path);
 			goto fail;
 		}
@@ -1115,7 +1114,7 @@ static int flush_dirty_cache(struct inode *inode)
 	ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DIRTY | EXTENT_DELALLOC, 0, 0, NULL);
+				 EXTENT_DELALLOC, 0, 0, NULL);
 
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 612c25aac15c..491755921c4b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4935,9 +4935,8 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	}
 
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, block_start, block_end,
-			  EXTENT_DIRTY | EXTENT_DELALLOC |
-			  EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			  0, 0, &cached_state);
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
+			 0, 0, &cached_state);
 
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
@@ -5321,9 +5320,9 @@ static void evict_inode_truncate_pages(struct inode *inode)
 			btrfs_qgroup_free_data(inode, NULL, start, end - start + 1);
 
 		clear_extent_bit(io_tree, start, end,
-				 EXTENT_LOCKED | EXTENT_DIRTY |
-				 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-				 EXTENT_DEFRAG, 1, 1, &cached_state);
+				 EXTENT_LOCKED | EXTENT_DELALLOC |
+				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1, 1,
+				 &cached_state);
 
 		cond_resched();
 		spin_lock(&io_tree->lock);
@@ -7690,12 +7689,9 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	u64 start = iblock << inode->i_blkbits;
 	u64 lockstart, lockend;
 	u64 len = bh_result->b_size;
-	int unlock_bits = EXTENT_LOCKED;
 	int ret = 0;
 
-	if (create)
-		unlock_bits |= EXTENT_DIRTY;
-	else
+	if (!create)
 		len = min_t(u64, len, fs_info->sectorsize);
 
 	lockstart = start;
@@ -7754,9 +7750,8 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 		if (ret < 0)
 			goto unlock_err;
 
-		/* clear and unlock the entire range */
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-				 unlock_bits, 1, 0, &cached_state);
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
+				     lockend, &cached_state);
 	} else {
 		ret = btrfs_get_blocks_direct_read(em, bh_result, inode,
 						   start, len);
@@ -7772,9 +7767,8 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 		 */
 		lockstart = start + bh_result->b_size;
 		if (lockstart < lockend) {
-			clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
-					 lockend, unlock_bits, 1, 0,
-					 &cached_state);
+			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+					     lockstart, lockend, &cached_state);
 		} else {
 			free_extent_state(cached_state);
 		}
@@ -7785,8 +7779,8 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	return 0;
 
 unlock_err:
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			 unlock_bits, 1, 0, &cached_state);
+	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			     &cached_state);
 err:
 	if (dio_data)
 		current->journal_info = dio_data;
@@ -8801,8 +8795,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		 */
 		if (!inode_evicting)
 			clear_extent_bit(tree, start, end,
-					 EXTENT_DIRTY | EXTENT_DELALLOC |
-					 EXTENT_DELALLOC_NEW |
+					 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, 1, 0, &cached_state);
 		/*
@@ -8857,8 +8850,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	if (PageDirty(page))
 		btrfs_qgroup_free_data(inode, NULL, page_start, PAGE_SIZE);
 	if (!inode_evicting) {
-		clear_extent_bit(tree, page_start, page_end,
-				 EXTENT_LOCKED | EXTENT_DIRTY |
+		clear_extent_bit(tree, page_start, page_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1, 1,
 				 &cached_state);
@@ -8986,9 +8978,8 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * reserve data&meta space before lock_page() (see above comments).
 	 */
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
-			  EXTENT_DIRTY | EXTENT_DELALLOC |
-			  EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			  0, 0, &cached_state);
+			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			  EXTENT_DEFRAG, 0, 0, &cached_state);
 
 	ret2 = btrfs_set_extent_delalloc(inode, page_start, end, 0,
 					&cached_state);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4eabd419aaca..4b383811a7d2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1333,9 +1333,8 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	lock_extent_bits(&BTRFS_I(inode)->io_tree,
 			 page_start, page_end - 1, &cached_state);
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start,
-			  page_end - 1, EXTENT_DIRTY | EXTENT_DELALLOC |
-			  EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 0, 0,
-			  &cached_state);
+			  page_end - 1, EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			  EXTENT_DEFRAG, 0, 0, &cached_state);
 
 	if (i_done != page_cnt) {
 		spin_lock(&BTRFS_I(inode)->lock);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index b363fb990cec..09ecf7dc7b08 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -988,8 +988,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
 			       BTRFS_MAX_EXTENT_SIZE >> 1,
 			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
-			       EXTENT_DELALLOC | EXTENT_DIRTY |
-			       EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1056,8 +1055,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
 			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
 			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
-			       EXTENT_DIRTY | EXTENT_DELALLOC |
-			       EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1089,8 +1087,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* Empty */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-			       EXTENT_DIRTY | EXTENT_DELALLOC |
-			       EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1105,8 +1102,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 out:
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-				 EXTENT_DIRTY | EXTENT_DELALLOC |
-				 EXTENT_UPTODATE, 0, 0, NULL);
+				 EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
-- 
2.17.1

