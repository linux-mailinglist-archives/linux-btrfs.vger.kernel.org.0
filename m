Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949ED6C549C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 20:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCVTMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCVTMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 15:12:20 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E65FE84
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 12:12:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 577E83200754;
        Wed, 22 Mar 2023 15:12:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Mar 2023 15:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679512322; x=
        1679598722; bh=cfZJuxmsemb10qZPPalT6K2gUME8tNXOwpuTXtNq3dE=; b=Z
        OsMSepke5Qq3NoDtVWddDpuO7fIRCgR2u0T6iOJ+qdMdGBf5W6MvMv0tLTFV+6AS
        lQIT0Zy+Cx/58YIrZPO/kdApTgmQXehXsEMcDEPwy6/Xq65P2ljB6hu/chUoJrKx
        cgtZMM3dD/XRNrtIAqZqTQw/fW3S8IG9E7ekY03AHJ0+GOGQb8WvOQI8D70Gp6t4
        mpT/ln2+e5UPaUnr/06Ik+CkR9Ul/vNgsY2Tj9yCINZLpc5vtoAy2d25/bH3lmmQ
        QHFzb0ruw2f0RL8D5HkiAn7GeP34vtMvV2ge+UnwPgepSXVxt1wSNjvvh1rcCwH8
        LW8OdDsd1YVp9uRtc+NGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679512322; x=1679598722; bh=c
        fZJuxmsemb10qZPPalT6K2gUME8tNXOwpuTXtNq3dE=; b=r2k3B7dX9HBoVzJKR
        6/IfW+2xcdbe6fJ88+YgK7DZC+wOShpjwH0cX5YuXYNLfzi6Wa9Jwe+ZkhDIeMUc
        OKSSI44pZRAhkD5/suuOmI19GzPvTXZNJx9RwQF2qD6rpJxSNVyGFJMEryfuZjAm
        0ohL8EzoZLwoyapR4lRJ1ARJkCDt4QSedX26fKTnxnA4ZmMYddEsjFFfkgE6LpvW
        wrzAz7d/aZGwsQANe9tCwD2N2kNARZPl/MgA6vSlfxApWuMiTC6MBIu9vRx+YWCO
        QhzT9HjMERLjiRXoK+OuJLoYMOjxXY6cCCExnQyZ1zbmxMR3kwK5lBjqlxc/L0yt
        gXWug==
X-ME-Sender: <xms:AlMbZC_XP8WJBpZG-2OTaJMmo__-wGNY9PuJhZt30zDTToCfwKuPPw>
    <xme:AlMbZCv1zMBne_k-z7gptL6OIIa25C8MNEA7sU23pLPRNDo0u4FtlEhLh3SZPxAfN
    qJo8zKRq2zGYOsFZeg>
X-ME-Received: <xmr:AlMbZIBdjYCKyyExBxwmdJ_5n-5QtID-HV2Z87jCq49xgyOnTdAO2x_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:AlMbZKc7FTXJPTLuXMXGcb-OiUqUScje3nSoRlaHG2ZXgh_ejaP0-A>
    <xmx:AlMbZHM02rndyJI5XUnvnZHcmh-z9kuQ_wMjwJFCU8A2UqxYsdwa4A>
    <xmx:AlMbZElD8sHpm1xQcMlXDdp2XlbAP-SCge7ZU2WMuY0JdCoDjtT6AA>
    <xmx:AlMbZJWqGIvLBcYtukcl7FI0qXl50qGNHTwtnwJoEkVZrC6yDgzWbQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 15:12:02 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio extraction
Date:   Wed, 22 Mar 2023 12:11:50 -0700
Message-Id: <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679512207.git.boris@bur.io>
References: <cover.1679512207.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When extracting a bio from its ordered extent for dio partial writes, we
need the "remainder" ordered extent. It would be possible to look it up
in that case, but since we can grab the ordered_extent from the new
allocation function, we might as well wire it up to be returned to the
caller via out parameter and save that lookup.

Refactor the clone ordered extent function to return the new ordered
extent, then refactor the split and extract functions to pass back the
new pre and post split ordered extents via output parameter.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/bio.c          |  2 +-
 fs/btrfs/btrfs_inode.h  |  5 ++++-
 fs/btrfs/inode.c        | 36 +++++++++++++++++++++++++++---------
 fs/btrfs/ordered-data.c | 36 +++++++++++++++++++++++-------------
 fs/btrfs/ordered-data.h |  6 ++++--
 5 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cf09c6271edb..b849ced40d37 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -653,7 +653,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		if (use_append) {
 			bio->bi_opf &= ~REQ_OP_WRITE;
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
-			ret = btrfs_extract_ordered_extent(bbio);
+			ret = btrfs_extract_ordered_extent_bio(bbio, NULL, NULL, NULL);
 			if (ret)
 				goto fail_put_bio;
 		}
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9dc21622806e..e92a09559058 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -407,7 +407,10 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio);
+blk_status_t btrfs_extract_ordered_extent_bio(struct btrfs_bio *bbio,
+					      struct btrfs_ordered_extent *ordered,
+					      struct btrfs_ordered_extent **ret_pre,
+					      struct btrfs_ordered_extent **ret_post);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5ab486f448eb..e30390051f15 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2514,10 +2514,14 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 /*
  * Split an extent_map at [start, start + len]
  *
- * This function is intended to be used only for extract_ordered_extent().
+ * This function is intended to be used only for
+ * btrfs_extract_ordered_extent_bio().
+ *
+ * It makes assumptions about the extent map that are only valid in the narrow
+ * situations in which we are extracting a bio from a containing ordered extent,
+ * that are specific to zoned filesystems or partial dio writes.
  */
-static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
-			  u64 pre, u64 post)
+static int split_em(struct btrfs_inode *inode, u64 start, u64 len, u64 pre, u64 post)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
@@ -2626,22 +2630,36 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	return ret;
 }
 
-blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
+/*
+ * Extract a bio from an ordered extent to enforce an invariant where the bio
+ * fully matches a single ordered extent.
+ *
+ * @bbio: the bio to extract.
+ * @ordered: the ordered extent the bio is in, will be shrunk to fit. If NULL we
+ *	     will look it up.
+ * @ret_pre: out parameter to return the new oe in front of the bio, if needed.
+ * @ret_post: out parameter to return the new oe past the bio, if needed.
+ */
+blk_status_t btrfs_extract_ordered_extent_bio(struct btrfs_bio *bbio,
+					      struct btrfs_ordered_extent *ordered,
+					      struct btrfs_ordered_extent **ret_pre,
+					      struct btrfs_ordered_extent **ret_post)
 {
 	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 len = bbio->bio.bi_iter.bi_size;
 	struct btrfs_inode *inode = bbio->inode;
-	struct btrfs_ordered_extent *ordered;
 	u64 file_len;
 	u64 end = start + len;
 	u64 ordered_end;
 	u64 pre, post;
 	int ret = 0;
 
-	ordered = btrfs_lookup_ordered_extent(inode, bbio->file_offset);
+	if (!ordered)
+		ordered = btrfs_lookup_ordered_extent(inode, bbio->file_offset);
 	if (WARN_ON_ONCE(!ordered))
 		return BLK_STS_IOERR;
 
+	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
 	/* No need to split */
 	if (ordered->disk_num_bytes == len)
 		goto out;
@@ -2658,7 +2676,6 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
 	/* bio must be in one ordered extent */
 	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
 		ret = -EINVAL;
@@ -2675,10 +2692,11 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	pre = start - ordered->disk_bytenr;
 	post = ordered_end - end;
 
-	ret = btrfs_split_ordered_extent(ordered, pre, post);
+	ret = btrfs_split_ordered_extent(ordered, pre, post, ret_pre, ret_post);
 	if (ret)
 		goto out;
-	ret = split_zoned_em(inode, bbio->file_offset, file_len, pre, post);
+	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
+		ret = split_em(inode, bbio->file_offset, file_len, pre, post);
 
 out:
 	btrfs_put_ordered_extent(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1848d0d1a9c4..4bebebb9b434 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1117,8 +1117,8 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 }
 
 
-static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
-				u64 len)
+static struct btrfs_ordered_extent *clone_ordered_extent(struct btrfs_ordered_extent *ordered,
+						  u64 pos, u64 len)
 {
 	struct inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
@@ -1133,18 +1133,22 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
 	percpu_counter_add_batch(&fs_info->ordered_bytes, -len,
 				 fs_info->delalloc_batch);
 	WARN_ON_ONCE(flags & (1 << BTRFS_ORDERED_COMPRESSED));
-	return btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, len, len,
-					disk_bytenr, len, 0, flags,
-					ordered->compress_type);
+	return btrfs_alloc_ordered_extent(BTRFS_I(inode), file_offset, len, len,
+					  disk_bytenr, len, 0, flags,
+					  ordered->compress_type);
 }
 
-int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
-				u64 post)
+int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered,
+			       u64 pre, u64 post,
+			       struct btrfs_ordered_extent **ret_pre,
+			       struct btrfs_ordered_extent **ret_post)
+
 {
 	struct inode *inode = ordered->inode;
 	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_ordered_extent *oe;
 	int ret = 0;
 
 	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
@@ -1172,12 +1176,18 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 
 	spin_unlock_irq(&tree->lock);
 
-	if (pre)
-		ret = clone_ordered_extent(ordered, 0, pre);
-	if (ret == 0 && post)
-		ret = clone_ordered_extent(ordered, pre + ordered->disk_num_bytes,
-					   post);
-
+	if (pre) {
+		oe = clone_ordered_extent(ordered, 0, pre);
+		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
+		if (!ret && ret_pre)
+			*ret_pre = oe;
+	}
+	if (!ret && post) {
+		oe = clone_ordered_extent(ordered, pre + ordered->disk_num_bytes, post);
+		ret = IS_ERR(oe) ? PTR_ERR(oe) : 0;
+		if (!ret && ret_post)
+			*ret_post = oe;
+	}
 	return ret;
 }
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 18007f9c00ad..933f6f0d8c10 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -212,8 +212,10 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					struct extent_state **cached_state);
 bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state);
-int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
-			       u64 post);
+int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered,
+			       u64 pre, u64 post,
+			       struct btrfs_ordered_extent **ret_pre,
+			       struct btrfs_ordered_extent **ret_post);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.38.1

