Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF122A4681
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgKCNbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbgKCNbn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBx9ZdCSJC1BXIHvn/bEr70EaR3xMTnMC4SlDW90lTI=;
        b=DulBNW+yfXfrCEVYC3mqrmmW7gh1Ve0W2jgF2wVIK+q/6gjRuR3WzUZCNdgeA+1Z4sA8De
        5aTp5VwHVuNjv09Yf311dRHbHR/x7zS29RGcMEr2YFKcFl2Eg97hx9uu7uQUyNihFHNhZW
        8o2Lph+u4xm5E4REjpnqeHPYY9eMj3Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C177DAB0E
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:31:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/32] btrfs: extent_io: sink less common parameters for __set_extent_bit()
Date:   Tue,  3 Nov 2020 21:30:44 +0800
Message-Id: <20201103133108.148112-9-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For __set_extent_bit(), those parameter are less common for most
callers:
- exclusive_bits
- failed_start
  Mostly for extent locking.

- extent_changeset
  For qgroup usage.

As a common design principle, less common parameters should have their
default values and only callers really need them will set the parameters
to non-default values.

Sink those parameters into a new structure, extent_io_extra_options.
So most callers won't bother those less used parameters, and make later
expansion easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h | 22 ++++++++++++++
 fs/btrfs/extent_io.c      | 61 ++++++++++++++++++++++++---------------
 2 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index cab4273ff8d3..c93065794567 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -82,6 +82,28 @@ struct extent_state {
 #endif
 };
 
+/*
+ * Extra options for extent io tree operations.
+ *
+ * All of these options are initialized to 0/false/NULL by default,
+ * and most callers should utilize the wrappers other than the extra options.
+ */
+struct extent_io_extra_options {
+	/*
+	 * For __set_extent_bit(), to return -EEXIST when hit an extent with
+	 * @excl_bits set, and update @excl_failed_start.
+	 * Utizlied by EXTENT_LOCKED wrappers.
+	 */
+	u32 excl_bits;
+	u64 excl_failed_start;
+
+	/*
+	 * For __set/__clear_extent_bit() to record how many bytes is modified.
+	 * For qgroup related functions.
+	 */
+	struct extent_changeset *changeset;
+};
+
 int __init extent_state_cache_init(void);
 void __cold extent_state_cache_exit(void);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a90cdcf01b7f..1fd92815553d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -29,6 +29,7 @@ static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
 static struct bio_set btrfs_bioset;
 
+static struct extent_io_extra_options default_opts = { 0 };
 static inline bool extent_state_in_tree(const struct extent_state *state)
 {
 	return !RB_EMPTY_NODE(&state->rb_node);
@@ -952,10 +953,10 @@ static void cache_state(struct extent_state *state,
 }
 
 /*
- * set some bits on a range in the tree.  This may require allocations or
+ * Set some bits on a range in the tree.  This may require allocations or
  * sleeping, so the gfp mask is used to indicate what is allowed.
  *
- * If any of the exclusive bits are set, this will fail with -EEXIST if some
+ * If *any* of the exclusive bits are set, this will fail with -EEXIST if some
  * part of the range already has the desired bits set.  The start of the
  * existing range is returned in failed_start in this case.
  *
@@ -964,26 +965,30 @@ static void cache_state(struct extent_state *state,
 
 static int __must_check
 __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		 unsigned bits, unsigned exclusive_bits,
-		 u64 *failed_start, struct extent_state **cached_state,
-		 gfp_t mask, struct extent_changeset *changeset)
+		 unsigned bits, struct extent_state **cached_state,
+		 gfp_t mask, struct extent_io_extra_options *extra_opts)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
 	struct rb_node *node;
 	struct rb_node **p;
 	struct rb_node *parent;
+	struct extent_changeset *changeset;
 	int err = 0;
+	u32 exclusive_bits;
+	u64 *failed_start;
 	u64 last_start;
 	u64 last_end;
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
 
-	if (exclusive_bits)
-		ASSERT(failed_start);
-	else
-		ASSERT(failed_start == NULL);
+	if (!extra_opts)
+		extra_opts = &default_opts;
+	exclusive_bits = extra_opts->excl_bits;
+	failed_start = &extra_opts->excl_failed_start;
+	changeset = extra_opts->changeset;
+
 again:
 	if (!prealloc && gfpflags_allow_blocking(mask)) {
 		/*
@@ -1186,7 +1191,7 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   unsigned bits, struct extent_state **cached_state, gfp_t mask)
 {
-	return __set_extent_bit(tree, start, end, bits, 0, NULL, cached_state,
+	return __set_extent_bit(tree, start, end, bits, cached_state,
 			        mask, NULL);
 }
 
@@ -1413,6 +1418,10 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   unsigned bits, struct extent_changeset *changeset)
 {
+	struct extent_io_extra_options extra_opts = {
+		.changeset = changeset,
+	};
+
 	/*
 	 * We don't support EXTENT_LOCKED yet, as current changeset will
 	 * record any bits changed, so for EXTENT_LOCKED case, it will
@@ -1421,15 +1430,14 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	BUG_ON(bits & EXTENT_LOCKED);
 
-	return __set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
-				changeset);
+	return __set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS,
+				&extra_opts);
 }
 
 int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
 			   unsigned bits)
 {
-	return __set_extent_bit(tree, start, end, bits, 0, NULL, NULL,
-				GFP_NOWAIT, NULL);
+	return __set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT, NULL);
 }
 
 int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
@@ -1460,16 +1468,18 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 		     struct extent_state **cached_state)
 {
+	struct extent_io_extra_options extra_opts = {
+		.excl_bits = EXTENT_LOCKED,
+	};
 	int err;
-	u64 failed_start;
 
 	while (1) {
 		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				       EXTENT_LOCKED, &failed_start,
-				       cached_state, GFP_NOFS, NULL);
+				       cached_state, GFP_NOFS, &extra_opts);
 		if (err == -EEXIST) {
-			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
-			start = failed_start;
+			wait_extent_bit(tree, extra_opts.excl_failed_start, end,
+					EXTENT_LOCKED);
+			start = extra_opts.excl_failed_start;
 		} else
 			break;
 		WARN_ON(start > end);
@@ -1479,14 +1489,17 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 
 int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 {
+	struct extent_io_extra_options extra_opts = {
+		.excl_bits = EXTENT_LOCKED,
+	};
 	int err;
-	u64 failed_start;
 
-	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
-			       &failed_start, NULL, GFP_NOFS, NULL);
+	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
+			       NULL, GFP_NOFS, &extra_opts);
 	if (err == -EEXIST) {
-		if (failed_start > start)
-			clear_extent_bit(tree, start, failed_start - 1,
+		if (extra_opts.excl_failed_start > start)
+			clear_extent_bit(tree, start,
+					 extra_opts.excl_failed_start - 1,
 					 EXTENT_LOCKED, 1, 0, NULL);
 		return 0;
 	}
-- 
2.29.2

