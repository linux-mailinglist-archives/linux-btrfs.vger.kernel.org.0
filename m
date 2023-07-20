Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E675BADE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGTWzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGTWzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4919A6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:55:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EE555C01B7;
        Thu, 20 Jul 2023 18:54:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 20 Jul 2023 18:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893691; x=
        1689980091; bh=nMbPWmouGFmIGUrqhGx4noxOHImeao1RF1x8Mbmgx9M=; b=p
        E1UPnURmvQpx0QT+j6vo9c5d9JvwKvCUPR9cm+CODeIVqriP0A1gdFxc7vRrrapO
        13zbl29UoF6DRpLcGpB/NlnX3FfFi7tDzq8ql7BrxdGna9DzGds1JN+8q7RQEqAo
        6CAC6lCGaVUzFIugRhv+LTHGJKyIoKzdBvKiN21L1ymdtNCgRwkSA7Kapq4WEX4T
        dsZT0w9O9dXdt4GTXzuQNPj4kJUgmaFFvvXKnacSqozGSIeTzAezeuzsCI9VAwH6
        sY01P8kdyGshmRuYrfS77+YhM7hnEuZWcCUu/puX2LQzkRT1+L/rQganQeU2jhQA
        Qf7TGexQOF2fI6WYDEO6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893691; x=1689980091; bh=n
        MbPWmouGFmIGUrqhGx4noxOHImeao1RF1x8Mbmgx9M=; b=FXscXg0THI58mVRer
        s+2BzDRLZY3wu7Btaj2u/TbOI285XGe+G/QKbwhF+f768+unMbonEEH1ts/BQJPT
        IhkAYRYAo9D2BBAAlZK9bgdTsja39xkzXF0WZExHMV0x+SonYvrFgaJflctELPwq
        LX1P0namEdhW/7ElTMKjfweEaNZqSLuxmEMrVis8+yXVk2HzqpirEZnW2aBMGv9U
        U0ujojPHq02KP3XYGVx+3tieaEj//KIBVt570ZvJDDURHLrnuVyKzi+lKTzh+bLD
        SOLuY+e7VfYr+hrfdfmwAjdvXAsTOeAGmoimZ/XAsoywRZlySUSGJTSNL99FGS66
        HVFsg==
X-ME-Sender: <xms:O7u5ZP_3AICtCpaCxAtuaH2vj7mFiETKTRjlkV8QsPLcum-XAI9X0Q>
    <xme:O7u5ZLvNQmipqyeIIST74kaX0-G20i59Z2An9UBfiFjTEU2jvCYy-TW9Dzt-tUigM
    OjCSDb9hDgdHQRy4Wo>
X-ME-Received: <xmr:O7u5ZNDyCzPfA9V0WqeaVdg_nHiJx4qc10C4Nyo-PhB93HbXEijnsSjfm2tMYNkya_3UcMOvigmToBkRiOPA2SfXHZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:O7u5ZLeu4PSKERvuuvhvsKtzEuqmv-i2nwimncWELcPHIkPmxTvtVQ>
    <xmx:O7u5ZEOSmh9Qz0A4Q6BAmO2KycR-l0U6O6AqGMnRkp8tRHXUuDTdUA>
    <xmx:O7u5ZNkU48QqI_FRUBRCp58LozEg_ZVe1oFhYs3I_m9goGz7lpadiQ>
    <xmx:O7u5ZOWZtnD1UD2gqrKBGwj5X8fk-qlAb3sD2HjN0rLSTvyk4142Zw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:50 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 15/20] btrfs: record simple quota deltas
Date:   Thu, 20 Jul 2023 15:52:43 -0700
Message-ID: <9a3188ac77e9dac5f93039289f7f3bc5ae2d231b.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 7636c0361a61..5ea52319c112 100644
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
@@ -2851,11 +2880,12 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
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
@@ -2866,6 +2896,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
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
@@ -2968,6 +3004,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
+	u64 delayed_ref_root = node->owning_root;
 
 	extent_root = btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
@@ -3166,6 +3203,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
@@ -3204,6 +3249,16 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
@@ -3213,7 +3268,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
+		ret = do_free_extent_accounting(trans, bytenr, &delta);
 	}
 	btrfs_release_path(path);
 
@@ -4784,6 +4839,13 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
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
@@ -4812,6 +4874,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 					 offset, ins, 1);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
+	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
 	btrfs_put_block_group(block_group);
 	return ret;
 }
-- 
2.41.0

