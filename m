Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3046A6F4E3E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjECA77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 20:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECA75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 20:59:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895F2D69
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 35F185C0310;
        Tue,  2 May 2023 20:59:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 May 2023 20:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075594; x=
        1683161994; bh=StCgSaAGnttN7o4lvZdFJjTNKXiMfeCw1hb8kRfr0+w=; b=T
        xt9JsqOndzWBGw1q9WC8fNemriZZxuO6N8UaULNgNhZCli8qETgwzVZBdt2GcHIg
        iOVXPGpy4Zo0OozzzJNA0u69zsw48Uv4bAPJ7JUpOOnyVQEVRVhwu6XTK6CqB8+w
        R30Of4AlBycbEUur7Jl2E5Z9WJbGlV9dD/YlgOQsFucieuEdCfZz7nJxD46Ygn30
        giN3Nfq+T1nfcGu/mxeWo2oW3iETXiU/YGER8s48mVf9EY8J9HsWpFcYUWlgCG0o
        8Gl9/V711i8LdtD0fE488BXZ3zoPquqPQGsUuyGlGQe8Grrut9TVIbLxc08bFI4z
        rmv6tHDTxnOaKGSRa03Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075594; x=1683161994; bh=S
        tCgSaAGnttN7o4lvZdFJjTNKXiMfeCw1hb8kRfr0+w=; b=HCwjsS8+Jvh1Je1jo
        1r9s4SVZdHBZ/IbDdPMwCldarho4fimDWcLJk/oQrWuq5y7BhCHMsOj/ZxA2PwBz
        OsX9vlyGO8eWpeWVN3smX1rfXs4VJPnP2NBSdpJcqzvZOk/qfzXv7xt+vrY+fVDz
        blVitLGblwEhH2bgtPVqi0i/UOq5o49J/19rGqth5vKv2Ljz/7/9wp1BNaJiz192
        A5giYAN3t04JLA8ukm6UNqA9KE1RHfQvTa6+ggHq42WyCOecyDr7cc91n3EDMWlu
        oXoMP3/lcf7JSbX0DARxJnRxbiI8ijwx0/kFtaRD2HtBL9mBBEYMkp/98Bdy8LxP
        Ck05w==
X-ME-Sender: <xms:CrJRZCVnv3H_jd98TaPn4g1Un_D8fFSXiWRkZHbXqFC_SiDbd8YibQ>
    <xme:CrJRZOlEPNn7Pic37dH35UkNNBlhwXR6BdpUhyDk0NNHyAFy0MEHUe4XtuSM4Q1cY
    qCYA6t88Xe3NMpXuLM>
X-ME-Received: <xmr:CrJRZGYFvzBmROAo8SwYrPp3KGy9PHBsj-rag9YDEKCmmyg5lL4s4tUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:CrJRZJVcGhPcCSDSLKC35pAix4LrmPa3slVV7u1kaUeGZKpAxJMIuQ>
    <xmx:CrJRZMkNB52-gGTKIbQpHhjJUHQxH8aLwqCNykfuS1dff3bJBACRdw>
    <xmx:CrJRZOcQlrZAIj1KMO1QE9AguGIlvZWLbG5LSoR1eR5pVPgE93pt6Q>
    <xmx:CrJRZDspBTfYpZMUJCaGukPXdpYTlvUH1uhMwWaHZAeI9gtLQBAQeg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:53 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: record simple quota deltas
Date:   Tue,  2 May 2023 17:59:26 -0700
Message-Id: <c3bea347b06870dfabe66458e2ec3582c749dc9c.1683075170.git.boris@bur.io>
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-ref.c |  6 ++++
 fs/btrfs/delayed-ref.h | 12 +++++++
 fs/btrfs/extent-tree.c | 82 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/qgroup.c      | 11 +++---
 fs/btrfs/qgroup.h      |  2 ++
 fs/btrfs/transaction.c |  5 +++
 6 files changed, 106 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f4c01965e1ea..c06e5c8bcdc1 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -732,6 +732,12 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->bytenr = bytenr;
 	head_ref->num_bytes = num_bytes;
 	head_ref->ref_mod = count_mod;
+	head_ref->ref_root = 0;
+	head_ref->reserved_bytes = 0;
+	if (ref_root && reserved) {
+		head_ref->ref_root = ref_root;
+		head_ref->reserved_bytes = reserved;
+	}
 	head_ref->must_insert_reserved = must_insert_reserved;
 	head_ref->is_data = is_data;
 	head_ref->is_system = is_system;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 427de8a25eb2..64aba4601de4 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -107,6 +107,18 @@ struct btrfs_delayed_ref_head {
 	 */
 	int ref_mod;
 
+	/*
+	 * Track the root which accounted for the reservation relevant to
+	 * must_insert_reserved. In simple quota mode, we need to drop
+	 * reservations for such head refs when we drop delayed refs.
+	 */
+	u64 ref_root;
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
index c821d22be2ca..7379ee04018d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1506,6 +1506,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 }
 
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
+				struct btrfs_delayed_ref_head *href,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
 				int insert_reserved)
@@ -1529,12 +1530,23 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	ref_root = ref->root;
 
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
+		struct btrfs_simple_quota_delta delta = {
+			.root = ref_root,
+			.num_bytes = node->num_bytes,
+			.rsv_root = href->ref_root,
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
@@ -1661,6 +1673,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 				int insert_reserved)
 {
 	int ret = 0;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_tree_ref *ref;
 	u64 parent = 0;
 	u64 ref_root = 0;
@@ -1680,8 +1693,19 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -EIO;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
+		struct btrfs_simple_quota_delta delta = {
+			.root = ref_root,
+			.num_bytes = fs_info->nodesize,
+			.rsv_root = 0,
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
@@ -1696,6 +1720,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 /* helper function to actually process a single delayed ref entry */
 static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
+			       struct btrfs_delayed_ref_head *href,
 			       struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       int insert_reserved)
@@ -1714,8 +1739,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
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
@@ -1812,6 +1837,11 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 		spin_unlock(&delayed_refs->lock);
 		nr_items += btrfs_csum_bytes_to_leaves(fs_info, head->num_bytes);
 	}
+	if (head->must_insert_reserved && head->is_data &&
+	    btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		btrfs_qgroup_free_refroot(fs_info, head->ref_root,
+					  head->reserved_bytes,
+					  BTRFS_QGROUP_RSV_DATA);
 
 	btrfs_delayed_refs_rsv_release(fs_info, nr_items);
 }
@@ -1959,8 +1989,8 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		locked_ref->extent_op = NULL;
 		spin_unlock(&locked_ref->lock);
 
-		ret = run_one_delayed_ref(trans, ref, extent_op,
-					  must_insert_reserved);
+		ret = run_one_delayed_ref(trans, locked_ref, ref,
+					  extent_op, must_insert_reserved);
 
 		btrfs_free_delayed_extent_op(extent_op);
 		if (ret) {
@@ -2826,11 +2856,12 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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
@@ -2841,6 +2872,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
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
@@ -2936,6 +2973,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
+	u64 delayed_ref_root = node->allocation_owning_root;
 
 	extent_root = btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
@@ -3133,6 +3171,16 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 	} else {
+		struct btrfs_extent_owner_ref *oref;
+		struct btrfs_simple_quota_delta delta = {
+			.root = delayed_ref_root,
+			.num_bytes = num_bytes,
+			.rsv_root = 0,
+			.rsv_bytes = 0,
+			.is_data = is_data,
+			.is_inc = false,
+		};
+
 		/* In this branch refs == 1 */
 		if (found_extent) {
 			if (is_data && refs_to_drop !=
@@ -3170,6 +3218,26 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
+		if (is_data && btrfs_fs_incompat(trans->fs_info, SIMPLE_QUOTA)) {
+			struct btrfs_extent_inline_ref *owning_iref;
+			int type;
+
+			owning_iref = (struct btrfs_extent_inline_ref *)(ei + 1);
+			type = btrfs_get_extent_inline_ref_type(leaf, owning_iref,
+								BTRFS_REF_TYPE_ANY);
+			if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
+				oref = (struct btrfs_extent_owner_ref *)(&owning_iref->offset);
+				delta.root = btrfs_extent_owner_ref_root_id(leaf, oref);
+			}
+		}
 
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
@@ -3179,7 +3247,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
+		ret = do_free_extent_accounting(trans, bytenr, &delta);
 	}
 	btrfs_release_path(path);
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8982b76ae9e5..e3d0630fef0c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1655,6 +1655,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_qgroup *qgroup;
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
+		return 0;
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
@@ -4520,7 +4523,6 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
 	struct ulist_iterator uiter;
 	struct ulist_node *unode;
 	struct btrfs_qgroup *qg;
-	bool drop_rsv = false;
 	u64 root = delta->root;
 	u64 num_bytes = delta->num_bytes;
 	int sign = delta->is_inc ? 1 : -1;
@@ -4546,14 +4548,13 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
 		qg = unode_aux_to_qgroup(unode);
 		qg->excl += num_bytes * sign;
 		qg->rfer += num_bytes * sign;
-		if (delta->is_inc && delta->is_data)
-			drop_rsv = true;
 		qgroup_dirty(fs_info, qg);
 	}
 
 out:
 	spin_unlock(&fs_info->qgroup_lock);
-	if (!ret && drop_rsv)
-		btrfs_qgroup_free_refroot(fs_info, root, num_bytes, BTRFS_QGROUP_RSV_DATA);
+	if (!ret && delta->rsv_bytes && delta->rsv_root)
+		btrfs_qgroup_free_refroot(fs_info, delta->rsv_root,
+					  delta->rsv_bytes, BTRFS_QGROUP_RSV_DATA);
 	return ret;
 }
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 0d627a871900..b300998dcbc7 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -238,6 +238,8 @@ struct btrfs_qgroup {
 struct btrfs_simple_quota_delta {
 	u64 root; /* The fstree root this delta counts against */
 	u64 num_bytes; /* The number of bytes in the extent being counted */
+	u64 rsv_root; /* The fstree root this delta should free rsv for */
+	u64 rsv_bytes; /* The number of bytes reserved for this extent */
 	bool is_inc; /* Whether we are using or freeing the extent */
 	bool is_data; /* Whether the extent is data or metadata */
 };
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e6d6752c2fca..0edfb58afd80 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1704,6 +1704,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
+	ret = btrfs_create_qgroup(trans, objectid);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 	/*
 	 * pull in the delayed directory update
 	 * and the delayed inode item
-- 
2.40.0

