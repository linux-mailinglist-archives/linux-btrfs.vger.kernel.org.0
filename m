Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2945F1406
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiI3Up6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiI3Upl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 16:45:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF8691B5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i17so3545497qkk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=eSW7k8pQ/bwkD6cTIU/DNG/LdMN0exjXXvW5zWjItUI=;
        b=WOzjJCogshK/UL3NAwAWobl2T9dHbdAn2glLexiG+rG2diGc2NmzDYULYEPr4dc5m2
         HBPgbA2TUq9rqi+SLM2cmc53qnqvllHXYXD5WRx101NYbwSS7RvFehDGNHMIL9ZzrlJK
         KmBbvr/hNh4L7P7lf0lSE7LTM+OjNWBktFBcifCOORVLTdGq34/AdDN8LGyx7LKv3htq
         0h/KpAHI20j5TQihLC/T2kgUH94SRgSGT+814ENpzhmdWIMzEqe2KHYbXVF6J3EUuGzX
         CQFlIf4c22jLMS6drWTXHMB9su3wCe+lQUPIlnYMR0rK1k4T5L1D+ww8bLAOpaKTjqho
         aJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eSW7k8pQ/bwkD6cTIU/DNG/LdMN0exjXXvW5zWjItUI=;
        b=okcAl/c01ycpVr8LvpQIgLjiQgGwF915eSTCtd/AlAUmQ/R2y0N4JTUxD5E8PtzQH5
         wSA/OxtF2v3WfieBLXblqOVikTmBuwWt0pAQ7dXFBzd8r50io8jZ1sxbeSY9/wfFNZ1h
         1D5R8Qd7hYOe/FSe5htlUw/Ir92rbE/Bly58xvRWlrYlYB4iQ9P3gllsdgTCQeTxB1pG
         wMkxN/oHgXZXqfkH0llXIj8FDVLJ5KZD9nY0m5PxJWH18sTOuLiX1FRpbstjIrVlliAu
         /8KvTAfN+SzdvoRuzLEELWRVQM2dehOaBvpwPTtvpL6EiowDyGdt/ArjzMNIq1Z+NoJR
         zm/A==
X-Gm-Message-State: ACrzQf3yy2EBDfR1SNZV290TgHxBKyIZucep9fZEQabphiZEYyqYFQDh
        gUo0NXf0STlSZ/5Bgkboz/4HzkVEhSPGfw==
X-Google-Smtp-Source: AMsMyM7zJag2rEyyhskVp3OjgYW2uhJgepA4FcDSsqJ+d0gT1RiAFeYCfOKUkZwntbTHMd/MVe77tA==
X-Received: by 2002:ae9:f209:0:b0:6ce:24c1:13d5 with SMTP id m9-20020ae9f209000000b006ce24c113d5mr7688515qkg.330.1664570735855;
        Fri, 30 Sep 2022 13:45:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006cf38fd659asm3090927qkb.103.2022.09.30.13.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:45:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/6] btrfs: cache the failed state when locking extents
Date:   Fri, 30 Sep 2022 16:45:12 -0400
Message-Id: <deaaecdd155197c3909785c10d70c240f134683f.1664570261.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
References: <cover.1664570261.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if we fail to lock a range we'll return the start of the range
that we failed to lock.  We'll then search down to this range and wait
on any extent states in this range.

However we can avoid this search altogether if we simply cache the
extent_state that had the contention.  We can pass this into
wait_extent_bit() and start from that extent_state without doing the
search.  In the most optimistic case we can avoid all searches, more
likely we'll avoid the initial search and have to perform the search
after we wait on the failed state, or worst case we must search both
times which is what currently happens.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 52 +++++++++++++++++++++++++++++----------
 fs/btrfs/extent-io-tree.h |  3 ++-
 fs/btrfs/extent_io.c      |  3 ++-
 3 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 1b0a45b51f4c..e455439f9e86 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -714,7 +714,8 @@ static void wait_on_state(struct extent_io_tree *tree,
  * The range [start, end] is inclusive.
  * The tree lock is taken by this function
  */
-void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+		     struct extent_state **cached_state)
 {
 	struct extent_state *state;
 
@@ -722,6 +723,16 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 
 	spin_lock(&tree->lock);
 again:
+	/*
+	 * Maintain cached_state, as we may not remove it from the tree if there
+	 * are more bits than the bits we're waiting on set on this state.
+	 */
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (extent_state_in_tree(state) &&
+		    state->start <= start && state->end > start)
+			goto process_node;
+	}
 	while (1) {
 		/*
 		 * This search will find all the extents that end after our
@@ -752,6 +763,12 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 		}
 	}
 out:
+	/* This state is no longer useful, clear it and free it up. */
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		*cached_state = NULL;
+		free_extent_state(state);
+	}
 	spin_unlock(&tree->lock);
 }
 
@@ -939,13 +956,17 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
  * sleeping, so the gfp mask is used to indicate what is allowed.
  *
  * If any of the exclusive bits are set, this will fail with -EEXIST if some
- * part of the range already has the desired bits set.  The start of the
- * existing range is returned in failed_start in this case.
+ * part of the range already has the desired bits set.  The extent_state of the
+ * existing range is returned in failed_state in this case, and the start of the
+ * existing range is returned in failed_start.  failed_state is used as an
+ * optimization for wait_extent_bit, failed_start must be used as the source of
+ * truth as failed_state may have changed since we returned.
  *
  * [start, end] is inclusive This takes the tree lock.
  */
 static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			    u32 bits, u64 *failed_start,
+			    struct extent_state **failed_state,
 			    struct extent_state **cached_state,
 			    struct extent_changeset *changeset, gfp_t mask)
 {
@@ -964,7 +985,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (exclusive_bits)
 		ASSERT(failed_start);
 	else
-		ASSERT(failed_start == NULL);
+		ASSERT(failed_start == NULL && failed_state == NULL);
 again:
 	if (!prealloc && gfpflags_allow_blocking(mask)) {
 		/*
@@ -1012,6 +1033,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (state->start == start && state->end <= end) {
 		if (state->state & exclusive_bits) {
 			*failed_start = state->start;
+			cache_state(state, failed_state);
 			err = -EEXIST;
 			goto out;
 		}
@@ -1047,6 +1069,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (state->start < start) {
 		if (state->state & exclusive_bits) {
 			*failed_start = start;
+			cache_state(state, failed_state);
 			err = -EEXIST;
 			goto out;
 		}
@@ -1125,6 +1148,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (state->start <= end && state->end > end) {
 		if (state->state & exclusive_bits) {
 			*failed_start = start;
+			cache_state(state, failed_state);
 			err = -EEXIST;
 			goto out;
 		}
@@ -1162,8 +1186,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, struct extent_state **cached_state, gfp_t mask)
 {
-	return __set_extent_bit(tree, start, end, bits, NULL, cached_state,
-				NULL, mask);
+	return __set_extent_bit(tree, start, end, bits, NULL, NULL,
+				cached_state, NULL, mask);
 }
 
 /*
@@ -1598,8 +1622,8 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return __set_extent_bit(tree, start, end, bits, NULL, NULL, changeset,
-				GFP_NOFS);
+	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL,
+				changeset, GFP_NOFS);
 }
 
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -1622,7 +1646,7 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 failed_start;
 
 	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
-			       cached, NULL, GFP_NOFS);
+			       NULL, cached, NULL, GFP_NOFS);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
@@ -1639,20 +1663,22 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 		struct extent_state **cached_state)
 {
+	struct extent_state *failed_state = NULL;
 	int err;
 	u64 failed_start;
 
 	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
-			       cached_state, NULL, GFP_NOFS);
+			       &failed_state, cached_state, NULL, GFP_NOFS);
 	while (err == -EEXIST) {
 		if (failed_start != start)
 			clear_extent_bit(tree, start, failed_start - 1,
 					 EXTENT_LOCKED, cached_state);
 
-		wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
+		wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED,
+				&failed_state);
 		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				       &failed_start, cached_state, NULL,
-				       GFP_NOFS);
+				       &failed_start, &failed_state,
+				       cached_state, NULL, GFP_NOFS);
 	}
 	return err;
 }
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 786be8f38f0b..c71aa29f719d 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -235,6 +235,7 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
-void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits);
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+		     struct extent_state **cached_state);
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e29e8aafc3b7..21b437f4e36e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5004,7 +5004,8 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	if (ret || wait != WAIT_COMPLETE)
 		return ret;
 
-	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1, EXTENT_LOCKED);
+	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+			EXTENT_LOCKED, NULL);
 	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		ret = -EIO;
 	return ret;
-- 
2.26.3

