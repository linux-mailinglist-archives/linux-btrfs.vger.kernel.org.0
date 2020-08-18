Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFA248D9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRSAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 14:00:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39863 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgHRSAT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 14:00:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1074E5C0049;
        Tue, 18 Aug 2020 14:00:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 18 Aug 2020 14:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=RCNp4UROlQkyEREtGIMSoiPPyq
        3iyW0QjnVnkkXSMN4=; b=rdaPHQ4//tVT03rr7EePbifIrSUQ3bM0GqX5SXRqnY
        nzPbGnm0jAJSv7nBFCCQjRCaa7fXlKR1yqVjZUwtUq5cptIBF+B3+wylf+JNLAe0
        +VeGq9G9B4QBaIFjd4nHWxd5HmjSUgA7MowZ1c+MwaQ4/j43ktPJ0h639Gy/S1Sk
        IlmPtVzOSmKM01APOPdSy99FSQtptQnad4+1Ef+5Nm6Ek0tU+IrxfMAEg3dZFzs1
        4YSG73fha06S9Rq46Sngw0icfaJ6pRl/u4iRJ7vtJzWF0Rk2po8kO9iqNgwe/wmw
        UWODeCzEVruEL45IOsbjYBuJruYpr178hY//CiTbyJ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RCNp4UROlQkyEREtG
        IMSoiPPyq3iyW0QjnVnkkXSMN4=; b=BjMN2Cwx04j3Jy/2ITGMNCDp8AaO0mDUy
        vGdgYPby5rQGi95pbhkkBdxg0kmIpYbovnmeaEsa23qwWuBoRWn6vvQp7pp0PGZ0
        i436jcQfiLd/D9bdy+2loSNriixOtTxGR+gc08LkRb1w2DQyKEbYyBRvp8B2UPea
        QqtZ3w8vo9Sas5f47Ie7xiYd6pt6G2c6OeotQ+/OXK/5R+YCGSqNkWptFm4K5kUK
        zjE75gB1cCC2IdiKo4aXcYw2Ylbnzo+cxV41EtN76J3D8nNfPk4vhs61QH/TjEZw
        PNIQazk6OEUbYy8ZZVTgUZDlTlyaefa1sI8PPuh13tSCYoUk/hj6A==
X-ME-Sender: <xms:LBc8X4YytZrUIywP0i8eyuebZfoNTDr7H_n0oD2Tad3oMX6z1IJ_7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtiedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitd
    elueeijeefleffveelieefgfejjeeigeekudduteefkefffeethfdvjeevnecukfhppedu
    ieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LRc8XzYDCboe7g0ivsmcAKJxt14_QK1ovVT_SGCZO0DyVrqaY0d1sg>
    <xmx:LRc8Xy864Q_zJJxO3MxNtGZd1ErJxcgYvTSpsWfvq84ijwRijrYx6A>
    <xmx:LRc8XypsY8c69tMJD2tsBSKs9pEHEb_KL8i0n-xEWold8qwOp27ACw>
    <xmx:Lhc8XyUJimh8BZX-TWI8aws3N0TfBRG3B-8FAE5h78YEodgVgzrD-w>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6726A3060067;
        Tue, 18 Aug 2020 14:00:12 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs: detect nocow for swap after snapshot delete
Date:   Tue, 18 Aug 2020 11:00:05 -0700
Message-Id: <20200818180005.933061-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

can_nocow_extent and btrfs_cross_ref_exist both rely on a heuristic for
detecting a must cow condition which is not exactly accurate, but saves
unnecessary tree traversal. The incorrect assumption is that if the
extent was created in a generation smaller than the last snapshot
generation, it must be referenced by that snapshot. That is true, except
the snapshot could have since been deleted, without affecting the last
snapshot generation.

The original patch claimed a performance win from this check, but it
also leads to a bug where you are unable to use a swapfile if you ever
snapshotted the subvolume it's in. Make the check slower and more strict
for the swapon case, without modifying the general cow checks as a
compromise. Turning swap on does not seem to be a particularly
performance sensitive operation, so incurring a possibly unnecessary
btrfs_search_slot seems worthwhile for the added usability.

Note: Until the snapshot delete transaction is committed,
check_committed_refs will still cause the logic to think that cow is
necessary, so the user must sync before swapon.

Signed-off-by: Boris Burkov <boris@bur.io>
Suggested-by: Omar Sandoval <osandov@osandov.com>
---
 fs/btrfs/ctree.h       |  4 ++--
 fs/btrfs/extent-tree.c | 17 +++++++++++------
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 18 +++++++++++-------
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c7e466f27a9..1d3162cc8fc9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2518,7 +2518,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    u64 bytenr, u64 num_bytes);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
 int btrfs_cross_ref_exist(struct btrfs_root *root,
-			  u64 objectid, u64 offset, u64 bytenr);
+			  u64 objectid, u64 offset, u64 bytenr, bool strict);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     u64 parent, u64 root_objectid,
@@ -2934,7 +2934,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes);
+			      u64 *ram_bytes, bool strict);
 
 void __btrfs_del_delalloc_inode(struct btrfs_root *root,
 				struct btrfs_inode *inode);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 597505df90b4..096d20fab32f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2306,7 +2306,8 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 
 static noinline int check_committed_ref(struct btrfs_root *root,
 					struct btrfs_path *path,
-					u64 objectid, u64 offset, u64 bytenr)
+					u64 objectid, u64 offset, u64 bytenr,
+					bool strict)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *extent_root = fs_info->extent_root;
@@ -2348,9 +2349,13 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	    btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
 		goto out;
 
-	/* If extent created before last snapshot => it's definitely shared */
-	if (btrfs_extent_generation(leaf, ei) <=
-	    btrfs_root_last_snapshot(&root->root_item))
+	/*
+	 * If extent created before last snapshot => it's shared unless the
+	 * snapshot has been deleted. Use the heuristic if strict is false.
+	 */
+	if (!strict &&
+	    (btrfs_extent_generation(leaf, ei) <=
+	     btrfs_root_last_snapshot(&root->root_item)))
 		goto out;
 
 	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
@@ -2375,7 +2380,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 }
 
 int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
-			  u64 bytenr)
+			  u64 bytenr, bool strict)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -2386,7 +2391,7 @@ int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
 
 	do {
 		ret = check_committed_ref(root, path, objectid,
-					  offset, bytenr);
+					  offset, bytenr, strict);
 		if (ret && ret != -ENOENT)
 			goto out;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bb824c7cb7c7..4507c3d09399 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1571,7 +1571,7 @@ static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	}
 
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			NULL, NULL, NULL);
+			NULL, NULL, NULL, false);
 	if (ret <= 0) {
 		ret = 0;
 		if (!nowait)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8c49168a1b48..df08ace5d914 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1610,7 +1610,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				goto out_check;
 			ret = btrfs_cross_ref_exist(root, ino,
 						    found_key.offset -
-						    extent_offset, disk_bytenr);
+						    extent_offset, disk_bytenr, false);
 			if (ret) {
 				/*
 				 * ret could be -EIO if the above fails to read
@@ -6949,6 +6949,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
  * @orig_start:	(optional) Return the original file offset of the file extent
  * @orig_len:	(optional) Return the original on-disk length of the file extent
  * @ram_bytes:	(optional) Return the ram_bytes of the file extent
+ * @strict:	if true, omit optimizations that might force us into unnecessary
+ *		cow. e.g., don't trust generation number.
  *
  * This function will flush ordered extents in the range to ensure proper
  * nocow checks for (nowait == false) case.
@@ -6963,7 +6965,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes)
+			      u64 *ram_bytes, bool strict)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_path *path;
@@ -7041,8 +7043,9 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	 * Do the same check as in btrfs_cross_ref_exist but without the
 	 * unnecessary search.
 	 */
-	if (btrfs_file_extent_generation(leaf, fi) <=
-	    btrfs_root_last_snapshot(&root->root_item))
+	if (!strict &&
+	    (btrfs_file_extent_generation(leaf, fi) <=
+	     btrfs_root_last_snapshot(&root->root_item)))
 		goto out;
 
 	backref_offset = btrfs_file_extent_offset(leaf, fi);
@@ -7078,7 +7081,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	 */
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(BTRFS_I(inode)),
-				    key.offset - backref_offset, disk_bytenr);
+				    key.offset - backref_offset, disk_bytenr,
+				    strict);
 	if (ret) {
 		ret = 0;
 		goto out;
@@ -7299,7 +7303,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes) == 1 &&
+				     &orig_block_len, &ram_bytes, false) == 1 &&
 		    btrfs_inc_nocow_writers(fs_info, block_start)) {
 			struct extent_map *em2;
 
@@ -10130,7 +10134,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
-- 
2.24.1

