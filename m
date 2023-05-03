Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CAA6F4E42
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjECBAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 21:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECA77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 20:59:59 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D042D5E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 84B625C0314;
        Tue,  2 May 2023 20:59:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 May 2023 20:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075597; x=
        1683161997; bh=xpw8KzBWFdqXFGYtgH8wcPFmB32ZF1BOUcspkp+TVk4=; b=y
        GZb2EGE/hYvW1AJ7xPYG0eYtOhgTtybQcd3eQLLXt8k7z67VPSPEqh+I2OJc135l
        FKZi49jKXN5WMG9wkqY3Fm9lbfE75P3Mf8gwzCLYdcAleqixwk/jh6+eStlLDojE
        vy5yA3hZn84V+K6ayDw4ebHAo2VqhM2uZyX9lCxlaQSRuyHzZO1QmIr0lz5Co+gG
        HzTQQoTRQ2YYsAcCjnEVQ2oAtOsgnK6HwqR1Y0sL1rbEMO+aoKni/bT2Oms18fFf
        49pQOlsEZBLiP7VpFa8LsFQwhtwJsasCP7OTW9vQRQqO2drjIo601gvAmrzgIOvJ
        duSWcA32K01Kb4XZsiSwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075597; x=1683161997; bh=x
        pw8KzBWFdqXFGYtgH8wcPFmB32ZF1BOUcspkp+TVk4=; b=a+eW2YINxWoK0CO70
        jSds655ioCa+zubGl2DTWx/TtXyqm9zQb8amZjdpDhF349pRTJhLXhiaeXKeC4qs
        tjeYTXxomt14k23PcXdB+WaWRVvwc1YbhepEhbBm5ecxpoPXicGnjx4AG8XG62eP
        bRP2ft4JghA5VXU751n/xZT41G0KftiwzTGiA8wBfPNYkSZoK84QQMygXyztYt7N
        kwYggM/R7P0T9tcF16o/ESDMgrds6kYT56kArWEqzDhcw+RMiw1BcMl/U9pZuVNG
        zgYgUb09+f1RMu1u3NfJi3FwUbD9h/GVdH/k/bb5hCx9C4+ar2M/bLloEKhFbNFg
        qA+Vw==
X-ME-Sender: <xms:DbJRZNMdxM7isqH1hD-wKLLRffCiviJDglSmWvSfoaNkjrv_LpLEbA>
    <xme:DbJRZP9gxvyF7lfTKYaAafN8f7gsXL1pjMy5ACHSMBhKcHwDAbcz3X5jM-WBdqweL
    MxhBtX1mszFfe5uf84>
X-ME-Received: <xmr:DbJRZMS-EGCJowdsu9TFgJmYAGKn7hW71r2SCGsrCAi6XY4xtcStZ9da>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:DbJRZJu9GAz4DGMTOSM_vGUSbHIIM3ZZaphoaVmgfmIqsPddjD6RhQ>
    <xmx:DbJRZFfBCdKV0GfUXA6_3AHdZlzoRyB766k_0jJ_xgBGT-I0FJ9rAg>
    <xmx:DbJRZF0Y9mDqiKjqpt0bBhvuzmruxHByTvY7B1Ns7bc2LN41cIhiZw>
    <xmx:DbJRZFlwRT-hJaDogLu91uP0BYCpeqgbSzDPK-FScM4BqwsFEGNNoA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:57 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: check generation when recording simple quota delta
Date:   Tue,  2 May 2023 17:59:28 -0700
Message-Id: <13e4e8d1d9479423c135fa9d192e074c8036bcf4.1683075170.git.boris@bur.io>
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
 fs/btrfs/extent-tree.c          |  3 +++
 fs/btrfs/fs.h                   |  2 ++
 fs/btrfs/qgroup.c               | 20 ++++++++++++++++----
 fs/btrfs/qgroup.h               |  1 +
 include/uapi/linux/btrfs_tree.h |  7 +++++++
 6 files changed, 31 insertions(+), 4 deletions(-)

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
index 7379ee04018d..7f48e7d34b09 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1537,6 +1537,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = href->reserved_bytes,
 			.is_data = true,
 			.is_inc	= true,
+			.generation = trans->transid,
 		};
 
 		if (extent_op)
@@ -1700,6 +1701,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = false,
 			.is_inc = true,
+			.generation = trans->transid,
 		};
 
 		BUG_ON(!extent_op || !extent_op->update_flags);
@@ -3179,6 +3181,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			.rsv_bytes = 0,
 			.is_data = is_data,
 			.is_inc = false,
+			.generation = btrfs_extent_generation(leaf, ei),
 		};
 
 		/* In this branch refs == 1 */
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 6c989d87768c..d67ee2652c87 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -803,6 +803,8 @@ struct btrfs_fs_info {
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
 #endif
+
+	u64 quota_enable_gen;
 };
 
 static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6816e01f00b5..cd28e92d8a37 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -467,8 +467,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
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
@@ -1114,6 +1115,10 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	ptr = btrfs_item_ptr(leaf, path->slots[0],
 				 struct btrfs_qgroup_status_item);
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
+	if (simple_qgroups) {
+		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
+		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
+	}
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
 	if (!simple_qgroups)
@@ -1209,6 +1214,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 		goto out_free_path;
 	}
 
+	fs_info->quota_enable_gen = trans->transid;
+
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	/*
 	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
@@ -1233,8 +1240,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->qgroup_lock);
 	fs_info->quota_root = quota_root;
 	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	if (simple_qgroups)
-		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 	spin_unlock(&fs_info->qgroup_lock);
 
 	/* Skip rescan for simple qgroups */
@@ -4573,6 +4578,13 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
 	if (!is_fstree(root))
 		return 0;
 
+	/*
+	 * If the extent predates enabling quotas, don't count it.
+	 * This is particularly likely when freeing old extents.
+	 */
+	if (delta->generation < fs_info->quota_enable_gen)
+		return 0;
+
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = find_qgroup_rb(fs_info, root);
 	if (!qgroup) {
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index aecebe9d0d62..9f3c397d51fb 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -242,6 +242,7 @@ struct btrfs_simple_quota_delta {
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
2.40.0

