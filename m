Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1375BAE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGTWzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGTWzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA919A1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:55:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DA3C5C018B;
        Thu, 20 Jul 2023 18:54:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 18:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893694; x=
        1689980094; bh=QC3lpdEd9PyVCYi09LwUhYZZqQ2zP7Ve8qkRCyHNTF8=; b=f
        aioV61nELyBNIFmZLWg1oW0eYyMUzJNcSQNnMCkgoGt/8RetCiohYyiG4mRUGdJT
        2VLH6VmMlXHql8/+RPX4A7KEEjBTREmeZJZntyV5TWYfLvkqKq/SjWSwTTKKHULb
        6hMdI2ZipMtruLq/t5Wx5z7pjXXClhkrvvXw9JSgGw/xw6dvHLi+WBpMp7skDtGk
        oCil4N3QXlwrWL5BIUXR6ht+OTzyla/i0jorN3J9FGlj8LK70oeeJjRF2udRJj3W
        O1SFdNAIfxQBciAWdcJ6Tp4od9CD+6IXMQVamKnOvmEVBPP34+EMfDHsrLOZrmpj
        ooIa5ujzpIjXREiafScLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893694; x=1689980094; bh=Q
        C3lpdEd9PyVCYi09LwUhYZZqQ2zP7Ve8qkRCyHNTF8=; b=0zjKO+ZpnPpaxz479
        A7QYuE+I/6pVEsLafr6PRKdYxXmQDQ6CnSTVtHoaeDVIYVPvSjmAH2T+aXiDvumC
        7+DZLKKAuyaTGU861SddChAGDIfYPB8gvs/+T3pYxHJjov3NLFQRgIHTCLaHLqlQ
        kJFGn8470Z6QYDDlaVfEy/yNWBhw+nMScJfifbeIUNIyHaR5apzrSW3OTXBqocdh
        KMdZotCTVDAmC/wq3laVosFOTg3SWhpJuJNY3FmuVQP66yWSx4pl8qZGXIS6Fhe4
        0owf0CkJx43y5Cp8PVFFCA8KrC95Ck5Xmv8m8opKfntn5usqglm28tsPmPGJBq3y
        r/w5w==
X-ME-Sender: <xms:Pru5ZITKIHOKlu8hScAZ7kpOe5GpvCbkRtxQLLt2xSCZWgixdSohWg>
    <xme:Pru5ZFzujuwW5_OpC8aEx5RYvBKnVpQ4__R5Zwaxfg7E0qA84qnWzBkx_Qyf1RtuX
    loudPAa75V7_fj-yoI>
X-ME-Received: <xmr:Pru5ZF19Mp9jTjS3mBZYNMfdMGcdIBxQhc9hgvszLNax06AIZCIfvRSaeSjqd2Ek-E_juRjmh4r39TDpdqJmu98bOHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Pru5ZMBawKH1_uedLOlZsGVaartFvXm9bwrCQfPBrJfd71waNHEAGQ>
    <xmx:Pru5ZBjoshWZ3GylAd0fxy_EvDHw5g0XQcPd5XYaG8SMyOmy2VNrMw>
    <xmx:Pru5ZIr-uEBvELf4wSZ4oqYJyIM4HNI2yXGv97fTyJmDkKASiqi9RQ>
    <xmx:Pru5ZBIJHeufEzvA4EpGffpmvphbBuIpJIWTxuWi9Fwaevc4bQm3Vw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:53 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 17/20] btrfs: check generation when recording simple quota delta
Date:   Thu, 20 Jul 2023 15:52:45 -0700
Message-ID: <191463d8eb5bf69ae9175fd3bc0324b51c06437a.1689893021.git.boris@bur.io>
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
 fs/btrfs/qgroup.c               | 14 ++++++++++++--
 fs/btrfs/qgroup.h               |  1 +
 include/uapi/linux/btrfs_tree.h |  7 +++++++
 6 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index a23045c05937..513f8edbd98e 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -970,6 +970,8 @@ BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
 		   flags, 64);
 BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
 		   rescan, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_enable_gen, struct btrfs_qgroup_status_item,
+		   enable_gen, 64);
 
 /* btrfs_qgroup_info_item */
 BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5ea52319c112..ee61e96b4f20 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1512,6 +1512,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = href->reserved_bytes,
 			.is_data = true,
 			.is_inc	= true,
+			.generation = trans->transid,
 		};
 
 		if (extent_op)
@@ -1675,6 +1676,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = false,
 			.is_inc = true,
+			.generation = trans->transid,
 		};
 
 		BUG_ON(!extent_op || !extent_op->update_flags);
@@ -3209,6 +3211,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = is_data,
 			.is_inc = false,
+			.generation = btrfs_extent_generation(leaf, ei),
 		};
 
 		/* In this branch refs == 1 */
@@ -4842,6 +4845,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
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
index 58e9ed0deedd..a8a603242431 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -454,6 +454,8 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			}
 			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
 			simple = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
+			if (simple)
+				fs_info->quota_enable_gen = btrfs_qgroup_status_enable_gen(l, ptr);
 			if (btrfs_qgroup_status_generation(l, ptr) !=
 			    fs_info->generation && !simple) {
 				qgroup_mark_inconsistent(fs_info);
@@ -1107,10 +1109,12 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
-	if (simple)
+	if (simple) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
-	else
+		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
+	} else {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	}
 	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
 				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
@@ -1202,6 +1206,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 		goto out_free_path;
 	}
 
+	fs_info->quota_enable_gen = trans->transid;
+
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	/*
 	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
@@ -4622,6 +4628,10 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
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
index cdedd748de28..281b93a2e06d 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1242,6 +1242,13 @@ struct btrfs_qgroup_status_item {
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

