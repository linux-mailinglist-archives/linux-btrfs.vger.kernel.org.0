Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA88765F1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjG0WPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjG0WPs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:48 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E143187
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 91B3A32000D7;
        Thu, 27 Jul 2023 18:15:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Jul 2023 18:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496146; x=
        1690582546; bh=Qbzav/zj/K7IjWpA6qmWrvxYPaTohGZsY1YEH5pT/kc=; b=d
        1XTv9rSVxNRTBAmpHVrLSjB+gDEB++pEVZ+ZRPX2t3+e7ddRWE/MPtsljXSEWr0+
        erA0Uc2yBJYO3AtXNDl/OrCwMXM/81kFcLJjjtLL8FhiD0ZjjRSiCPEOnQsmS+z5
        f6x7fP+xK6ZpHr7YCsDAXEq8UWjP9iz0qm7pASKE5D1FIB4sW1AU7NVPUQxeN753
        Slyh25n5eJZ5vH4qGyr1djVSRgCmyrwHsFInTgPw5nuyCAhkeajYaRzE+0f4eDKO
        61sFEK7sNRDF2JMUHIQEggOdzq9TblQXViM0ixK5KeNZ5en2WlTLw1R+SO41WBiD
        keuv7E0lUz3Z/ZIOL+5IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496146; x=1690582546; bh=Q
        bzav/zj/K7IjWpA6qmWrvxYPaTohGZsY1YEH5pT/kc=; b=spkdouNKEhg/AQSwB
        zI84fHo7C5zM9IOKhmfj6WRcySmGHxHVajwBhv9QWX6TNb++4L+hl5sIDdfmKzGH
        l5U22HuSTxnV9cTJpXCq4PNwqfd3DYiFvuzWzHgaPT1w7vpT0dd6h3LG4oh5CY25
        E21fTWykJD5JOPo/qCCxGp6PACwgIooM6PgyJtu8FJumLn2gnEwZik0SFDn5S+0o
        2hbZOnFnpOWalKrBylXt3HAemI6fc/qMPXPNXt0dh6JehGc546JL58W2RTVo2f0N
        uc3jFm+9a8W1KFtWL+TSHb9XzI47Jc6Vtx4YjA2uxPqPxBtbPQa8/EsrjNF8r/28
        uNzUQ==
X-ME-Sender: <xms:kuzCZFdUqq3mTgjpfanhDwjl6BwUeolT7RSW7aUNenECkScSb0FxsA>
    <xme:kuzCZDMvdnOdLO1W_lJAIUx-8sRQ0t2x2smhQwPzNFwZrHRBcLSlWwFYfCg7am3Sz
    8tzT4UxI4Ao30jJxww>
X-ME-Received: <xmr:kuzCZOhCHgwYR6j-VrT9l8BploHhyHWGndJe4LWiEF63DAYgT59JpSPjDU4PswZ0N2nVxcS0fPz62YkACoOlVOb5k8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:kuzCZO9Ywnu82n8carZ9m9RTJEtMtMUABTsrr4yeDP7K0zc5cKe7Dg>
    <xmx:kuzCZBtcPsjHt1R3EQeLB4EhkqDBP8KIfb8IML3bzgsppFCfxQqqew>
    <xmx:kuzCZNEVGB02uI0Zx3YR_6R5_brELDhcBlJLCX9mO81x7OoyYdt9Xw>
    <xmx:kuzCZP3USUcWlEHWpHiHVZ0i8gQtx7T_TrFIWNiEJvmgIHjTt5BFTA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 17/18] btrfs: track data relocation with simple quota
Date:   Thu, 27 Jul 2023 15:13:04 -0700
Message-ID: <86397d08757a9fc03a69cd027f415a5537c53f69.1690495785.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690495785.git.boris@bur.io>
References: <cover.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 50db75529a83..eb132200833d 100644
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
@@ -1521,7 +1521,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		ret = alloc_reserved_file_extent(trans, parent, ref_root,
 						 flags, ref->objectid,
 						 ref->offset, &ins,
-						 node->ref_mod);
+						 node->ref_mod, href->owning_root);
 		if (!ret)
 			ret = btrfs_record_simple_quota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
@@ -4669,7 +4669,7 @@ static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
-				      struct btrfs_key *ins, int ref_mod)
+				      struct btrfs_key *ins, int ref_mod, u64 oref_root)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *extent_root;
@@ -4717,7 +4717,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (simple_quota) {
 		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
 		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
-		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
+		btrfs_set_extent_owner_ref_root_id(leaf, oref, oref_root);
 		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
 	}
 	btrfs_set_extent_inline_ref_type(leaf, iref, type);
@@ -4828,6 +4828,9 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
 
+	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
+		owning_root = root->relocation_src_root;
+
 	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 			       ins->objectid, ins->offset, 0, owning_root);
 	btrfs_init_data_ref(&generic_ref, root_objectid, owner,
@@ -4883,7 +4886,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&space_info->lock);
 
 	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
-					 offset, ins, 1);
+					 offset, ins, 1, root_objectid);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
 	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3161a48d5970..f8c4a549db3a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -122,6 +122,7 @@ struct file_extent_cluster {
 	u64 end;
 	u64 boundary[MAX_EXTENTS];
 	unsigned int nr;
+	u64 owning_root;
 };
 
 struct reloc_control {
@@ -3130,6 +3131,7 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
 			 struct file_extent_cluster *cluster)
 {
 	int ret;
+	struct btrfs_root *root = BTRFS_I(inode)->root;
 
 	if (cluster->nr > 0 && extent_key->objectid != cluster->end + 1) {
 		ret = relocate_file_extent_cluster(inode, cluster);
@@ -3138,8 +3140,38 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
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
@@ -3668,6 +3700,21 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
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

