Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541A26C374F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCUQqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCUQqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:46:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C092F51CA6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:45:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5065D5C014B;
        Tue, 21 Mar 2023 12:45:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 21 Mar 2023 12:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679417142; x=
        1679503542; bh=I2FWZRYa52HN0xI8V64bxq5aHVpHC8EPYigxrPJS41k=; b=D
        kYV0j3kU893lr1irGoxGCv0UJtzfIkKadvTBSmmQ1ucrIK1upTN5MExOkp5kLdmz
        hOLn+IZw6++ykIL7efJSp78YqMlHUWlOzagy63VUigDqtL7c6Q52jHGSgduiKsTX
        7LwF/lRG8hRyokFsOc+2Z4RQT5blaGSN1vkGAgPZ2ETNv8hcNeXaLyx4e6F3Azrd
        5iYmmcwxeI2A/UENCZiydJ02p2rT/qhsNmkzbgdSO/wpItKZz7L3agAShqbKGe8r
        kz6iJplXNjHXBMRSpyV0OG3EZpNLyT+9qDrMZglfgjoq1oaJA6Eo0qPm3SMU+L+G
        coVyqBEKY8tFQYHiWebIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679417142; x=1679503542; bh=I
        2FWZRYa52HN0xI8V64bxq5aHVpHC8EPYigxrPJS41k=; b=O5+KBSmKHgAxE7P1Q
        xCGVWAvNGu9uJyWvuMch7j4XU/AE8NRGhnL2DTXJXh4v1YebHXAPESc4mB3iznfi
        FAFkQv2ESmBdpNHhacm+ALSPJezj7pdkyX9XHt/fSl+hTqReoc6CtA08Mwu4qMp0
        YwOc8AOFrnCRmQoLFDQfMEzV2wa9jASRod5xyeTjcVjTwOUojHDAEoPEk2QrQfCp
        CWDUgxASqd5n50XQVJvBSYFUayU1tLdJy5vIOPIVtomXJ1Ji567UtvTQp0XQEmKv
        4627TZt8KpvsgBYf+W0JxlzMn7gUeIaZXTUbHOP1xuOoiSmeDv9fGjvz0gxhHH1n
        Wr83g==
X-ME-Sender: <xms:Nt8ZZDQMzFB2-Hr_3TKcHPsUBlFil4A5OF9Trbw4QFzHJEITupifcQ>
    <xme:Nt8ZZEwGvll6EC7mD5C5BsoF2JpNeWfVTv-F8c_T1eLOYLsd0rLcIJcb0Rs066YSj
    t82LoUxWddN6EThwis>
X-ME-Received: <xmr:Nt8ZZI1OAZ20zE7DKNHU8UfFmDqfcJZZmFrBC3EVC5H1feBLpn4-iZt_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Nt8ZZDCMAPsO7sZdmkL4EeZ5m3trJxJ-rtZAJIWYvXK9uMTvwj6CRw>
    <xmx:Nt8ZZMiUsnWyONVDaH59OKT8uPrlMFioKPKRhsSaMZQFkcqneeNZmA>
    <xmx:Nt8ZZHql-6dpWNug5SHMv9OATtZ3YOm9f9inqH6_yKAlFvfp8HCGpQ>
    <xmx:Nt8ZZELQoiJ75hyt_AQzslrGOxVCW9UnShxmxItHVtJaerCmksEuMA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 12:45:41 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 4/6] btrfs: return ordered_extent splits from bio extraction
Date:   Tue, 21 Mar 2023 09:45:31 -0700
Message-Id: <f39c1456efa7bc4e961ccbcf1ab88ecc46156af8.1679416511.git.boris@bur.io>
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
 fs/btrfs/inode.c        | 23 ++++++++++++++++++-----
 fs/btrfs/ordered-data.c | 36 +++++++++++++++++++++++-------------
 fs/btrfs/ordered-data.h |  6 ++++--
 5 files changed, 50 insertions(+), 22 deletions(-)

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
index 2f8baf4797ea..dbea124c9fa3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2666,21 +2666,35 @@ static int split_em(struct btrfs_inode *inode, u64 start, u64 len)
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
@@ -2697,7 +2711,6 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
 	/* bio must be in one ordered extent */
 	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
 		ret = -EINVAL;
@@ -2713,7 +2726,7 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	pre = start - ordered->disk_bytenr;
 	post = ordered_end - end;
 
-	ret = btrfs_split_ordered_extent(ordered, pre, post);
+	ret = btrfs_split_ordered_extent(ordered, pre, post, ret_pre, ret_post);
 	if (ret)
 		goto out;
 	ret = split_em(inode, bbio->file_offset, len);
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

