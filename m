Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0564D79DD09
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjIMANL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjIMANK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED010F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 649DC3200940;
        Tue, 12 Sep 2023 20:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Sep 2023 20:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563985; x=
        1694650385; bh=ZrexDphNPmLfGP1T7l4G2kAQd1dqxx8hykG/I+tQajw=; b=S
        N06ppg3JfC3I34LaZMHeCI9XLuNz3cO8rYZV5dWQQBKJoIwbBiznVZbQS4zXZYSg
        wfX3Fd2zyTnXcESJYzzCofjwifzVNKqLmyUJy7bMb0N7w+BAQQD9PZC28mlFKbyK
        j/plO55BeFqe80yGHq/zqFRcb6RKyBFAyKZquL637iaklyOz6tnYDxmHiK3c0Koq
        TMjTOCGu6nTer3FdYki3RjFVlNOFyIfaZIvHHUnByNo+pMz/ULbbq05TpF7mrlq1
        kN3RPJESwGb9foJlmkCrrlegHyxRHUuTBXn3WhJyGqmyLrO3UZHgty0KUsPKASY4
        ZwumWo/yET5CzCa5y/tbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563985; x=1694650385; bh=Z
        rexDphNPmLfGP1T7l4G2kAQd1dqxx8hykG/I+tQajw=; b=MRiTBrxYnOx/p2sKj
        90WkQTumZlzoqElHU7Zf84JSCMmyI3i0R8B0odfZ13sOm2f2A39j3DNNxwdQGOAh
        olml6gWeKiq12iLkT9v531FTVkFb7VuFeFIdhTudmuu9Fih90fT9YpzptfCJU9dR
        3L2E9QmMirhA4weQToobpGp2ozUtq8LzUy2qrxA9emKTvRgTfsCNi7mTYuv0a6gF
        OaDcXO4fJCvXvzuNzUa800Q0lle0rEseUBeESYSEJdFKfHIxUA1I2kkHZKlhEo9h
        xlK1slNk2L9LAKOI07tzKZM41gGeQ+GXdRlOdcuT3n7HodCgqHb2pE7Ey3QrsBXw
        w7J4A==
X-ME-Sender: <xms:kf4AZUo0VSqzZPTFwM-9yyngrywSveaJCSbFsqNRO4pVr8qYybtmrQ>
    <xme:kf4AZarbbzvz34fxDieRHzOwc4aDhu5ZHBBIwOKKcTcPjjNi2YtGiS_tN9IuvGQ3U
    Hjd6dqesV7k108rICY>
X-ME-Received: <xmr:kf4AZZObE7KCweCWUq0x38jwSvQEcDQInFI_BtKOc5IslJDYWSMqV98yqdraLtouoHggUAji_NX6TWMw21Rbm8OnKAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:kf4AZb67hpqmv0wZhmvO7swUZW_Qzxzk_RxUQ4WSzl1Lz0Dvv--1Aw>
    <xmx:kf4AZT5oduuseeLfp7g3izqudOqNp83q_7dhzMwz07JcVx_ecdxI_g>
    <xmx:kf4AZbiyIAG9RW0SmtEZPMAtzU9ZBS4A3gEKqgJ8bRqpcYszOCMkGQ>
    <xmx:kf4AZQh4sxOzY9EMBVYqMPWxkcpaSNep7AJxzOJ8rsLbQE20iA753A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:05 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 09/18] btrfs: track owning root in btrfs_ref
Date:   Tue, 12 Sep 2023 17:13:20 -0700
Message-ID: <054dd41cf8c0f9ac01c4ed0b1a8faef34c0d3691.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/btrfs/delayed-ref.h |  7 +++++--
 fs/btrfs/extent-tree.c | 19 +++++++++++--------
 fs/btrfs/file.c        | 10 +++++-----
 fs/btrfs/inode-item.c  |  2 +-
 fs/btrfs/relocation.c  | 17 ++++++++++-------
 fs/btrfs/tree-log.c    |  3 ++-
 6 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 1b4d16864d97..2c384862110e 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -245,6 +245,7 @@ struct btrfs_ref {
 #endif
 	u64 bytenr;
 	u64 len;
+	u64 owning_root;
 
 	/* Bytenr of the parent tree block */
 	u64 parent;
@@ -295,16 +296,18 @@ static inline u64 btrfs_calc_delayed_ref_csum_bytes(const struct btrfs_fs_info *
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
index ab13d2cd0ed5..336957737c6c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2447,7 +2447,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
 			key.offset -= btrfs_file_extent_offset(buf, fi);
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent);
+					       num_bytes, parent, ref_root);
 			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
 					    key.offset, root->root_key.objectid,
 					    for_reloc);
@@ -2460,8 +2460,9 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 		} else {
 			bytenr = btrfs_node_blockptr(buf, i);
 			num_bytes = fs_info->nodesize;
+			/* We don't know the owning_root, use 0 */
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent);
+					       num_bytes, parent, 0);
 			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
 					    root->root_key.objectid, for_reloc);
 			if (inc)
@@ -3281,7 +3282,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
-			       buf->start, buf->len, parent);
+			       buf->start, buf->len, parent, btrfs_header_owner(buf));
 	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
 			    root_id, 0, false);
 
@@ -4744,12 +4745,14 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
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
 
@@ -4975,7 +4978,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->level = level;
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-				       ins.objectid, ins.offset, parent);
+				       ins.objectid, ins.offset, parent, btrfs_header_owner(buf));
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -5396,7 +5399,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		find_next_key(path, level, &wc->drop_progress);
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-				       fs_info->nodesize, parent);
+				       fs_info->nodesize, parent, btrfs_header_owner(next));
 		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
 				    0, false);
 		ret = btrfs_free_extent(trans, &ref);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd2f8fec115f..59c2478d644b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -374,7 +374,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			if (update_refs && disk_bytenr > 0) {
 				btrfs_init_generic_ref(&ref,
 						BTRFS_ADD_DELAYED_REF,
-						disk_bytenr, num_bytes, 0);
+						disk_bytenr, num_bytes, 0, root->root_key.objectid);
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						new_key.objectid,
@@ -464,7 +464,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			} else if (update_refs && disk_bytenr > 0) {
 				btrfs_init_generic_ref(&ref,
 						BTRFS_DROP_DELAYED_REF,
-						disk_bytenr, num_bytes, 0);
+						disk_bytenr, num_bytes, 0, root->root_key.objectid);
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						key.objectid,
@@ -746,7 +746,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_mark_buffer_dirty(leaf);
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, bytenr,
-				       num_bytes, 0);
+				       num_bytes, 0, root->root_key.objectid);
 		btrfs_init_data_ref(&ref, root->root_key.objectid, ino,
 				    orig_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -772,7 +772,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	other_start = end;
 	other_end = 0;
 	btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-			       num_bytes, 0);
+			       num_bytes, 0, root->root_key.objectid);
 	btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offset,
 			    0, false);
 	if (extent_mergeable(leaf, path->slots[0] + 1,
@@ -2288,7 +2288,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
 				       extent_info->disk_offset,
-				       extent_info->disk_len, 0);
+				       extent_info->disk_len, 0, root->root_key.objectid);
 		ref_offset = extent_info->file_offset - extent_info->data_offset;
 		btrfs_init_data_ref(&ref, root->root_key.objectid,
 				    btrfs_ino(inode), ref_offset, 0, false);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index c19c0f10f0e2..d4af1dd4f5ba 100644
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
index ad67a88f2bbf..bd07d5322c61 100644
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
@@ -1400,8 +1401,9 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 			break;
 		}
 
+		/* We don't know the real owning_root, use 0 */
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
-				       blocksize, path->nodes[level]->start);
+				       blocksize, path->nodes[level]->start, 0);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
 				    0, true);
 		ret = btrfs_free_extent(trans, &ref);
@@ -1410,8 +1412,9 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 			break;
 		}
 
+		/* We don't know the real owning_root, use 0 */
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
-				       blocksize, 0);
+				       blocksize, 0, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid,
 				    0, true);
 		ret = btrfs_free_extent(trans, &ref);
@@ -2520,7 +2523,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 			btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
 					       node->eb->start, blocksize,
-					       upper->eb->start);
+					       upper->eb->start, btrfs_header_owner(upper->eb));
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb),
 					    root->root_key.objectid, false);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 15c8cb6627fe..07e7fdaf8eb7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -766,7 +766,8 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
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

