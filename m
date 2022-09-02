Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00215AB940
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiIBURY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIBURR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E24D344C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:16 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h21so2366049qta.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=nUH29Kuj+9Kj13POOq6b6+j8Fm5sPuZ/f0gXK+WTPBU=;
        b=QcJu4mPzW6Fflk0r1x9OgB9XWVigzXxsazfBLU/q1Bmqtig7plyInAgd37BWC/Mu/c
         9eGv133VrhoD1RUFkjjz+UWBA7WnzGhXSsnOtbKSlsiulCd4ApCx/o8AM6SzRo+9EIvn
         cm7NoNBHfG0Irjby+zMdgP0YZ95Gskmd/9GVzXJKTNiGf/T7bpu98tma8cSMBT4qHnYX
         M5/brBrrRL6Gb9gV3eSfl+AclH2p/lVX7k4dZI+1FwOb8qwX4NDjOejAedxHu2oylTyz
         iWmd+xBgvy8q3Vo5EWjiIMw9bV/ZHBzugW4JREEUDc4Nu3xzB9LZV9SKAYHTIJwEum0x
         5Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nUH29Kuj+9Kj13POOq6b6+j8Fm5sPuZ/f0gXK+WTPBU=;
        b=z5LFtsDACOIwDTluH6sf7FhYb5dlBXo/5JXgfIQdWY6JD4VQFEQGIzPw3dpoO220QW
         HVaPbrgl/0jr1eJ+jqltHcO+8K7GAS8Q+JrEexdU4/T9uMKxw9lxdCQ4C/I4OuMgronZ
         Q5dHHc4rSC36ZxqNDikdD4ZieAtz3bVuK2A/kCs3pS9cWFl7F6bmotteUiqjuyQdQdIk
         8C3H8HXgBLIahx5AsZshvGAnA05bFmFSyv68WqR1u95314RwUExPS4SdUg0Z8SzVLlvT
         aABkxG/aXE6uWL9li4qWrnQBa/EfUuPfk/ZqqJYePPMINDInNV8t+m1pRhSb+2C5aqLW
         CeAA==
X-Gm-Message-State: ACgBeo0ewymVyNf8LhgMQ5U7fAycEqmXT4v2oVElL+PmbkSo5m3Ct9hw
        tF8JN0n4wcoxejMB6Vgrbr6TN6EmzNHC5g==
X-Google-Smtp-Source: AA6agR6O9tVHZpPU+Q7K76DhZmq93ISeAu9ssLdoXY2vv4WYNuBfZTreqQr3IUagT29zxR8wfPETrg==
X-Received: by 2002:ac8:7f47:0:b0:344:8d2b:14a9 with SMTP id g7-20020ac87f47000000b003448d2b14a9mr29570359qtk.442.1662149835200;
        Fri, 02 Sep 2022 13:17:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d16-20020ac86150000000b0033a5048464fsm1709768qtm.11.2022.09.02.13.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/31] btrfs: drop exclusive_bits from set_extent_bit
Date:   Fri,  2 Sep 2022 16:16:26 -0400
Message-Id: <753911ae28fb8e99d593867fd0874793abbb729b.1662149276.git.josef@toxicpanda.com>
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

This is only ever set if we have EXTENT_LOCKED set, so simply push this
into the function itself and remove the function argument.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 16 ++++++++--------
 fs/btrfs/extent-io-tree.h | 20 ++++++++++----------
 fs/btrfs/inode.c          |  4 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 5f0a00c6aa96..97df40edf199 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -199,7 +199,7 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
+	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS,
 			      changeset);
 }
 
@@ -221,8 +221,8 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	int err;
 	u64 failed_start;
 
-	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
-			     &failed_start, NULL, GFP_NOFS, NULL);
+	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+			     NULL, GFP_NOFS, NULL);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
@@ -839,9 +839,8 @@ static void cache_state(struct extent_state *state,
  * [start, end] is inclusive This takes the tree lock.
  */
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		   u32 exclusive_bits, u64 *failed_start,
-		   struct extent_state **cached_state, gfp_t mask,
-		   struct extent_changeset *changeset)
+		   u64 *failed_start, struct extent_state **cached_state,
+		   gfp_t mask, struct extent_changeset *changeset)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
@@ -850,6 +849,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 	int err = 0;
 	u64 last_start;
 	u64 last_end;
+	u32 exclusive_bits = bits & EXTENT_LOCKED;
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
@@ -1278,8 +1278,8 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 
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
index 7bdf89756be4..85f7407e7975 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2816,7 +2816,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, 0, NULL, cached_state,
+				     EXTENT_DELALLOC_NEW, NULL, cached_state,
 				     GFP_NOFS, NULL);
 next:
 		search_start = extent_map_end(em);
@@ -4964,7 +4964,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, 0, NULL, NULL, GFP_NOFS, NULL);
+			       EXTENT_NORESERVE, NULL, NULL, GFP_NOFS, NULL);
 
 out_unlock:
 	if (ret) {
-- 
2.26.3

