Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2757491D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGEXX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGEXXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E6171A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B6AA05C0283;
        Wed,  5 Jul 2023 19:23:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Jul 2023 19:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599410; x=
        1688685810; bh=8lAK8TLx1DpHNqHscJ9rV3z2fS9NQS09/y7fRQguPlo=; b=Z
        d4o9UXUDUt/Gkl1cxrQlq699YftWVccUEWtG47LiLIcONX6IT4cdgNhLudjYv5ET
        3rIrNJS6Fi+U4QdJegqLx8piAIVWrTxvdbznb2yGe+/iHG4pav57TAWG1R8rVH7T
        nEqTZjUPvkQAkiEIEqZnOjO6jJBn2Tc4AJP3qBenuJiOC24rWYJiiOz6Y52jn0ER
        Clxtpq88JGqQO0dJu4yoqc102X4GRxqdAQQh6kRCcu1D5U+R/yZ9R29FKoLd9fHm
        labPzUS2OjWUSMCc/4//Wv4yLyMlN/UQtPygDGupBY1mAv3Lwic9bU5RBJd56pxU
        ZvLxAHFQHRi3jbxv9NZ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599410; x=1688685810; bh=8
        lAK8TLx1DpHNqHscJ9rV3z2fS9NQS09/y7fRQguPlo=; b=JD7BIgFctvMPsXE2V
        hsJsf+Hzb4OPkkeaQT1JIyB2bmOvYcMS5JmvRe5bhAXfueTxmKdKgmVAdcT5NZIM
        KzoyA6Gg6Rt1oG2ARlYB0tdBrwG6BxOkPSEbQB8Iho5hpb+FaSHpvJ1flmkVAI2i
        s84kDGkQo4e7vA9XNakgeO3rhELi59H+7KkcD8uH/wRJmm85+5XiSh1dfSrl7SEZ
        FXfDOATp5sS+Sp5vGQQNJDvOLiOlmusJErO7lMiEU0W8DnicgDWzHaERNEzRq7ae
        bi4A41HR6bf2VMZMUM4WKSHs88Y3iGh8koeR09N/4soG6EjtVo2ek7PFT2wlQizJ
        JgMMg==
X-ME-Sender: <xms:cvulZEoxzd7YNTHjCLgrDo4mSwMPhQDpC3c4mHEe85FqtEh_ejF1UA>
    <xme:cvulZKqU1BvjlGcrCd0GVK1FCAAGJAIhMmRToor3CCo-CRPFuKStzAO4jIfOJ1FGx
    B6NG7MijNjaxdYNzbo>
X-ME-Received: <xmr:cvulZJNgLEeS7bcev5j0Xeh9kdrLwczNBkZjSb_VMgS5yDl4y4j4GRQ-rmTvpOzZRosDL0O2pGAMqOL-YI_8yDW-fhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:cvulZL6cEPP3hakJZwha3H9DYwnjFvoOls6pq7pf57HiLASkBaEWSA>
    <xmx:cvulZD41UeoMF04y9UluLOXIgFqL_jKHSRKNSIwPvTJLALWk8QTw0Q>
    <xmx:cvulZLj7dxRs0vmzgpxzkSkEo7_rG9tpuYAE7ewCA9H_MKQCN9lzMw>
    <xmx:cvulZAjdPydtSK-YUGuZtwVltr2WUBFtqGROC7zI1eiptDqbVUOAtA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:30 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/18] btrfs: check generation when recording simple quota delta
Date:   Wed,  5 Jul 2023 16:20:53 -0700
Message-ID: <53936613c2fc11671997383e1f5a5b5878687784.1688597211.git.boris@bur.io>
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
 fs/btrfs/fs.h                   |  2 ++
 fs/btrfs/qgroup.c               | 17 +++++++++++++----
 fs/btrfs/qgroup.h               |  1 +
 include/uapi/linux/btrfs_tree.h |  7 +++++++
 6 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index aab61312e4e8..8d122cc42cb7 100644
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
index c8914c66dc83..3cd1d24f1146 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1533,6 +1533,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = href->reserved_bytes,
 			.is_data = true,
 			.is_inc	= true,
+			.generation = trans->transid,
 		};
 
 		if (extent_op)
@@ -1696,6 +1697,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = false,
 			.is_inc = true,
+			.generation = trans->transid,
 		};
 
 		BUG_ON(!extent_op || !extent_op->update_flags);
@@ -3231,6 +3233,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = is_data,
 			.is_inc = false,
+			.generation = btrfs_extent_generation(leaf, ei),
 		};
 
 		/* In this branch refs == 1 */
@@ -4866,6 +4869,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_simple_quota_delta delta = {
 		.root = root_objectid,
 		.num_bytes = ins->offset,
+		.generation = trans->transid,
 		.rsv_bytes = 0,
 		.is_data = true,
 		.is_inc = true,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f76f450c2abf..da7b623ff15f 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -802,6 +802,8 @@ struct btrfs_fs_info {
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
 #endif
+
+	u64 quota_enable_gen;
 };
 
 static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6714c5aeb4e1..c9bedd2e6451 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -468,8 +468,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				btrfs_err(fs_info,
 					"qgroup generation mismatch, marked as inconsistent");
 			}
-			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l,
-									  ptr);
+			if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
+				fs_info->quota_enable_gen = btrfs_qgroup_status_enable_gen(l, ptr);
+			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
 			rescan_progress = btrfs_qgroup_status_rescan(l, ptr);
 			goto next1;
 		}
@@ -1115,6 +1116,10 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	ptr = btrfs_item_ptr(leaf, path->slots[0],
 				 struct btrfs_qgroup_status_item);
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
+	if (simple) {
+		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
+		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
+	}
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
 	if (!simple)
@@ -1210,6 +1215,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 		goto out_free_path;
 	}
 
+	fs_info->quota_enable_gen = trans->transid;
+
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	/*
 	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
@@ -1234,8 +1241,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->qgroup_lock);
 	fs_info->quota_root = quota_root;
 	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	if (simple)
-		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 	spin_unlock(&fs_info->qgroup_lock);
 
 	/* Skip rescan for simple qgroups */
@@ -4629,6 +4634,10 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
 	if (!is_fstree(root))
 		return 0;
 
+	/* If the extent predates enabling quotas, don't count it. */
+	if (delta->generation < fs_info->quota_enable_gen)
+		return 0;
+
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = find_qgroup_rb(fs_info, root);
 	if (!qgroup) {
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index ce6fa8694ca7..ae1ce14b365c 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -241,6 +241,7 @@ struct btrfs_simple_quota_delta {
 	u64 rsv_bytes; /* The number of bytes reserved for this extent */
 	bool is_inc; /* Whether we are using or freeing the extent */
 	bool is_data; /* Whether the extent is data or metadata */
+	u64 generation; /* The generation the extent was created in */
 };
 
 static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 424c7f342712..7797560f0215 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1230,6 +1230,13 @@ struct btrfs_qgroup_status_item {
 	 * of the scan. It contains a logical address
 	 */
 	__le64 rescan;
+
+	/*
+	 * the generation when quotas are enabled. Used by simple quotas to
+	 * avoid decrementing when freeing an extent that was written before
+	 * enable.
+	 */
+	__le64 enable_gen;
 } __attribute__ ((__packed__));
 
 struct btrfs_qgroup_info_item {
-- 
2.41.0

