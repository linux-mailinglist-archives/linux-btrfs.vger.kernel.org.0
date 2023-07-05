Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDFE7491D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjGEXX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjGEXXe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:34 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D8E57
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 761AB5C0293;
        Wed,  5 Jul 2023 19:23:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599412; x=
        1688685812; bh=mIWHowgCkeL8+II9h8XH1QEsr3JJexoJBAWBlbzwGco=; b=l
        sCkYKYl7SrW/K+hqbyRL8cuiohL2HYNNP8DY90RKoaS5pprBSVN+3JY8Mmns4J3L
        ITtv/iKKw7pJ8a32PnhTMR14kptKAiLalVOuolDZaqVgn14891k1lkHIYxV80SrO
        p0zyCee9IynLhpewF7ufyAXRBdjIRF5mn1T1NAS5SvIqUUmg9aOLw3VP3e+YOq40
        YtDYGbhuz/pT2J0USDfIZ+2hKyuquwv+D+vRhR5I40XMM15c++/twEO8JtWRj/FJ
        15J6JZaEuJOcSSMaGa1t+rPIvQE5SYWqrMmLavbU5rXwgcen6kcQ6PWYLyafd2cI
        gokYCNThsfv4b6b0qwQQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599412; x=1688685812; bh=m
        IWHowgCkeL8+II9h8XH1QEsr3JJexoJBAWBlbzwGco=; b=ZM3kXVGu3iEnVt3E/
        BOXesV9jmhruG8VjjHrsxvnI8tH7i1pC7KudMqDE6E8vI8ue2pnQRQIFyX+5iJCb
        6A/3FAEWcttmG6O3RkAk16h2Q0IKWvCBKboo3Qs5LveUTQdqNJ3Es7Bbm0mVwq77
        TDcOelm5D/YErAElD5PrZWXV+5JDK7qW1kPnjDml/hdUvM7hQfw0qe+VdgA5Oe4I
        aA931daJeA3xdGvPPfwVbzMa30cB4nBeCGIW+DoRnzCnPIHqjEg+hmAlqgi1jhLr
        kKTnXWQezSzcliUPljPYz4LkR3NsERdHWOgWcZ26stm2yaHN07GDpzKn1QLP8zDK
        Qusvw==
X-ME-Sender: <xms:dPulZBhM3nkphqqzfwFNgTABtzVacCajcMPrUbgVFEHfabNZni8wKQ>
    <xme:dPulZGASGtqnZAGRTuFej2bosi3CadfTdsIp_gvUEaeda0UwygaR5LgHfd-QrsLMC
    axUpbmTjAp-4lHeg6U>
X-ME-Received: <xmr:dPulZBFrfHFgrZMfjwqOluGz1N7o2hj1iYXc6vwQAcDWCeA-bFnOKxqyoRd0kmB2gJcymhlYwVca4FGDhP2uBqlEW3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:dPulZGRIutCrqKoClOe4a-m6OtRJCnAndivQWe3B5ASMLokaeTFCMQ>
    <xmx:dPulZOxuzuw9WLmoooRNBC19mS0SctcnRSw5ugQ3L-MiIHn-qBIKNw>
    <xmx:dPulZM7eA7ZIiuNfhWnB_t6vguoM2UXAKQjMttEiaNSj531VNediXA>
    <xmx:dPulZEZ5SxicWyU8sGakvYF-GhSGKPhUlcMGLZeUx2-AUrfNolP9gg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:31 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/18] btrfs: track metadata relocation cow with simple quota
Date:   Wed,  5 Jul 2023 16:20:54 -0700
Message-ID: <100b6185fc66f98c72cb8ad93092aba193b681e6.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
 fs/btrfs/ctree.c       | 22 ++++++++++++++--------
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/extent-tree.c |  8 ++++++--
 fs/btrfs/extent-tree.h |  3 ++-
 fs/btrfs/ioctl.c       |  2 +-
 5 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a4cb4b642987..cb0d4535de37 100644
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
+				     BTRFS_NESTING_NEW_ROOT, reloc_src_root);
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
+				     search_start, empty_size, nest, reloc_src_root);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -2956,7 +2962,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
 	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				   &lower_key, level, root->node->start, 0,
-				   BTRFS_NESTING_NEW_ROOT);
+				   BTRFS_NESTING_NEW_ROOT, 0);
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
@@ -3100,7 +3106,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	split = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				       &disk_key, level, c->start, 0,
-				       BTRFS_NESTING_SPLIT);
+				       BTRFS_NESTING_SPLIT, 0);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -3853,7 +3859,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	right = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
 				       &disk_key, 0, l->start, 0,
 				       num_doubles ? BTRFS_NESTING_NEW_ROOT :
-				       BTRFS_NESTING_SPLIT);
+				       BTRFS_NESTING_SPLIT, 0);
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7513388b0567..29f11d91bfb6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -862,7 +862,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	root->root_key.offset = 0;
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
-				      BTRFS_NESTING_NORMAL);
+				      BTRFS_NESTING_NORMAL, 0);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		leaf = NULL;
@@ -939,7 +939,7 @@ int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 	 */
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
-			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
+			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL, 0);
 	if (IS_ERR(leaf))
 		return PTR_ERR(leaf);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3cd1d24f1146..99845a54e168 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5005,7 +5005,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     const struct btrfs_disk_key *key,
 					     int level, u64 hint,
 					     u64 empty_size,
-					     enum btrfs_lock_nesting nest)
+					     enum btrfs_lock_nesting nest,
+					     u64 reloc_src_root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key ins;
@@ -5017,6 +5018,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 	u32 blocksize = fs_info->nodesize;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
+	u64 owning_root;
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (btrfs_is_testing(fs_info)) {
@@ -5043,11 +5045,13 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
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
 
@@ -5067,7 +5071,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->level = level;
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-				       ins.objectid, ins.offset, parent, btrfs_header_owner(buf));
+				       ins.objectid, ins.offset, parent, owning_root);
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 9c8fd96cbee7..8c6beb524d26 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -121,7 +121,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     const struct btrfs_disk_key *key,
 					     int level, u64 hint,
 					     u64 empty_size,
-					     enum btrfs_lock_nesting nest);
+					     enum btrfs_lock_nesting nest,
+					     u64 reloc_src_root);
 void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			   u64 root_id,
 			   struct extent_buffer *buf,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 23f5142ef18b..c8caab65a46b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -657,7 +657,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		goto out;
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
-				      BTRFS_NESTING_NORMAL);
+				      BTRFS_NESTING_NORMAL, 0);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		goto out;
-- 
2.41.0

