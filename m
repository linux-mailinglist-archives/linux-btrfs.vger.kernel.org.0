Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0461579DD0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbjIMANW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMANV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77610F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F23BC32005D8;
        Tue, 12 Sep 2023 20:13:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 20:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563996; x=
        1694650396; bh=A1CND227lvobr1FHOClaSn0NRI2uCHMnUjt3w/a2+e0=; b=b
        mog5byj/4Ua9PuwFMG4v3ROtGGa8VdXMb+9oKBBfqjHEy8UNkH6dvSoLp4cyTP7S
        WKsKW3KEdMAxkQDKY+Eadl5KYDiyOncdXcJgosK+ybGTj+RSFi24kuXAqreN1BpC
        qoZg42h8Ok/ub/UpczKHy2JgoHA4fmkhbqy3ADaD97gvNjcpIqANi0S5RsXuWkYW
        Pd2CQffm1Ta9Bmn6z8XSoD/ABAWdfc+hgS+AMOWIqHuwUHRKGvjtGN/nwqYbSjOI
        b5DkPnNNBqRt8QZSRVifcCkAUdJnISFrmUexOdPgAmJUw6l/kTdUtLLAi4HFTWVV
        O3sDNZJ38NSFipvV3JrXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563996; x=1694650396; bh=A
        1CND227lvobr1FHOClaSn0NRI2uCHMnUjt3w/a2+e0=; b=uf+TDI1pg3CEC69Mr
        8TXfL3XFsiVF4ggwHCErV1iQdYhX2198TrT1vpRSRpANmcm+Z6Ki0e0Q2J+jmgIr
        Jtzs7Nmfxlfl6Non/nvJHM4wsyIsC7ldZ1ppkZvdI0T0nRcwhYKIYVHlfqWE/D5j
        NsXkCSduO57IrgnhIkXpyzaFEuSLqD7ikNy9Y5EK5gfJ0gjx2Pw5T8/rBnqnStTv
        +Ob0R6g9L/QcShCWWLulLIa52EbBQJEiLDtVZz4cabFw3DkZl2yPTSxn35er25KJ
        hHcXbb9rNHzvMYmlVREMrrSMbWZg/pczAu4fzoB+V3hBPQbFTBajWQv1HU6uZ8Pv
        UFKfQ==
X-ME-Sender: <xms:nP4AZSVCIhgncoqwKJ7jXDUJiYUbT325LBlsay8dAyHh5ZwqAIMLHQ>
    <xme:nP4AZemDFWbgPtLfqiQqgmCjIgdV1qkz36IM01CCERebCPgNcrOndSXjacy5PpDGs
    lbTTwhbgMjQiMnLiV4>
X-ME-Received: <xmr:nP4AZWbY2GuxHKo0_SrwGw0TxBG7gU9tba92hajcu97yxvvKseAx4aqJABiLgP9UUpw8rviRD62Hhm95FxWogmQK6sM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:nP4AZZUzq_TX1h-Q0mU6w-nKbmuZagdQ7qIZLwqo5vXabC7GvJBT3A>
    <xmx:nP4AZcmY3PycNR9P_KCm7K8Uv8IddatbZqCauOIYGFQTIXBh5XLfKw>
    <xmx:nP4AZec_ZIObUyblTQUwiTTqa3yVSd3F0J1j-qK1CXg-LhPSP1qCFw>
    <xmx:nP4AZTtcZl5pwRs7A2-oc6Ul4T98hdVrLi80GB2t-pDgAHVsmJB6qA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:15 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 13/18] btrfs: record simple quota deltas
Date:   Tue, 12 Sep 2023 17:13:24 -0700
Message-ID: <41b5b59ce38d17f9cbe3b77257a9716a3b8f12ea.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/btrfs/delayed-ref.h |  6 +++
 fs/btrfs/extent-tree.c | 85 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index b8ae48e8a63b..c6c3a4f67db7 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -802,6 +802,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->bytenr = bytenr;
 	head_ref->num_bytes = num_bytes;
 	head_ref->ref_mod = count_mod;
+	head_ref->reserved_bytes = reserved;
 	head_ref->must_insert_reserved = must_insert_reserved;
 	head_ref->owning_root = owning_root;
 	head_ref->is_data = is_data;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index faa2e000dadc..d2cc779e10a6 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -116,6 +116,12 @@ struct btrfs_delayed_ref_head {
 	 */
 	u64 owning_root;
 
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
index 249b3bfe181a..c399127f9918 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -47,6 +47,7 @@
 
 
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
+			       struct btrfs_delayed_ref_head *href,
 			       struct btrfs_delayed_ref_node *node, u64 parent,
 			       u64 root_objectid, u64 owner_objectid,
 			       u64 owner_offset,
@@ -1536,6 +1537,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 }
 
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
+				struct btrfs_delayed_ref_head *href,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
 				bool insert_reserved)
@@ -1553,6 +1555,13 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		struct btrfs_key key;
+		struct btrfs_squota_delta delta = {
+			.root = href->owning_root,
+			.num_bytes = node->num_bytes,
+			.rsv_bytes = href->reserved_bytes,
+			.is_data = true,
+			.is_inc	= true,
+		};
 
 		if (extent_op)
 			flags |= extent_op->flags_to_set;
@@ -1565,12 +1574,14 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 						 flags, ref->objectid,
 						 ref->offset, &key,
 						 node->ref_mod);
+		if (!ret)
+			ret = btrfs_record_squota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref->root,
 					     ref->objectid, ref->offset,
 					     extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
-		ret = __btrfs_free_extent(trans, node, parent,
+		ret = __btrfs_free_extent(trans, href, node, parent,
 					  ref->root, ref->objectid,
 					  ref->offset, extent_op);
 	} else {
@@ -1687,11 +1698,13 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
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
@@ -1711,13 +1724,23 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -EUCLEAN;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
+		struct btrfs_squota_delta delta = {
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
+			btrfs_record_squota_delta(fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
 					     ref->level, 0, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
-		ret = __btrfs_free_extent(trans, node, parent, ref_root,
+		ret = __btrfs_free_extent(trans, href, node, parent, ref_root,
 					  ref->level, 0, extent_op);
 	} else {
 		BUG();
@@ -1727,6 +1750,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 /* helper function to actually process a single delayed ref entry */
 static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
+			       struct btrfs_delayed_ref_head *href,
 			       struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       bool insert_reserved)
@@ -1741,12 +1765,12 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 
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
@@ -1847,6 +1871,11 @@ u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 
 		return btrfs_calc_delayed_ref_csum_bytes(fs_info, nr_csums);
 	}
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE &&
+	    head->must_insert_reserved && head->is_data)
+		btrfs_qgroup_free_refroot(fs_info, head->owning_root,
+					  head->reserved_bytes,
+					  BTRFS_QGROUP_RSV_DATA);
 
 	return 0;
 }
@@ -1995,10 +2024,11 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		locked_ref->extent_op = NULL;
 		spin_unlock(&locked_ref->lock);
 
-		ret = run_one_delayed_ref(trans, ref, extent_op,
-					  must_insert_reserved);
+		ret = run_one_delayed_ref(trans, locked_ref, ref,
+					  extent_op, must_insert_reserved);
 		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 		*bytes_released += btrfs_calc_delayed_ref_bytes(fs_info, 1);
+
 		btrfs_free_delayed_extent_op(extent_op);
 		if (ret) {
 			unselect_delayed_ref_head(delayed_refs, locked_ref);
@@ -2916,11 +2946,12 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
 }
 
 static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
-				     u64 bytenr, u64 num_bytes, bool is_data)
+				     u64 bytenr, struct btrfs_squota_delta *delta)
 {
 	int ret;
+	u64 num_bytes = delta->num_bytes;
 
-	if (is_data) {
+	if (delta->is_data) {
 		struct btrfs_root *csum_root;
 
 		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
@@ -2931,6 +2962,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	ret = btrfs_record_squota_delta(trans->fs_info, delta);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
 	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -3011,6 +3048,7 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
  * And that (13631488 EXTENT_DATA_REF <HASH>) gets removed.
  */
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
+			       struct btrfs_delayed_ref_head *href,
 			       struct btrfs_delayed_ref_node *node, u64 parent,
 			       u64 root_objectid, u64 owner_objectid,
 			       u64 owner_offset,
@@ -3034,6 +3072,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
+	u64 delayed_ref_root = href->owning_root;
 
 	extent_root = btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
@@ -3234,6 +3273,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 	} else {
+		struct btrfs_squota_delta delta = {
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
@@ -3272,6 +3319,16 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
@@ -3281,7 +3338,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
+		ret = do_free_extent_accounting(trans, bytenr, &delta);
 	}
 	btrfs_release_path(path);
 
@@ -4857,6 +4914,13 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	int ret;
 	struct btrfs_block_group *block_group;
 	struct btrfs_space_info *space_info;
+	struct btrfs_squota_delta delta = {
+		.root = root_objectid,
+		.num_bytes = ins->offset,
+		.rsv_bytes = 0,
+		.is_data = true,
+		.is_inc = true,
+	};
 
 	/*
 	 * Mixed block groups will exclude before processing the log so we only
@@ -4885,6 +4949,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 					 offset, ins, 1);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
+	ret = btrfs_record_squota_delta(fs_info, &delta);
 	btrfs_put_block_group(block_group);
 	return ret;
 }
-- 
2.41.0

