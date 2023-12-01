Return-Path: <linux-btrfs+bounces-480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E08518014E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FC1B21114
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6735A106;
	Fri,  1 Dec 2023 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RIeDjFm1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="12d1+N7Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FE412A
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:59:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 013855C00CB;
	Fri,  1 Dec 2023 15:59:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 01 Dec 2023 15:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1701464346; x=
	1701550746; bh=bY5hgXS7HK/qiu6LG36iWyufVoqx8JfjZQqIT6n6Y4g=; b=R
	IeDjFm1CY3gSuemb8IDvANsQrbIbEhdQYeF4V5FVdqiPUvWFjHwbZ7i8k8d9bu6w
	jWfibYhyB6sD4x1I0pO1FTp1CehVyxD4Y2qRUYU9/GTknFdiAONxwJRQBNs0Ihyl
	7y0bgqmjgjJeZJLywOxiHwReAPe3htO2GmYf4KA5nhd94Q9YeoM+M8tvnLDO6SXc
	vwm1t1sM6TeSb/kNaR77kn9nbIut5Gu0qcFT4j28+h/BW7o1E03naUok3JvxGIza
	v47VKPyEx6/wIh51lCQgOgsfOim1eSy3Yy5G2l0+hwN2TjbH59r4MHvzbPf3RnTq
	7EQyX0zVMQQv2e2Tz944A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1701464346; x=1701550746; bh=b
	Y5hgXS7HK/qiu6LG36iWyufVoqx8JfjZQqIT6n6Y4g=; b=12d1+N7QfS54LeffN
	ozr+C9WQA6vuTToCpfYT4EXprvsed4QFvCcAWI1gFmlcDL52mpxNUBKn6QlCoIYg
	xz/7BI6Eses36/Ut/b8bpfWfpAeEpJwx1bFXzzNpYPKZ7Jz+6OxsFT6JGZZ8WIWN
	/n2jVJOE7NZCcn4WAHJURBvzuYV33blUvzz2RHJt8kIfIccwulQbN2Sf3tUm5J7L
	72mjAn17SiuCMCzgpPUHgMLVDAY6RmYjNNmb1KCfI1UddXZLPNS+77lZxeo+sUyp
	xnlcfrDtq5gMw6hLuiQQVimQSUx0DHefPXARZnCZQhx+POS5b5S6c3nRXkrVrkjw
	PpZJQ==
X-ME-Sender: <xms:GklqZX27zRDNYsoVDq6l-YZ3Lov7ke6TX2cjiCV5bg2QMD7IQCQ6AQ>
    <xme:GklqZWE-PYOf4idnVRipTnp9QVRIssZ0OUm42ZR1bw598iyxi5Uc-tBW7WFgiy9gn
    eAG67WfgWZmi5zuP-Q>
X-ME-Received: <xmr:GklqZX4N632N9k1x8xL44OlH1ZVuznhBumYK1D7RWxet7qv48WIa5vRgVu1YJmP3Weh2r2ZMjTeBnMUZX5Vzsmbd3m4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:GklqZc1eP8Qqeh3UFz1t1QKfhQ5SA7MKDKBCgjOaAwhRfMv2ewPPuw>
    <xmx:GklqZaFPZ-X4VpyaSigmG5Pvt9pjPEouEq3y_zcR4GQPHfpLVImhkA>
    <xmx:GklqZd8p2gXDMZkYdPYeERuVq40IAGVfaEv0T_Wsu05zlrZWQfDSPg>
    <xmx:GklqZVMcMZaCQPXsn9ksLU3ngg7KaHo8Alh5jbTOtI0pQtmA9kNOAA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:59:06 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: ensure releasing squota rsv on head refs
Date: Fri,  1 Dec 2023 13:00:13 -0800
Message-ID: <451f3bf7c437690326036d84bf43bf32c9887ebd.1701464169.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701464169.git.boris@bur.io>
References: <cover.1701464169.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A reservation goes through a 3 step lifetime:
- generated during delalloc
- released/counted by ordered_extent allocation
- freed by running delayed ref

That third step depends on must_insert_reserved on the head ref, so the
head ref with that field set owns the reservation. Once you prepare to
run the head ref, must_insert_reserved is unset, which means that
running the ref must free the reservation, whether or not it succeeds,
or else the reservation is leaked. That results in either a risk of
spurious ENOSPC if the fs stays writeable or a warning on unmount if it
is readonly.

The existing squota code was aware of these invariants, but missed a few
cases. Improve it by adding a helper function to use in the cleanup
paths and call it from the existing early returns in running delayed
refs. This also simplifies btrfs_record_squota_delta and struct
btrfs_quota_delta.

This fixes (or at least improves the reliability of) generic/475 with
mkfs -O squota. On my machine, that test failed ~4/10 times without this
patch and passed 100/100 times with it.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c | 47 +++++++++++++++++++++++++++++-------------
 fs/btrfs/qgroup.c      | 16 +++++++++++---
 fs/btrfs/qgroup.h      |  4 ++--
 3 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 008c4c77a847..e41251c08190 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1547,6 +1547,23 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static void free_head_ref_squota_rsv(struct btrfs_fs_info *fs_info,
+				     struct btrfs_delayed_ref_head *href)
+{
+	u64 root = href->owning_root;
+
+	/*
+	 * Don't check must_insert_reserved, as this is called from contexts
+	 * where it has already been unset.
+	 */
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE ||
+	    !href->is_data || !is_fstree(root))
+		return;
+
+	btrfs_qgroup_free_refroot(fs_info, root, href->reserved_bytes,
+				  BTRFS_QGROUP_RSV_DATA);
+}
+
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_ref_head *href,
 				struct btrfs_delayed_ref_node *node,
@@ -1569,7 +1586,6 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		struct btrfs_squota_delta delta = {
 			.root = href->owning_root,
 			.num_bytes = node->num_bytes,
-			.rsv_bytes = href->reserved_bytes,
 			.is_data = true,
 			.is_inc	= true,
 			.generation = trans->transid,
@@ -1586,11 +1602,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 						 flags, ref->objectid,
 						 ref->offset, &key,
 						 node->ref_mod, href->owning_root);
+		free_head_ref_squota_rsv(trans->fs_info, href);
 		if (!ret)
 			ret = btrfs_record_squota_delta(trans->fs_info, &delta);
-		else
-			btrfs_qgroup_free_refroot(trans->fs_info, delta.root,
-						  delta.rsv_bytes, BTRFS_QGROUP_RSV_DATA);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref->root,
 					     ref->objectid, ref->offset,
@@ -1742,7 +1756,6 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		struct btrfs_squota_delta delta = {
 			.root = href->owning_root,
 			.num_bytes = fs_info->nodesize,
-			.rsv_bytes = 0,
 			.is_data = false,
 			.is_inc = true,
 			.generation = trans->transid,
@@ -1774,8 +1787,10 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 	int ret = 0;
 
 	if (TRANS_ABORTED(trans)) {
-		if (insert_reserved)
+		if (insert_reserved) {
 			btrfs_pin_extent(trans, node->bytenr, node->num_bytes, 1);
+			free_head_ref_squota_rsv(trans->fs_info, href);
+		}
 		return 0;
 	}
 
@@ -1871,6 +1886,8 @@ u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 				  struct btrfs_delayed_ref_root *delayed_refs,
 				  struct btrfs_delayed_ref_head *head)
 {
+	u64 ret = 0;
+
 	/*
 	 * We had csum deletions accounted for in our delayed refs rsv, we need
 	 * to drop the csum leaves for this update from our delayed_refs_rsv.
@@ -1885,14 +1902,13 @@ u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 
 		btrfs_delayed_refs_rsv_release(fs_info, 0, nr_csums);
 
-		return btrfs_calc_delayed_ref_csum_bytes(fs_info, nr_csums);
+		ret = btrfs_calc_delayed_ref_csum_bytes(fs_info, nr_csums);
 	}
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE &&
-	    head->must_insert_reserved && head->is_data)
-		btrfs_qgroup_free_refroot(fs_info, head->owning_root,
-					  head->reserved_bytes, BTRFS_QGROUP_RSV_DATA);
+	/* must_insert_reserved can be set only if we didn't run the head ref */
+	if (head->must_insert_reserved)
+		free_head_ref_squota_rsv(fs_info, head);
 
-	return 0;
+	return ret;
 }
 
 static int cleanup_ref_head(struct btrfs_trans_handle *trans,
@@ -2033,6 +2049,11 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		 * spin lock.
 		 */
 		must_insert_reserved = locked_ref->must_insert_reserved;
+		/*
+		 * Unsetting this on the head ref relinquishes ownership of
+		 * the rsv_bytes, so it is critical that every possible code
+		 * path from here forward frees all rsv including qgroup rsv.
+		 */
 		locked_ref->must_insert_reserved = false;
 
 		extent_op = locked_ref->extent_op;
@@ -3292,7 +3313,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		struct btrfs_squota_delta delta = {
 			.root = delayed_ref_root,
 			.num_bytes = num_bytes,
-			.rsv_bytes = 0,
 			.is_data = is_data,
 			.is_inc = false,
 			.generation = btrfs_extent_generation(leaf, ei),
@@ -4935,7 +4955,6 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 		.root = root_objectid,
 		.num_bytes = ins->offset,
 		.generation = trans->transid,
-		.rsv_bytes = 0,
 		.is_data = true,
 		.is_inc = true,
 	};
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index daec90342dad..9576d77f6f6a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4661,6 +4661,19 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 	*root = RB_ROOT;
 }
 
+void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info,
+			   u64 root, u64 rsv_bytes)
+{
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
+		return;
+
+	if (!is_fstree(root))
+		return;
+
+	btrfs_qgroup_free_refroot(fs_info, root, rsv_bytes,
+				  BTRFS_QGROUP_RSV_DATA);
+}
+
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta)
 {
@@ -4705,8 +4718,5 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 
 out:
 	spin_unlock(&fs_info->qgroup_lock);
-	if (!ret && delta->rsv_bytes)
-		btrfs_qgroup_free_refroot(fs_info, root, delta->rsv_bytes,
-					  BTRFS_QGROUP_RSV_DATA);
 	return ret;
 }
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 15b485506104..3dbb4095d2f2 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -274,8 +274,6 @@ struct btrfs_squota_delta {
 	u64 root;
 	/* The number of bytes in the extent being counted. */
 	u64 num_bytes;
-	/* The number of bytes reserved for this extent. */
-	u64 rsv_bytes;
 	/* The generation the extent was created in. */
 	u64 generation;
 	/* Whether we are using or freeing the extent. */
@@ -422,6 +420,8 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
+void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info,
+			   u64 root, u64 rsv_bytes);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta);
 
-- 
2.42.0


