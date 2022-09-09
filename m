Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4395B41E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiIIVyk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiIIVyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:35 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9C6454
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s13so2272883qvq.10
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=ww5BR4RsRGLH3fMTOPXXTkslZr50cs9YVbc06M/oW6Y=;
        b=hPqllIlkAdM/06F2+mkePEBXhv2yEWTTW0lEK3k8Eccy5jpBRMYv9axBxR5GipALZe
         sFswgL/4VuNrEGJ7LDFWdeaYeQ/ojHVrMFjyIB1FB0CDxn+NZFOUEInyrw+pmpJMdvaM
         tmdzpEvkVKs9Q6+OGXS2WL0pSPzrh5LZzZxpldTd/N6+vuOxYEhz3+rwrtOwueIiVU6/
         QOk6YkSkOeBozwPvp94AQ1v8/pN6vTnGncduqDiGUU7G09eHp1GSRNgurDR7HMRw1m2M
         1reVr10xzHq+W/qqAsc7o5cqS3o0H04hUg6OQ4Wbo8xOz8q6czAxDd0zN5C8yKK4nlAH
         XUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ww5BR4RsRGLH3fMTOPXXTkslZr50cs9YVbc06M/oW6Y=;
        b=GTaQa0uGC5AD1OB1yOb55LXmpV1st2/+mycUUwcJnf8zCFtTUqeVs0l6XjQVjMK06x
         5Og7oQp/fNmPaT8WZxhwCgYA5gz4OKnoREyPH4Va8CLr0ctcti5H+/F8RlKprHJEzWNE
         XxfuOk7UFfiUYljMMkg9zBjFyEdwLuHUrufL0jewbvhMCj0ngE3ANP5BpI+nlt8lNMf3
         3lyktOHapabqyamMvaB25jn8m1bgQKiHwn7LNTd+v3oAGjLSS6sTLuH5xJ/0+c1WzKEx
         iMxSkjxiV36M8smuByElxXX1CuwvNAsCOIxuuXNL0jvAXph6sbHsrBie9EN+tFvOjXTc
         UPbw==
X-Gm-Message-State: ACgBeo1auOjUSjr1X9jeAIGLbzqH6uPmFkZm+ToVbcU8xbkJFGNNJo2G
        RML2adTulFIIHjBI/aq2dSTubUsiLFXxTw==
X-Google-Smtp-Source: AA6agR5hs1ntxL6DBdsMkYCUyCwlWXxYndBueQf0EE35bTxW5Fcv9yzvb2afWF41rnOaQoK2VvLbxw==
X-Received: by 2002:a05:6214:e62:b0:499:18d0:63d2 with SMTP id jz2-20020a0562140e6200b0049918d063d2mr13677581qvb.114.1662760470448;
        Fri, 09 Sep 2022 14:54:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t7-20020a05620a450700b006cbca9886easm1610573qkp.36.2022.09.09.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 27/36] btrfs: remove the wake argument from clear_extent_bits
Date:   Fri,  9 Sep 2022 17:53:40 -0400
Message-Id: <5ea180371a3290cebf61df3c722e6fd97c37e465.1662760286.git.josef@toxicpanda.com>
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

This is only used in the case that we are clearing EXTENT_LOCKED, so
infer this value from the bits passed in instead of taking it as an
argument.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c    |  7 ++++---
 fs/btrfs/extent-io-tree.h    | 34 ++++++++++++++--------------------
 fs/btrfs/extent_io.c         |  4 ++--
 fs/btrfs/extent_map.c        |  2 +-
 fs/btrfs/file-item.c         |  2 +-
 fs/btrfs/file.c              |  2 +-
 fs/btrfs/free-space-cache.c  |  6 +++---
 fs/btrfs/inode.c             | 17 ++++++++---------
 fs/btrfs/ioctl.c             |  2 +-
 fs/btrfs/reflink.c           |  2 +-
 fs/btrfs/tests/inode-tests.c |  8 ++++----
 fs/btrfs/transaction.c       |  2 +-
 12 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index f67d9ee6f03e..a870e74f9c6c 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -557,7 +557,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
  * This takes the tree lock, and returns 0 on success and < 0 on error.
  */
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, int wake, int delete,
+		       u32 bits, int delete,
 		       struct extent_state **cached_state,
 		       gfp_t mask, struct extent_changeset *changeset)
 {
@@ -567,6 +567,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 last_end;
 	int err;
 	int clear = 0;
+	int wake = (bits & EXTENT_LOCKED) ? 1 : 0;
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
@@ -1622,7 +1623,7 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return __clear_extent_bit(tree, start, end, bits, 0, 0, NULL, GFP_NOFS,
+	return __clear_extent_bit(tree, start, end, bits, 0, NULL, GFP_NOFS,
 				  changeset);
 }
 
@@ -1636,7 +1637,7 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
-					 EXTENT_LOCKED, 1, 0, NULL);
+					 EXTENT_LOCKED, 0, NULL);
 		return 0;
 	}
 	return 1;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index fb6caef20373..bd3c345a7530 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -121,46 +121,40 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     u32 bits, int wake, int delete,
-		     struct extent_state **cached, gfp_t mask,
-		     struct extent_changeset *changeset);
+		       u32 bits, int delete, struct extent_state **cached,
+		       gfp_t mask, struct extent_changeset *changeset);
 
 static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				   u64 end, u32 bits, int wake, int delete,
+				   u64 end, u32 bits, int delete,
 				   struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, bits, wake, delete,
-				  cached, GFP_NOFS, NULL);
+	return __clear_extent_bit(tree, start, end, bits, delete, cached,
+				  GFP_NOFS, NULL);
 }
 
 static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 {
-	return clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, NULL);
+	return clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, NULL);
 }
 
 static inline int unlock_extent_cached(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
-				GFP_NOFS, NULL);
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, cached,
+				  GFP_NOFS, NULL);
 }
 
 static inline int unlock_extent_cached_atomic(struct extent_io_tree *tree,
 		u64 start, u64 end, struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
-				GFP_ATOMIC, NULL);
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, cached,
+				  GFP_ATOMIC, NULL);
 }
 
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 				    u64 end, u32 bits)
 {
-	int wake = 0;
-
-	if (bits & EXTENT_LOCKED)
-		wake = 1;
-
-	return clear_extent_bit(tree, start, end, bits, wake, 0, NULL);
+	return clear_extent_bit(tree, start, end, bits, 0, NULL);
 }
 
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -187,8 +181,8 @@ static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE, 0, 0,
-				cached_state, GFP_NOFS, NULL);
+	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE, 0,
+				  cached_state, GFP_NOFS, NULL);
 }
 
 static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
@@ -203,7 +197,7 @@ static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
 {
 	return clear_extent_bit(tree, start, end,
 				EXTENT_DIRTY | EXTENT_DELALLOC |
-				EXTENT_DO_ACCOUNTING, 0, 0, cached);
+				EXTENT_DO_ACCOUNTING, 0, cached);
 }
 
 int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8644072303df..59fe8f379433 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -487,7 +487,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 clear_bits, unsigned long page_ops)
 {
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);
+	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 0, NULL);
 
 	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
 			       start, end, page_ops, NULL);
@@ -3400,7 +3400,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		 */
 		ret = __clear_extent_bit(tree, start, end,
 			 ~(EXTENT_LOCKED | EXTENT_NODATASUM | EXTENT_DELALLOC_NEW),
-			 0, 0, NULL, mask, NULL);
+			 0, NULL, mask, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
 		 * we can't allow the release to continue.
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6fee14ce2e6b..fae627c28d7c 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -382,7 +382,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 
 		__clear_extent_bit(&device->alloc_state, stripe->physical,
 				   stripe->physical + stripe_size - 1, bits,
-				   0, 0, NULL, GFP_NOWAIT, NULL);
+				   0, NULL, GFP_NOWAIT, NULL);
 	}
 }
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 29999686d234..d44e0d3c84cd 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -118,7 +118,7 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
 	return clear_extent_bit(&inode->file_extent_tree, start,
-				start + len - 1, EXTENT_DIRTY, 0, 0, NULL);
+				start + len - 1, EXTENT_DIRTY, 0, NULL);
 }
 
 static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 636b3ec46184..8ce01f69df3b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -473,7 +473,7 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	 */
 	clear_extent_bit(&inode->io_tree, start_pos, end_of_last_block,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 0, 0, cached);
+			 0, cached);
 
 	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
 					extra_bits, cached);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0c94bbb5dcd7..0bd5b02966c0 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1163,7 +1163,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DELALLOC, 0, 0, NULL);
+				 EXTENT_DELALLOC, 0, NULL);
 		goto fail;
 	}
 	leaf = path->nodes[0];
@@ -1176,7 +1176,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 		    found_key.offset != offset) {
 			clear_extent_bit(&BTRFS_I(inode)->io_tree, 0,
 					 inode->i_size - 1, EXTENT_DELALLOC, 0,
-					 0, NULL);
+					 NULL);
 			btrfs_release_path(path);
 			goto fail;
 		}
@@ -1272,7 +1272,7 @@ static int flush_dirty_cache(struct inode *inode)
 	ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DELALLOC, 0, 0, NULL);
+				 EXTENT_DELALLOC, 0, NULL);
 
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 538b6a3a88ad..77060eb7e848 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1747,7 +1747,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 
 		if (count > 0)
 			clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE,
-					 0, 0, NULL);
+					 0, NULL);
 	}
 
 	return cow_file_range(inode, locked_page, start, end, page_started,
@@ -3324,7 +3324,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	    !test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags))
 		clear_extent_bit(&inode->io_tree, start, end,
 				 EXTENT_DELALLOC_NEW | EXTENT_ADD_INODE_BYTES,
-				 0, 0, &cached_state);
+				 0, &cached_state);
 
 	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode_fallback(trans, root, inode);
@@ -3334,8 +3334,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	}
 	ret = 0;
 out:
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits,
-			 (clear_bits & EXTENT_LOCKED) ? 1 : 0, 0,
+	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 0,
 			 &cached_state);
 
 	if (trans)
@@ -4936,7 +4935,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	clear_extent_bit(&inode->io_tree, block_start, block_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 0, 0, &cached_state);
+			 0, &cached_state);
 
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
@@ -5352,7 +5351,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 
 		clear_extent_bit(io_tree, start, end,
 				 EXTENT_LOCKED | EXTENT_DELALLOC |
-				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1, 1,
+				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1,
 				 &cached_state);
 
 		cond_resched();
@@ -8333,7 +8332,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 			clear_extent_bit(tree, cur, range_end,
 					 EXTENT_DELALLOC |
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
-					 EXTENT_DEFRAG, 1, 0, &cached_state);
+					 EXTENT_DEFRAG, 0, &cached_state);
 
 		spin_lock_irq(&inode->ordered_tree.lock);
 		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
@@ -8379,7 +8378,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		if (!inode_evicting) {
 			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
-				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1,
+				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 				 delete_states, &cached_state);
 		}
 		cur = range_end + 1;
@@ -8515,7 +8514,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
 			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			  EXTENT_DEFRAG, 0, 0, &cached_state);
+			  EXTENT_DEFRAG, 0, &cached_state);
 
 	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fe0cc816b4eb..274ad3e23190 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1616,7 +1616,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 		return ret;
 	clear_extent_bit(&inode->io_tree, start, start + len - 1,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			 EXTENT_DEFRAG, 0, 0, cached_state);
+			 EXTENT_DEFRAG, 0, cached_state);
 	set_extent_defrag(&inode->io_tree, start, start + len - 1, cached_state);
 
 	/* Update the page status */
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9acf47b11fe6..39556ce1b551 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -92,7 +92,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 
 	clear_extent_bit(&inode->io_tree, file_offset, range_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 0, 0, NULL);
+			 0, NULL);
 	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
 	if (ret)
 		goto out_unlock;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index cac89c388131..eeba3deb7714 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -975,7 +975,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 			       BTRFS_MAX_EXTENT_SIZE >> 1,
 			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_UPTODATE, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1043,7 +1043,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
 			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_UPTODATE, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1076,7 +1076,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	/* Empty */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_UPTODATE, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1092,7 +1092,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
 				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-				 EXTENT_UPTODATE, 0, 0, NULL);
+				 EXTENT_UPTODATE, 0, NULL);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9d7563df81a0..83f3d4b89faa 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1116,7 +1116,7 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 		 * it's safe to do it (through extent_io_tree_release()).
 		 */
 		err = clear_extent_bit(dirty_pages, start, end,
-				       EXTENT_NEED_WAIT, 0, 0, &cached_state);
+				       EXTENT_NEED_WAIT, 0, &cached_state);
 		if (err == -ENOMEM)
 			err = 0;
 		if (!err)
-- 
2.26.3

