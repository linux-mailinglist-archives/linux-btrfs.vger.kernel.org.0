Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB47491CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjGEXXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjGEXXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CEC1990
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 746FA5C02A5;
        Wed,  5 Jul 2023 19:23:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 19:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599400; x=
        1688685800; bh=30K/vuylWF3Qii7MVgvFFZttrkoBcu9PEE51vGauAqQ=; b=H
        86/p14sHomj/4YZxiPs1OtprgZ5EW0POPAV/tuPV2hopC5EEm5bXNdOT9JC9VjAc
        MUN122s5I2pmAQBGk+6ollmkUd1EGNYkO3NCYGT3k0QYLZlbvjfjaRbH9RwY9nT1
        50AEBo+PthZ4rlwDF2YmwuzlVe/ZrTzoX/xHL8ghZlEOfr6RDhGcHDbsAw5xA8Yq
        hEhYFX/8kfCT/AawadlXlrdAJlzuhJOvh2p1928zp++QoONp/YrnFzeRoKXOxc89
        Mvh2WhbYU2wYKqcSPFXabuhwhT8+0991AvmQEdTlGFIRyzUOcjEXpqOBKJuZ6vca
        bY3R/yUFi8aIGD3Uh5wHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599400; x=1688685800; bh=3
        0K/vuylWF3Qii7MVgvFFZttrkoBcu9PEE51vGauAqQ=; b=Yn8+dHg1Ai1sHpzg+
        IZftW699jhZdlqUKPwA0QczWawaMfcsz8qbx36mZ1vxhutVC7+HYH57SuhcOdNWk
        vxOdlpImNEzZYWTlVFlY3LZ37dyFstUcqfC6nY2MI6lvdQou4HulXBfXOR2VQm6r
        igVCuhpN/sXC8YmYz8ib/QNUilruG6eQ6hwQA2nTPKMkwqizWJiPui4ya2fQNCXo
        twQOqd1Hpo1jXE4/YWai1cp5leqYxPi2FtKKJVlDbijlLsjxolGaxgx6i0syvj8A
        iDiTwo89y9JyLpUePzVIvVPrAqqciP25we/bme5Pqnv+m7QUcwwxDtBiuc4oDUy7
        YK6RQ==
X-ME-Sender: <xms:aPulZJb0wf8gjlivZ_VaCKFpAmZB910xz6r3arWnT3PoEw4FEeElkA>
    <xme:aPulZAYEkv1vFG5EB8BUgQ3U8BUqR7B6WEqV2e2jq1lRw2zDCbHm6GDRjNniZOWlt
    9rQRSL9z0vDiwWnajY>
X-ME-Received: <xmr:aPulZL9ysQd0GUruch0iNAzxv4y8nHAofiRIZO4cEPbEHrAqBQohWhXK0j1CFR5Zbf-GhKPcZjjex3PNTh4hQwDWXWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:aPulZHrhnGI5uCplmPfSldC6J1fE-cUXHzBSRJIle_Oej7Mx_VNWUA>
    <xmx:aPulZEphG9SzKPH7U2OyefakKcs2_5EQuCqW7Bvsuha1DPbB5OUC8w>
    <xmx:aPulZNSEL0aqv2GI8rjGz8o-Fw8Ir-kYE5g-Eu9T0v3N8wZBwIMNDQ>
    <xmx:aPulZLSIDJOyTQ4A2581RFA8CqJMOYng7Je74klnEQ6MU2gJyoAtVA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:19 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/18] btrfs: track owning root in btrfs_ref
Date:   Wed,  5 Jul 2023 16:20:47 -0700
Message-ID: <2a1725b60a1978c03c67a93c55c8c52b76d7f046.1688597211.git.boris@bur.io>
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

While data extents require us to store additional inline refs to track
the original owner on free, this information is available implicitly for
metadata. It is found in the owner field of the header of the tree
block. Even if other trees refer to this block and the original ref goes
away, we will not rewrite that header field, so it will reliably give the
original owner.

In addition, there is a relocation case where a new data extent needs to
have an owning root separate from the referring root wired through
delayed refs.

To use it for recording simple quota deltas, we need to wire this root
id through from when we create the delayed ref until we fully process
it. Store it in the generic btrfs_ref struct of the delayed ref.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-ref.c |  7 ++++---
 fs/btrfs/delayed-ref.h | 13 +++++++++++--
 fs/btrfs/extent-tree.c | 19 ++++++++++++-------
 fs/btrfs/file.c        | 10 +++++-----
 fs/btrfs/inode-item.c  |  2 +-
 fs/btrfs/relocation.c  | 16 +++++++++-------
 fs/btrfs/tree-log.c    |  3 ++-
 7 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f0bae1e1c455..49c320f2334b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -840,7 +840,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 				    struct btrfs_delayed_ref_node *ref,
 				    u64 bytenr, u64 num_bytes, u64 ref_root,
-				    int action, u8 ref_type)
+				    int action, u8 ref_type, u64 owning_root)
 {
 	u64 seq = 0;
 
@@ -857,6 +857,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	ref->action = action;
 	ref->seq = seq;
 	ref->type = ref_type;
+	ref->owning_root = owning_root;
 	RB_CLEAR_NODE(&ref->ref_node);
 	INIT_LIST_HEAD(&ref->add_list);
 }
@@ -915,7 +916,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
 				generic_ref->tree_ref.ref_root, action,
-				ref_type);
+				ref_type, generic_ref->owning_root);
 	ref->root = generic_ref->tree_ref.ref_root;
 	ref->parent = parent;
 	ref->level = level;
@@ -989,7 +990,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	else
 	        ref_type = BTRFS_EXTENT_DATA_REF_KEY;
 	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
-				ref_root, action, ref_type);
+				ref_root, action, ref_type, ref_root);
 	ref->root = ref_root;
 	ref->parent = parent;
 	ref->objectid = owner;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index a71eff78469c..336c33c28191 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -32,6 +32,12 @@ struct btrfs_delayed_ref_node {
 	/* seq number to keep track of insertion order */
 	u64 seq;
 
+	/*
+	 * root which originally allocated this extent and owns it for
+	 * simple quota accounting purposes.
+	 */
+	u64 owning_root;
+
 	/* ref count on this data structure */
 	refcount_t refs;
 
@@ -239,6 +245,7 @@ struct btrfs_ref {
 #endif
 	u64 bytenr;
 	u64 len;
+	u64 owning_root;
 
 	/* Bytenr of the parent tree block */
 	u64 parent;
@@ -278,16 +285,18 @@ static inline u64 btrfs_calc_delayed_ref_bytes(const struct btrfs_fs_info *fs_in
 }
 
 static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
-				int action, u64 bytenr, u64 len, u64 parent)
+				int action, u64 bytenr, u64 len, u64 parent, u64 owning_root)
 {
 	generic_ref->action = action;
 	generic_ref->bytenr = bytenr;
 	generic_ref->len = len;
 	generic_ref->parent = parent;
+	generic_ref->owning_root = owning_root;
 }
 
 static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
-				int level, u64 root, u64 mod_root, bool skip_qgroup)
+				int level, u64 root, u64 mod_root,
+				bool skip_qgroup)
 {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	/* If @real_root not set, use @root as fallback */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 041f2eb153d7..fa53f7cbd84a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2410,7 +2410,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
 			key.offset -= btrfs_file_extent_offset(buf, fi);
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent);
+					       num_bytes, parent, ref_root);
 			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
 					    key.offset, root->root_key.objectid,
 					    for_reloc);
@@ -2424,7 +2424,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			bytenr = btrfs_node_blockptr(buf, i);
 			num_bytes = fs_info->nodesize;
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent);
+					       num_bytes, parent, ref_root);
 			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
 					    root->root_key.objectid, for_reloc);
 			if (inc)
@@ -3242,7 +3242,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
-			       buf->start, buf->len, parent);
+			       buf->start, buf->len, parent, btrfs_header_owner(buf));
 	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
 			    root_id, 0, false);
 
@@ -4699,12 +4699,16 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_key *ins)
 {
 	struct btrfs_ref generic_ref = { 0 };
+	u64 root_objectid = root->root_key.objectid;
+	u64 owning_root = root_objectid;
+
+	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
 
 	BUG_ON(root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-			       ins->objectid, ins->offset, 0);
-	btrfs_init_data_ref(&generic_ref, root->root_key.objectid, owner,
+			       ins->objectid, ins->offset, 0, owning_root);
+	btrfs_init_data_ref(&generic_ref, root_objectid, owner,
 			    offset, 0, false);
 	btrfs_ref_tree_mod(root->fs_info, &generic_ref);
 
@@ -4916,7 +4920,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->level = level;
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-				       ins.objectid, ins.offset, parent);
+				       ins.objectid, ins.offset, parent, btrfs_header_owner(buf));
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -5336,8 +5340,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		wc->drop_level = level;
 		find_next_key(path, level, &wc->drop_progress);
 
+		// TODO owning root on generic ref!?
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-				       fs_info->nodesize, parent);
+				       fs_info->nodesize, parent, btrfs_header_owner(next));
 		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
 				    0, false);
 		ret = btrfs_free_extent(trans, &ref);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 392bc7d512a0..f858d9652969 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -373,7 +373,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			if (update_refs && disk_bytenr > 0) {
 				btrfs_init_generic_ref(&ref,
 						BTRFS_ADD_DELAYED_REF,
-						disk_bytenr, num_bytes, 0);
+						disk_bytenr, num_bytes, 0, root->root_key.objectid);
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						new_key.objectid,
@@ -463,7 +463,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			} else if (update_refs && disk_bytenr > 0) {
 				btrfs_init_generic_ref(&ref,
 						BTRFS_DROP_DELAYED_REF,
-						disk_bytenr, num_bytes, 0);
+						disk_bytenr, num_bytes, 0, root->root_key.objectid);
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						key.objectid,
@@ -745,7 +745,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_mark_buffer_dirty(leaf);
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, bytenr,
-				       num_bytes, 0);
+				       num_bytes, 0, root->root_key.objectid);
 		btrfs_init_data_ref(&ref, root->root_key.objectid, ino,
 				    orig_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -771,7 +771,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	other_start = end;
 	other_end = 0;
 	btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-			       num_bytes, 0);
+			       num_bytes, 0, root->root_key.objectid);
 	btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offset,
 			    0, false);
 	if (extent_mergeable(leaf, path->slots[0] + 1,
@@ -2294,7 +2294,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
 				       extent_info->disk_offset,
-				       extent_info->disk_len, 0);
+				       extent_info->disk_len, 0, root->root_key.objectid);
 		ref_offset = extent_info->file_offset - extent_info->data_offset;
 		btrfs_init_data_ref(&ref, root->root_key.objectid,
 				    btrfs_ino(inode), ref_offset, 0, false);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 4c322b720a80..4a56bf679de6 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -676,7 +676,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			bytes_deleted += extent_num_bytes;
 
 			btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF,
-					extent_start, extent_num_bytes, 0);
+					extent_start, extent_num_bytes, 0, root->root_key.objectid);
 			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 					control->ino, extent_offset,
 					root->root_key.objectid, false);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 25a3361caedc..119f670538f7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1158,7 +1158,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 
 		key.offset -= btrfs_file_extent_offset(leaf, fi);
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
-				       num_bytes, parent);
+				       num_bytes, parent, root->root_key.objectid);
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 				    key.objectid, key.offset,
 				    root->root_key.objectid, false);
@@ -1169,7 +1169,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-				       num_bytes, parent);
+				       num_bytes, parent, root->root_key.objectid);
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 				    key.objectid, key.offset,
 				    root->root_key.objectid, false);
@@ -1382,7 +1382,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_mark_buffer_dirty(path->nodes[level]);
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, old_bytenr,
-				       blocksize, path->nodes[level]->start);
+				       blocksize, path->nodes[level]->start,
+				       src->root_key.objectid);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
 				    0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -1391,7 +1392,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 			break;
 		}
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
-				       blocksize, 0);
+				       blocksize, 0, dest->root_key.objectid);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid, 0,
 				    true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -1401,7 +1402,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
-				       blocksize, path->nodes[level]->start);
+				       blocksize, path->nodes[level]->start,
+				       src->root_key.objectid);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
 				    0, true);
 		ret = btrfs_free_extent(trans, &ref);
@@ -1411,7 +1413,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
-				       blocksize, 0);
+				       blocksize, 0, src->root_key.objectid);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid,
 				    0, true);
 		ret = btrfs_free_extent(trans, &ref);
@@ -2491,7 +2493,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 			btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
 					       node->eb->start, blocksize,
-					       upper->eb->start);
+					       upper->eb->start, btrfs_header_owner(upper->eb));
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb),
 					    root->root_key.objectid, false);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ad7e7e38d18..51aaaefaf39d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -767,7 +767,8 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			} else if (ret == 0) {
 				btrfs_init_generic_ref(&ref,
 						BTRFS_ADD_DELAYED_REF,
-						ins.objectid, ins.offset, 0);
+						ins.objectid, ins.offset, 0,
+						root->root_key.objectid);
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						key->objectid, offset, 0, false);
-- 
2.41.0

