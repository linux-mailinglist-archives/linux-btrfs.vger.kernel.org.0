Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3697491D2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjGEXXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGEXX3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:29 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9259E57
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 45B405C02A1;
        Wed,  5 Jul 2023 19:23:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jul 2023 19:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599407; x=
        1688685807; bh=W80V2QyUb7WEXNyME8hnBHOtlpN/8S5iQHLAwGvSMXs=; b=F
        bXu4k75XsbMaM2YVrTBS2aCmP/hm44v8jcPWwofOGuF/+jK2epN0/sETyfnnp1Ml
        qiN1b/KYIMn/iPTezAOoR1YHrhWQjs/Xhs+xMsJZFA2sRqceLnIP0LhtKlvXVQba
        8Eqbs4+VcArnU6o6S0br0+92jlsgHLKFWnueIaJwQmI9pCr9X0UZfp4IKInABhEH
        caJLhm0fTBKSwPzEkS2qIGs9BBLQJPuumosZ2k4hnAtieY4uO5HKtOexdgauf5Gh
        Lb1yZwO2MZeUrJ7VBnxQLys5V4KwpkG1z6ZRQ/3ItNLBgyLwmkBSbMAsp1y8GdIo
        Uh6REG3E9v5kL4NNiQo2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599407; x=1688685807; bh=W
        80V2QyUb7WEXNyME8hnBHOtlpN/8S5iQHLAwGvSMXs=; b=d4RX6btU96cuAgooe
        +URgIR4g6YnkDUxmwe5bAgRfjd7xAt7yIQ9zUFwA5OxXbXkPMHstOXXgL9RaRXG9
        Z7AiKMLKV3ORF4Om1o/v7/Q98uz/4wZgaBXe1lm909p/5lc3E63lfkHy+YCZPsow
        6ZNdAWQHTIO5w9+MzmuIa365/Li970wF6pLeyIKYrmmnqzvlC9k36uQar4Sof0nC
        BLGa1dmVWWR4sVoXFZL9b3NW5aEeG361CF5Z4MR/neRfAi1Ahlf97FKXZLA2pKic
        PVUcHpEYYG4IpblwFJ6Ofy/i0cbuQXxMmdQ62VlsUS9dvsudgfcpxKZRf12NTQm5
        0/bVA==
X-ME-Sender: <xms:b_ulZJxsjULrs7t4G0Jut7RQRRXaF7o0rNPxsyaJCMBP6f-eJ9aUOA>
    <xme:b_ulZJSCkRVqw78ojxHRXzjSlwziS-8voIgjrcvkOZ9Nuoa4bkuqGLh586FPTn6Ik
    dgQYQV-99k89W2R3Xk>
X-ME-Received: <xmr:b_ulZDXpFZoIrK-JMV5kiOippBavFs7Uzlysg-ADaSlCRM3LXiDYEdcKcO_YWYC0vaQixYmHexa_fZ5FaaB_1uTq-KU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:b_ulZLhVmYKEUszQlaPSwEesbwfhwsOy_J7t_84Yld55Whn3KSb1Kw>
    <xmx:b_ulZLCTMDAc_n5qcoot-LhIE-VRZ2Up-cq_rt9atdScT_1UZ_2n5A>
    <xmx:b_ulZEKehXAMipxqUJb6bLY0aI6ZrROxoU_1qP_-ihyJ1lsEGAU7OQ>
    <xmx:b_ulZOoXoUC0n_XyU6ul_xVyNBlIb7yz209W51hsG8Miwc7llRE4PQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/18] btrfs: record simple quota deltas
Date:   Wed,  5 Jul 2023 16:20:51 -0700
Message-ID: <ebe324c9b3ab85f6ba4fca00a398e8e17ebe3c8c.1688597211.git.boris@bur.io>
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
 fs/btrfs/delayed-ref.c |  3 ++
 fs/btrfs/delayed-ref.h |  6 ++++
 fs/btrfs/extent-tree.c | 79 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 89641bcd6841..04e124a93049 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -735,6 +735,9 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->bytenr = bytenr;
 	head_ref->num_bytes = num_bytes;
 	head_ref->ref_mod = count_mod;
+	head_ref->reserved_bytes = 0;
+	if (reserved)
+		head_ref->reserved_bytes = reserved;
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
index c8f767d7e261..c8914c66dc83 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1503,6 +1503,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 }
 
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
+				struct btrfs_delayed_ref_head *href,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
 				bool insert_reserved)
@@ -1526,12 +1527,22 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
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
@@ -1653,11 +1664,13 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
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
@@ -1677,8 +1690,18 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
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
@@ -1693,6 +1716,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 /* helper function to actually process a single delayed ref entry */
 static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
+			       struct btrfs_delayed_ref_head *href,
 			       struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       bool insert_reserved)
@@ -1707,12 +1731,12 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 
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
@@ -1809,6 +1833,11 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
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
@@ -1955,8 +1984,8 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		locked_ref->extent_op = NULL;
 		spin_unlock(&locked_ref->lock);
 
-		ret = run_one_delayed_ref(trans, ref, extent_op,
-					  must_insert_reserved);
+		ret = run_one_delayed_ref(trans, locked_ref, ref,
+					  extent_op, must_insert_reserved);
 
 		btrfs_free_delayed_extent_op(extent_op);
 		if (ret) {
@@ -2873,11 +2902,12 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
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
@@ -2888,6 +2918,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
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
@@ -2990,6 +3026,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
+	u64 delayed_ref_root = node->owning_root;
 
 	extent_root = btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
@@ -3188,6 +3225,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
@@ -3226,6 +3271,16 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
@@ -3235,7 +3290,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
+		ret = do_free_extent_accounting(trans, bytenr, &delta);
 	}
 	btrfs_release_path(path);
 
@@ -4808,6 +4863,13 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
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
@@ -4836,6 +4898,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 					 offset, ins, 1);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
+	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
 	btrfs_put_block_group(block_group);
 	return ret;
 }
-- 
2.41.0

