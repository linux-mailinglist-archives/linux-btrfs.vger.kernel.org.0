Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52F15B41DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiIIVyj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiIIVya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:30 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4575FD8
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:29 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j6so2204628qkl.10
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=LJDy91ir/xEcsnxtDi+XN8zsugFLRV+CqF0cZnUndrk=;
        b=YHXsId3CpFBVoBmoa6tkwsqF4lcg8ZA2dNygW44z1IamGqCW7JuMA4CJXTmyLL01Wl
         vL/H0OutuhpCVROBpZ/7+nvVWXTh7YvI1mo8mW5rIgE34D5b4X8jtm/m9EngwYXX3Jfv
         FUwgm2tzuj8jcr4eM8XCE22XX46iLq4FMip6poNdbCREZPIVEzv6efTgwctA1ZQBjBjl
         cad5MS31arxlOQHQ1S0B6PE6obcaHTKAJ2kBgOisirABFtZNomo3RvAkJh/wmqHF7NEE
         I/oHFXlV9n/5CjIa8GM/5my7RTUXQjRzGbJEcXmrFLc7TAuVhgrgw/uqmQzXldXTUqGw
         OE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LJDy91ir/xEcsnxtDi+XN8zsugFLRV+CqF0cZnUndrk=;
        b=zbF8M5SAPvBgdLZH45zRgu9BqvH78/OxZ4/cmI+KBFBnB+K8fX4F7fertOQvU5sVW9
         8VSLeZQr53l919ubaGlsh4epvMnjgr8DsJS5c3Xmvx88F7lLyYW4uI9Tt9EyQo46M/ya
         7B0fCqNjGhda2p0ysryjY3Gbfq8ngDkq091nTUSeXFX00yWzr0GOoeusDPj7RvCWhRUG
         BtLtB7wDdJSL44LBClefiplW9tBqVJwltF7cSufFaWB+IxpYRwBwkron+kPuMySerQmB
         XnnH4Np9EEYetDgVPWS2UIanA1IaAn1JxgIhxlEowDsCHjGs4LQ1v7yIEJKHwTNAWnxG
         Uxzw==
X-Gm-Message-State: ACgBeo2zLVTd2YkQui1uAhN5m2LkuZMTsHeBKCINqEAQoDdUd2OvMPBM
        RhN31ff5L6Q8KSsRD7KGbMzq8qNLKtDW0Q==
X-Google-Smtp-Source: AA6agR6ofMIKaq0Hj4dwfFxqN5mp7a/xlMXkWyT1shkcUKd++zotqIx7eIa4tMZD77D1GGlUDKGuMQ==
X-Received: by 2002:a05:620a:4005:b0:6be:971c:378f with SMTP id h5-20020a05620a400500b006be971c378fmr11315250qko.530.1662760468804;
        Fri, 09 Sep 2022 14:54:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g21-20020ac84695000000b0035ba5db657esm660430qto.76.2022.09.09.14.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 26/36] btrfs: drop exclusive_bits from set_extent_bit
Date:   Fri,  9 Sep 2022 17:53:39 -0400
Message-Id: <2126d9685e12436d4736969cb84bedaa077b0f12.1662760286.git.josef@toxicpanda.com>
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

This is only ever set if we have EXTENT_LOCKED set, so simply push this
into the function itself and remove the function argument.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 15 ++++++++-------
 fs/btrfs/extent-io-tree.h | 20 ++++++++++----------
 fs/btrfs/inode.c          |  4 ++--
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6c734b6871f8..f67d9ee6f03e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -955,8 +955,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
  *
  * [start, end] is inclusive This takes the tree lock.
  */
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		   u32 exclusive_bits, u64 *failed_start,
+int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, u64 *failed_start,
 		   struct extent_state **cached_state, gfp_t mask,
 		   struct extent_changeset *changeset)
 {
@@ -967,6 +967,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 	int err = 0;
 	u64 last_start;
 	u64 last_end;
+	u32 exclusive_bits = bits & EXTENT_LOCKED;
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
@@ -1608,7 +1609,7 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
+	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS,
 			      changeset);
 }
 
@@ -1630,8 +1631,8 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	int err;
 	u64 failed_start;
 
-	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
-			     &failed_start, NULL, GFP_NOFS, NULL);
+	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+			     NULL, GFP_NOFS, NULL);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
@@ -1653,8 +1654,8 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 
 	while (1) {
 		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				     EXTENT_LOCKED, &failed_start,
-				     cached_state, GFP_NOFS, NULL);
+				     &failed_start, cached_state, GFP_NOFS,
+				     NULL);
 		if (err == -EEXIST) {
 			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
 			start = failed_start;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 85acdd13d2c4..fb6caef20373 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -166,21 +166,21 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, unsigned exclusive_bits, u64 *failed_start,
+		   u32 bits, u64 *failed_start,
 		   struct extent_state **cached_state, gfp_t mask,
 		   struct extent_changeset *changeset);
 
 static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start,
 					 u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL,
-			      GFP_NOWAIT, NULL);
+	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOWAIT,
+			      NULL);
 }
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
+	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS,
 			      NULL);
 }
 
@@ -194,8 +194,8 @@ static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
 		u64 end, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, 0, NULL, NULL,
-			      mask, NULL);
+	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, NULL, mask,
+			      NULL);
 }
 
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
@@ -216,7 +216,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | extra_bits,
-			      0, NULL, cached_state, GFP_NOFS, NULL);
+			      NULL, cached_state, GFP_NOFS, NULL);
 }
 
 static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
@@ -224,20 +224,20 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | EXTENT_DEFRAG,
-			      0, NULL, cached_state, GFP_NOFS, NULL);
+			      NULL, cached_state, GFP_NOFS, NULL);
 }
 
 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
-	return set_extent_bit(tree, start, end, EXTENT_NEW, 0, NULL, NULL,
+	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, NULL,
 			      GFP_NOFS, NULL);
 }
 
 static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_UPTODATE, 0, NULL,
+	return set_extent_bit(tree, start, end, EXTENT_UPTODATE, NULL,
 			      cached_state, mask, NULL);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8def3a67adb7..538b6a3a88ad 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2815,7 +2815,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, 0, NULL, cached_state,
+				     EXTENT_DELALLOC_NEW, NULL, cached_state,
 				     GFP_NOFS, NULL);
 next:
 		search_start = extent_map_end(em);
@@ -4963,7 +4963,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, 0, NULL, NULL, GFP_NOFS, NULL);
+			       EXTENT_NORESERVE, NULL, NULL, GFP_NOFS, NULL);
 
 out_unlock:
 	if (ret) {
-- 
2.26.3

