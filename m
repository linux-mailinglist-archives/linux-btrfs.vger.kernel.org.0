Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5764479DD11
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjIMANd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMANc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:32 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA7C10F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9397B3200940;
        Tue, 12 Sep 2023 20:13:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 12 Sep 2023 20:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694564007; x=
        1694650407; bh=uNLa0yJI7FL8SDPOk2qnY3XMMXGy5QsZPprxRdWfo0s=; b=r
        W0ghKFUsm5g6dzryQ+DlGLUp25sRZPLNqIWgIRDHqUpKdxTKFlvErDNcysyMLOQv
        92b+IqTcdnDYqXNrkMoGkgvhxj2ZettY82XSdYE0JhJBHBbaSRwRzI43CzhrDl/W
        0A88PIaKOeeIyGzJod87+Y3ID3AH2TgRKd6YdtDVP6iaFRrJD9xWiQYS8VMew4q6
        G+gPtWtDRetehzUImM8lE2aln1yw6I8JoeKWNFUGHtpw4LiOrzxpfTqT0wr3iZpN
        eeEQ0W922Ex+pdwstSq1/jRAsnwpkS4ImH1746n1sdnOVX4Q2O097dWeTWYI0Lye
        OWHw3eJkXCWV6pYqltjQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694564007; x=1694650407; bh=u
        NLa0yJI7FL8SDPOk2qnY3XMMXGy5QsZPprxRdWfo0s=; b=oM8Km0zgPyUTL+e1J
        3A8a6bwQsaQMfT56yMoDTATt3lNWaCmKl1X9QKno5xYJKjU5vfj/bJEMUf2UUQON
        QRDRGGFMiwDb/WP5SNRzffsrRKIdKrJfJU/Gk0i9eR9bFDbq5XBfbEjtsQ1B6Fwo
        4Kv6kZLIhKwdu2+VUJU3BZvFkL4OGeGpwYxXs33o2qZsoGc74tuMP41+Gw+c9NhA
        U5hgF0WUWZKPajTMbTcP9C4hACiahEhWp5HKvV3jyZvknlD503byCcEOdX0jpYTx
        B9ZQH59R+Em6l2DAan2SymH9QXzpJM7Px3gG1y+lpLlicw7x3Ok8aHtAGlvDGQt5
        T1kpA==
X-ME-Sender: <xms:pv4AZWHtXE_zgXlykIP9FK4isIM2K0ZZ_HZ6QiN0y0Zyyut9Sfroig>
    <xme:pv4AZXVUOIPG2UAx1sDfNm5ojyCL58hVgqX_nqllgyyYnwwjPbqvsPTMH1EUk4oJe
    uxeJzL8YVHVrf8rfWM>
X-ME-Received: <xmr:pv4AZQJsGcSMhm2ZrTxXjDKAiv0i29uKfYJiygRgFH0UaMxCD_wHYjKPDUSdFKBJh67mACCxvqzJYtP5L--mZ9uWJtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:p_4AZQE1mOjVFwMMzZVhdC2BQ5N8g335j9C_ThaNaAQsvb-xm2lJOA>
    <xmx:p_4AZcU7nb_En7QSm3M0zeRMmn26Ek0_1KaqDGM1Fjfu0uUDG0z7VA>
    <xmx:p_4AZTMNKErdCyoGuP5BKTZ2rLtDRuzQs2pEv9wmXah4_0DNx1at2A>
    <xmx:p_4AZVdH8xPnu-R97oCCHAhNCyvnPpfC8jB5i8rzAOAh72sIjU_mLQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 17/18] btrfs: track data relocation with simple quota
Date:   Tue, 12 Sep 2023 17:13:28 -0700
Message-ID: <4c5b76256e13ab4e7123b17cd63553020077c261.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation data allocations are quite tricky for simple quotas. The
basic data relocation sequence is (ignoring details that aren't relevant
to this fix):
- create a fake relocation data fs root
- create a fake relocation inode in that root
- foreach data extent:
  - preallocate a data extent on behalf of the fake inode
  - copy over the data
- foreach extent
  - swap the refs so that the original file extent now refers to the new
    extent item
- drop the fake root, dropping its refs on the old extents, which lets
  us delete them.

Done naively, this results in storing an extent item in the extent tree
whose owner_ref points at the relocation data root and a no-op squota
recording, since the reloc root is not a legit fstree. So far, that's
OK. The problem comes when you do the swap, and leave an extent item
owned by this bogus root as the real permanent extents of the file. If
the file then drops that ref, we free it and no-op account that against
the fake relocation root. Essentially, this means that relocation is
simple quota "extent laundering", since we re-own the extents into a
fake root.

Simple quotas very intentionally doesn't have a mechanism for
transferring ownership of extents, as that is exactly the complicated
thing we are trying to avoid with the new design. Further, it cannot be
correctly done in this case, since at the time you create the new
"real" refs, there is no way to know which was the original owner before
relocation unless we track it.

Therefore, it makes more sense to trick the preallocation to handle
relocation as a special case and note the proper owner ref from the
beginning. That way, we never write out an extent item without the
correct owner ref that it will eventually have.

This could be done by wiring a special root parameter all the way
through the allocation code path, but to avoid that special case
touching all the code, take advantage of the serial nature of relocation
to store the src root on the relocation root object. Then when we finish
the prealloc, if it happens to be this case, prepare the delayed ref
appropriately.

We must also add logic to handle relocating adjacent extents with
different owning roots. Those cannot be preallocated together in a
cluster as it would lose the separate ownership information.

This is obviously a smelly bit of code, but I think it is the best
solution to the problem, given the relocation implementation.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/extent-tree.c | 13 ++++++-----
 fs/btrfs/relocation.c  | 49 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index da9e07bf76ea..d8b23936ff54 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -305,6 +305,7 @@ struct btrfs_root {
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 #endif
+	u64 relocation_src_root;
 };
 
 static inline bool btrfs_root_readonly(const struct btrfs_root *root)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7b9c58fc9fa8..a1fa114196e5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -58,7 +58,7 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
-				      struct btrfs_key *ins, int ref_mod);
+				      struct btrfs_key *ins, int ref_mod, u64 oref_root);
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 				     struct btrfs_delayed_ref_node *node,
 				     struct btrfs_delayed_extent_op *extent_op);
@@ -1574,7 +1574,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		ret = alloc_reserved_file_extent(trans, parent, ref->root,
 						 flags, ref->objectid,
 						 ref->offset, &key,
-						 node->ref_mod);
+						 node->ref_mod, href->owning_root);
 		if (!ret)
 			ret = btrfs_record_squota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
@@ -4737,7 +4737,7 @@ static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
-				      struct btrfs_key *ins, int ref_mod)
+				      struct btrfs_key *ins, int ref_mod, u64 oref_root)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *extent_root;
@@ -4784,7 +4784,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (simple_quota) {
 		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
 		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
-		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
+		btrfs_set_extent_owner_ref_root_id(leaf, oref, oref_root);
 		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
 	}
 	btrfs_set_extent_inline_ref_type(leaf, iref, type);
@@ -4895,6 +4895,9 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
 
+	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
+		owning_root = root->relocation_src_root;
+
 	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 			       ins->objectid, ins->offset, 0, owning_root);
 	btrfs_init_data_ref(&generic_ref, root_objectid, owner,
@@ -4950,7 +4953,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&space_info->lock);
 
 	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
-					 offset, ins, 1);
+					 offset, ins, 1, root_objectid);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
 	ret = btrfs_record_squota_delta(fs_info, &delta);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bd07d5322c61..58cf831e1cac 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -122,6 +122,7 @@ struct file_extent_cluster {
 	u64 end;
 	u64 boundary[MAX_EXTENTS];
 	unsigned int nr;
+	u64 owning_root;
 };
 
 struct reloc_control {
@@ -3165,6 +3166,7 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
 			 struct file_extent_cluster *cluster)
 {
 	int ret;
+	struct btrfs_root *root = BTRFS_I(inode)->root;
 
 	if (cluster->nr > 0 && extent_key->objectid != cluster->end + 1) {
 		ret = relocate_file_extent_cluster(inode, cluster);
@@ -3173,8 +3175,38 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
 		cluster->nr = 0;
 	}
 
-	if (!cluster->nr)
+	/*
+	 * Under simple quotas, we set root->relocation_src_root when we find
+	 * the extent. If adjacent extents have different owners, we can't merge
+	 * them while relocating. Handle this by storing the owning root that
+	 * started a cluster and if we see an extent from a different root break
+	 * cluster formation (just like the above case of non-adjacent extents).
+	 *
+	 * Absent simple quotas, relocation_src_root is always 0, so we should
+	 * never see a mismatch, and it should have no effect on relocation
+	 * clusters.
+	 */
+	if (cluster->nr > 0 && cluster->owning_root != root->relocation_src_root) {
+		u64 tmp = root->relocation_src_root;
+
+		/*
+		 * root->relocation_src_root is the state that actually
+		 * affects the preallocation we do here, so set it to the
+		 * root owning the cluster we need to relocate.
+		 */
+		root->relocation_src_root = cluster->owning_root;
+		ret = relocate_file_extent_cluster(inode, cluster);
+		if (ret)
+			return ret;
+		cluster->nr = 0;
+		/* And reset it back for the current extent's owning root */
+		root->relocation_src_root = tmp;
+	}
+
+	if (!cluster->nr) {
 		cluster->start = extent_key->objectid;
+		cluster->owning_root = root->relocation_src_root;
+	}
 	else
 		BUG_ON(cluster->nr >= MAX_EXTENTS);
 	cluster->end = extent_key->objectid + extent_key->offset - 1;
@@ -3704,6 +3736,21 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 				    struct btrfs_extent_item);
 		flags = btrfs_extent_flags(path->nodes[0], ei);
 
+		/*
+		 * If we are relocating a simple quota owned extent item, we need
+		 * to note the owner on the reloc data root so that when we
+		 * allocate the replacement item, we can attribute it to the
+		 * correct eventual owner (rather than the reloc data root)
+		 */
+		if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
+			struct btrfs_root *root = BTRFS_I(rc->data_inode)->root;
+			u64 owning_root_id = btrfs_get_extent_owner_root(fs_info,
+									 path->nodes[0],
+									 path->slots[0]);
+
+			root->relocation_src_root = owning_root_id;
+		}
+
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
 		} else if (rc->stage == UPDATE_DATA_PTRS &&
-- 
2.41.0

