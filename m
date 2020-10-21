Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38CB294831
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440758AbgJUG0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:43090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408709AbgJUG0p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yAsvUnTjhihyWg22r8hxrNfUDHPJhWIb8XUBYQF7rOw=;
        b=jBVZhdseOZ5ajHdoQwfxIdyUlkTiWtpq26PCpDPQGSykpoyPju5NKyly6/9Exm101L4JLD
        AyCZ1IKJr89pNQY2HuhezAkwmSeNzbcdJIAvb93XXqH0ziu6ZCMYCwLtuXuWw1mAwxTmws
        z+t7VQ6ndFRZdevNTZ5lCF+gfY6h3HA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2E89AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 21/68] btrfs: extent_io: sink less common parameters for __clear_extent_bit()
Date:   Wed, 21 Oct 2020 14:25:07 +0800
Message-Id: <20201021062554.68132-22-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following parameters are less commonly used for
__clear_extent_bit():
- wake
  To wake up the waiters

- delete
  For cleanup cases, to remove the extent state regardless of its state

- changeset
  Only utilized for qgroup

Sink them into extent_io_extra_options structure.

For most callers who don't care these options, we obviously sink some
parameters, without any impact.
For callers who care these options, we slightly increase the stack
usage, as the extent_io_extra options has extra members only for
__set_extent_bits().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h | 30 +++++++++++++++++++-------
 fs/btrfs/extent_io.c      | 45 ++++++++++++++++++++++++++++-----------
 fs/btrfs/extent_map.c     |  2 +-
 3 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index dfbb65ac9c8c..2893573eb556 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -102,6 +102,15 @@ struct extent_io_extra_options {
 	 * For qgroup related functions.
 	 */
 	struct extent_changeset *changeset;
+
+	/*
+	 * For __clear_extent_bit().
+	 * @wake:	Wake up the waiters. Mostly for EXTENT_LOCKED case
+	 * @delete:	Delete the extent regardless of its state. Mostly for
+	 * 		cleanup.
+	 */
+	bool wake;
+	bool delete;
 };
 
 int __init extent_state_cache_init(void);
@@ -139,9 +148,8 @@ int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		     unsigned bits, int wake, int delete,
 		     struct extent_state **cached);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     unsigned bits, int wake, int delete,
-		     struct extent_state **cached, gfp_t mask,
-		     struct extent_changeset *changeset);
+		       unsigned bits, struct extent_state **cached_state,
+		       gfp_t mask, struct extent_io_extra_options *extra_opts);
 
 static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 {
@@ -151,15 +159,21 @@ static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 static inline int unlock_extent_cached(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
-				GFP_NOFS, NULL);
+	struct extent_io_extra_options extra_opts = {
+		.wake = true,
+	};
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
+				GFP_NOFS, &extra_opts);
 }
 
 static inline int unlock_extent_cached_atomic(struct extent_io_tree *tree,
 		u64 start, u64 end, struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
-				GFP_ATOMIC, NULL);
+	struct extent_io_extra_options extra_opts = {
+		.wake = true,
+	};
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
+				GFP_ATOMIC, &extra_opts);
 }
 
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
@@ -190,7 +204,7 @@ static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE, 0, 0,
+	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE,
 				cached_state, GFP_NOFS, NULL);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f899b27962b..98b114becd52 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -688,26 +688,38 @@ static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
  * or inserting elements in the tree, so the gfp mask is used to
  * indicate which allocations or sleeping are allowed.
  *
- * pass 'wake' == 1 to kick any sleepers, and 'delete' == 1 to remove
- * the given range from the tree regardless of state (ie for truncate).
+ * extar_opts::wake:		To kick any sleeps.
+ * extra_opts::delete:		To remove the given range regardless of state
+ *				(ie for truncate)
+ * extra_opts::changeset: 	To record how many bytes are modified and
+ * 				which ranges are modified. (for qgroup)
  *
- * the range [start, end] is inclusive.
+ * The range [start, end] is inclusive.
  *
- * This takes the tree lock, and returns 0 on success and < 0 on error.
+ * Returns 0 on success
+ * No error can be returned yet, the ENOMEM for memory is handled by BUG_ON().
  */
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-			      unsigned bits, int wake, int delete,
-			      struct extent_state **cached_state,
-			      gfp_t mask, struct extent_changeset *changeset)
+		       unsigned bits, struct extent_state **cached_state,
+		       gfp_t mask, struct extent_io_extra_options *extra_opts)
 {
+	struct extent_changeset *changeset;
 	struct extent_state *state;
 	struct extent_state *cached;
 	struct extent_state *prealloc = NULL;
 	struct rb_node *node;
+	bool wake;
+	bool delete;
 	u64 last_end;
 	int err;
 	int clear = 0;
 
+	if (!extra_opts)
+		extra_opts = &default_opts;
+	changeset = extra_opts->changeset;
+	wake = extra_opts->wake;
+	delete = extra_opts->delete;
+
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
 
@@ -1445,21 +1457,30 @@ int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		     unsigned bits, int wake, int delete,
 		     struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, bits, wake, delete,
-				  cached, GFP_NOFS, NULL);
+	struct extent_io_extra_options extra_opts = {
+		.wake = wake,
+		.delete = delete,
+	};
+
+	return __clear_extent_bit(tree, start, end, bits,
+				  cached, GFP_NOFS, &extra_opts);
 }
 
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 		unsigned bits, struct extent_changeset *changeset)
 {
+	struct extent_io_extra_options extra_opts = {
+		.changeset = changeset,
+	};
+
 	/*
 	 * Don't support EXTENT_LOCKED case, same reason as
 	 * set_record_extent_bits().
 	 */
 	BUG_ON(bits & EXTENT_LOCKED);
 
-	return __clear_extent_bit(tree, start, end, bits, 0, 0, NULL, GFP_NOFS,
-				  changeset);
+	return __clear_extent_bit(tree, start, end, bits, NULL, GFP_NOFS,
+				  &extra_opts);
 }
 
 /*
@@ -4479,7 +4500,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		 */
 		ret = __clear_extent_bit(tree, start, end,
 				 ~(EXTENT_LOCKED | EXTENT_NODATASUM),
-				 0, 0, NULL, mask, NULL);
+				 NULL, mask, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
 		 * we can't allow the release to continue.
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bd6229fb2b6f..95651ddbb3a7 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -380,7 +380,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 
 		__clear_extent_bit(&device->alloc_state, stripe->physical,
 				   stripe->physical + stripe_size - 1, bits,
-				   0, 0, NULL, GFP_NOWAIT, NULL);
+				   NULL, GFP_NOWAIT, NULL);
 	}
 }
 
-- 
2.28.0

