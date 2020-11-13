Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331102B1B6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKMMwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgKMMwq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRxD1j1tuTmq9hfmxsjCxLCny0jjxT7NBTeGN4yIr8w=;
        b=Nr8gcje+Z9EsRPkFOXmpjK+tv8OXc/lSWWNQJgOmdT7MYtV/elOtZBzf2zcK2+24cPrpnD
        Ad4Aqx3s74i44lt40cSPmJ7Pd+5jfW2iRliROGO7kfpSWMrgWwQr6lY8ehd5dpNDcgywCg
        JNuUvMqu8VyTSTTLAPiF4gM99/QalPY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2860ABD6;
        Fri, 13 Nov 2020 12:52:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 15/24] btrfs: extent-io: make type of extent_state::state to be at least 32 bits
Date:   Fri, 13 Nov 2020 20:51:40 +0800
Message-Id: <20201113125149.140836-16-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we use 'unsigned' for extent_state::state, which is only ensured
to be at least 16 bits.

But for incoming subpage support, we are going to introduce more bits,
thus we will go beyond 16 bits.

To support this, make extent_state::state at least 32bit and to be more
explicit, we use "u32" to be clear about the max supported bits.

This doesn't increase the memory usage for x86_64, but may affect other
architectures.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h | 33 ++++++++++++------------
 fs/btrfs/extent_io.c      | 54 +++++++++++++++++++--------------------
 fs/btrfs/extent_io.h      |  2 +-
 3 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 5334b3772f18..042ad97ca08a 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -35,6 +35,7 @@ struct io_failure_record;
  * delalloc bytes decremented, in an atomic way to prevent races with stat(2).
  */
 #define EXTENT_ADD_INODE_BYTES  (1U << 15)
+
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
 				 EXTENT_CLEAR_DATA_RESV)
 #define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING | \
@@ -87,7 +88,7 @@ struct extent_state {
 	/* ADD NEW ELEMENTS AFTER THIS */
 	wait_queue_head_t wq;
 	refcount_t refs;
-	unsigned state;
+	u32 state;
 
 	struct io_failure_record *failrec;
 
@@ -119,19 +120,19 @@ void __cold extent_io_exit(void);
 
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
 
@@ -155,7 +156,7 @@ static inline int unlock_extent_cached_atomic(struct extent_io_tree *tree,
 }
 
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
-		u64 end, unsigned bits)
+				    u64 end, u32 bits)
 {
 	int wake = 0;
 
@@ -166,14 +167,14 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 }
 
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits, struct extent_changeset *changeset);
+			   u32 bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, struct extent_state **cached_state, gfp_t mask);
+		   u32 bits, struct extent_state **cached_state, gfp_t mask);
 int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits);
+			   u32 bits);
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
-		u64 end, unsigned bits)
+		u64 end, u32 bits)
 {
 	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
 }
@@ -200,11 +201,11 @@ static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
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
@@ -234,12 +235,12 @@ static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 }
 
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, unsigned bits,
+			  u64 *start_ret, u64 *end_ret, u32 bits,
 			  struct extent_state **cached_state);
 void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, unsigned bits);
+				 u64 *start_ret, u64 *end_ret, u32 bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-			       u64 *start_ret, u64 *end_ret, unsigned bits);
+			       u64 *start_ret, u64 *end_ret, u32 bits);
 int extent_invalidatepage(struct extent_io_tree *tree,
 			  struct page *page, unsigned long offset);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1c240448be83..f305777ee1a3 100644
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
@@ -695,9 +695,9 @@ static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
  * This takes the tree lock, and returns 0 on success and < 0 on error.
  */
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-			      unsigned bits, int wake, int delete,
-			      struct extent_state **cached_state,
-			      gfp_t mask, struct extent_changeset *changeset)
+		       u32 bits, int wake, int delete,
+		       struct extent_state **cached_state,
+		       gfp_t mask, struct extent_changeset *changeset)
 {
 	struct extent_state *state;
 	struct extent_state *cached;
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
@@ -964,8 +964,8 @@ static void cache_state(struct extent_state *state,
 
 static int __must_check
 __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		 unsigned bits, unsigned exclusive_bits,
-		 u64 *failed_start, struct extent_state **cached_state,
+		 u32 bits, u32 exclusive_bits, u64 *failed_start,
+		 struct extent_state **cached_state,
 		 gfp_t mask, struct extent_changeset *changeset)
 {
 	struct extent_state *state;
@@ -1184,7 +1184,7 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, struct extent_state **cached_state, gfp_t mask)
+		   u32 bits, struct extent_state **cached_state, gfp_t mask)
 {
 	return __set_extent_bit(tree, start, end, bits, 0, NULL, cached_state,
 			        mask, NULL);
@@ -1210,7 +1210,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
  * All allocations are done with GFP_NOFS.
  */
 int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       unsigned bits, unsigned clear_bits,
+		       u32 bits, u32 clear_bits,
 		       struct extent_state **cached_state)
 {
 	struct extent_state *state;
@@ -1411,7 +1411,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 /* wrappers around set/clear extent bit */
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits, struct extent_changeset *changeset)
+			   u32 bits, struct extent_changeset *changeset)
 {
 	/*
 	 * We don't support EXTENT_LOCKED yet, as current changeset will
@@ -1426,14 +1426,14 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
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
@@ -1441,7 +1441,7 @@ int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		unsigned bits, struct extent_changeset *changeset)
+		u32 bits, struct extent_changeset *changeset)
 {
 	/*
 	 * Don't support EXTENT_LOCKED case, same reason as
@@ -1529,8 +1529,7 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
  * nothing was found after 'start'
  */
 static struct extent_state *
-find_first_extent_bit_state(struct extent_io_tree *tree,
-			    u64 start, unsigned bits)
+find_first_extent_bit_state(struct extent_io_tree *tree, u64 start, u32 bits)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -1565,7 +1564,7 @@ find_first_extent_bit_state(struct extent_io_tree *tree,
  * Return 1 if we found nothing.
  */
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, unsigned bits,
+			  u64 *start_ret, u64 *end_ret, u32 bits,
 			  struct extent_state **cached_state)
 {
 	struct extent_state *state;
@@ -1616,7 +1615,7 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
  * returned will be the full contiguous area with the bits set.
  */
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-			       u64 *start_ret, u64 *end_ret, unsigned bits)
+			       u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
 	int ret = 1;
@@ -1653,7 +1652,7 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
  * trim @end_ret to the appropriate size.
  */
 void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, unsigned bits)
+				 u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
 	struct rb_node *node, *prev = NULL, *next;
@@ -2024,8 +2023,7 @@ static int __process_pages_contig(struct address_space *mapping,
 
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
-				  unsigned clear_bits,
-				  unsigned long page_ops)
+				  u32 clear_bits, unsigned long page_ops)
 {
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);
 
@@ -2041,7 +2039,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
  */
 u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end, u64 max_bytes,
-		     unsigned bits, int contig)
+		     u32 bits, int contig)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -2161,7 +2159,7 @@ struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 sta
  * range is found set.
  */
 int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, int filled, struct extent_state *cached)
+		   u32 bits, int filled, struct extent_state *cached)
 {
 	struct extent_state *state = NULL;
 	struct rb_node *node;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index d39ebaee5ff7..0123c75ee203 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -265,7 +265,7 @@ void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
-				  unsigned bits_to_clear,
+				  u32 bits_to_clear,
 				  unsigned long page_ops);
 struct bio *btrfs_bio_alloc(u64 first_byte);
 struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
-- 
2.29.2

