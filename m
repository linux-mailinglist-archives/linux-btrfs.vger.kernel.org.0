Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06A627DE18
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgI3B4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:50684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbgI3B4x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE5g3SPzfF0SAj8sVOy/bjIKDnIYFeImvgqR08+a/zE=;
        b=Q1BRRrmhAPTS0abKGB1qsCOAFDhWLKg8q//QtsrbgPiuw/D9IjCODNTxFxVBdS4vA3AzNw
        zNKkaIJsBsfGB5ANaG6uSpyFgofY0h7HI+qd+y5YNow+3mK0TzYYxYfNoaHf87QIccbmg4
        Mcw4PVhFJsW+ARIi9A3Ibx/LpQ17Qno=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0A61AF95
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 31/49] btrfs: extent-io: make type of extent_state::state to be at least 32 bits
Date:   Wed, 30 Sep 2020 09:55:21 +0800
Message-Id: <20200930015539.48867-32-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we use 'unsigned' for extent_state::state, which is only ensured
to be at least 16 bits.

But for incoming subpage support, we are going to introduce more bits to
at least match the following page bits:
- PageUptodate
- PagePrivate2

Thus we will go beyond 16 bits.

To support this, make extent_state::state at least 32bit and to be more
explicit, we use "u32" to be clear about the max supported bits.

This doesn't increase the memory usage for x86_64, but may affect other
architectures.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h | 36 +++++++++++++++-------------
 fs/btrfs/extent_io.c      | 49 +++++++++++++++++++--------------------
 fs/btrfs/extent_io.h      |  2 +-
 3 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 4d0dbb562a81..108b386118fe 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -22,6 +22,10 @@ struct io_failure_record;
 #define EXTENT_QGROUP_RESERVED	(1U << 12)
 #define EXTENT_CLEAR_DATA_RESV	(1U << 13)
 #define EXTENT_DELALLOC_NEW	(1U << 14)
+
+/* For subpage btree io tree, to indicate there is an extent buffer */
+#define EXTENT_HAS_TREE_BLOCK	(1U << 15)
+
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
 				 EXTENT_CLEAR_DATA_RESV)
 #define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING)
@@ -73,7 +77,7 @@ struct extent_state {
 	/* ADD NEW ELEMENTS AFTER THIS */
 	wait_queue_head_t wq;
 	refcount_t refs;
-	unsigned state;
+	u32 state;
 
 	struct io_failure_record *failrec;
 
@@ -105,19 +109,19 @@ void __cold extent_io_exit(void);
 
 u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end,
-		     u64 max_bytes, unsigned bits, int contig);
+		     u64 max_bytes, u32 bits, int contig);
 
 void free_extent_state(struct extent_state *state);
 int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, int filled,
+		   u32 bits, int filled,
 		   struct extent_state *cached_state);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		unsigned bits, struct extent_changeset *changeset);
+			     u32 bits, struct extent_changeset *changeset);
 int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     unsigned bits, int wake, int delete,
+		     u32 bits, int wake, int delete,
 		     struct extent_state **cached);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     unsigned bits, int wake, int delete,
+		     u32 bits, int wake, int delete,
 		     struct extent_state **cached, gfp_t mask,
 		     struct extent_changeset *changeset);
 
@@ -141,7 +145,7 @@ static inline int unlock_extent_cached_atomic(struct extent_io_tree *tree,
 }
 
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
-		u64 end, unsigned bits)
+				    u64 end, u32 bits)
 {
 	int wake = 0;
 
@@ -152,15 +156,15 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 }
 
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits, struct extent_changeset *changeset);
+			   u32 bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, u64 *failed_start,
+		   u32 bits, u64 *failed_start,
 		   struct extent_state **cached_state, gfp_t mask);
 int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits);
+			   u32 bits);
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
-		u64 end, unsigned bits)
+		u64 end, u32 bits)
 {
 	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS);
 }
@@ -188,11 +192,11 @@ static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
 }
 
 int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       unsigned bits, unsigned clear_bits,
+		       u32 bits, u32 clear_bits,
 		       struct extent_state **cached_state);
 
 static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
-				      u64 end, unsigned int extra_bits,
+				      u64 end, u32 extra_bits,
 				      struct extent_state **cached_state)
 {
 	return set_extent_bit(tree, start, end,
@@ -223,12 +227,12 @@ static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 }
 
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, unsigned bits,
+			  u64 *start_ret, u64 *end_ret, u32 bits,
 			  bool exact_match, struct extent_state **cached_state);
 void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, unsigned bits);
+				 u64 *start_ret, u64 *end_ret, u32 bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-			       u64 *start_ret, u64 *end_ret, unsigned bits);
+			       u64 *start_ret, u64 *end_ret, u32 bits);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e42a17039bf6..0c4ce0b1f4ce 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -142,7 +142,7 @@ struct extent_page_data {
 	unsigned int sync_io:1;
 };
 
-static int add_extent_changeset(struct extent_state *state, unsigned bits,
+static int add_extent_changeset(struct extent_state *state, u32 bits,
 				 struct extent_changeset *changeset,
 				 int set)
 {
@@ -530,7 +530,7 @@ static void merge_state(struct extent_io_tree *tree,
 }
 
 static void set_state_bits(struct extent_io_tree *tree,
-			   struct extent_state *state, unsigned *bits,
+			   struct extent_state *state, u32 *bits,
 			   struct extent_changeset *changeset);
 
 /*
@@ -547,7 +547,7 @@ static int insert_state(struct extent_io_tree *tree,
 			struct extent_state *state, u64 start, u64 end,
 			struct rb_node ***p,
 			struct rb_node **parent,
-			unsigned *bits, struct extent_changeset *changeset)
+			u32 *bits, struct extent_changeset *changeset)
 {
 	struct rb_node *node;
 
@@ -628,11 +628,11 @@ static struct extent_state *next_state(struct extent_state *state)
  */
 static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 					    struct extent_state *state,
-					    unsigned *bits, int wake,
+					    u32 *bits, int wake,
 					    struct extent_changeset *changeset)
 {
 	struct extent_state *next;
-	unsigned bits_to_clear = *bits & ~EXTENT_CTLBITS;
+	u32 bits_to_clear = *bits & ~EXTENT_CTLBITS;
 	int ret;
 
 	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
@@ -695,7 +695,7 @@ static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
  * This takes the tree lock, and returns 0 on success and < 0 on error.
  */
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-			      unsigned bits, int wake, int delete,
+			      u32 bits, int wake, int delete,
 			      struct extent_state **cached_state,
 			      gfp_t mask, struct extent_changeset *changeset)
 {
@@ -868,7 +868,7 @@ static void wait_on_state(struct extent_io_tree *tree,
  * The tree lock is taken by this function
  */
 static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-			    unsigned long bits)
+			    u32 bits)
 {
 	struct extent_state *state;
 	struct rb_node *node;
@@ -915,9 +915,9 @@ static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 static void set_state_bits(struct extent_io_tree *tree,
 			   struct extent_state *state,
-			   unsigned *bits, struct extent_changeset *changeset)
+			   u32 *bits, struct extent_changeset *changeset)
 {
-	unsigned bits_to_set = *bits & ~EXTENT_CTLBITS;
+	u32 bits_to_set = *bits & ~EXTENT_CTLBITS;
 	int ret;
 
 	if (tree->private_data && is_data_inode(tree->private_data))
@@ -964,7 +964,7 @@ static void cache_state(struct extent_state *state,
 
 static int __must_check
 __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		 unsigned bits, unsigned exclusive_bits,
+		 u32 bits, u32 exclusive_bits,
 		 u64 *failed_start, struct extent_state **cached_state,
 		 gfp_t mask, struct extent_changeset *changeset)
 {
@@ -1180,7 +1180,7 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, u64 * failed_start,
+		   u32 bits, u64 * failed_start,
 		   struct extent_state **cached_state, gfp_t mask)
 {
 	return __set_extent_bit(tree, start, end, bits, 0, failed_start,
@@ -1207,7 +1207,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
  * All allocations are done with GFP_NOFS.
  */
 int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       unsigned bits, unsigned clear_bits,
+		       u32 bits, u32 clear_bits,
 		       struct extent_state **cached_state)
 {
 	struct extent_state *state;
@@ -1408,7 +1408,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 /* wrappers around set/clear extent bit */
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits, struct extent_changeset *changeset)
+			   u32 bits, struct extent_changeset *changeset)
 {
 	/*
 	 * We don't support EXTENT_LOCKED yet, as current changeset will
@@ -1423,14 +1423,14 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits)
+			   u32 bits)
 {
 	return __set_extent_bit(tree, start, end, bits, 0, NULL, NULL,
 				GFP_NOWAIT, NULL);
 }
 
 int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     unsigned bits, int wake, int delete,
+		     u32 bits, int wake, int delete,
 		     struct extent_state **cached)
 {
 	return __clear_extent_bit(tree, start, end, bits, wake, delete,
@@ -1438,7 +1438,7 @@ int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		unsigned bits, struct extent_changeset *changeset)
+		u32 bits, struct extent_changeset *changeset)
 {
 	/*
 	 * Don't support EXTENT_LOCKED case, same reason as
@@ -1521,7 +1521,7 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 	}
 }
 
-static bool match_extent_state(struct extent_state *state, unsigned bits,
+static bool match_extent_state(struct extent_state *state, u32 bits,
 			       bool exact_match)
 {
 	if (exact_match)
@@ -1541,7 +1541,7 @@ static bool match_extent_state(struct extent_state *state, unsigned bits,
  */
 static struct extent_state *
 find_first_extent_bit_state(struct extent_io_tree *tree,
-			    u64 start, unsigned bits, bool exact_match)
+			    u64 start, u32 bits, bool exact_match)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -1577,7 +1577,7 @@ find_first_extent_bit_state(struct extent_io_tree *tree,
  * Return 1 if we found nothing.
  */
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, unsigned bits,
+			  u64 *start_ret, u64 *end_ret, u32 bits,
 			  bool exact_match, struct extent_state **cached_state)
 {
 	struct extent_state *state;
@@ -1629,7 +1629,7 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
  * returned will be the full contiguous area with the bits set.
  */
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-			       u64 *start_ret, u64 *end_ret, unsigned bits)
+			       u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
 	int ret = 1;
@@ -1666,7 +1666,7 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
  * trim @end_ret to the appropriate size.
  */
 void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, unsigned bits)
+				 u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
 	struct rb_node *node, *prev = NULL, *next;
@@ -2056,8 +2056,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
-				  unsigned clear_bits,
-				  unsigned long page_ops)
+				  u32 clear_bits, unsigned long page_ops)
 {
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);
 
@@ -2072,7 +2071,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
  */
 u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end, u64 max_bytes,
-		     unsigned bits, int contig)
+		     u32 bits, int contig)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -2192,7 +2191,7 @@ struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 sta
  * range is found set.
  */
 int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, int filled, struct extent_state *cached)
+		   u32 bits, int filled, struct extent_state *cached)
 {
 	struct extent_state *state = NULL;
 	struct rb_node *node;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 552afc1c0bbc..602d6568c8ea 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -288,7 +288,7 @@ void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
-				  unsigned bits_to_clear,
+				  u32 bits_to_clear,
 				  unsigned long page_ops);
 struct bio *btrfs_bio_alloc(u64 first_byte);
 struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
-- 
2.28.0

