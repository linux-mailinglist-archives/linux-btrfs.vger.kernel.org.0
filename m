Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0087640AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGZUlJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGZUlH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:41:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A116EC
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:41:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D82D05C006D;
        Wed, 26 Jul 2023 16:41:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 16:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404065; x=
        1690490465; bh=r6r7/2xSl+1qUS2a1HEjEI/7tXY4y4rHQV81MXiK/eY=; b=m
        1N9FrlF3p007qloxyJIbGWCCT6VPCpC+1w0tTk4H2ltPBJuLP/HTVcO1vy+2Fr1i
        4ZzqJdT6oz2zU+P+cds+D9zcwUyaPMBzcAovU7DxudEgZ+6xuNq97GeIhMb5TuuU
        NoTB5zuB6wUL4BtGWPwtBD3UkewacyTXaMJ8y1EAtK65PFt65HGdETAB0N90xq0c
        hdt3G5d1bJxAcVgHzsR/KfpeMxoa8DzGHcdiDxR1EnvgaWr5h1rb/OszMt3c5ZMQ
        9g70Tw9JoqEPBegmqSa9vsLQ0mmnPvfww4GNVk9G3SZQeuwesKwlBTDWfu1m/gqa
        mNxjyOnM16lS6KiJl1INQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404065; x=1690490465; bh=r
        6r7/2xSl+1qUS2a1HEjEI/7tXY4y4rHQV81MXiK/eY=; b=BAt0hXwJzHniB+dJJ
        egFlIfUPOEWy+mGkGRJoZyqs8tp2yxe8S9CGOyv0lyNMdPERL0IcAfbhnfEs3VnI
        f8i6zY4c+kUUc1u6fKpSJNEHagWCw7xcs1aGuvXgcmD0STtV4nkRJ+vMonBvoZ4F
        aNqWrxCq1vGwFGORuAhEMOp1kX9INKD3JGOUOV2pHHQN/Pu/71vKfJd36W9PvUrs
        U64EPlitgdBb4aKNRsizsoGDRCqrYwOptjABRz8v33nC29S4F5BwSZfIKJ+DtcD9
        5rZOSmhRt7YBEK6r5XSpVJjeDFNOVUBcH7L53g5fpKYXexqisS5PYMMhttWutxlI
        LTBOw==
X-ME-Sender: <xms:4YTBZPoXqhsyxGaso6yLZuRcVFiTxKwLYqI2OlvWUB6zkZAl2pIhNg>
    <xme:4YTBZJrtZMfvm0dPbzl4cFXeoZN4-FlN8S9sTc4PcbpeDYPCewRz7j3JdhP7uV0f8
    PbuJIFDiERl6Z_LJoE>
X-ME-Received: <xmr:4YTBZMPeySDSQtteIhlPrh5Hra-f8TZBxWdxNc815e-Se-SlVGxMhVuvrbiBVfqF_6ku4V9MSR9Niz3n_KnSWLHA4Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:4YTBZC53vg5oZPG6fEbvTzffYfpu8XGkN_Lnct6Y-SAD3sjhkr2qbg>
    <xmx:4YTBZO7W12RvFtuZGOfhdxDUQjjdX4mPkOgQh6migsxrPLHHclL-tg>
    <xmx:4YTBZKjzTuNydHSCPVfxSrPmh8p_nRPaJ7TE8N_aC6atkaIu8v274A>
    <xmx:4YTBZDjx3BJjN2_NAwASden0Y4miQfkW4lzr1sZRn3PZWXY384mSsw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:41:05 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 13/18] btrfs: record simple quota deltas
Date:   Wed, 26 Jul 2023 13:38:40 -0700
Message-ID: <87524cd71423bf8fe26f8fe7ae24eaa05f9b8caf.1690403768.git.boris@bur.io>
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

At the moment that we run delayed refs, we make the final ref-count
based decision on creating/removing extent (and metadata) items.
Therefore, it is exactly the spot to hook up simple quotas.

There are a few important subtleties to the fields we must collect to
accurately track simple quotas, particularly when removing an extent.
When removing a data extent, the ref could be in any tree (due to
reflink, for example) and so we need to recover the owning root id from
the owner ref item. When removing a metadata extent, we know the owning
root from the owner field in the header when we create the delayed ref,
so we can recover it from there.

We must also be careful to handle reservations properly to not leaked
reserved space. The happy path is freeing the reservation when the
simple quota delta runs on a data extent. If that doesn't happen, due to
refs canceling out or some error, the ref head already has the
must_insert_reserved machinery to handle this, so we piggy back on that
and use it to clean up the reserved data.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-ref.c |  1 +
 fs/btrfs/delayed-ref.h |  6 ++++
 fs/btrfs/extent-tree.c | 79 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 89641bcd6841..b7a6562d6fb7 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -735,6 +735,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->bytenr = bytenr;
 	head_ref->num_bytes = num_bytes;
 	head_ref->ref_mod = count_mod;
+	head_ref->reserved_bytes = reserved;
 	head_ref->must_insert_reserved = must_insert_reserved;
 	head_ref->owning_root = owning_root;
 	head_ref->is_data = is_data;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 0af3b7395aba..aff05b3fb4ba 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -110,6 +110,12 @@ struct btrfs_delayed_ref_head {
 	 */
 	int ref_mod;
 
+	/*
+	 * Track reserved bytes when setting must_insert_reserved.
+	 * On success or cleanup, we will need to free the reservation.
+	 */
+	u64 reserved_bytes;
+
 	/*
 	 * when a new extent is allocated, it is just reserved in memory
 	 * The actual extent isn't inserted into the extent allocation tree
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9b44fb85eed4..3108dd1410b4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1482,6 +1482,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 }
 
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
+				struct btrfs_delayed_ref_head *href,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
 				bool insert_reserved)
@@ -1505,12 +1506,22 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	ref_root = ref->root;
 
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
+		struct btrfs_simple_quota_delta delta = {
+			.root = href->owning_root,
+			.num_bytes = node->num_bytes,
+			.rsv_bytes = href->reserved_bytes,
+			.is_data = true,
+			.is_inc	= true,
+		};
+
 		if (extent_op)
 			flags |= extent_op->flags_to_set;
 		ret = alloc_reserved_file_extent(trans, parent, ref_root,
 						 flags, ref->objectid,
 						 ref->offset, &ins,
 						 node->ref_mod);
+		if (!ret)
+			ret = btrfs_record_simple_quota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
 					     ref->objectid, ref->offset,
@@ -1632,11 +1643,13 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 }
 
 static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
+				struct btrfs_delayed_ref_head *href,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
 				bool insert_reserved)
 {
 	int ret = 0;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_tree_ref *ref;
 	u64 parent = 0;
 	u64 ref_root = 0;
@@ -1656,8 +1669,18 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -EIO;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
+		struct btrfs_simple_quota_delta delta = {
+			.root = href->owning_root,
+			.num_bytes = fs_info->nodesize,
+			.rsv_bytes = 0,
+			.is_data = false,
+			.is_inc = true,
+		};
+
 		BUG_ON(!extent_op || !extent_op->update_flags);
 		ret = alloc_reserved_tree_block(trans, node, extent_op);
+		if (!ret)
+			btrfs_record_simple_quota_delta(fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
 					     ref->level, 0, 1, extent_op);
@@ -1672,6 +1695,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 /* helper function to actually process a single delayed ref entry */
 static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
+			       struct btrfs_delayed_ref_head *href,
 			       struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       bool insert_reserved)
@@ -1686,12 +1710,12 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 
 	if (node->type == BTRFS_TREE_BLOCK_REF_KEY ||
 	    node->type == BTRFS_SHARED_BLOCK_REF_KEY)
-		ret = run_delayed_tree_ref(trans, node, extent_op,
+		ret = run_delayed_tree_ref(trans, href, node, extent_op,
 					   insert_reserved);
 	else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
 		 node->type == BTRFS_SHARED_DATA_REF_KEY)
-		ret = run_delayed_data_ref(trans, node, extent_op,
-					   insert_reserved);
+		ret = run_delayed_data_ref(trans, href, node,
+					   extent_op, insert_reserved);
 	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
 		ret = 0;
 	else
@@ -1788,6 +1812,11 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 		spin_unlock(&delayed_refs->lock);
 		nr_items += btrfs_csum_bytes_to_leaves(fs_info, head->num_bytes);
 	}
+	if (head->must_insert_reserved && head->is_data &&
+	    btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		btrfs_qgroup_free_refroot(fs_info, head->owning_root,
+					  head->reserved_bytes,
+					  BTRFS_QGROUP_RSV_DATA);
 
 	btrfs_delayed_refs_rsv_release(fs_info, nr_items);
 }
@@ -1934,8 +1963,8 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		locked_ref->extent_op = NULL;
 		spin_unlock(&locked_ref->lock);
 
-		ret = run_one_delayed_ref(trans, ref, extent_op,
-					  must_insert_reserved);
+		ret = run_one_delayed_ref(trans, locked_ref, ref,
+					  extent_op, must_insert_reserved);
 
 		btrfs_free_delayed_extent_op(extent_op);
 		if (ret) {
@@ -2856,11 +2885,12 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
 }
 
 static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
-				     u64 bytenr, u64 num_bytes, bool is_data)
+				     u64 bytenr, struct btrfs_simple_quota_delta *delta)
 {
 	int ret;
+	u64 num_bytes = delta->num_bytes;
 
-	if (is_data) {
+	if (delta->is_data) {
 		struct btrfs_root *csum_root;
 
 		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
@@ -2871,6 +2901,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	ret = btrfs_record_simple_quota_delta(trans->fs_info, delta);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
 	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -2973,6 +3009,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
+	u64 delayed_ref_root = node->owning_root;
 
 	extent_root = btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
@@ -3171,6 +3208,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 	} else {
+		struct btrfs_simple_quota_delta delta = {
+			.root = delayed_ref_root,
+			.num_bytes = num_bytes,
+			.rsv_bytes = 0,
+			.is_data = is_data,
+			.is_inc = false,
+		};
+
 		/* In this branch refs == 1 */
 		if (found_extent) {
 			if (is_data && refs_to_drop !=
@@ -3209,6 +3254,16 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				num_to_del = 2;
 			}
 		}
+		/*
+		 * We can't infer the data owner from the delayed ref, so we
+		 * need to try to get it from the owning ref item.
+		 *
+		 * If it is not present, then that extent was not written under
+		 * simple quotas mode, so we don't need to account for its
+		 * deletion.
+		 */
+		if (is_data)
+			delta.root = btrfs_get_extent_owner_root(trans->fs_info, leaf, extent_slot);
 
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
@@ -3218,7 +3273,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
+		ret = do_free_extent_accounting(trans, bytenr, &delta);
 	}
 	btrfs_release_path(path);
 
@@ -4789,6 +4844,13 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	int ret;
 	struct btrfs_block_group *block_group;
 	struct btrfs_space_info *space_info;
+	struct btrfs_simple_quota_delta delta = {
+		.root = root_objectid,
+		.num_bytes = ins->offset,
+		.rsv_bytes = 0,
+		.is_data = true,
+		.is_inc = true,
+	};
 
 	/*
 	 * Mixed block groups will exclude before processing the log so we only
@@ -4817,6 +4879,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 					 offset, ins, 1);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
+	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
 	btrfs_put_block_group(block_group);
 	return ret;
 }
-- 
2.41.0

