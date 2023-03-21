Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94F6C3750
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCUQqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCUQqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:46:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54542799B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:45:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BB745C0160;
        Tue, 21 Mar 2023 12:45:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 Mar 2023 12:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679417140; x=
        1679503540; bh=rXsjMfASmVp3FdC7wSRSkWbq55i+g8Uq0zzQq3PALfE=; b=L
        RdK+zphv3jGooxLp8xRg+KSQl8xA1G/mWJbWNCO/Wa/4VjqJ1RU+HUm9vG9HYak1
        O++aqaNUG+vdedUKPanz6n0SzGFSOukHSIQVGOP4AUiBd+V/d5e62TCUeN/GUXaO
        kNbqgPZ37z8oHa12KhWXuQQXtQ4CfBHxlSS8V8Il59dNdnUS5Dy/M+iwRpQzHBdE
        sHU9EzDjUvxmb5lqDQbeLTYnas9IqXy4s//81NBUcidejZ4u0RV57x0caXTuir6v
        f1ERhj17GYkhWB5o0BbXQPR0iEjpSWAC8HdcQTn5FC2vprXxRdRWTHRcLipjo3AE
        Te0X54p/5vzHqetGw3mwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679417140; x=1679503540; bh=r
        XsjMfASmVp3FdC7wSRSkWbq55i+g8Uq0zzQq3PALfE=; b=PGOXpXsbFgbhmzLrD
        1EKR703c5BtMtiFlgNJk3OrmGZAW6wAEfWYGrThNPLo1x7BrjyufGWBCtdWWOmu+
        Ag2MrSDL7iofJmt8T481n9gXBYVHtJFAGAjBY5dIOXx3m/ByQqUKdcBf50I4C7IV
        Cb+qvoBnAceaYmz8173alroYoLgx74iieXQn4vYE45BAQ3QkqrCw/+JLPAzKN1cG
        oKJCxnV3cCJCIBmx0Ro2crs40BoO3oxCU6qhQlaF9z92i8bOjG+WUqvsogVw9+3t
        Jf06p/4U/oVhLWgZsdM7UHx66BCj2EF3r9Lenzsnb5rxcL2jZMos0UX7dOTf9qwx
        cnNwQ==
X-ME-Sender: <xms:NN8ZZLIEP_BcxLrgMZA1UnVKaZFYut38Vzk2Dr1kz9UjcDO2DaGJKw>
    <xme:NN8ZZPIHG-Gti0995PPd0RnT6jwsEv4xzOicVjEw4PH33jadY5Wn0UQgmadVtRg0k
    A89bG46dv6cUrB8gzs>
X-ME-Received: <xmr:NN8ZZDsmHkhDVTwOAPtQO-JQ6vfdVHw8xjCDw5Catey42ZpojLKDAf1R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:NN8ZZEa1dngSlSt-QwIdKegBdvexCPn9Zf-o0rRiNFuO3TsMkS3TAQ>
    <xmx:NN8ZZCbXM_43s6-55RAeh1CTmUkNWkgg5SihenIuqm_EBcJWh6rR8Q>
    <xmx:NN8ZZIBbTZtiYZzcC6LBxJ-B_6QaRjlI-5iAOXOn6FIhoMLk8x4wLg>
    <xmx:NN8ZZLCvdVmnWOncLZLl_7U7war8UD-n9EE0KJtd2QnSTFZ-lXMvkQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 12:45:40 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 3/6] btrfs: repurpose split_zoned_em for partial dio splitting
Date:   Tue, 21 Mar 2023 09:45:30 -0700
Message-Id: <5faf0148f526b4e9eb373c177de3c70284999ce7.1679416511.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679416511.git.boris@bur.io>
References: <cover.1679416511.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a subsequent patch I will be "extracting" a partial dio write bio
from its ordered extent, creating a 1:1 bio<->ordered_extent relation.
This is necessary to avoid triggering an assertion in unpin_extent_cache
called from btrfs_finish_ordered_io that checks that the em matches the
finished ordered extent.

Since there is already a function which splits an uncompressed
extent_map for a zoned bio use case, adapt it to this new, similar
use case. Mostly, modify it to handle the case where the extent_map is
bigger than the ordered_extent, and we cannot assume the em "post" split
can be computed from the ordered_extent and bio. This comes up in
btrfs/250, for example.

I felt that these relaxations where not so damaging to the legibility of
the zoned case as to merit a fully separate codepath, but I admit that is
not my area of expertise.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 104 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5ab486f448eb..2f8baf4797ea 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2512,37 +2512,59 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 }
 
 /*
- * Split an extent_map at [start, start + len]
+ * Split out a middle extent_map [start, start+len] from within an extent_map.
  *
- * This function is intended to be used only for extract_ordered_extent().
+ * @inode: the inode to which the extent map belongs.
+ * @start: the start index of the middle split
+ * @len: the length of the middle split
+ *
+ * The result is two or three extent_maps inserted in the tree, depending on
+ * whether start and len imply an uncovered area at the beginning or end of the
+ * extent map. If the implied split lines up with the end or beginning, there
+ * will only be two extent maps in the resulting split, otherwise there will be
+ * three. (If they both match, the split operation is a no-op)
+ *
+ * extent map splitting assumptions:
+ * end = start + len
+ * em-end = em-start + em-len
+ * start >= em-start
+ * len < em-len
+ * end <= em-end
+ *
+ * Diagrams explaining the splitting cases:
+ * original em:
+ *   [em-start---start---end---em-end)
+ * resulting ems:
+ * start != em-start && end != em-end (full tri split):
+ *   [em-start---start) [start---end) [end---em-end)
+ * start == em-start (no pre split):
+ *   [em-start---end) [end---em-end)
+ * end == em-end (no post split):
+ *   [em-start---start) [start--em-end)
+ *
+ * Returns: 0 on success, -errno on failure.
  */
-static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
-			  u64 pre, u64 post)
+static int split_em(struct btrfs_inode *inode, u64 start, u64 len)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
+	u64 pre_start, pre_len, pre_end;
+	u64 mid_start, mid_len, mid_end;
+	u64 post_start, post_len, post_end;
 	struct extent_map *split_pre = NULL;
 	struct extent_map *split_mid = NULL;
 	struct extent_map *split_post = NULL;
 	int ret = 0;
 	unsigned long flags;
 
-	/* Sanity check */
-	if (pre == 0 && post == 0)
-		return 0;
-
 	split_pre = alloc_extent_map();
-	if (pre)
-		split_mid = alloc_extent_map();
-	if (post)
-		split_post = alloc_extent_map();
-	if (!split_pre || (pre && !split_mid) || (post && !split_post)) {
+	split_mid = alloc_extent_map();
+	split_post = alloc_extent_map();
+	if (!split_pre || !split_mid || !split_post) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ASSERT(pre + post < len);
-
 	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	write_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
@@ -2551,19 +2573,38 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 		goto out_unlock;
 	}
 
-	ASSERT(em->len == len);
+	pre_start = em->start;
+	pre_end = start;
+	pre_len = pre_end - pre_start;
+	mid_start = start;
+	mid_end = start + len;
+	mid_len = len;
+	post_start = mid_end;
+	post_end = em->start + em->len;
+	post_len = post_end - post_start;
+	ASSERT(pre_start == em->start);
+	ASSERT(pre_start + pre_len == mid_start);
+	ASSERT(mid_start + mid_len == post_start);
+	ASSERT(post_start + post_len == em->start + em->len);
+
+	/* Sanity check */
+	if (pre_len == 0 && post_len == 0) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
 	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
-	ASSERT(test_bit(EXTENT_FLAG_PINNED, &em->flags));
 	ASSERT(!test_bit(EXTENT_FLAG_LOGGING, &em->flags));
 	ASSERT(!list_empty(&em->list));
 
 	flags = em->flags;
-	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
+	if (test_bit(EXTENT_FLAG_PINNED, &em->flags))
+		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 
 	/* First, replace the em with a new extent_map starting from * em->start */
 	split_pre->start = em->start;
-	split_pre->len = (pre ? pre : em->len - post);
+	split_pre->len = (pre_len ? pre_len : mid_len);
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = em->block_start;
 	split_pre->block_len = split_pre->len;
@@ -2577,16 +2618,15 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 
 	/*
 	 * Now we only have an extent_map at:
-	 *     [em->start, em->start + pre] if pre != 0
-	 *     [em->start, em->start + em->len - post] if pre == 0
+	 *     [em->start, em->start + pre_len] if pre_len != 0
+	 *     [em->start, em->start + mid_len] if pre == 0
 	 */
-
-	if (pre) {
+	if (pre_len) {
 		/* Insert the middle extent_map */
-		split_mid->start = em->start + pre;
-		split_mid->len = em->len - pre - post;
+		split_mid->start = mid_start;
+		split_mid->len = mid_len;
 		split_mid->orig_start = split_mid->start;
-		split_mid->block_start = em->block_start + pre;
+		split_mid->block_start = em->block_start + pre_len;
 		split_mid->block_len = split_mid->len;
 		split_mid->orig_block_len = split_mid->block_len;
 		split_mid->ram_bytes = split_mid->len;
@@ -2596,11 +2636,11 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 		add_extent_mapping(em_tree, split_mid, 1);
 	}
 
-	if (post) {
-		split_post->start = em->start + em->len - post;
-		split_post->len = post;
+	if (post_len) {
+		split_post->start = post_start;
+		split_post->len = post_len;
 		split_post->orig_start = split_post->start;
-		split_post->block_start = em->block_start + em->len - post;
+		split_post->block_start = em->block_start + pre_len + mid_len;
 		split_post->block_len = split_post->len;
 		split_post->orig_block_len = split_post->block_len;
 		split_post->ram_bytes = split_post->len;
@@ -2632,7 +2672,6 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	u64 len = bbio->bio.bi_iter.bi_size;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_ordered_extent *ordered;
-	u64 file_len;
 	u64 end = start + len;
 	u64 ordered_end;
 	u64 pre, post;
@@ -2671,14 +2710,13 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	file_len = ordered->num_bytes;
 	pre = start - ordered->disk_bytenr;
 	post = ordered_end - end;
 
 	ret = btrfs_split_ordered_extent(ordered, pre, post);
 	if (ret)
 		goto out;
-	ret = split_zoned_em(inode, bbio->file_offset, file_len, pre, post);
+	ret = split_em(inode, bbio->file_offset, len);
 
 out:
 	btrfs_put_ordered_extent(ordered);
-- 
2.38.1

