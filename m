Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3F5B41E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiIIVyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiIIVyn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8006312
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:42 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c11so2340425qtw.8
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=HOB5AH3mO8rmv3k14eACviC/x0Vp/V0aiEyr0xOui3c=;
        b=3F+vdYK+1/UaRSIUf07OFwyWZAi9aZzV5B0xfW7+xH1WmeWdKPa21JoMzid0ODuVYI
         5079VUhZYVqWq/wV86UTO8ti+VSUiHAhNiQt+4OTpDJgY4FUUYwwuAJhBgP6HyFfzlgX
         Y9r3hjcOJ0hrQrfMhXr9GorEwwv0E21L7H406+zht0NluLhXLaCJtKPFKic4I+RPlUQ1
         5D7c1kp+6RZKCTjytKpVnUGHCob3dGW5B8B4bs7yMbL1YYjT4wPBXxS03dla3OBNgKHp
         /RXARW7sk+WVkZdy+2JENPf1gOUcpYzCthO5jQggNdG48H2gMlwKiefLKo7pD1awTqHI
         UW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HOB5AH3mO8rmv3k14eACviC/x0Vp/V0aiEyr0xOui3c=;
        b=iditO7aFU7NRBX/0cHZuwR/abCt6e+JJv43faKRI/fHTmRuPsaFATceBs1rQfJU295
         haHVDa9gpP1AMPgpn6LZUOr/pG557MKToB1noKhu67f0qm5vsoJHGvqNpDjpYhzGKKNH
         PK0CUK+YTnr3CwncIvz77qs+NxYLfb5fYi2va84kzQKINSTiT7jz/2yFEn7yPHalxGO/
         JjLqunc1x8AtHeJAQah3cR5iV2wkfZcas2yOTwKhGp76RzGjYa7EfliwrWqoMUqVLCNJ
         f3tQldvJmmXnwvkHdN1XKlWdJ9R6dl+dCbxsoTjH8EzUmNlCcuGWUcFgRZVbuTriNVrx
         Dqbg==
X-Gm-Message-State: ACgBeo1PXA0l1J5eqFEgQTzIjybrqHBmjNcYATl0UawzRo+H/pZWvAQ3
        IJ+MQzbQcO3wu5LZp70JwrWys/E/qIEDOQ==
X-Google-Smtp-Source: AA6agR7VrWeZK6Q0MuwUUpHRg8kK24zsK6J4HS/4pT+d/NDNTjPEvo+p1vwVzZhbzd/2WCkb3SgKkg==
X-Received: by 2002:ac8:5853:0:b0:343:7b95:96ff with SMTP id h19-20020ac85853000000b003437b9596ffmr14726800qth.386.1662760480819;
        Fri, 09 Sep 2022 14:54:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a0a4400b006b8e049cf08sm1272461qka.2.2022.09.09.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 34/36] btrfs: replace delete argument with EXTENT_CLEAR_ALL_BITS
Date:   Fri,  9 Sep 2022 17:53:47 -0400
Message-Id: <4cdff16fc22bc856920471ab599030d46864f182.1662760286.git.josef@toxicpanda.com>
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

Instead of taking up a whole argument to indicate we're clearing
everything in a range, simply add another EXTENT bit to control this,
and then update all the callers to drop this argument from the
clear_extent_bit variants.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c    | 17 ++++++++-------
 fs/btrfs/extent-io-tree.h    | 28 +++++++++++++++---------
 fs/btrfs/extent_io.c         |  4 ++--
 fs/btrfs/extent_map.c        |  2 +-
 fs/btrfs/file-item.c         |  2 +-
 fs/btrfs/file.c              |  2 +-
 fs/btrfs/free-space-cache.c  |  6 +++---
 fs/btrfs/inode.c             | 41 +++++++++++++++++-------------------
 fs/btrfs/ioctl.c             |  2 +-
 fs/btrfs/reflink.c           |  2 +-
 fs/btrfs/tests/inode-tests.c |  8 +++----
 fs/btrfs/transaction.c       |  2 +-
 12 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 3a89d338ddc6..482b6acc76a8 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -546,8 +546,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
  * This takes the tree lock, and returns 0 on success and < 0 on error.
  */
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, int delete,
-		       struct extent_state **cached_state,
+		       u32 bits, struct extent_state **cached_state,
 		       gfp_t mask, struct extent_changeset *changeset)
 {
 	struct extent_state *state;
@@ -556,17 +555,19 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 last_end;
 	int err;
 	int clear = 0;
-	int wake = (bits & EXTENT_LOCKED) ? 1 : 0;
+	int wake;
+	int delete = bits & EXTENT_CLEAR_ALL_BITS;
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
 
-	if (bits & EXTENT_DELALLOC)
-		bits |= EXTENT_NORESERVE;
-
 	if (delete)
 		bits |= ~EXTENT_CTLBITS;
 
+	if (bits & EXTENT_DELALLOC)
+		bits |= EXTENT_NORESERVE;
+
+	wake = (bits & EXTENT_LOCKED) ? 1 : 0;
 	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
 		clear = 1;
 again:
@@ -1615,7 +1616,7 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return __clear_extent_bit(tree, start, end, bits, 0, NULL, GFP_NOFS,
+	return __clear_extent_bit(tree, start, end, bits, NULL, GFP_NOFS,
 				  changeset);
 }
 
@@ -1629,7 +1630,7 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
-					 EXTENT_LOCKED, 0, NULL);
+					 EXTENT_LOCKED, NULL);
 		return 0;
 	}
 	return 1;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 94574062eabe..a8671116b59f 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -35,10 +35,18 @@ struct io_failure_record;
  * delalloc bytes decremented, in an atomic way to prevent races with stat(2).
  */
 #define EXTENT_ADD_INODE_BYTES  (1U << 15)
+
+/*
+ * Set during truncate when we're clearing an entire range and we just want the
+ * extent states to go away.
+ */
+#define EXTENT_CLEAR_ALL_BITS	(1U << 16)
+
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
 				 EXTENT_CLEAR_DATA_RESV)
 #define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING | \
-				 EXTENT_ADD_INODE_BYTES)
+				 EXTENT_ADD_INODE_BYTES | \
+				 EXTENT_CLEAR_ALL_BITS)
 
 /*
  * Redefined bits above which are used only in the device allocation tree,
@@ -114,35 +122,35 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, int delete, struct extent_state **cached,
-		       gfp_t mask, struct extent_changeset *changeset);
+		       u32 bits, struct extent_state **cached, gfp_t mask,
+		       struct extent_changeset *changeset);
 
 static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				   u64 end, u32 bits, int delete,
+				   u64 end, u32 bits,
 				   struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, bits, delete, cached,
+	return __clear_extent_bit(tree, start, end, bits, cached,
 				  GFP_NOFS, NULL);
 }
 
 static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 				struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, cached,
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
 				  GFP_NOFS, NULL);
 }
 
 static inline int unlock_extent_atomic(struct extent_io_tree *tree, u64 start,
 				       u64 end, struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 0, cached,
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
 				  GFP_ATOMIC, NULL);
 }
 
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 				    u64 end, u32 bits)
 {
-	return clear_extent_bit(tree, start, end, bits, 0, NULL);
+	return clear_extent_bit(tree, start, end, bits, NULL);
 }
 
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -165,7 +173,7 @@ static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE, 0,
+	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE,
 				  cached_state, GFP_NOFS, NULL);
 }
 
@@ -180,7 +188,7 @@ static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
 {
 	return clear_extent_bit(tree, start, end,
 				EXTENT_DIRTY | EXTENT_DELALLOC |
-				EXTENT_DO_ACCOUNTING, 0, cached);
+				EXTENT_DO_ACCOUNTING, cached);
 }
 
 int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d69d9213da6a..3bd4a6b065e9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -487,7 +487,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 clear_bits, unsigned long page_ops)
 {
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 0, NULL);
+	clear_extent_bit(&inode->io_tree, start, end, clear_bits, NULL);
 
 	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
 			       start, end, page_ops, NULL);
@@ -3398,7 +3398,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		 * The delalloc new bit will be cleared by ordered extent
 		 * completion.
 		 */
-		ret = __clear_extent_bit(tree, start, end, clear_bits, 0, NULL,
+		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL,
 					 mask, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index fae627c28d7c..d5640e695e6b 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -382,7 +382,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 
 		__clear_extent_bit(&device->alloc_state, stripe->physical,
 				   stripe->physical + stripe_size - 1, bits,
-				   0, NULL, GFP_NOWAIT, NULL);
+				   NULL, GFP_NOWAIT, NULL);
 	}
 }
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d44e0d3c84cd..45949261c699 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -118,7 +118,7 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
 	return clear_extent_bit(&inode->file_extent_tree, start,
-				start + len - 1, EXTENT_DIRTY, 0, NULL);
+				start + len - 1, EXTENT_DIRTY, NULL);
 }
 
 static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index eb5579d9a3e0..fea508a35900 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -473,7 +473,7 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	 */
 	clear_extent_bit(&inode->io_tree, start_pos, end_of_last_block,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 0, cached);
+			 cached);
 
 	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
 					extra_bits, cached);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ecef1ba816c3..7859eeca484c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1163,7 +1163,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DELALLOC, 0, NULL);
+				 EXTENT_DELALLOC, NULL);
 		goto fail;
 	}
 	leaf = path->nodes[0];
@@ -1175,7 +1175,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 		if (found_key.objectid != BTRFS_FREE_SPACE_OBJECTID ||
 		    found_key.offset != offset) {
 			clear_extent_bit(&BTRFS_I(inode)->io_tree, 0,
-					 inode->i_size - 1, EXTENT_DELALLOC, 0,
+					 inode->i_size - 1, EXTENT_DELALLOC,
 					 NULL);
 			btrfs_release_path(path);
 			goto fail;
@@ -1272,7 +1272,7 @@ static int flush_dirty_cache(struct inode *inode)
 	ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DELALLOC, 0, NULL);
+				 EXTENT_DELALLOC, NULL);
 
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c417bbc29986..39f00b68b3a8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1747,7 +1747,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 
 		if (count > 0)
 			clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE,
-					 0, NULL);
+					 NULL);
 	}
 
 	return cow_file_range(inode, locked_page, start, end, page_started,
@@ -3323,7 +3323,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	    !test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags))
 		clear_extent_bit(&inode->io_tree, start, end,
 				 EXTENT_DELALLOC_NEW | EXTENT_ADD_INODE_BYTES,
-				 0, &cached_state);
+				 &cached_state);
 
 	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode_fallback(trans, root, inode);
@@ -3333,7 +3333,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	}
 	ret = 0;
 out:
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 0,
+	clear_extent_bit(&inode->io_tree, start, end, clear_bits,
 			 &cached_state);
 
 	if (trans)
@@ -4933,7 +4933,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	clear_extent_bit(&inode->io_tree, block_start, block_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 0, &cached_state);
+			 &cached_state);
 
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
@@ -5347,8 +5347,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 					       end - start + 1);
 
 		clear_extent_bit(io_tree, start, end,
-				 EXTENT_LOCKED | EXTENT_DELALLOC |
-				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1,
+				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
 				 &cached_state);
 
 		cond_resched();
@@ -8275,9 +8274,9 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	cur = page_start;
 	while (cur < page_end) {
 		struct btrfs_ordered_extent *ordered;
-		bool delete_states;
 		u64 range_end;
 		u32 range_len;
+		u32 extra_flags = 0;
 
 		ordered = btrfs_lookup_first_ordered_range(inode, cur,
 							   page_end + 1 - cur);
@@ -8287,7 +8286,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 			 * No ordered extent covering this range, we are safe
 			 * to delete all extent states in the range.
 			 */
-			delete_states = true;
+			extra_flags = EXTENT_CLEAR_ALL_BITS;
 			goto next;
 		}
 		if (ordered->file_offset > cur) {
@@ -8298,7 +8297,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 			 * the ordered extent in the next iteration.
 			 */
 			range_end = ordered->file_offset - 1;
-			delete_states = true;
+			extra_flags = EXTENT_CLEAR_ALL_BITS;
 			goto next;
 		}
 
@@ -8313,7 +8312,6 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 			 * We can't delete the extent states as
 			 * btrfs_finish_ordered_io() may still use some of them.
 			 */
-			delete_states = false;
 			goto next;
 		}
 		btrfs_page_clear_ordered(fs_info, &folio->page, cur, range_len);
@@ -8330,7 +8328,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 			clear_extent_bit(tree, cur, range_end,
 					 EXTENT_DELALLOC |
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
-					 EXTENT_DEFRAG, 0, &cached_state);
+					 EXTENT_DEFRAG, &cached_state);
 
 		spin_lock_irq(&inode->ordered_tree.lock);
 		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
@@ -8338,6 +8336,12 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 					     cur - ordered->file_offset);
 		spin_unlock_irq(&inode->ordered_tree.lock);
 
+		/*
+		 * If the ordered extent has finished, we're safe to delete all
+		 * the extent states of the range, otherwise
+		 * btrfs_finish_ordered_io() will get executed by endio for
+		 * other pages, so we can't delete extent states.
+		 */
 		if (btrfs_dec_test_ordered_pending(inode, &ordered,
 						   cur, range_end + 1 - cur)) {
 			btrfs_finish_ordered_io(ordered);
@@ -8345,14 +8349,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 			 * The ordered extent has finished, now we're again
 			 * safe to delete all extent states of the range.
 			 */
-			delete_states = true;
-		} else {
-			/*
-			 * btrfs_finish_ordered_io() will get executed by endio
-			 * of other pages, thus we can't delete extent states
-			 * anymore
-			 */
-			delete_states = false;
+			extra_flags = EXTENT_CLEAR_ALL_BITS;
 		}
 next:
 		if (ordered)
@@ -8376,8 +8373,8 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		if (!inode_evicting) {
 			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
-				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-				 delete_states, &cached_state);
+				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG |
+				 extra_flags, &cached_state);
 		}
 		cur = range_end + 1;
 	}
@@ -8511,7 +8508,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
 			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			  EXTENT_DEFRAG, 0, &cached_state);
+			  EXTENT_DEFRAG, &cached_state);
 
 	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d59e1f1b762e..d5dd8bed1488 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1616,7 +1616,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 		return ret;
 	clear_extent_bit(&inode->io_tree, start, start + len - 1,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			 EXTENT_DEFRAG, 0, cached_state);
+			 EXTENT_DEFRAG, cached_state);
 	set_extent_defrag(&inode->io_tree, start, start + len - 1, cached_state);
 
 	/* Update the page status */
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 7a0db71d683b..f50586ff85c8 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -92,7 +92,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 
 	clear_extent_bit(&inode->io_tree, file_offset, range_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 0, NULL);
+			 NULL);
 	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
 	if (ret)
 		goto out_unlock;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index eeba3deb7714..b1c88dd187cb 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -975,7 +975,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 			       BTRFS_MAX_EXTENT_SIZE >> 1,
 			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, 0, NULL);
+			       EXTENT_UPTODATE, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1043,7 +1043,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
 			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, 0, NULL);
+			       EXTENT_UPTODATE, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1076,7 +1076,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	/* Empty */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, 0, NULL);
+			       EXTENT_UPTODATE, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1092,7 +1092,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
 				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-				 EXTENT_UPTODATE, 0, NULL);
+				 EXTENT_UPTODATE, NULL);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 83f3d4b89faa..d9d770a9b1a3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1116,7 +1116,7 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 		 * it's safe to do it (through extent_io_tree_release()).
 		 */
 		err = clear_extent_bit(dirty_pages, start, end,
-				       EXTENT_NEED_WAIT, 0, &cached_state);
+				       EXTENT_NEED_WAIT, &cached_state);
 		if (err == -ENOMEM)
 			err = 0;
 		if (!err)
-- 
2.26.3

