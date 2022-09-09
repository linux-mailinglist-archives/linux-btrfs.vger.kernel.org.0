Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05B5B41D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiIIVyl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiIIVyh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5287663
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:32 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g16so2201305qkl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=GFsjkPZ3Nz8YdlrQS5atB1yyLBEvGBPP2exlMpzSuN0=;
        b=CFY4hi9+lQy0B4jrcDnCIA5XmG2xt78M6A4ejNkrvB2ky1LEfxJzKF/NK0wOpUxYY3
         xcxDbjYqE6lhm+dsPFQM86W6hIsIeTVUzk1FSYEWO4ZcoO4TxNCgXN7k+hCz46wXZPwR
         1tjLK/kV73H1/LDfqHMouaAt3h+T79n9hK6zuKU+FDZHY51FR4GUAhYuHPk28jpK8Snh
         ZhpFmM50vZaQpGv7os+FUfv+Ndi242aJhkibUeVl2mwEk3pY0mDuQ0K2Nq2/ouZlzv5M
         xBwg+O9szwmV694CmRqz209ifP6IHZc54hpFFbN6+0bY8E/Sq05IUCgIe40sRuTvgof6
         wEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GFsjkPZ3Nz8YdlrQS5atB1yyLBEvGBPP2exlMpzSuN0=;
        b=UHi8a2RATPUQvU13qaVombuSJqVAx974m/xjgtXV/5Be9wwcGkC9tTrGC2cKEhZN99
         V45pfpA2cXHDBjMqhERSCncA0Qa+JXg6a7YnAohUY9HKKCz1c6x6JwGCCLJwSfXyAXLY
         zaxkAY7GMhFK1f+Oq/Lj3ViW3XrA1ITqleML4mujKRh9ODk4MJEOdqhrpXOySLyIuR2H
         cqtC4qecchcRw2NQK3/ePLWF2SznvkFuNIxHEGPJDdS01HT662Bux7jOM1AHO2xxE28X
         maFChe2YLp7JzLFjynmHKgNhU6DWUPD3cCzZMYpoWizh9QVN96VABgx3q2L4DKQbw5f2
         ykPQ==
X-Gm-Message-State: ACgBeo3wzJL32M64gVjfwNPrKh5A7S1dYGqBceENbpgG/uYa3Itj1OeR
        AgVWeFTWi7Ry5FzuldRYpcGzQlNH4as/1Q==
X-Google-Smtp-Source: AA6agR5BP43afmZa2HpbUPkhUp0vg5sYap4hp+A3LIdw+WwfW/yI3/Dmm70wyhErtqY8lCNHNbw2+A==
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id j14-20020a05620a410e00b006bc5cdc88ecmr11964771qko.734.1662760471784;
        Fri, 09 Sep 2022 14:54:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z24-20020ac84558000000b0035ba4e53500sm999949qtn.56.2022.09.09.14.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 28/36] btrfs: remove failed_start argument from set_extent_bit
Date:   Fri,  9 Sep 2022 17:53:41 -0400
Message-Id: <f2272d293dde46d0e5950c2328120721b1d5f452.1662760286.git.josef@toxicpanda.com>
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

This is only used for internal locking related helpers, everybody else
just passes in NULL.  I've changed set_extent_bit to __set_extent_bit
and made it static, removed failed_start from set_extent_bit and have it
call __set_extent_bit with a NULL failed_start, and I've moved some code
down below the now static __set_extent_bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 30 +++++++++++++++++++-----------
 fs/btrfs/extent-io-tree.h | 22 +++++++++-------------
 fs/btrfs/inode.c          |  4 ++--
 3 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index a870e74f9c6c..7d6e0e748238 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -956,10 +956,10 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
  *
  * [start, end] is inclusive This takes the tree lock.
  */
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, u64 *failed_start,
-		   struct extent_state **cached_state, gfp_t mask,
-		   struct extent_changeset *changeset)
+static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			    u32 bits, u64 *failed_start,
+			    struct extent_state **cached_state,
+			    struct extent_changeset *changeset, gfp_t mask)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
@@ -1172,6 +1172,14 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
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
@@ -1610,8 +1618,8 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS,
-			      changeset);
+	return __set_extent_bit(tree, start, end, bits, NULL, NULL, changeset,
+				GFP_NOFS);
 }
 
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -1632,8 +1640,8 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	int err;
 	u64 failed_start;
 
-	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
-			     NULL, GFP_NOFS, NULL);
+	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+			       NULL, NULL, GFP_NOFS);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
@@ -1654,9 +1662,9 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 failed_start;
 
 	while (1) {
-		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				     &failed_start, cached_state, GFP_NOFS,
-				     NULL);
+		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
+				       &failed_start, cached_state, NULL,
+				       GFP_NOFS);
 		if (err == -EEXIST) {
 			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
 			start = failed_start;
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
index 77060eb7e848..ff2eae4474e5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2815,7 +2815,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, NULL, cached_state,
+				     EXTENT_DELALLOC_NEW, cached_state,
 				     GFP_NOFS, NULL);
 next:
 		search_start = extent_map_end(em);
@@ -4962,7 +4962,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, NULL, NULL, GFP_NOFS, NULL);
+			       EXTENT_NORESERVE, NULL, GFP_NOFS, NULL);
 
 out_unlock:
 	if (ret) {
-- 
2.26.3

