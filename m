Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E425B41CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIIVyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiIIVyP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:15 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7AF10D72D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:13 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z18so2335817qts.7
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=gEVI1BkzSeksrm2FHW6+BRs3zBNNFKw3QpM0DAwdrLc=;
        b=ZISD8szcBbG2V+JVdiQONe2I5LPFN2NDCEEbYN7kdBrZ0m7qDTaVIZZRVHj5ynGVx1
         CkHYbRYHZvKlosd2cmEJD67l0STouRgwietaSqxvr/Vo1n0KfWyUb7ASrlUA/Vb6ImE4
         E5LbV35B3rJ1r3d2ziM6XOTAvGc1/HKVrWEvo9odojsuOTIkktste3lbgM7gDs16LO5H
         teZVWXbhOq+jH97wF4PlUDpyslXQ5MFyw3DrhXDPjLPFLXt9MCD+fd0MociQrl59KQCi
         PVKDDgLyB+YNy2+m8/jkBVfqdAFL5pJHUreY7XbcpYEo1GoVhsxO/bUBm898IAJNHAiS
         zRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gEVI1BkzSeksrm2FHW6+BRs3zBNNFKw3QpM0DAwdrLc=;
        b=KZX93GwxL8uxDeD4+RGOb/ll/1QVluqPGgHsddwZYa7yVmMmlQwYVQ7qd7FwVOerGS
         2pLP1PLx5jHnItYAq329HsPlC4BFbPuRtu54btv84iG+xpGUFB+61rKxrRVq8V2t/Hw4
         q3Dto0yi4gCp3OdJB6QBqv2xI/Rd3GCJuWPARx2N1Pc33wos8IJDV/sXHqi7BggASyI0
         hJ3u+ExB2CdeQcFhYPw+AcW6CdMt5bBuM/sfVFAyfnlL7n2IFvA5JvQlFCMsgDAJQxd7
         srQpisnx4jDRufsuuLGBnPCIOby8q7Mzp4NJX2sQqYI0yGXFNT4uGQ1JBRvU141+gQ05
         gD2Q==
X-Gm-Message-State: ACgBeo3g/DuJAPQ1w3CFY3B7uOg23lddb/PlsGzTWeSxi90zIAPCFf7m
        8+Z4ELYcOCdWBQ8LFdeZyGFCFTB4r1v7wA==
X-Google-Smtp-Source: AA6agR7EptkH45QixeN6bUdwePkm8NgXb2LNN2BL88b5vuAjQhawWqVpEnbObfGGHfZ6D8tOYQwwTA==
X-Received: by 2002:a05:622a:291:b0:343:7e97:db08 with SMTP id z17-20020a05622a029100b003437e97db08mr14073302qtw.58.1662760452559;
        Fri, 09 Sep 2022 14:54:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n21-20020a05620a295500b006bb49cfe147sm1752026qkp.84.2022.09.09.14.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 15/36] btrfs: move a few exported extent_io_tree helpers to extent-io-tree.c
Date:   Fri,  9 Sep 2022 17:53:28 -0400
Message-Id: <006710f3346c24464aee913dec7d5066938a6047.1662760286.git.josef@toxicpanda.com>
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

These are the last few helpers that do not rely on tree_search() and
who's other helpers are exported and in extent-io-tree.c already.  Move
these across now in order to make the core move smaller.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 142 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.c      | 141 -------------------------------------
 2 files changed, 142 insertions(+), 141 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 882f9a609d11..468b373c4359 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -5,6 +5,7 @@
 #include "ctree.h"
 #include "extent-io-tree.h"
 #include "btrfs_inode.h"
+#include "misc.h"
 
 static struct kmem_cache *extent_state_cache;
 
@@ -510,6 +511,123 @@ struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	return next;
 }
 
+/**
+ * Find the first range that has @bits not set. This range could start before
+ * @start.
+ *
+ * @tree:      the tree to search
+ * @start:     offset at/after which the found extent should start
+ * @start_ret: records the beginning of the range
+ * @end_ret:   records the end of the range (inclusive)
+ * @bits:      the set of bits which must be unset
+ *
+ * Since unallocated range is also considered one which doesn't have the bits
+ * set it's possible that @end_ret contains -1, this happens in case the range
+ * spans (last_range_end, end of device]. In this case it's up to the caller to
+ * trim @end_ret to the appropriate size.
+ */
+void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				 u64 *start_ret, u64 *end_ret, u32 bits)
+{
+	struct extent_state *state;
+	struct rb_node *node, *prev = NULL, *next;
+
+	spin_lock(&tree->lock);
+
+	/* Find first extent with bits cleared */
+	while (1) {
+		node = tree_search_prev_next(tree, start, &prev, &next);
+		if (!node && !next && !prev) {
+			/*
+			 * Tree is completely empty, send full range and let
+			 * caller deal with it
+			 */
+			*start_ret = 0;
+			*end_ret = -1;
+			goto out;
+		} else if (!node && !next) {
+			/*
+			 * We are past the last allocated chunk, set start at
+			 * the end of the last extent.
+			 */
+			state = rb_entry(prev, struct extent_state, rb_node);
+			*start_ret = state->end + 1;
+			*end_ret = -1;
+			goto out;
+		} else if (!node) {
+			node = next;
+		}
+		/*
+		 * At this point 'node' either contains 'start' or start is
+		 * before 'node'
+		 */
+		state = rb_entry(node, struct extent_state, rb_node);
+
+		if (in_range(start, state->start, state->end - state->start + 1)) {
+			if (state->state & bits) {
+				/*
+				 * |--range with bits sets--|
+				 *    |
+				 *    start
+				 */
+				start = state->end + 1;
+			} else {
+				/*
+				 * 'start' falls within a range that doesn't
+				 * have the bits set, so take its start as
+				 * the beginning of the desired range
+				 *
+				 * |--range with bits cleared----|
+				 *      |
+				 *      start
+				 */
+				*start_ret = state->start;
+				break;
+			}
+		} else {
+			/*
+			 * |---prev range---|---hole/unset---|---node range---|
+			 *                          |
+			 *                        start
+			 *
+			 *                        or
+			 *
+			 * |---hole/unset--||--first node--|
+			 * 0   |
+			 *    start
+			 */
+			if (prev) {
+				state = rb_entry(prev, struct extent_state,
+						 rb_node);
+				*start_ret = state->end + 1;
+			} else {
+				*start_ret = 0;
+			}
+			break;
+		}
+	}
+
+	/*
+	 * Find the longest stretch from start until an entry which has the
+	 * bits set
+	 */
+	while (1) {
+		state = rb_entry(node, struct extent_state, rb_node);
+		if (state->end >= start && !(state->state & bits)) {
+			*end_ret = state->end;
+		} else {
+			*end_ret = state->start - 1;
+			break;
+		}
+
+		node = rb_next(node);
+		if (!node)
+			break;
+	}
+out:
+	spin_unlock(&tree->lock);
+}
+
 /* wrappers around set/clear extent bit */
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset)
@@ -555,6 +673,30 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	return 1;
 }
 
+/*
+ * either insert or lock state struct between start and end use mask to tell
+ * us if waiting is desired.
+ */
+int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+		     struct extent_state **cached_state)
+{
+	int err;
+	u64 failed_start;
+
+	while (1) {
+		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
+				     EXTENT_LOCKED, &failed_start,
+				     cached_state, GFP_NOFS, NULL);
+		if (err == -EEXIST) {
+			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
+			start = failed_start;
+		} else
+			break;
+		WARN_ON(start > end);
+	}
+	return err;
+}
+
 void __cold extent_state_free_cachep(void)
 {
 	btrfs_extent_state_leak_debug_check();
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 65e239ab3dc0..fd2506c9be03 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -889,30 +889,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return err;
 }
 
-/*
- * either insert or lock state struct between start and end use mask to tell
- * us if waiting is desired.
- */
-int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		     struct extent_state **cached_state)
-{
-	int err;
-	u64 failed_start;
-
-	while (1) {
-		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				     EXTENT_LOCKED, &failed_start,
-				     cached_state, GFP_NOFS, NULL);
-		if (err == -EEXIST) {
-			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
-			start = failed_start;
-		} else
-			break;
-		WARN_ON(start > end);
-	}
-	return err;
-}
-
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
 	unsigned long index = start >> PAGE_SHIFT;
@@ -1057,123 +1033,6 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 	return ret;
 }
 
-/**
- * Find the first range that has @bits not set. This range could start before
- * @start.
- *
- * @tree:      the tree to search
- * @start:     offset at/after which the found extent should start
- * @start_ret: records the beginning of the range
- * @end_ret:   records the end of the range (inclusive)
- * @bits:      the set of bits which must be unset
- *
- * Since unallocated range is also considered one which doesn't have the bits
- * set it's possible that @end_ret contains -1, this happens in case the range
- * spans (last_range_end, end of device]. In this case it's up to the caller to
- * trim @end_ret to the appropriate size.
- */
-void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, u32 bits)
-{
-	struct extent_state *state;
-	struct rb_node *node, *prev = NULL, *next;
-
-	spin_lock(&tree->lock);
-
-	/* Find first extent with bits cleared */
-	while (1) {
-		node = tree_search_prev_next(tree, start, &prev, &next);
-		if (!node && !next && !prev) {
-			/*
-			 * Tree is completely empty, send full range and let
-			 * caller deal with it
-			 */
-			*start_ret = 0;
-			*end_ret = -1;
-			goto out;
-		} else if (!node && !next) {
-			/*
-			 * We are past the last allocated chunk, set start at
-			 * the end of the last extent.
-			 */
-			state = rb_entry(prev, struct extent_state, rb_node);
-			*start_ret = state->end + 1;
-			*end_ret = -1;
-			goto out;
-		} else if (!node) {
-			node = next;
-		}
-		/*
-		 * At this point 'node' either contains 'start' or start is
-		 * before 'node'
-		 */
-		state = rb_entry(node, struct extent_state, rb_node);
-
-		if (in_range(start, state->start, state->end - state->start + 1)) {
-			if (state->state & bits) {
-				/*
-				 * |--range with bits sets--|
-				 *    |
-				 *    start
-				 */
-				start = state->end + 1;
-			} else {
-				/*
-				 * 'start' falls within a range that doesn't
-				 * have the bits set, so take its start as
-				 * the beginning of the desired range
-				 *
-				 * |--range with bits cleared----|
-				 *      |
-				 *      start
-				 */
-				*start_ret = state->start;
-				break;
-			}
-		} else {
-			/*
-			 * |---prev range---|---hole/unset---|---node range---|
-			 *                          |
-			 *                        start
-			 *
-			 *                        or
-			 *
-			 * |---hole/unset--||--first node--|
-			 * 0   |
-			 *    start
-			 */
-			if (prev) {
-				state = rb_entry(prev, struct extent_state,
-						 rb_node);
-				*start_ret = state->end + 1;
-			} else {
-				*start_ret = 0;
-			}
-			break;
-		}
-	}
-
-	/*
-	 * Find the longest stretch from start until an entry which has the
-	 * bits set
-	 */
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
-		if (state->end >= start && !(state->state & bits)) {
-			*end_ret = state->end;
-		} else {
-			*end_ret = state->start - 1;
-			break;
-		}
-
-		node = rb_next(node);
-		if (!node)
-			break;
-	}
-out:
-	spin_unlock(&tree->lock);
-}
-
 /*
  * find a contiguous range of bytes in the file marked as delalloc, not
  * more than 'max_bytes'.  start and end are used to return the range,
-- 
2.26.3

