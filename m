Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B945AB94D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiIBUR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIBURU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA679C889B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:19 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cr9so2326067qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=77a0jGVseOmBdoEHB7/ojV0KwN3p8J4wJ8xeAfmxpu8=;
        b=FQw+ZQNR3ZZsPbFaJZNVG8EfpuqeLcyZkgeeh2Tki4o9schBfRE9kLig7ZQLnDLDw4
         8pMXhdC3cCGbiPptNsOnu338bnVVG1yVp4q2gmaneNJdl8dB9hoG2ZA1HP0lswXeE1tb
         qaKfy94mx2Kefkp/3QBDtjmqTwU9OCqKsL854xqItp9/TfRLLuxqbvYQnlTqw1LeJsxz
         wqeKFEQ4oi6FxhNMfuUkWVXQ1kffuPB7eBluAY0A4p5mY2tldcnIuhZkrFJSbjipi0nO
         bfSpvhSjw7inHXmhf/NMmkpA6KlCwzJxwhJx0UYoE/jq/X2cLceVeaayF08UPjDQzmS5
         eVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=77a0jGVseOmBdoEHB7/ojV0KwN3p8J4wJ8xeAfmxpu8=;
        b=UdvP843kqv2GZqd4S/rEHPrDL9wg+VTdufw8uKrBruFtzrPyHPIUr3T87FrEneUl9U
         YmgBpbnjt8dwga502kCdshr4HjvckWBvzAWEyHrbLnopczhnHbS3d29PY5aM6PxQSx8+
         EUP5WePoAvNX1UQoTjipo25wAW3nO6xTO0nOBUP7gA42zz026Fbgg0Tuq0dtMQJT/qlw
         kRAXeULSCACT4suLR7kRey+2tQo9ezFK+DBReNCWuMVN8jekgF0cbkRnxx7AKUpooY0+
         2NxVfaz9ykRksh9kUUNRnieUQRN1oYxFJp8PyqYzLAwN3xPDCfKRRkkzxS553GK1EzWo
         gkSA==
X-Gm-Message-State: ACgBeo1kmgyFL+gj3NPFjwALANROGIBFvyCbMd+TchLYsH0nsQaiSeNO
        3F4o+EUu7fLfp7cOnZwfKxomYWWbt/zV6w==
X-Google-Smtp-Source: AA6agR4GVxtST/9vgrUUk8D6akwv3laxCjt9KZ19jrLZIJXuQUx8+ImPGu0gNtVkkR+YoY5MGtOPUg==
X-Received: by 2002:a05:622a:18e:b0:342:f7a9:a133 with SMTP id s14-20020a05622a018e00b00342f7a9a133mr30261955qtw.402.1662149838529;
        Fri, 02 Sep 2022 13:17:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o1-20020ac84281000000b0033c36ef019esm1673463qtl.63.2022.09.02.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/31] btrfs: remove failed_start argument from set_extent_bit
Date:   Fri,  2 Sep 2022 16:16:28 -0400
Message-Id: <529dfc42ce5fab69dcc3cc8ed6806b5510d0cf1d.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

This is only used for internal locking related helpers, everybody else
just passes in NULL.  I've changed set_extent_bit to __set_extent_bit
and made it static, removed failed_start from set_extent_bit and have it
call __set_extent_bit with a NULL failed_start, and I've moved some code
down below the now static __set_extent_bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 110 ++++++++++++++++++++------------------
 fs/btrfs/extent-io-tree.h |  22 ++++----
 fs/btrfs/inode.c          |   4 +-
 3 files changed, 70 insertions(+), 66 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index f486e70b444b..9440879862c8 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -187,51 +187,6 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 	return ret;
 }
 
-/* wrappers around set/clear extent bit */
-int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   u32 bits, struct extent_changeset *changeset)
-{
-	/*
-	 * We don't support EXTENT_LOCKED yet, as current changeset will
-	 * record any bits changed, so for EXTENT_LOCKED case, it will
-	 * either fail with -EEXIST or changeset will record the whole
-	 * range.
-	 */
-	ASSERT(!(bits & EXTENT_LOCKED));
-
-	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS,
-			      changeset);
-}
-
-int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		u32 bits, struct extent_changeset *changeset)
-{
-	/*
-	 * Don't support EXTENT_LOCKED case, same reason as
-	 * set_record_extent_bits().
-	 */
-	ASSERT(!(bits & EXTENT_LOCKED));
-
-	return __clear_extent_bit(tree, start, end, bits, 0, NULL, GFP_NOFS,
-				  changeset);
-}
-
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	int err;
-	u64 failed_start;
-
-	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
-			     NULL, GFP_NOFS, NULL);
-	if (err == -EEXIST) {
-		if (failed_start > start)
-			clear_extent_bit(tree, start, failed_start - 1,
-					 EXTENT_LOCKED, 0, NULL);
-		return 0;
-	}
-	return 1;
-}
-
 static struct extent_state *next_state(struct extent_state *state)
 {
 	struct rb_node *next = rb_next(&state->rb_node);
@@ -839,9 +794,10 @@ static void cache_state(struct extent_state *state,
  *
  * [start, end] is inclusive This takes the tree lock.
  */
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		   u64 *failed_start, struct extent_state **cached_state,
-		   gfp_t mask, struct extent_changeset *changeset)
+static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			    u32 bits, u64 *failed_start,
+			    struct extent_state **cached_state,
+			    struct extent_changeset *changeset, gfp_t mask)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
@@ -1054,6 +1010,14 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 
 }
 
+int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, struct extent_state **cached_state, gfp_t mask,
+		   struct extent_changeset *changeset)
+{
+	return __set_extent_bit(tree, start, end, bits, NULL, cached_state,
+				changeset, mask);
+}
+
 /**
  * convert_extent_bit - convert all bits in a given range from one bit to
  * 			another
@@ -1278,9 +1242,8 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 failed_start;
 
 	while (1) {
-		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				     &failed_start, cached_state, GFP_NOFS,
-				     NULL);
+		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
+				       &failed_start, cached_state, NULL, GFP_NOFS);
 		if (err == -EEXIST) {
 			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
 			start = failed_start;
@@ -1662,6 +1625,51 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
+/* wrappers around set/clear extent bit */
+int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+			   u32 bits, struct extent_changeset *changeset)
+{
+	/*
+	 * We don't support EXTENT_LOCKED yet, as current changeset will
+	 * record any bits changed, so for EXTENT_LOCKED case, it will
+	 * either fail with -EEXIST or changeset will record the whole
+	 * range.
+	 */
+	ASSERT(!(bits & EXTENT_LOCKED));
+
+	return __set_extent_bit(tree, start, end, bits, NULL, NULL, changeset,
+				GFP_NOFS);
+}
+
+int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+		u32 bits, struct extent_changeset *changeset)
+{
+	/*
+	 * Don't support EXTENT_LOCKED case, same reason as
+	 * set_record_extent_bits().
+	 */
+	ASSERT(!(bits & EXTENT_LOCKED));
+
+	return __clear_extent_bit(tree, start, end, bits, 0, NULL, GFP_NOFS,
+				  changeset);
+}
+
+int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
+{
+	int err;
+	u64 failed_start;
+
+	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+			       NULL, NULL, GFP_NOFS);
+	if (err == -EEXIST) {
+		if (failed_start > start)
+			clear_extent_bit(tree, start, failed_start - 1,
+					 EXTENT_LOCKED, 0, NULL);
+		return 0;
+	}
+	return 1;
+}
+
 void __cold extent_state_free_cachep(void)
 {
 	btrfs_extent_state_leak_debug_check();
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index bd3c345a7530..991bfa3a8391 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -160,22 +160,19 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, u64 *failed_start,
-		   struct extent_state **cached_state, gfp_t mask,
+		   u32 bits, struct extent_state **cached_state, gfp_t mask,
 		   struct extent_changeset *changeset);
 
 static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start,
 					 u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOWAIT,
-			      NULL);
+	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT, NULL);
 }
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS,
-			      NULL);
+	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS, NULL);
 }
 
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
@@ -188,8 +185,7 @@ static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
 		u64 end, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, NULL, mask,
-			      NULL);
+	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask, NULL);
 }
 
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
@@ -210,7 +206,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | extra_bits,
-			      NULL, cached_state, GFP_NOFS, NULL);
+			      cached_state, GFP_NOFS, NULL);
 }
 
 static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
@@ -218,20 +214,20 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | EXTENT_DEFRAG,
-			      NULL, cached_state, GFP_NOFS, NULL);
+			      cached_state, GFP_NOFS, NULL);
 }
 
 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
-	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, NULL,
-			      GFP_NOFS, NULL);
+	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS,
+			      NULL);
 }
 
 static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_UPTODATE, NULL,
+	return set_extent_bit(tree, start, end, EXTENT_UPTODATE,
 			      cached_state, mask, NULL);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 700e6aa4af4f..b82d220e9342 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2816,7 +2816,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, NULL, cached_state,
+				     EXTENT_DELALLOC_NEW, cached_state,
 				     GFP_NOFS, NULL);
 next:
 		search_start = extent_map_end(em);
@@ -4963,7 +4963,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, NULL, NULL, GFP_NOFS, NULL);
+			       EXTENT_NORESERVE, NULL, GFP_NOFS, NULL);
 
 out_unlock:
 	if (ret) {
-- 
2.26.3

