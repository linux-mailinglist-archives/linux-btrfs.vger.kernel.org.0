Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE079DD0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbjIMAN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMAN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:27 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CAD10F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4C5A432005D8;
        Tue, 12 Sep 2023 20:13:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 20:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694564001; x=
        1694650401; bh=ii2WWIkNvtrK1HXOr7zA7xTNGGHgx33IdLKX8NKBrC8=; b=b
        HOgY54boPSk7A+ixcy7v7EP7ZfjeQNA0zhilHjweDF/QySj7F5W94CKdrl/4/SN0
        6XlrvrtTLxK67+88WzL8j05ris4MZX9kI0r2Su5D5b0i0zRYCi129xgFEWVkVKh9
        5B7M1UP0jzwtvuaqMniC93a7zn6Wt4L6YYIKkwzxgPt+2SoSAiS2pxPkQEi5sSpI
        24T7tkMOgoaVJEEZC/yqZPZmTMCbQ084wVrMcVVjeVNJ9RUJMXBVFmMNvqXpUacE
        RvqTBq/RGcRc83Um1hMWKoAOmlV7Ib1EYmn5qcNvpLxNnBTlrkCvfImtI4+7yqG/
        I3iUnI+hoQc8J7hXiNIkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694564001; x=1694650401; bh=i
        i2WWIkNvtrK1HXOr7zA7xTNGGHgx33IdLKX8NKBrC8=; b=d3Fs2FzngTltnW76R
        vyuvTa5nZXH44WVpcMPUL5z248BQH95x9MsGhwDnqo2UbjiGqgnxWi7Rhu2wJluD
        W7fQ7Is2aTrjrM+CfcDBildnw7QWNOG9K7zbJBTggHfswpvKgBKDEVswc3o8re/i
        BiSrv1B9rJMefg810js0+ffE2JGNFonB0xciuYUjy7MRDI0oCUYTdiuJEgc3f8OI
        JwLvjZ35z/+c3hvEWvKlDyNgPkW3949S4XpawqM9/iE762BPUgsLj0xZMCMIsEsR
        mQUuA0AgiacLVxebO1TKmi/uSqwGVpcZULz4hZW+tmxdU6xrUzkhFmQCKFT9SAxW
        RdNvw==
X-ME-Sender: <xms:of4AZWptCJMuweLqiYyMcqHJKpJrLYHEPwnO_T2RFrEAgwyix9i-4w>
    <xme:of4AZUrukT5rHBrf2xriLiQGAFWGTKKuf-xgZswJegkBg1k1-WD_bOwjdKcldWhjc
    duQBQewjeaHVsnJI6s>
X-ME-Received: <xmr:of4AZbNJ0Y9ChL4r0DR53Ee4jbeDxY9EFIxVNbzYtE1KnQztkYZHhuSH4OEM5G5GtpldRP7sLmTVafT_H1MKjC8-EAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:of4AZV6fOrRPDOdOclOsymetdpNcIu7pL9iM-7MEacz2ggDSja4Ngw>
    <xmx:of4AZV4TEBM8rpvbMBnisjYXK7e_K-5UvitldzNYPCfs-OP7xNPcHw>
    <xmx:of4AZVhPzW5Yhaeb4HXwLgrmyoCCKzuZhusVQKE16sm2dkagYJcGEQ>
    <xmx:of4AZSjK7IJkBtGcGtqJwxfUbf60Kj8f2BjWM4rkJmP1Wy3UPsTUQg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:21 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 15/18] btrfs: check generation when recording simple quota delta
Date:   Tue, 12 Sep 2023 17:13:26 -0700
Message-ID: <5d8f271d9040cf02fca6dbfce348c7edc9e66dd5.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simple quotas count extents only from the moment the feature is enabled.
Therefore, if we do something like:
1. create subvol S
2. write F in S
3. enable quotas
4. remove F
5. write G in S

then after 3. and 4. we would expect the simple quota usage of S to be 0
(putting aside some metadata extents that might be written) and after
5., it should be the size of G plus metadata. Therefore, we need to be
able to determine whether a particular quota delta we are processing
predates simple quota enablement.

To do this, store the transaction id when quotas were enabled. In
fs_info for immediate use and in the quota status item to make it
recoverable on mount. When we see a delta, check if the generation of
the extent item is less than that of quota enablement. If so, we should
ignore the delta from this extent.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/accessors.h            |  2 ++
 fs/btrfs/extent-tree.c          |  4 ++++
 fs/btrfs/fs.h                   |  1 +
 fs/btrfs/qgroup.c               | 28 ++++++++++++++++++++++------
 fs/btrfs/qgroup.h               |  2 ++
 include/uapi/linux/btrfs_tree.h |  9 +++++++++
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index ad8aa1ae5c0c..5c5f89079b9a 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -971,6 +971,8 @@ BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
 		   flags, 64);
 BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
 		   rescan, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_enable_gen, struct btrfs_qgroup_status_item,
+		   enable_gen, 64);
 
 /* btrfs_qgroup_info_item */
 BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c399127f9918..8d16f7b4786d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1561,6 +1561,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = href->reserved_bytes,
 			.is_data = true,
 			.is_inc	= true,
+			.generation = trans->transid,
 		};
 
 		if (extent_op)
@@ -1730,6 +1731,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = false,
 			.is_inc = true,
+			.generation = trans->transid,
 		};
 
 		BUG_ON(!extent_op || !extent_op->update_flags);
@@ -3279,6 +3281,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = is_data,
 			.is_inc = false,
+			.generation = btrfs_extent_generation(leaf, ei),
 		};
 
 		/* In this branch refs == 1 */
@@ -4917,6 +4920,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_squota_delta delta = {
 		.root = root_objectid,
 		.num_bytes = ins->offset,
+		.generation = trans->transid,
 		.rsv_bytes = 0,
 		.is_data = true,
 		.is_inc = true,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 49fdac7dfd07..ea72240c0554 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -679,6 +679,7 @@ struct btrfs_fs_info {
 	/* Protected by qgroup_rescan_lock */
 	bool qgroup_rescan_running;
 	u8 qgroup_drop_subtree_thres;
+	u64 qgroup_enable_gen;
 
 	/*
 	 * If this is not 0, then it indicates a serious filesystem error has
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1b41686f934f..759395e83f9e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -379,6 +379,15 @@ static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
 				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
 }
 
+static void qgroup_read_enable_gen(struct btrfs_fs_info *fs_info,
+				   struct extent_buffer *leaf, int slot,
+				   struct btrfs_qgroup_status_item *ptr)
+{
+	ASSERT(btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+	ASSERT(btrfs_item_size(leaf, slot) >= sizeof(*ptr));
+	fs_info->qgroup_enable_gen = btrfs_qgroup_status_enable_gen(leaf, ptr);
+}
+
 /*
  * The full config is read in one go, only called from open_ctree()
  * It doesn't use any locking, as at this point we're still single-threaded
@@ -394,7 +403,6 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 	u64 flags = 0;
 	u64 rescan_progress = 0;
-	bool simple;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		return 0;
@@ -447,9 +455,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				goto out;
 			}
 			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
-			simple = (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE);
-			if (btrfs_qgroup_status_generation(l, ptr) !=
-			    fs_info->generation && !simple) {
+			if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE) {
+				qgroup_read_enable_gen(fs_info, l, slot, ptr);
+			} else if (btrfs_qgroup_status_generation(l, ptr) != fs_info->generation) {
 				qgroup_mark_inconsistent(fs_info);
 				btrfs_err(fs_info,
 					"qgroup generation mismatch, marked as inconsistent");
@@ -1113,10 +1121,12 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
-	if (simple)
+	if (simple) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
-	else
+		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
+	} else {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	}
 	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
 				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
@@ -1220,6 +1230,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 		goto out_free_path;
 	}
 
+	fs_info->qgroup_enable_gen = trans->transid;
+
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	/*
 	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
@@ -4666,6 +4678,10 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 	if (!is_fstree(root))
 		return 0;
 
+	/* If the extent predates enabling quotas, don't count it. */
+	if (delta->generation < fs_info->qgroup_enable_gen)
+		return 0;
+
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = find_qgroup_rb(fs_info, root);
 	if (!qgroup) {
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 126a599c7349..25200b5f6ed3 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -276,6 +276,8 @@ struct btrfs_squota_delta {
 	u64 num_bytes;
 	/* The number of bytes reserved for this extent */
 	u64 rsv_bytes;
+	/* The generation the extent was created in */
+	u64 generation;
 	/* Whether we are using or freeing the extent */
 	bool is_inc;
 	/* Whether the extent is data or metadata */
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e60b62c1627e..7844c28846d1 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1248,6 +1248,15 @@ struct btrfs_qgroup_status_item {
 	 * of the scan. It contains a logical address
 	 */
 	__le64 rescan;
+
+	/*
+	 * the generation when quotas were last enabled. Used by simple quotas to
+	 * avoid decrementing when freeing an extent that was written before
+	 * enable.
+	 *
+	 * Set iff flags contains BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE.
+	 */
+	__le64 enable_gen;
 } __attribute__ ((__packed__));
 
 struct btrfs_qgroup_info_item {
-- 
2.41.0

