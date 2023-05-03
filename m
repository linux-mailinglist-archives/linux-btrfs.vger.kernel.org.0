Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D856F4E3F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjECA74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 20:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECA7z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 20:59:55 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8010E5
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9159F5C02C4;
        Tue,  2 May 2023 20:59:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 20:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075592; x=
        1683161992; bh=Fyg3Qhxh4i1zVTniLzT7tblQqhRAZo85Wa6g2FIgu5w=; b=U
        VDgfhacwag2ugY1ZlJNM4Hbk7/u0XdC5XEdP/4oPlZUR7oUMLTu54fIZfBR6JQIf
        zyn0J3magaUU/akvMdLvTgN+ed2C09I3snUWAhxWy5V8dPYT1shcJdJhIyWY61AN
        ZwbFUSmn3pDmGzh0yDSsRyXLSHtsInw84Ja7K1E9iftvOPTW7YuSz3qazxJ6r6Gf
        ShW5AlzSMR+Ear6psk/mcjhREBSQP2ykuUgBFY7oi8dX50cEQ/98MPF9vBMksn8y
        xty+LkmMUWIiMQ7CKHYK0d9aO2HjfjPGBF0HOhdmzRJ4QfmS3hlLtYAFldKx9gj0
        tDA6fX3VaSS3ABXO/6bcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075592; x=1683161992; bh=F
        yg3Qhxh4i1zVTniLzT7tblQqhRAZo85Wa6g2FIgu5w=; b=CdPvKDPznFJiCWnLS
        IcWyvQePiA5/cXw2uX9d02L2Qyk4/zscE2EvjVVD9qoWrTkb21OsLJ52gJL1lBqS
        OgwRgHc1IVCQYR0vS/50ms9U/UHo8RRgC8QGESzA+yWGqbPXJhHYb8rLaxuKtolM
        z+A6WggDKCkPxWOLz6v6RFiB25busMZljQ6W9/f/LnMCuo94No+qUwYf7KNOcpUo
        CggHYa9xbqOCQVeFmcFILT5GoIDyTuPzYCj8gy1xwAIDH4nJVX3yIUizGXajcw4v
        lvzwNgmEViBirEvaVPepel0uGHOxd+L0zn9x7ZWQBIz6IY923kt2AB3knv0/aQ64
        YxHBA==
X-ME-Sender: <xms:CLJRZBHIQnJWZozk4w88w5l5N90zsJqflioknOgmMILAoY6IjMLfgw>
    <xme:CLJRZGWR0Bs8He8Q-K_KjDRUSEE6r4u1yF7ZVFQoxh4Ck93HUVbuzHBRQI2O9c9M1
    LZXHSWdoibkv1vSFPU>
X-ME-Received: <xmr:CLJRZDL-6tDi80FSDzW6gT_t4TORVkMQkKBST5txJ2W4PlhMlxnIFkk1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:CLJRZHGTagstAb4t_zKS1e5BSHFJYTJo6cEBK24yuSFmlqViLzSIZA>
    <xmx:CLJRZHURSMP7rFxo6KgvSInRWPfj2faBXYFLoouXIFUoaeYJJCuNMg>
    <xmx:CLJRZCMpIfRUm_mp1mBNkvgc0IVVMoFZMK-bJzp6zqkRyH9Gvvr1nw>
    <xmx:CLJRZIfvstW1SjJo6O5l9UEgPKm72h2KzFhbKd3rf1yBLNoHaGTvqg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:52 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: track metadata owning root in delayed refs
Date:   Tue,  2 May 2023 17:59:25 -0700
Message-Id: <fa89b696b6c91d6eae9a26400c1cb517f0e65c02.1683075170.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1683075170.git.boris@bur.io>
References: <cover.1683075170.git.boris@bur.io>
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
away, we will not rewrite that header field, so it will reliabl give the
original owner.

To use it for recording simple quota deltas, we need to wire this root
id through from when we create the delayed ref until we fully process it
and know that we are deleteing a metadata extent. Store it in the
btrfs_tree_ref struct of the delayed tree ref.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-ref.c |  7 ++++---
 fs/btrfs/delayed-ref.h | 16 +++++++++++++++-
 fs/btrfs/extent-tree.c |  8 ++++----
 fs/btrfs/relocation.c  | 11 ++++++-----
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 0b32432d7d56..f4c01965e1ea 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -838,7 +838,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 				    struct btrfs_delayed_ref_node *ref,
 				    u64 bytenr, u64 num_bytes, u64 ref_root,
-				    int action, u8 ref_type)
+				    int action, u8 ref_type, u64 allocation_owning_root)
 {
 	u64 seq = 0;
 
@@ -857,6 +857,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	ref->in_tree = 1;
 	ref->seq = seq;
 	ref->type = ref_type;
+	ref->allocation_owning_root = allocation_owning_root;
 	RB_CLEAR_NODE(&ref->ref_node);
 	INIT_LIST_HEAD(&ref->add_list);
 }
@@ -915,7 +916,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
 				generic_ref->tree_ref.owning_root, action,
-				ref_type);
+				ref_type, generic_ref->tree_ref.allocation_owning_root);
 	ref->root = generic_ref->tree_ref.owning_root;
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
index b54261fe509b..427de8a25eb2 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -32,6 +32,12 @@ struct btrfs_delayed_ref_node {
 	/* seq number to keep track of insertion order */
 	u64 seq;
 
+	/*
+	 * root which originally allocated this extent and owns it for
+	 * simple quota accounting purposes.
+	 */
+	u64 allocation_owning_root;
+
 	/* ref count on this data structure */
 	refcount_t refs;
 
@@ -216,6 +222,12 @@ struct btrfs_tree_ref {
 	u64 owning_root;
 
 	/* For non-skinny metadata, no special member needed */
+
+	/*
+	 * Root that originally allocated this block and owns the allocation for
+	 * simple quota accounting purposes.
+	 */
+	u64 allocation_owning_root;
 };
 
 struct btrfs_ref {
@@ -284,7 +296,8 @@ static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
 }
 
 static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
-				int level, u64 root, u64 mod_root, bool skip_qgroup)
+				int level, u64 root, u64 mod_root,
+				bool skip_qgroup, u64 allocation_owning_root)
 {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	/* If @real_root not set, use @root as fallback */
@@ -292,6 +305,7 @@ static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
 #endif
 	generic_ref->tree_ref.level = level;
 	generic_ref->tree_ref.owning_root = root;
+	generic_ref->tree_ref.allocation_owning_root = allocation_owning_root;
 	generic_ref->type = BTRFS_REF_METADATA;
 	if (skip_qgroup || !(is_fstree(root) &&
 			     (!mod_root || is_fstree(mod_root))))
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b9a2f1e355b7..c821d22be2ca 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2446,7 +2446,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
 					       num_bytes, parent);
 			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
-					    root->root_key.objectid, for_reloc);
+					    root->root_key.objectid, for_reloc, ref_root);
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &generic_ref);
 			else
@@ -3268,7 +3268,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
 			       buf->start, buf->len, parent);
 	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
-			    root_id, 0, false);
+			    root_id, 0, false, btrfs_header_owner(buf));
 
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -4952,7 +4952,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 				       ins.objectid, ins.offset, parent);
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
-				    root->root_key.objectid, false);
+				    root->root_key.objectid, false, btrfs_header_owner(buf));
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, extent_op);
 		if (ret)
@@ -5374,7 +5374,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
 				       fs_info->nodesize, parent);
 		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
-				    0, false);
+				    0, false, btrfs_header_owner(next));
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret)
 			goto out_unlock;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 09b1988d1791..0e981e8a374e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1384,7 +1384,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, old_bytenr,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
-				    0, true);
+				    0, true, src->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1393,7 +1393,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid, 0,
-				    true);
+				    true, dest->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1403,7 +1403,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
-				    0, true);
+				    0, true, src->root_key.objectid);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1413,7 +1413,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid,
-				    0, true);
+				    0, true, src->root_key.objectid);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -2494,7 +2494,8 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 					       upper->eb->start);
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb),
-					    root->root_key.objectid, false);
+					    root->root_key.objectid, false,
+					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
 			if (!ret)
 				ret = btrfs_drop_subtree(trans, root, eb,
-- 
2.40.0

