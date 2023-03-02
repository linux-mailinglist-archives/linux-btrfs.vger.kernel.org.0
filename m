Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5CB6A8BC7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCBW0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCBWZ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142B33462
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C3632006A;
        Thu,  2 Mar 2023 22:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7C2xhp9MLIt0v3/UeQF+fgDVwDd7TAsxBhvuW4XL0s=;
        b=xuA/8OiaJf+clzqLD7p1MX2nFiTKAvFyjsu35BTEtKwakGDjn3tKquRwW3qYP3Ql5ZQlMS
        KF701yfFjPCX4oZcY+bqOZRKdO1ZKzvsCJE2KuGSmqA+2M/2GvRev7fBjt5h0Hmf27R29P
        4gNxMpyKTvsM2sJYmu7Pkegnyz22s+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7C2xhp9MLIt0v3/UeQF+fgDVwDd7TAsxBhvuW4XL0s=;
        b=i+w/cqdM4bAQb8w9Osdnh8mwpO83OKifkoPzDEGIvV87vkZuCXKZ5yfK0UTUs0dmZJK9bp
        2m53UG7846ItePAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C24413349;
        Thu,  2 Mar 2023 22:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZLn5OnEiAWT6SQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:53 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 21/21] btrfs: debug extent locking
Date:   Thu,  2 Mar 2023 16:25:06 -0600
Message-Id: <b05663f1fc9e1b7bce91a80c99cf9fa82d13af5e.1677793433.git.rgoldwyn@suse.com>
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

This is the patch I used to figure out who locked the extent before the
deadlock. While this patch is not required, it may be helpful to debug
extent based deadlocks.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent-io-tree.c    | 27 +++++++++++----------
 fs/btrfs/extent-io-tree.h    | 46 +++++++++++++++++++++---------------
 fs/btrfs/extent_io.c         |  2 +-
 fs/btrfs/extent_map.c        |  2 +-
 fs/btrfs/inode.c             |  4 ++--
 fs/btrfs/ordered-data.c      |  8 +++----
 fs/btrfs/ordered-data.h      |  3 ++-
 include/trace/events/btrfs.h | 18 +++++++++-----
 8 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index d467c614c84e..25faf587f050 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -545,7 +545,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
  *
  * This takes the tree lock, and returns 0 on success and < 0 on error.
  */
-int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+int __clear_extent_bit(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		       u32 bits, struct extent_state **cached_state,
 		       gfp_t mask, struct extent_changeset *changeset)
 {
@@ -559,7 +559,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	int delete = (bits & EXTENT_CLEAR_ALL_BITS);
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
-	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
+	trace_btrfs_clear_extent_bit(tree, func, start, end - start + 1, bits);
 
 	if (delete)
 		bits |= ~EXTENT_CTLBITS;
@@ -965,7 +965,7 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
  *
  * [start, end] is inclusive This takes the tree lock.
  */
-static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+static int __set_extent_bit(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 			    u32 bits, u64 *failed_start,
 			    struct extent_state **failed_state,
 			    struct extent_state **cached_state,
@@ -981,7 +981,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	u32 exclusive_bits = (bits & EXTENT_LOCKED);
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
-	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
+	trace_btrfs_set_extent_bit(tree, func, start, end - start + 1, bits);
 
 	if (exclusive_bits)
 		ASSERT(failed_start);
@@ -1188,10 +1188,10 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 }
 
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+int set_extent_bit(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		   u32 bits, struct extent_state **cached_state, gfp_t mask)
 {
-	return __set_extent_bit(tree, start, end, bits, NULL, NULL,
+	return __set_extent_bit(tree, func, start, end, bits, NULL, NULL,
 				cached_state, NULL, mask);
 }
 
@@ -1688,7 +1688,7 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL,
+	return __set_extent_bit(tree, NULL, start, end, bits, NULL, NULL, NULL,
 				changeset, GFP_NOFS);
 }
 
@@ -1701,19 +1701,20 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return __clear_extent_bit(tree, start, end, bits, NULL, GFP_NOFS,
+	return __clear_extent_bit(tree, __func__, start, end, bits, NULL, GFP_NOFS,
 				  changeset);
 }
 
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+int __try_lock_extent(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		    struct extent_state **cached)
 {
 	int err;
 	u64 failed_start;
 
 	WARN_ON(start > end);
-	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+	err = __set_extent_bit(tree, func, start, end, EXTENT_LOCKED, &failed_start,
 			       NULL, cached, NULL, GFP_NOFS);
+
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
@@ -1727,7 +1728,7 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
  * Either insert or lock state struct between start and end use mask to tell
  * us if waiting is desired.
  */
-int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+int __lock_extent(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		struct extent_state **cached_state)
 {
 	struct extent_state *failed_state = NULL;
@@ -1735,7 +1736,7 @@ int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 failed_start;
 
 	WARN_ON(start > end);
-	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+	err = __set_extent_bit(tree, func, start, end, EXTENT_LOCKED, &failed_start,
 			       &failed_state, cached_state, NULL, GFP_NOFS);
 	while (err == -EEXIST) {
 		if (failed_start != start)
@@ -1744,7 +1745,7 @@ int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 
 		wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED,
 				&failed_state);
-		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
+		err = __set_extent_bit(tree, func, start, end, EXTENT_LOCKED,
 				       &failed_start, &failed_state,
 				       cached_state, NULL, GFP_NOFS);
 	}
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 21766e49ec02..2ad38b43baaf 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -107,12 +107,15 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner);
 void extent_io_tree_release(struct extent_io_tree *tree);
 
-int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+int __lock_extent(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		struct extent_state **cached);
 
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+int __try_lock_extent(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		    struct extent_state **cached);
 
+#define lock_extent(t, s, e, c) __lock_extent(t, __func__, s, e, c)
+#define try_lock_extent(t, s, e, c) __try_lock_extent(t, __func__, s, e, c)
+
 int __init extent_state_init_cachep(void);
 void __cold extent_state_free_cachep(void);
 
@@ -126,25 +129,30 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, int filled, struct extent_state *cached_state);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
-int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+int __clear_extent_bit(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		       u32 bits, struct extent_state **cached, gfp_t mask,
 		       struct extent_changeset *changeset);
 
-static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				   u64 end, u32 bits,
-				   struct extent_state **cached)
+#define clear_extent_bit(t, s, e, b, c) __clear_extent_bit(t, __func__, s, e, b, c, GFP_NOFS, NULL)
+
+static inline int __unlock_extent(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
+				struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, bits, cached,
+	return __clear_extent_bit(tree, func, start, end, EXTENT_LOCKED, cached,
 				  GFP_NOFS, NULL);
 }
 
-static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
-				struct extent_state **cached)
+static inline int __unlock_extent_atomic(struct extent_io_tree *tree, const char *func, u64 start,
+				       u64 end, struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
-				  GFP_NOFS, NULL);
+	return __clear_extent_bit(tree, func, start, end, EXTENT_LOCKED, cached,
+				  GFP_ATOMIC, NULL);
 }
 
+#define unlock_extent(t, s, e, c) __unlock_extent(t, __func__, s, e, c)
+#define unlock_extent_atomic(t, s, e, c) __unlock_extent_atomic(t, __func__, s, e, c)
+
+
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 				    u64 end, u32 bits)
 {
@@ -153,32 +161,32 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset);
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+int set_extent_bit(struct extent_io_tree *tree, const char *func, u64 start, u64 end,
 		   u32 bits, struct extent_state **cached_state, gfp_t mask);
 
 static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start,
 					 u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT);
+	return set_extent_bit(tree, __func__, start, end, bits, NULL, GFP_NOWAIT);
 }
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
+	return set_extent_bit(tree, __func__, start, end, bits, NULL, GFP_NOFS);
 }
 
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE,
+	return __clear_extent_bit(tree, __func__, start, end, EXTENT_UPTODATE,
 				  cached_state, GFP_NOFS, NULL);
 }
 
 static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
 		u64 end, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask);
+	return set_extent_bit(tree, __func__, start, end, EXTENT_DIRTY, NULL, mask);
 }
 
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
@@ -197,7 +205,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 				      u64 end, u32 extra_bits,
 				      struct extent_state **cached_state)
 {
-	return set_extent_bit(tree, start, end,
+	return set_extent_bit(tree, __func__, start, end,
 			      EXTENT_DELALLOC | extra_bits,
 			      cached_state, GFP_NOFS);
 }
@@ -205,7 +213,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
-	return set_extent_bit(tree, start, end,
+	return set_extent_bit(tree, __func__, start, end,
 			      EXTENT_DELALLOC | EXTENT_DEFRAG,
 			      cached_state, GFP_NOFS);
 }
@@ -213,7 +221,7 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
-	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
+	return set_extent_bit(tree, __func__, start, end, EXTENT_NEW, NULL, GFP_NOFS);
 }
 
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 12aa7eaf12c5..fa2fedc9577f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2772,7 +2772,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		 * The delalloc new bit will be cleared by ordered extent
 		 * completion.
 		 */
-		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL,
+		ret = __clear_extent_bit(tree, __func__, start, end, clear_bits, NULL,
 					 mask, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index be94030e1dfb..d255d31130db 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -379,7 +379,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		__clear_extent_bit(&device->alloc_state, stripe->physical,
+		__clear_extent_bit(&device->alloc_state, __func__, stripe->physical,
 				   stripe->physical + stripe_size - 1, bits,
 				   NULL, GFP_NOWAIT, NULL);
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b5f5c1896dbb..eebced86bd70 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2663,7 +2663,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		if (em_len > search_len)
 			em_len = search_len;
 
-		ret = set_extent_bit(&inode->io_tree, search_start,
+		ret = set_extent_bit(&inode->io_tree, __func__, search_start,
 				     search_start + em_len - 1,
 				     EXTENT_DELALLOC_NEW, cached_state,
 				     GFP_NOFS);
@@ -4779,7 +4779,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	btrfs_page_set_dirty(fs_info, page, block_start, block_end + 1 - block_start);
 
 	if (only_release_metadata)
-		set_extent_bit(&inode->io_tree, block_start, block_end,
+		set_extent_bit(&inode->io_tree, __func__, block_start, block_end,
 			       EXTENT_NORESERVE, NULL, GFP_NOFS);
 
 out_unlock:
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6c24b69e2d0a..9854494d3bcf 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -231,8 +231,8 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			   &entry->rb_node);
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
-				"inconsistency in ordered tree at offset %llu",
-				file_offset);
+				"inconsistency in ordered tree ino %lu at offset %llu",
+				inode->vfs_inode.i_ino, file_offset);
 	spin_unlock_irq(&tree->lock);
 
 	spin_lock(&root->ordered_extent_lock);
@@ -1032,7 +1032,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
  * Always return with the given range locked, ensuring after it's called no
  * order extent can be pending.
  */
-void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
+void __btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, const char *func, u64 start,
 					u64 end,
 					struct extent_state **cached_state)
 {
@@ -1044,7 +1044,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 		cachedp = cached_state;
 
 	while (1) {
-		lock_extent(&inode->io_tree, start, end, cachedp);
+		__lock_extent(&inode->io_tree, func, start, end, cachedp);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     end - start + 1);
 		if (!ordered) {
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index eb40cb39f842..e426aeda71d5 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -202,9 +202,10 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			      const u64 range_start, const u64 range_len);
-void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
+void __btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, const char *func, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
+#define btrfs_lock_and_flush_ordered_range(i, s, e, c) __btrfs_lock_and_flush_ordered_range(i, __func__, s, e, c)
 bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state);
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8ea9cea9bfeb..d4f4a415d085 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2059,12 +2059,14 @@ DEFINE_EVENT(btrfs__block_group, btrfs_skip_unused_block_group,
 
 TRACE_EVENT(btrfs_set_extent_bit,
 	TP_PROTO(const struct extent_io_tree *tree,
+		const char *func,
 		 u64 start, u64 len, unsigned set_bits),
 
-	TP_ARGS(tree, start, len, set_bits),
+	TP_ARGS(tree, func, start, len, set_bits),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	unsigned,	owner	)
+		__string(	func,		func	)
 		__field(	u64,		ino	)
 		__field(	u64,		rootid	)
 		__field(	u64,		start	)
@@ -2083,26 +2085,29 @@ TRACE_EVENT(btrfs_set_extent_bit,
 			__entry->ino	= 0;
 			__entry->rootid	= 0;
 		}
+		__assign_str(func, func);
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->set_bits	= set_bits;
 	),
 
 	TP_printk_btrfs(
-		"io_tree=%s ino=%llu root=%llu start=%llu len=%llu set_bits=%s",
-		__print_symbolic(__entry->owner, IO_TREE_OWNER), __entry->ino,
+		"io_tree=%s func=%s ino=%llu root=%llu start=%llu len=%llu set_bits=%s",
+		__print_symbolic(__entry->owner, IO_TREE_OWNER), __get_str(func), __entry->ino,
 		__entry->rootid, __entry->start, __entry->len,
 		__print_flags(__entry->set_bits, "|", EXTENT_FLAGS))
 );
 
 TRACE_EVENT(btrfs_clear_extent_bit,
 	TP_PROTO(const struct extent_io_tree *tree,
+		const char *func,
 		 u64 start, u64 len, unsigned clear_bits),
 
-	TP_ARGS(tree, start, len, clear_bits),
+	TP_ARGS(tree, func, start, len, clear_bits),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	unsigned,	owner	)
+		__string(	func,		func	)
 		__field(	u64,		ino	)
 		__field(	u64,		rootid	)
 		__field(	u64,		start	)
@@ -2121,14 +2126,15 @@ TRACE_EVENT(btrfs_clear_extent_bit,
 			__entry->ino	= 0;
 			__entry->rootid	= 0;
 		}
+		__assign_str(func, func)
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->clear_bits	= clear_bits;
 	),
 
 	TP_printk_btrfs(
-		"io_tree=%s ino=%llu root=%llu start=%llu len=%llu clear_bits=%s",
-		__print_symbolic(__entry->owner, IO_TREE_OWNER), __entry->ino,
+		"io_tree=%s func=%s ino=%llu root=%llu start=%llu len=%llu clear_bits=%s",
+		__print_symbolic(__entry->owner, IO_TREE_OWNER), __get_str(func), __entry->ino,
 		__entry->rootid, __entry->start, __entry->len,
 		__print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
 );
-- 
2.39.2

