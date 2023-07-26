Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13E7640B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGZUlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGZUlO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:41:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F2211C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:41:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B6D945C0162;
        Wed, 26 Jul 2023 16:41:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 16:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404072; x=
        1690490472; bh=3VMosVU3Btj/bZ/q4OrIjWhW2g4olXkk6l8wsOzVfvE=; b=F
        ldfU2SLNFq0C8gFqF+2amJlTA7I8y3hu1UAmCBLN5LaGD7IvlXG8s5XeDn3iG51R
        NfSb00z21/UOnr3ux3MSSvlI12rF1qkcw/jUNJZw8etSAm7CzB/XBSwrQC3ESH7c
        BenPkLv8q4q9FC2oJdYfW8iZzWKyeiqpqCwBgVv29bliy/n55UEPYFxu+lR6g7Lv
        21B7Tx/raDFHHJ8xKV3LaibfWQhf5769SBlc2IdBzXdJYQhL6cSmiqmsnOKuAJHS
        unQxr8zxE/5wuemJZRaMP5KgOeANqn10BDN/e0GwsFR29N7IsGZKUe7hCJzrimVC
        EdMOu6V7wJnABrKljKMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404072; x=1690490472; bh=3
        VMosVU3Btj/bZ/q4OrIjWhW2g4olXkk6l8wsOzVfvE=; b=XcMTCxKj9xwQ2G5fL
        liRkOKxHQVIGKCQ9psUI4Cj7Kqbm8jgiOW6pscdZ7fwGd9aS+PUzRzsq6nt0Vnn6
        G0N+quS+XVQcu3qnRsnWB6H7cS6YcRh3TAtIJ+ii78a9mqKz8G7TxtrU8kBmmHqb
        rxsX43mJ2SwSLEiR68BXcXieypjlcQOx2CmMAYhcdLtSgR6o1F7U+ozCi9mmatEN
        s5fNrHckV2W9wPqxpgWuCvOwkE66o0NVcRlR11VWBvYSup+CDoUpMngN8YmFHtRO
        XX7Nn+9GLLSazRfeemLHHoamxyUewhfGexP2wU3Hsk1aD2UX39akDI716apOe7pP
        /xE3w==
X-ME-Sender: <xms:6ITBZCAK2jwclI8VHNa4jn_tjrMZZDN0VvGtEZYsmFG7nOJETR-1cw>
    <xme:6ITBZMgrZSsYVn8IMGrjjfkXPQcqX2KdjSvL013PQWzT3z-rq_6itmQEVq8ztn3o-
    1toFL0kIdj88PY0DUo>
X-ME-Received: <xmr:6ITBZFmsKSNLhpkidHh3rxO5FyUW4nWCEBuTWMkyjJGPHo-VMMbCdZfnEYRW48xiIG_PzuK5DeFS24y8zALmItk1mmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:6ITBZAzEhb74kFzzWhV5-i8l38k0NRLPntFnVFrJnF1kW2Ux8h6eUA>
    <xmx:6ITBZHQFa6wtQaYU4u_PaEk0A6mumVFKCLDqiLpf6DqCfru7wqgJWA>
    <xmx:6ITBZLYmTrDquqYD-ISLLwGFKL-32IN9uxuKPtcrxuuQqkgPI_nicA>
    <xmx:6ITBZI6blMKxWP24u9Rg4Q7kCDoa1HAEB-gqibV7IhLsQ1SuAZTBdQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:41:12 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 17/18] btrfs: track data relocation with simple quota
Date:   Wed, 26 Jul 2023 13:38:44 -0700
Message-ID: <fcf72c1abe3bde6f622f2b08af7dac234b60bddc.1690403768.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690403768.git.boris@bur.io>
References: <cover.1690403768.git.boris@bur.io>
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
index f2d2b313bde5..577186994188 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -333,6 +333,7 @@ struct btrfs_root {
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 #endif
+	u64 relocation_src_root;
 };
 
 static inline bool btrfs_root_readonly(const struct btrfs_root *root)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 80785db0cd0d..030be985594d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -57,7 +57,7 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
-				      struct btrfs_key *ins, int ref_mod);
+				      struct btrfs_key *ins, int ref_mod, u64 oref_root);
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 				     struct btrfs_delayed_ref_node *node,
 				     struct btrfs_delayed_extent_op *extent_op);
@@ -1520,7 +1520,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		ret = alloc_reserved_file_extent(trans, parent, ref_root,
 						 flags, ref->objectid,
 						 ref->offset, &ins,
-						 node->ref_mod);
+						 node->ref_mod, href->owning_root);
 		if (!ret)
 			ret = btrfs_record_simple_quota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
@@ -4666,7 +4666,7 @@ static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
-				      struct btrfs_key *ins, int ref_mod)
+				      struct btrfs_key *ins, int ref_mod, u64 oref_root)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *extent_root;
@@ -4714,7 +4714,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (simple_quota) {
 		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
 		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
-		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
+		btrfs_set_extent_owner_ref_root_id(leaf, oref, oref_root);
 		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
 	}
 	btrfs_set_extent_inline_ref_type(leaf, iref, type);
@@ -4825,6 +4825,9 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
 
+	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
+		owning_root = root->relocation_src_root;
+
 	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 			       ins->objectid, ins->offset, 0, owning_root);
 	btrfs_init_data_ref(&generic_ref, root_objectid, owner,
@@ -4880,7 +4883,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&space_info->lock);
 
 	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
-					 offset, ins, 1);
+					 offset, ins, 1, root_objectid);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
 	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8e0aee042179..63cfaf8f57e8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -122,6 +122,7 @@ struct file_extent_cluster {
 	u64 end;
 	u64 boundary[MAX_EXTENTS];
 	unsigned int nr;
+	u64 owning_root;
 };
 
 struct reloc_control {
@@ -3129,6 +3130,7 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
 			 struct file_extent_cluster *cluster)
 {
 	int ret;
+	struct btrfs_root *root = BTRFS_I(inode)->root;
 
 	if (cluster->nr > 0 && extent_key->objectid != cluster->end + 1) {
 		ret = relocate_file_extent_cluster(inode, cluster);
@@ -3137,8 +3139,38 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
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
@@ -3667,6 +3699,21 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
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

