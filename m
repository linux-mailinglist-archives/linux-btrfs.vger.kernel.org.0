Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1624765F16
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjG0WP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjG0WP1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:27 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1CF13E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 55CFD3200319;
        Thu, 27 Jul 2023 18:15:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 27 Jul 2023 18:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496124; x=
        1690582524; bh=YBM9FCEUGcwQYMvCF55QU8Qac1wzWpjLZ45k0b7oUng=; b=Q
        VWh/p5UZIggYc5+htEE9IShNkJeinjHdEMrT5wyG7isskqd/6Wv7KJhkoKOLvl/H
        aper0H2O9RJz4jbTftLZHQiEBGqBqQQ11SpU8pCE/UaUqh5U5nre9wt71eVa1dQr
        mFedftxUSMTs6Wtw1ynUawqyXrNJBhrJHefUM/tG8YacfZloTgyLcJPe1psMmH2Q
        XvPsw7x5sPOoqMDRL7CemfzLKIZd0i1HNkj64/AKII4wcM+6sQkilawcKqMk3W42
        u9LrZeQLuQRIEHkxvBAKXccxGERQPdcCrOqeoM5phPznHz3AzNK5puuQqav/K2Ku
        PdZO6V7sallWtRW5tUIxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496124; x=1690582524; bh=Y
        BM9FCEUGcwQYMvCF55QU8Qac1wzWpjLZ45k0b7oUng=; b=s/YhABP9AxBFsnt+L
        mCGvmlJRfAM9dIbIAntKof7GWZ5KtGfpfFV8Tj3VAwUV663aFuiazy+vjRZCB9mI
        n5w77Fbx5H2CbIIGidkkz+8WwmzEvLRATsCQeiN0LZDBjPHv3Kg75jJSdozDEs+p
        zT5AAP8rr/G3YMNE/GjG0lYtIoSx3mnJ1iTcjA/6A9T78TX3YqoGvFsEqXgbrSNf
        dLhk5Vfeh6zFhmq02pyd3WewTIagRKzYW6vHwM6FJ2vLrTr71wqDPeecdotCuj2P
        W5yFQuW1KDt63bN7vvDuDz42bmprn1qpovaFhLoApa37bqRr/kTLIn+cFavl4rQI
        D7c3A==
X-ME-Sender: <xms:fOzCZPNwABAvjmXERKnY-M4oYyHhYz2QVtrV-jiNir_dwFQFFovjew>
    <xme:fOzCZJ-FpFeADFH8afKGMWZK0iOo2IUkKIqB6lAydny1tP6Lrx7UIMqUc0v2dNBEe
    xLWEcBa7JgueXVfs3Y>
X-ME-Received: <xmr:fOzCZOQWDikNejWRem9mRFnQ_f76438dSUVGkl_baWQsTdSmnBsxVF9BXRuUmkZKEb1UwHW_Jmv37H25ZOqM8iKPwhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:fOzCZDsDpDqaODcAyn4NmaiS04-mj1cBBCcM4v5GR_of7ZQNVnmcLw>
    <xmx:fOzCZHcmZLOk5AKAvye4ffd-hvWEGXFalEjLwMyCVFjUTTss-gSxdA>
    <xmx:fOzCZP3mzYQDdlfAPeCKE226faYy764ZRhDU8RyfQ5lnG-I8l6lZBg>
    <xmx:fOzCZHmsSR4GnaL7sx1LnbqyDe9rLzGDBwr93pwiCdS1wrUzS-0hYg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:24 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 09/18] btrfs: track owning root in btrfs_ref
Date:   Thu, 27 Jul 2023 15:12:56 -0700
Message-ID: <7f601950d5e04b4cf18e3054346f2437633775e8.1690495785.git.boris@bur.io>
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
index a71eff78469c..0729850a9193 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -239,6 +239,7 @@ struct btrfs_ref {
 #endif
 	u64 bytenr;
 	u64 len;
+	u64 owning_root;
 
 	/* Bytenr of the parent tree block */
 	u64 parent;
@@ -278,16 +279,18 @@ static inline u64 btrfs_calc_delayed_ref_bytes(const struct btrfs_fs_info *fs_in
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
index 018e288ccf7d..4f0115553cd3 100644
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
@@ -2402,8 +2402,9 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
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
@@ -3220,7 +3221,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
-			       buf->start, buf->len, parent);
+			       buf->start, buf->len, parent, btrfs_header_owner(buf));
 	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
 			    root_id, 0, false);
 
@@ -4677,12 +4678,14 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
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
 
@@ -4894,7 +4897,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->level = level;
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-				       ins.objectid, ins.offset, parent);
+				       ins.objectid, ins.offset, parent, btrfs_header_owner(buf));
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -5315,7 +5318,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
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
index 9db2e6fa2cb2..3161a48d5970 100644
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
@@ -2491,7 +2494,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
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

