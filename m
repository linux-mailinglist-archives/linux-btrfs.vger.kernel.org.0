Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3BF79DD10
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjIMANa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMAN3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:29 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32D710F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EABC73200940;
        Tue, 12 Sep 2023 20:13:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Sep 2023 20:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694564004; x=
        1694650404; bh=0wuwNH+gwG/Qf/Im17An/wI+rzir670mY57X20iUBNE=; b=r
        oZNMnVdEv1CDUTPyu6tJdLlGwTUM+2mYZwjDMQFiCsJvGRsylbzF6EiOih8SK7Gp
        r3HwMfrvB+e8dsA2D7fyTtUpxtaX4AVB9mersCgmU095Y1B+IROHHcyQ5yb3U8cB
        5oUh4lplY9bcpQy2Tx6tOI+VZtYmuPegBuJd2dk5UvqCn/smnLSkDliwxZeFTK19
        76h5iR23qMV1VJc5rgG+5+VNQ9hZmg5mz7xn8NYGSyRhTqog2DR7Illvxkrl74xG
        LfR2/OA2STsIIuu/FPgD/aXQgjTq8SiLMSpwn8qCuhJy28yS7xR0xEETZppC+DF+
        tCKWrv/MH9ZlgcAYWJpTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694564004; x=1694650404; bh=0
        wuwNH+gwG/Qf/Im17An/wI+rzir670mY57X20iUBNE=; b=VUpSno0GColyoLkNQ
        AO8mZ1Qdr0J0nA1kCI/w4peBpFyFLntQv4+Ja0UotHJ9fqYJt0266EVHSVDvxm/Y
        6Vw2he72pad8qgca1y79XAt+U6oTSbFk6g/C3Zv8SNMKU/UecFgNqWkfUZbKwWkV
        gCYnO0Vr+XjTT9LvtpAKvWFn3UFRvMx0FTLv07f+M33o+elXOCPtiNLT0C3fVdaq
        KW7tOvasJV0sHaE7210BH69cZJY/KWTRdzFbhJNn2P1sO28CQxuHNFv6WM9US3n3
        /Gui81OXoGlT8rnIDwfPiO1UzFuJLVf4PdGQaMebdQqsBq7ff6woI29lI2f1qe0y
        Ytzlw==
X-ME-Sender: <xms:pP4AZY_sPwxxfVhYY_VoTY6S-QCo9fpLgBVWsJI2lx3HLXwWoCgzLw>
    <xme:pP4AZQtPigOpW2-xAjyRctmIPzfdRaLwMHLRc8XmpKUt3y4q-DN0b5IJoIxHcz9oi
    G_xh6yKhz6bj2FcAcI>
X-ME-Received: <xmr:pP4AZeDhayRcsTL-SMV8hOboK3-WaIhvSywbMaI1yaZIlLqNLHAcqSVt5deu3D1Wkm7BCOQGEILPjuiq-vYrJZnx6uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:pP4AZYfYQS5wOcHnLAkCYitXCw8VjuuTG-8CW9Qfb5mmvb8C9CuXnQ>
    <xmx:pP4AZdM_SsXfVPaf1l2y2tYwV1kAW0T6z_aChTQWO5TAdzDpfKFobQ>
    <xmx:pP4AZSlbXwe1ZNPsO7pCsup03V-4T3EIYWqSG8yovtOSFOUN8nCphQ>
    <xmx:pP4AZfVa36BmL65qXcLml3OamcuYIqnhDVkp7M2iK9HMGrmncZ1vVA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 16/18] btrfs: track metadata relocation cow with simple quota
Date:   Tue, 12 Sep 2023 17:13:27 -0700
Message-ID: <5485556ee458ca5e1bfac429956cb49b4d9e799a.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation cows metadata blocks in two cases for the reloc root:
- copying the subvol root item when creating the reloc root
- copying a btree node when there is a cow during relocation

In both cases, the resulting btree node hits an abnormal code path with
respect to the owner field in its btrfs_header. It first creates the
root item for the new objectid, which populates the reloc root id, and
it at this point that delayed refs are created.

Later, it fully copies the old node into the new node (including the
original owner field) which overwrites it. This results in a simple
quotas mismatch where we run the delayed ref for the reloc root which
has no simple quota effect (reloc root is not an fstree) but when we
ultimately delete the node, the owner is the real original fstree and we
do free the space.

To work around this without tampering with the behavior of relocation,
add a parameter to btrfs_add_tree_block that lets the relocation code
path specify a different owning root than the "operating" root (in this
case, owning root is the real root and the operating root is the reloc
root). These can naturally be plumbed into delayed refs that have the
same concept.

Note that this is a double count in some sense, but a relatively natural
one, as there are really two extents, and the old one will be deleted
soon. This is consistent with how data relocation extents are accounted
by simple quotas.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       | 22 ++++++++++++++--------
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/extent-tree.c |  6 +++++-
 fs/btrfs/extent-tree.h |  1 +
 fs/btrfs/ioctl.c       |  2 +-
 5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c362472a112f..e3818e451778 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -316,6 +316,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int level;
 	struct btrfs_disk_key disk_key;
+	u64 reloc_src_root = 0;
 
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != fs_info->running_transaction->transid);
@@ -328,9 +329,11 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
+	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
+		reloc_src_root = btrfs_header_owner(buf);
 	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
 				     &disk_key, level, buf->start, 0,
-				     BTRFS_NESTING_NEW_ROOT);
+				     reloc_src_root, BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -522,6 +525,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	int last_ref = 0;
 	int unlock_orig = 0;
 	u64 parent_start = 0;
+	u64 reloc_src_root = 0;
 
 	if (*cow_ret == buf)
 		unlock_orig = 1;
@@ -540,12 +544,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	if ((root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) && parent)
-		parent_start = parent->start;
-
+	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
+		if (parent)
+			parent_start = parent->start;
+		reloc_src_root = btrfs_header_owner(buf);
+	}
 	cow = btrfs_alloc_tree_block(trans, root, parent_start,
 				     root->root_key.objectid, &disk_key, level,
-				     search_start, empty_size, nest);
+				     search_start, empty_size, reloc_src_root, nest);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -2955,7 +2961,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
 	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				   &lower_key, level, root->node->start, 0,
-				   BTRFS_NESTING_NEW_ROOT);
+				   0, BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
@@ -3099,7 +3105,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	split = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				       &disk_key, level, c->start, 0,
-				       BTRFS_NESTING_SPLIT);
+				       0, BTRFS_NESTING_SPLIT);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -3850,7 +3856,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	 * use BTRFS_NESTING_NEW_ROOT.
 	 */
 	right = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
-				       &disk_key, 0, l->start, 0,
+				       &disk_key, 0, l->start, 0, 0,
 				       num_doubles ? BTRFS_NESTING_NEW_ROOT :
 				       BTRFS_NESTING_SPLIT);
 	if (IS_ERR(right))
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 43a6ca726879..e9413325c1d1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -859,7 +859,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	root->root_key.offset = 0;
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
-				      BTRFS_NESTING_NORMAL);
+				      0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		leaf = NULL;
@@ -936,7 +936,7 @@ int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 	 */
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
-			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
+			NULL, 0, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf))
 		return PTR_ERR(leaf);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8d16f7b4786d..7b9c58fc9fa8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5070,6 +5070,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     const struct btrfs_disk_key *key,
 					     int level, u64 hint,
 					     u64 empty_size,
+					     u64 reloc_src_root,
 					     enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -5082,6 +5083,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 	u32 blocksize = fs_info->nodesize;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
+	u64 owning_root;
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (btrfs_is_testing(fs_info)) {
@@ -5108,11 +5110,13 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		ret = PTR_ERR(buf);
 		goto out_free_reserved;
 	}
+	owning_root = btrfs_header_owner(buf);
 
 	if (root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
 		if (parent == 0)
 			parent = ins.objectid;
 		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
+		owning_root = reloc_src_root;
 	} else
 		BUG_ON(parent > 0);
 
@@ -5132,7 +5136,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->level = level;
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-				       ins.objectid, ins.offset, parent, btrfs_header_owner(buf));
+				       ins.objectid, ins.offset, parent, owning_root);
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 5a02faa05464..9038d797aab2 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -114,6 +114,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     const struct btrfs_disk_key *key,
 					     int level, u64 hint,
 					     u64 empty_size,
+					     u64 reloc_src_root,
 					     enum btrfs_lock_nesting nest);
 void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			   u64 root_id,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 59fcb7424d93..663709fd6dab 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -657,7 +657,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		goto out;
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
-				      BTRFS_NESTING_NORMAL);
+				      0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		goto out;
-- 
2.41.0

