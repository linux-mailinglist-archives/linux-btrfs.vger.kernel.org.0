Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822DC75CD12
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjGUQEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGUQEf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:35 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6B2D50
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D702932009A8;
        Fri, 21 Jul 2023 12:04:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 21 Jul 2023 12:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955472; x=
        1690041872; bh=cne++7FRXADhlK9ZOwI1PTHu+XgxCQaXYnzNUEjXJT0=; b=U
        X836kAB1hs+qW18dCJXEqsm6/Jw0Eb7sS9cOkwBOSeA317oro/sfrIqprVhVnSv5
        07g5aUApnH++7n3QB08LOzSS9WzTvQ+1/4N0DdfeCdLrAj/QwJ/KEMM7Nr1tVb54
        Y/LqIjyvmqSlpf9VpvC9GnveWDpOSY94vmuS/FJXFRzRkhuO0tdhWME1QSEmg/p5
        1c5FnA4IGKS/h8iNCXA9OrhQf1pFC/938x4QY97FGl8lPNg5IclNwDM4FPdryyMV
        8gt94qa/XroxilXhGR2LbP4SazB9PejXmuibKOvICqsuCpEN3+6dl0q/kMD97FQq
        31RaofG1SdVLQdu9jMWAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955472; x=1690041872; bh=c
        ne++7FRXADhlK9ZOwI1PTHu+XgxCQaXYnzNUEjXJT0=; b=sdk8FLNMK5JURV4BD
        GWtb4L5+pXbSPwcXvv9PWjc67BcB2bf4blWKTUQZR0sGCzCYb5VU9By2UDhnenKG
        ysDvB5v1s1F8NqUM2ddU6chehUQaG4wu9xHWs8JKFlMyQy2EVTnbHrNQx/KI2DAh
        RpC2Tel6hDZ46Tx/hvtKRngmyR8PWNYqGDXTb2EQmq8X3wLn2Vwv5Ngl2hQIAfCz
        qHKfeRZgmWvVg5ogUjrRe1yvTebFEDl8xtka0/h6rfwuJFD/3G6OT+gk21raH8wI
        jMxi4ckjB8+NRl2EdxuXvKaKLkkRC3aeQ6oV34xrrfaGXDme10NfjlK7MzVKHe0H
        i6w/g==
X-ME-Sender: <xms:kKy6ZD8KKFxSa2E3um7GH48xOCO-6nAEy_s886oiW_7iwfBYq_XOFA>
    <xme:kKy6ZPsSS5LEpREqx9qIP8aE07m8vR3z3waQ2LqAzyxzf0O4fhr4Dy2sXk9MCI6YA
    bOBQwHU-0JNxXaZAbc>
X-ME-Received: <xmr:kKy6ZBDvyN36JpT-nx-aXntXQKSGVmPOTnIEptklOmtGs3Pn8ByS2E-yOCPh8Q3ug7potBwX4x2qe-d-T0CcBVWB6Ts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:kKy6ZPeV-XxWP6u1fVnvlCxAAiIUHdnRWp02FEisGl1u3rs52m_zVQ>
    <xmx:kKy6ZIOI-CBQlM59Dj82VoY3-gEsOM-VTp69rDocIG1FX7gYVdctrg>
    <xmx:kKy6ZBluIkgWy0k-E14gjma141hx8OI_ma6cSc1__X2Q3thMPGhT_g>
    <xmx:kKy6ZCXe_giXdqbpJa7stvYqBi0MWOwLfFR_idz-9EP4hTQXrZsDSQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:31 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 11/20] btrfs: track owning root in btrfs_ref
Date:   Fri, 21 Jul 2023 09:02:16 -0700
Message-ID: <0e30099dd4d8c1e749c5592917b223f2fab19bbe.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/extent-tree.c | 18 ++++++++++--------
 fs/btrfs/file.c        | 10 +++++-----
 fs/btrfs/inode-item.c  |  2 +-
 fs/btrfs/relocation.c  | 16 +++++++++-------
 fs/btrfs/tree-log.c    |  3 ++-
 7 files changed, 42 insertions(+), 27 deletions(-)

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
index 018e288ccf7d..8e9a0da55f4c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2389,7 +2389,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
 			key.offset -= btrfs_file_extent_offset(buf, fi);
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent);
+					       num_bytes, parent, ref_root);
 			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
 					    key.offset, root->root_key.objectid,
 					    for_reloc);
@@ -2403,7 +2403,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			bytenr = btrfs_node_blockptr(buf, i);
 			num_bytes = fs_info->nodesize;
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent);
+					       num_bytes, parent, ref_root);
 			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
 					    root->root_key.objectid, for_reloc);
 			if (inc)
@@ -3220,7 +3220,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
-			       buf->start, buf->len, parent);
+			       buf->start, buf->len, parent, btrfs_header_owner(buf));
 	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
 			    root_id, 0, false);
 
@@ -4677,12 +4677,14 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_key *ins)
 {
 	struct btrfs_ref generic_ref = { 0 };
+	u64 root_objectid = root->root_key.objectid;
+	u64 owning_root = root_objectid;
 
-	BUG_ON(root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
+	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-			       ins->objectid, ins->offset, 0);
-	btrfs_init_data_ref(&generic_ref, root->root_key.objectid, owner,
+			       ins->objectid, ins->offset, 0, owning_root);
+	btrfs_init_data_ref(&generic_ref, root_objectid, owner,
 			    offset, 0, false);
 	btrfs_ref_tree_mod(root->fs_info, &generic_ref);
 
@@ -4894,7 +4896,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->level = level;
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-				       ins.objectid, ins.offset, parent);
+				       ins.objectid, ins.offset, parent, btrfs_header_owner(buf));
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -5315,7 +5317,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		find_next_key(path, level, &wc->drop_progress);
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-				       fs_info->nodesize, parent);
+				       fs_info->nodesize, parent, btrfs_header_owner(next));
 		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
 				    0, false);
 		ret = btrfs_free_extent(trans, &ref);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd03e689a6be..83b651d823bb 100644
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
@@ -2290,7 +2290,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 
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
index 9db2e6fa2cb2..8e0aee042179 100644
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

