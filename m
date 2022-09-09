Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A05B41DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiIIVyr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiIIVyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87BFDE85
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cb8so2379183qtb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=5AV8lNES8q04w0Nrq1zOOd7kLmlNyK1rz7UaOeWwM2A=;
        b=u2tgRX9dtvUIdROhIhztFM0CVvLEuKRzsaZo80aDihPdxOLSYlZbJvYu/hUBr2bqVb
         2YlYGeTXwAo7kuOhJUFfmIc8q90pcOw+SpEtybYPU4+Nsq9ychG+UAlsEqdHxh8TIJaX
         xL7h1ALx+YxX4+vG4SzKjjOES07esTtzirhXnlYZw617po4L8Dj7sG0fgpcm3s+ev5ZI
         GRM7PlxE7dxIkIMQ4ILnJwsjIptVa9WLhb/qKERIB+geklHN/Y1Po18LGc+ZCNhbkVgp
         LGuylLKcEH8SUIfe1AwQCc5k1oGBPPT8s8vuomSiloVqJSsXLkyZxujteSXwbhYR1mpj
         d03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5AV8lNES8q04w0Nrq1zOOd7kLmlNyK1rz7UaOeWwM2A=;
        b=RXzkIBz2Sq6fkDplehHr6kPZjpz2XqL9ZgFBrClSEpRYyKTeDLVFXF6i9bwBQLO0rv
         7nTGgwPvZ0Nbyw0DY8KLt2Nn+QrGRLSTy4E5KQlc7Rcn1XZVDBbp6MOm0jl/73LKIG9Y
         owafdzSMBijk2pD3ReIPltPk6baYYC67b5tkTMFldFR3znczcPjmoVzYqFVy2Dkhs4/R
         h8p6plYFRK20pPwuzVxgcxqI3xJz7QbI2rAQAxx7UqO+OED98PFn+MKuIIRj4ZZ0zJmM
         0xbjnxYudPwZ/ue8wzA9pCyDh/MxJ/8mn2fne5rY1P1t3iAXESBeJe5pYKAjRyuTKDYo
         7HVQ==
X-Gm-Message-State: ACgBeo0aiI8Glie9mXqADIzlB3eIFF/rO7j0EUnEGZ/o7gDSmbpB5wp3
        Oib+J8YzCjd0Afz0cX9kQi5+2py2hak6og==
X-Google-Smtp-Source: AA6agR74wIyWt+IffYlkfA8nZNmphgCtRzk/nz3h9oyA9wP1crjFg8myemg1AHbmZxjgg+soB1MrEg==
X-Received: by 2002:a05:622a:1803:b0:343:6cff:1186 with SMTP id t3-20020a05622a180300b003436cff1186mr14834003qtc.74.1662760475137;
        Fri, 09 Sep 2022 14:54:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d16-20020ac800d0000000b0035a691cec8esm1271489qtg.29.2022.09.09.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 30/36] btrfs: unify the lock/unlock extent variants
Date:   Fri,  9 Sep 2022 17:53:43 -0400
Message-Id: <7b0f9f343937c82ab287282ec841d34bc457209a.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have two variants of lock/unlock extent, one set that takes a cached
state, another that does not.  This is slightly annoying, and generally
speaking there are only a few places where we don't have a cached state.
Simplify this by making lock_extent/unlock_extent the only variant and
make it take a cached state, then convert all the callers appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c           |  6 +-
 fs/btrfs/disk-io.c               |  7 +--
 fs/btrfs/extent-io-tree.c        |  4 +-
 fs/btrfs/extent-io-tree.h        | 22 ++-----
 fs/btrfs/extent_io.c             | 39 ++++++-------
 fs/btrfs/file.c                  | 46 +++++++--------
 fs/btrfs/free-space-cache.c      | 16 +++---
 fs/btrfs/inode.c                 | 98 +++++++++++++++-----------------
 fs/btrfs/ioctl.c                 | 22 +++----
 fs/btrfs/ordered-data.c          |  4 +-
 fs/btrfs/reflink.c               |  8 +--
 fs/btrfs/relocation.c            | 18 +++---
 fs/btrfs/tests/extent-io-tests.c |  6 +-
 fs/btrfs/tree-log.c              |  8 +--
 14 files changed, 142 insertions(+), 162 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index cac0eeceb815..54caa00a2245 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -588,7 +588,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
-		lock_extent(tree, cur, page_end);
+		lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
@@ -602,7 +602,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
 		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
-			unlock_extent(tree, cur, page_end);
+			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
 			put_page(page);
 			break;
@@ -622,7 +622,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(cb->orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
-			unlock_extent(tree, cur, page_end);
+			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
 			put_page(page);
 			break;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f2b875b93ddf..0bb0c496a023 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -131,8 +131,7 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	if (atomic)
 		return -EAGAIN;
 
-	lock_extent_bits(io_tree, eb->start, eb->start + eb->len - 1,
-			 &cached_state);
+	lock_extent(io_tree, eb->start, eb->start + eb->len - 1, &cached_state);
 	if (extent_buffer_uptodate(eb) &&
 	    btrfs_header_generation(eb) == parent_transid) {
 		ret = 0;
@@ -145,8 +144,8 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	ret = 1;
 	clear_extent_buffer_uptodate(eb);
 out:
-	unlock_extent_cached(io_tree, eb->start, eb->start + eb->len - 1,
-			     &cached_state);
+	unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
+		      &cached_state);
 	return ret;
 }
 
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 10c8f40c35f6..018fde078d78 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1654,8 +1654,8 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
  * either insert or lock state struct between start and end use mask to tell
  * us if waiting is desired.
  */
-int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		     struct extent_state **cached_state)
+int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		struct extent_state **cached_state)
 {
 	int err;
 	u64 failed_start;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 113727a1c8d1..aa0314f6802c 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -98,13 +98,8 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 void *private_data);
 void extent_io_tree_release(struct extent_io_tree *tree);
 
-int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		     struct extent_state **cached);
-
-static inline int lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	return lock_extent_bits(tree, start, end, NULL);
-}
+int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		struct extent_state **cached);
 
 int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end);
 
@@ -132,20 +127,15 @@ static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				  GFP_NOFS, NULL);
 }
 
-static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	return clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, NULL);
-}
-
-static inline int unlock_extent_cached(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached)
+static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+				struct extent_state **cached)
 {
 	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, cached,
 				  GFP_NOFS, NULL);
 }
 
-static inline int unlock_extent_cached_atomic(struct extent_io_tree *tree,
-		u64 start, u64 end, struct extent_state **cached)
+static inline int unlock_extent_atomic(struct extent_io_tree *tree, u64 start,
+				       u64 end, struct extent_state **cached)
 {
 	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, cached,
 				  GFP_ATOMIC, NULL);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 59fe8f379433..597b89826f53 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -463,14 +463,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	}
 
 	/* step three, lock the state bits for the whole range */
-	lock_extent_bits(tree, delalloc_start, delalloc_end, &cached_state);
+	lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 
 	/* then test to make sure it is all still delalloc */
 	ret = test_range_bit(tree, delalloc_start, delalloc_end,
 			     EXTENT_DELALLOC, 1, cached_state);
 	if (!ret) {
-		unlock_extent_cached(tree, delalloc_start, delalloc_end,
-				     &cached_state);
+		unlock_extent(tree, delalloc_start, delalloc_end,
+			      &cached_state);
 		__unlock_for_delalloc(inode, locked_page,
 			      delalloc_start, delalloc_end);
 		cond_resched();
@@ -914,8 +914,8 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
 	if (uptodate)
 		set_extent_uptodate(&inode->io_tree, offset,
 				    offset + sectorsize - 1, &cached, GFP_ATOMIC);
-	unlock_extent_cached_atomic(&inode->io_tree, offset,
-				    offset + sectorsize - 1, &cached);
+	unlock_extent_atomic(&inode->io_tree, offset, offset + sectorsize - 1,
+			     &cached);
 }
 
 static void submit_data_read_repair(struct inode *inode,
@@ -1119,8 +1119,7 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	 * Now we don't have range contiguous to the processed range, release
 	 * the processed range now.
 	 */
-	unlock_extent_cached_atomic(tree, processed->start, processed->end,
-				    &cached);
+	unlock_extent_atomic(tree, processed->start, processed->end, &cached);
 
 update:
 	/* Update processed to current range */
@@ -1762,7 +1761,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 	ret = set_page_extent_mapped(page);
 	if (ret < 0) {
-		unlock_extent(tree, start, end);
+		unlock_extent(tree, start, end, NULL);
 		btrfs_page_set_error(fs_info, page, start, PAGE_SIZE);
 		unlock_page(page);
 		goto out;
@@ -1790,15 +1789,14 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			memzero_page(page, pg_offset, iosize);
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
-			unlock_extent_cached(tree, cur,
-					     cur + iosize - 1, &cached);
+			unlock_extent(tree, cur, cur + iosize - 1, &cached);
 			end_page_read(page, true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
-			unlock_extent(tree, cur, end);
+			unlock_extent(tree, cur, end, NULL);
 			end_page_read(page, false, cur, end + 1 - cur);
 			ret = PTR_ERR(em);
 			break;
@@ -1873,8 +1871,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
-			unlock_extent_cached(tree, cur,
-					     cur + iosize - 1, &cached);
+			unlock_extent(tree, cur, cur + iosize - 1, &cached);
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1882,7 +1879,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 		/* the get_extent function already copied into the page */
 		if (block_start == EXTENT_MAP_INLINE) {
-			unlock_extent(tree, cur, cur + iosize - 1);
+			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1898,7 +1895,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			 * We have to unlock the remaining range, or the page
 			 * will never be unlocked.
 			 */
-			unlock_extent(tree, cur, end);
+			unlock_extent(tree, cur, end, NULL);
 			end_page_read(page, false, cur, end + 1 - cur);
 			goto out;
 		}
@@ -3365,7 +3362,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	if (start > end)
 		return 0;
 
-	lock_extent_bits(tree, start, end, &cached_state);
+	lock_extent(tree, start, end, &cached_state);
 	folio_wait_writeback(folio);
 
 	/*
@@ -3373,7 +3370,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	 * so here we only need to unlock the extent range to free any
 	 * existing extent state.
 	 */
-	unlock_extent_cached(tree, start, end, &cached_state);
+	unlock_extent(tree, start, end, &cached_state);
 	return 0;
 }
 
@@ -3942,7 +3939,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	lockend = round_up(start + len, btrfs_inode_sectorsize(inode));
 	prev_extent_end = lockstart;
 
-	lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
+	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
@@ -4132,7 +4129,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 
 out_unlock:
-	unlock_extent_cached(&inode->io_tree, lockstart, lockend, &cached_state);
+	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 out:
 	kfree(backref_cache);
 	btrfs_free_path(path);
@@ -4975,7 +4972,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1))
 			return -EAGAIN;
 	} else {
-		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1, NULL);
 		if (ret < 0)
 			return ret;
 	}
@@ -4985,7 +4982,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	    PageUptodate(page) ||
 	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1, NULL);
 		return ret;
 	}
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8ce01f69df3b..eb5579d9a3e0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1426,15 +1426,14 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	if (start_pos < inode->vfs_inode.i_size) {
 		struct btrfs_ordered_extent *ordered;
 
-		lock_extent_bits(&inode->io_tree, start_pos, last_pos,
-				cached_state);
+		lock_extent(&inode->io_tree, start_pos, last_pos, cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start_pos,
 						     last_pos - start_pos + 1);
 		if (ordered &&
 		    ordered->file_offset + ordered->num_bytes > start_pos &&
 		    ordered->file_offset <= last_pos) {
-			unlock_extent_cached(&inode->io_tree, start_pos,
-					last_pos, cached_state);
+			unlock_extent(&inode->io_tree, start_pos, last_pos,
+				      cached_state);
 			for (i = 0; i < num_pages; i++) {
 				unlock_page(pages[i]);
 				put_page(pages[i]);
@@ -1510,7 +1509,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
 	}
-	unlock_extent(&inode->io_tree, lockstart, lockend);
+	unlock_extent(&inode->io_tree, lockstart, lockend, NULL);
 
 	return ret;
 }
@@ -1782,8 +1781,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 * possible cached extent state to avoid a memory leak.
 		 */
 		if (extents_locked)
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     lockstart, lockend, &cached_state);
+			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
+				      lockend, &cached_state);
 		else
 			free_extent_state(cached_state);
 
@@ -2592,8 +2591,8 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
-		lock_extent_bits(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-				 cached_state);
+		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			    cached_state);
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2608,8 +2607,8 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 					    page_lockend))
 			break;
 
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
-				     lockend, cached_state);
+		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			      cached_state);
 	}
 
 	btrfs_assert_inode_range_clean(BTRFS_I(inode), lockstart, lockend);
@@ -3109,8 +3108,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 out:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			     &cached_state);
+	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+		      &cached_state);
 out_only_mutex:
 	if (!updated_inode && truncated_block && !ret) {
 		/*
@@ -3383,16 +3382,16 @@ static int btrfs_zero_range(struct inode *inode,
 		ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
 						alloc_start, bytes_to_reserve);
 		if (ret) {
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
-					     lockend, &cached_state);
+			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
+				      lockend, &cached_state);
 			goto out;
 		}
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
 						i_blocksize(inode),
 						offset + len, &alloc_hint);
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
-				     lockend, &cached_state);
+		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			      &cached_state);
 		/* btrfs_prealloc_file_range releases reserved space on error */
 		if (ret) {
 			space_reserved = false;
@@ -3503,8 +3502,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	locked_end = alloc_end - 1;
-	lock_extent_bits(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
-			 &cached_state);
+	lock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
+		    &cached_state);
 
 	btrfs_assert_inode_range_clean(BTRFS_I(inode), alloc_start, locked_end);
 
@@ -3593,8 +3592,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	 */
 	ret = btrfs_fallocate_update_isize(inode, actual_end, mode);
 out_unlock:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
-			     &cached_state);
+	unlock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
+		      &cached_state);
 out:
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	extent_changeset_free(data_reserved);
@@ -3899,7 +3898,7 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 
 	last_extent_end = lockstart;
 
-	lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
+	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0) {
@@ -4035,8 +4034,7 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 	}
 
 out:
-	unlock_extent_cached(&inode->io_tree, lockstart, lockend,
-			     &cached_state);
+	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	btrfs_free_path(path);
 
 	if (ret < 0)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0bd5b02966c0..ecef1ba816c3 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -348,7 +348,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(inode, 0);
 	truncate_pagecache(vfs_inode, 0);
 
-	lock_extent_bits(&inode->io_tree, 0, (u64)-1, &cached_state);
+	lock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
 	btrfs_drop_extent_cache(inode, 0, (u64)-1, 0);
 
 	/*
@@ -360,7 +360,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 	btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
-	unlock_extent_cached(&inode->io_tree, 0, (u64)-1, &cached_state);
+	unlock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
 	if (ret)
 		goto fail;
 
@@ -1292,8 +1292,8 @@ cleanup_write_cache_enospc(struct inode *inode,
 			   struct extent_state **cached_state)
 {
 	io_ctl_drop_pages(io_ctl);
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, 0,
-			     i_size_read(inode) - 1, cached_state);
+	unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+		      cached_state);
 }
 
 static int __btrfs_wait_cache_io(struct btrfs_root *root,
@@ -1418,8 +1418,8 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	if (ret)
 		goto out_unlock;
 
-	lock_extent_bits(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
-			 &cached_state);
+	lock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+		    &cached_state);
 
 	io_ctl_set_generation(io_ctl, trans->transid);
 
@@ -1474,8 +1474,8 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	io_ctl_drop_pages(io_ctl);
 	io_ctl_free(io_ctl);
 
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, 0,
-			     i_size_read(inode) - 1, &cached_state);
+	unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+		      &cached_state);
 
 	/*
 	 * at this point the pages are under IO and we're happy,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ee0901944cbe..7519233b922f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -977,7 +977,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 		if (!(start >= locked_page_end || end <= locked_page_start))
 			locked_page = async_chunk->locked_page;
 	}
-	lock_extent(io_tree, start, end);
+	lock_extent(io_tree, start, end, NULL);
 
 	/* We have fall back to uncompressed write */
 	if (!async_extent->pages)
@@ -1524,7 +1524,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	unsigned nofs_flag;
 	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
-	unlock_extent(&inode->io_tree, start, end);
+	unlock_extent(&inode->io_tree, start, end, NULL);
 
 	if (inode->flags & BTRFS_INODE_NOCOMPRESS &&
 	    !btrfs_test_opt(fs_info, FORCE_COMPRESS)) {
@@ -2548,7 +2548,7 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 
 	ASSERT(pre + post < len);
 
-	lock_extent(&inode->io_tree, start, start + len - 1);
+	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	write_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
 	if (!em) {
@@ -2622,7 +2622,7 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 
 out_unlock:
 	write_unlock(&em_tree->lock);
-	unlock_extent(&inode->io_tree, start, start + len - 1);
+	unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
 out:
 	free_extent_map(split_pre);
 	free_extent_map(split_mid);
@@ -2928,7 +2928,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	if (ret)
 		goto out_page;
 
-	lock_extent_bits(&inode->io_tree, page_start, page_end, &cached_state);
+	lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 
 	/* already ordered? We're done */
 	if (PageOrdered(page))
@@ -2936,8 +2936,8 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 
 	ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
 	if (ordered) {
-		unlock_extent_cached(&inode->io_tree, page_start, page_end,
-				     &cached_state);
+		unlock_extent(&inode->io_tree, page_start, page_end,
+			      &cached_state);
 		unlock_page(page);
 		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
@@ -2963,8 +2963,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	if (free_delalloc_space)
 		btrfs_delalloc_release_space(inode, data_reserved, page_start,
 					     PAGE_SIZE, true);
-	unlock_extent_cached(&inode->io_tree, page_start, page_end,
-			     &cached_state);
+	unlock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 out_page:
 	if (ret) {
 		/*
@@ -3268,7 +3267,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	}
 
 	clear_bits |= EXTENT_LOCKED;
-	lock_extent_bits(io_tree, start, end, &cached_state);
+	lock_extent(io_tree, start, end, &cached_state);
 
 	if (freespace_inode)
 		trans = btrfs_join_transaction_spacecache(root);
@@ -4920,12 +4919,11 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	}
 	wait_on_page_writeback(page);
 
-	lock_extent_bits(io_tree, block_start, block_end, &cached_state);
+	lock_extent(io_tree, block_start, block_end, &cached_state);
 
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
 	if (ordered) {
-		unlock_extent_cached(io_tree, block_start, block_end,
-				     &cached_state);
+		unlock_extent(io_tree, block_start, block_end, &cached_state);
 		unlock_page(page);
 		put_page(page);
 		btrfs_start_ordered_extent(ordered, 1);
@@ -4940,8 +4938,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
 	if (ret) {
-		unlock_extent_cached(io_tree, block_start, block_end,
-				     &cached_state);
+		unlock_extent(io_tree, block_start, block_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -4958,7 +4955,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	btrfs_page_clear_checked(fs_info, page, block_start,
 				 block_end + 1 - block_start);
 	btrfs_page_set_dirty(fs_info, page, block_start, block_end + 1 - block_start);
-	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
+	unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
@@ -5134,7 +5131,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			break;
 	}
 	free_extent_map(em);
-	unlock_extent_cached(io_tree, hole_start, block_end - 1, &cached_state);
+	unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
 	return err;
 }
 
@@ -5268,7 +5265,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
  * While truncating the inode pages during eviction, we get the VFS
  * calling btrfs_invalidate_folio() against each folio of the inode. This
  * is slow because the calls to btrfs_invalidate_folio() result in a
- * huge amount of calls to lock_extent_bits() and clear_extent_bit(),
+ * huge amount of calls to lock_extent() and clear_extent_bit(),
  * which keep merging and splitting extent_state structures over and over,
  * wasting lots of time.
  *
@@ -5335,7 +5332,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		state_flags = state->state;
 		spin_unlock(&io_tree->lock);
 
-		lock_extent_bits(io_tree, start, end, &cached_state);
+		lock_extent(io_tree, start, end, &cached_state);
 
 		/*
 		 * If still has DELALLOC flag, the extent didn't reach disk,
@@ -7271,7 +7268,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			if (!try_lock_extent(io_tree, lockstart, lockend))
 				return -EAGAIN;
 		} else {
-			lock_extent_bits(io_tree, lockstart, lockend, cached_state);
+			lock_extent(io_tree, lockstart, lockend, cached_state);
 		}
 		/*
 		 * We're concerned with the entire range that we're going to be
@@ -7293,7 +7290,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 							 lockstart, lockend)))
 			break;
 
-		unlock_extent_cached(io_tree, lockstart, lockend, cached_state);
+		unlock_extent(io_tree, lockstart, lockend, cached_state);
 
 		if (ordered) {
 			if (nowait) {
@@ -7751,8 +7748,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	}
 
 	if (unlock_extents)
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-				     lockstart, lockend, &cached_state);
+		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			      &cached_state);
 	else
 		free_extent_state(cached_state);
 
@@ -7781,8 +7778,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	return 0;
 
 unlock_err:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			     &cached_state);
+	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+		      &cached_state);
 err:
 	if (dio_data->data_space_reserved) {
 		btrfs_free_reserved_data_space(BTRFS_I(inode),
@@ -7805,7 +7802,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (!write && (iomap->type == IOMAP_HOLE)) {
 		/* If reading from a hole, unlock and return */
-		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1);
+		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1,
+			      NULL);
 		return 0;
 	}
 
@@ -7817,7 +7815,7 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 						       pos, length, false);
 		else
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
-				      pos + length - 1);
+				      pos + length - 1, NULL);
 		ret = -ENOTBLK;
 	}
 
@@ -7842,7 +7840,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	} else {
 		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
 			      dip->file_offset,
-			      dip->file_offset + dip->bytes - 1);
+			      dip->file_offset + dip->bytes - 1, NULL);
 	}
 
 	kfree(dip->csums);
@@ -8272,7 +8270,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	}
 
 	if (!inode_evicting)
-		lock_extent_bits(tree, page_start, page_end, &cached_state);
+		lock_extent(tree, page_start, page_end, &cached_state);
 
 	cur = page_start;
 	while (cur < page_end) {
@@ -8470,11 +8468,11 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 	wait_on_page_writeback(page);
 
-	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
+	lock_extent(io_tree, page_start, page_end, &cached_state);
 	ret2 = set_page_extent_mapped(page);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
-		unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
+		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -8485,8 +8483,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start,
 			PAGE_SIZE);
 	if (ordered) {
-		unlock_extent_cached(io_tree, page_start, page_end,
-				     &cached_state);
+		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		unlock_page(page);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered, 1);
@@ -8519,8 +8516,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
 	if (ret2) {
-		unlock_extent_cached(io_tree, page_start, page_end,
-				     &cached_state);
+		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
@@ -8540,7 +8536,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
-	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
+	unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
@@ -8641,7 +8637,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
 
 		control.new_size = new_size;
-		lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
+		lock_extent(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
 				 &cached_state);
 		/*
 		 * We want to drop from the next block forward in case this new
@@ -8657,8 +8653,8 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		inode_sub_bytes(inode, control.sub_bytes);
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), control.last_size);
 
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start,
-				     (u64)-1, &cached_state);
+		unlock_extent(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
+			      &cached_state);
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN)
@@ -10237,7 +10233,7 @@ static ssize_t btrfs_encoded_read_inline(
 	}
 	read_extent_buffer(leaf, tmp, ptr, count);
 	btrfs_release_path(path);
-	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	unlock_extent(io_tree, start, lockend, cached_state);
 	btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
@@ -10440,7 +10436,7 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 	if (ret)
 		goto out;
 
-	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	unlock_extent(io_tree, start, lockend, cached_state);
 	btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
@@ -10510,13 +10506,13 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 					       lockend - start + 1);
 		if (ret)
 			goto out_unlock_inode;
-		lock_extent_bits(io_tree, start, lockend, &cached_state);
+		lock_extent(io_tree, start, lockend, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     lockend - start + 1);
 		if (!ordered)
 			break;
 		btrfs_put_ordered_extent(ordered);
-		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		unlock_extent(io_tree, start, lockend, &cached_state);
 		cond_resched();
 	}
 
@@ -10590,7 +10586,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	em = NULL;
 
 	if (disk_bytenr == EXTENT_MAP_HOLE) {
-		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		unlock_extent(io_tree, start, lockend, &cached_state);
 		btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
 		unlocked = true;
 		ret = iov_iter_zero(count, iter);
@@ -10611,7 +10607,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	free_extent_map(em);
 out_unlock_extent:
 	if (!unlocked)
-		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		unlock_extent(io_tree, start, lockend, &cached_state);
 out_unlock_inode:
 	if (!unlocked)
 		btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
@@ -10749,14 +10745,14 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 						    end >> PAGE_SHIFT);
 		if (ret)
 			goto out_pages;
-		lock_extent_bits(io_tree, start, end, &cached_state);
+		lock_extent(io_tree, start, end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
 		if (!ordered &&
 		    !filemap_range_has_page(inode->vfs_inode.i_mapping, start, end))
 			break;
 		if (ordered)
 			btrfs_put_ordered_extent(ordered);
-		unlock_extent_cached(io_tree, start, end, &cached_state);
+		unlock_extent(io_tree, start, end, &cached_state);
 		cond_resched();
 	}
 
@@ -10818,7 +10814,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (start + encoded->len > inode->vfs_inode.i_size)
 		i_size_write(&inode->vfs_inode, start + encoded->len);
 
-	unlock_extent_cached(io_tree, start, end, &cached_state);
+	unlock_extent(io_tree, start, end, &cached_state);
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
@@ -10849,7 +10845,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (!extent_reserved)
 		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
 out_unlock:
-	unlock_extent_cached(io_tree, start, end, &cached_state);
+	unlock_extent(io_tree, start, end, &cached_state);
 out_pages:
 	for (i = 0; i < nr_pages; i++) {
 		if (pages[i])
@@ -11090,7 +11086,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
 
-	lock_extent_bits(io_tree, 0, isize - 1, &cached_state);
+	lock_extent(io_tree, 0, isize - 1, &cached_state);
 	start = 0;
 	while (start < isize) {
 		u64 logical_block_start, physical_block_start;
@@ -11227,7 +11223,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (!IS_ERR_OR_NULL(em))
 		free_extent_map(em);
 
-	unlock_extent_cached(io_tree, 0, isize - 1, &cached_state);
+	unlock_extent(io_tree, 0, isize - 1, &cached_state);
 
 	if (ret)
 		btrfs_swap_deactivate(file);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 274ad3e23190..d59e1f1b762e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1218,10 +1218,10 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 
 		/* get the big lock and read metadata off disk */
 		if (!locked)
-			lock_extent_bits(io_tree, start, end, &cached);
+			lock_extent(io_tree, start, end, &cached);
 		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
 		if (!locked)
-			unlock_extent_cached(io_tree, start, end, &cached);
+			unlock_extent(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
 			return NULL;
@@ -1333,10 +1333,10 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		lock_extent_bits(&inode->io_tree, page_start, page_end, &cached_state);
+		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		unlock_extent_cached(&inode->io_tree, page_start, page_end,
-				     &cached_state);
+		unlock_extent(&inode->io_tree, page_start, page_end,
+			      &cached_state);
 		if (!ordered)
 			break;
 
@@ -1666,9 +1666,9 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		wait_on_page_writeback(pages[i]);
 
 	/* Lock the pages range */
-	lock_extent_bits(&inode->io_tree, start_index << PAGE_SHIFT,
-			 (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-			 &cached_state);
+	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+		    &cached_state);
 	/*
 	 * Now we have a consistent view about the extent map, re-check
 	 * which range really needs to be defragged.
@@ -1694,9 +1694,9 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		kfree(entry);
 	}
 unlock_extent:
-	unlock_extent_cached(&inode->io_tree, start_index << PAGE_SHIFT,
-			     (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-			     &cached_state);
+	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+		      &cached_state);
 free_pages:
 	for (i = 0; i < nr_pages; i++) {
 		if (pages[i]) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index eb24a6d20ff8..40a364c11178 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1043,7 +1043,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 		cachedp = cached_state;
 
 	while (1) {
-		lock_extent_bits(&inode->io_tree, start, end, cachedp);
+		lock_extent(&inode->io_tree, start, end, cachedp);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     end - start + 1);
 		if (!ordered) {
@@ -1056,7 +1056,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 				refcount_dec(&cache->refs);
 			break;
 		}
-		unlock_extent_cached(&inode->io_tree, start, end, cachedp);
+		unlock_extent(&inode->io_tree, start, end, cachedp);
 		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 	}
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 39556ce1b551..7a0db71d683b 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -615,8 +615,8 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 static void btrfs_double_extent_unlock(struct inode *inode1, u64 loff1,
 				       struct inode *inode2, u64 loff2, u64 len)
 {
-	unlock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1);
-	unlock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1);
+	unlock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1, NULL);
+	unlock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1, NULL);
 }
 
 static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
@@ -634,8 +634,8 @@ static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
 		swap(range1_end, range2_end);
 	}
 
-	lock_extent(&BTRFS_I(inode1)->io_tree, loff1, range1_end);
-	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, range2_end);
+	lock_extent(&BTRFS_I(inode1)->io_tree, loff1, range1_end, NULL);
+	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, range2_end, NULL);
 
 	btrfs_assert_inode_range_clean(BTRFS_I(inode1), loff1, range1_end);
 	btrfs_assert_inode_range_clean(BTRFS_I(inode2), loff2, range2_end);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 45c02aba2492..d87020ae5810 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1127,7 +1127,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				btrfs_drop_extent_cache(BTRFS_I(inode),
 						key.offset,	end, 1);
 				unlock_extent(&BTRFS_I(inode)->io_tree,
-					      key.offset, end);
+					      key.offset, end, NULL);
 			}
 		}
 
@@ -1566,9 +1566,9 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 		}
 
 		/* the lock_extent waits for read_folio to complete */
-		lock_extent(&BTRFS_I(inode)->io_tree, start, end);
+		lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 1);
-		unlock_extent(&BTRFS_I(inode)->io_tree, start, end);
+		unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 	}
 	return 0;
 }
@@ -2869,13 +2869,13 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		else
 			end = cluster->end - offset;
 
-		lock_extent(&inode->io_tree, start, end);
+		lock_extent(&inode->io_tree, start, end, NULL);
 		num_bytes = end + 1 - start;
 		ret = btrfs_prealloc_file_range(&inode->vfs_inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
 		cur_offset = end + 1;
-		unlock_extent(&inode->io_tree, start, end);
+		unlock_extent(&inode->io_tree, start, end, NULL);
 		if (ret)
 			break;
 	}
@@ -2904,7 +2904,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 	em->block_start = block_start;
 	set_bit(EXTENT_FLAG_PINNED, &em->flags);
 
-	lock_extent(&BTRFS_I(inode)->io_tree, start, end);
+	lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 	while (1) {
 		write_lock(&em_tree->lock);
 		ret = add_extent_mapping(em_tree, em, 0);
@@ -2915,7 +2915,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 		}
 		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
 	}
-	unlock_extent(&BTRFS_I(inode)->io_tree, start, end);
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 	return ret;
 }
 
@@ -3006,7 +3006,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 			goto release_page;
 
 		/* Mark the range delalloc and dirty for later writeback */
-		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end);
+		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end, NULL);
 		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), clamped_start,
 						clamped_end, 0, NULL);
 		if (ret) {
@@ -3039,7 +3039,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 					boundary_start, boundary_end,
 					EXTENT_BOUNDARY);
 		}
-		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end);
+		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end, NULL);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), clamped_len);
 		cur += clamped_len;
 
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index a232b15b8021..4c824b7f07dd 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -172,7 +172,7 @@ static int test_find_delalloc(u32 sectorsize)
 			sectorsize - 1, start, end);
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end);
+	unlock_extent(tmp, start, end, NULL);
 	unlock_page(locked_page);
 	put_page(locked_page);
 
@@ -208,7 +208,7 @@ static int test_find_delalloc(u32 sectorsize)
 		test_err("there were unlocked pages in the range");
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end);
+	unlock_extent(tmp, start, end, NULL);
 	/* locked_page was unlocked above */
 	put_page(locked_page);
 
@@ -263,7 +263,7 @@ static int test_find_delalloc(u32 sectorsize)
 		test_err("pages in range were not all locked");
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end);
+	unlock_extent(tmp, start, end, NULL);
 
 	/*
 	 * Now to test where we run into a page that is no longer dirty in the
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 020e01ea44bc..b5018e42cf06 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4271,8 +4271,8 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	 * file which happens to refer to the same extent as well. Such races
 	 * can leave checksum items in the log with overlapping ranges.
 	 */
-	ret = lock_extent_bits(&log_root->log_csum_range, sums->bytenr,
-			       lock_end, &cached_state);
+	ret = lock_extent(&log_root->log_csum_range, sums->bytenr, lock_end,
+			  &cached_state);
 	if (ret)
 		return ret;
 	/*
@@ -4288,8 +4288,8 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	if (!ret)
 		ret = btrfs_csum_file_blocks(trans, log_root, sums);
 
-	unlock_extent_cached(&log_root->log_csum_range, sums->bytenr, lock_end,
-			     &cached_state);
+	unlock_extent(&log_root->log_csum_range, sums->bytenr, lock_end,
+		      &cached_state);
 
 	return ret;
 }
-- 
2.26.3

