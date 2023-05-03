Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D666F4E44
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjECA7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 20:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECA7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 20:59:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AB52D5E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8597B5C02F7;
        Tue,  2 May 2023 20:59:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 May 2023 20:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075587; x=
        1683161987; bh=gWmI9gjUAqUqMrdHoFIIO04TEXXoG/G4C+hdZCLSIj4=; b=A
        RC/HdrKhIRWe38rtbpkEVQgVeMaMjg4FO3zcEO8mEUvLCEhRJBgKo9GkpzYP3oTY
        65m7pJaLlgO6ErrqIyPk5tbpT9l7vyZ9Nb/s0FHD/y54dQiU0KalB0hMAkUAU/GL
        v+Y20TNWGtojBxs4IYDQdr5fDboWJIeQ0VBeB5OKIPsxW7HsJi1m0wvTZnP7V/eq
        j5Qsm2F94AVLQz9nRbXT2kwrYmtlvvKnomAl+7ggVTo8m0QKAqH4UsKJ+NlI/9e0
        0D11Aw/idhHpfFO59+Je8daOft8uXfZH0BZCS1dYqz71Qvk86vl0GTH8xqL2ugQz
        RzEAP/oE7Eu5B/9YKw9gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075587; x=1683161987; bh=g
        WmI9gjUAqUqMrdHoFIIO04TEXXoG/G4C+hdZCLSIj4=; b=c0I3n2FYvHMjeeIst
        crcMhlMS8TOEUmsMxejBiEuJAjOPZpcyO/paKs6C54XNMlbeUvnMGxtIbD0o3T+8
        5C2rpLHnZxxno7II2WjspnKEhTfO3INvg/lvVTt8ucK2TLAvIp2UrgohmEwGoIs9
        2V7+FvBm+ZzNMPh6hUjWUCq+UWELLD1s5AOnaKPZWqHJo7vh0nRx+Xu5Iv2h3WDs
        y2rJWH7WHjdhJrHFzxdcaEscgF934kndzGa3tvnPmnCMoJVIe84/rzvocyWxUGTy
        Dzp2R0a6SWqhPOFnR98mR2dkwrnNUZ/DMwmHhTEkLreXgqaP4V8TZQtnHWWHRC8z
        m8hxg==
X-ME-Sender: <xms:A7JRZDiSWi4p6eHEptkrgF4i8N9VQdTFWEqd-Q0iHFUPS8kH_dRGZQ>
    <xme:A7JRZACuhL9tEVYTxXY10JtYM7PEFjBtZ57mbwiCzv7dJOE0fZuH9mFBW-LMM4v1t
    9J0uaNFDDsotanBVtA>
X-ME-Received: <xmr:A7JRZDFuMh8_jzvc9SbPg7mCqjEnhcp9urvVdBmIK3qRYRsK9YJ4Jyqz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:A7JRZARdiO9VY71PRjm1T1RN-6AXfpSIR3UcK1XxGgb32PI6ejswng>
    <xmx:A7JRZAz3lPRSxTarvoRCsJ7OHnalxGSFVAtHw0-X92P5dGSWNXL10w>
    <xmx:A7JRZG6UWKGWhYUdKiZw2eDdwn5x0XverA2_c6PtPHV99Y6iDRzvcw>
    <xmx:A7JRZGbAUtwFBZh4V_HBk9DNK26u5_Tz-cQ4CzcCobwBkwJVAwToDA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:47 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/9] btrfs: simple quotas mode
Date:   Tue,  2 May 2023 17:59:22 -0700
Message-Id: <099f2eee2855da6989c29c34e48aaf4b706f047e.1683075170.git.boris@bur.io>
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

Allow the quota enable ioctl to specify simple quotas. Set an INCOMPAT
bit when simple quotas are enabled, as it will result in several
breaking changes to the on-disk format.

Introduce an enum for capturing the current quota mode. Rather than just
enabled/disabled, the possible settings are now disabled/simple/full.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/fs.h              |  5 ++-
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/qgroup.c          | 68 ++++++++++++++++++++++++++++++--------
 fs/btrfs/qgroup.h          | 10 +++++-
 fs/btrfs/transaction.c     |  4 +--
 include/uapi/linux/btrfs.h |  1 +
 6 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0d98fc5f6f44..6c989d87768c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -218,7 +218,8 @@ enum {
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
-	 BTRFS_FEATURE_INCOMPAT_ZONED)
+	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
+	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
 
 #ifdef CONFIG_BTRFS_DEBUG
 	/*
@@ -233,7 +234,6 @@ enum {
 
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE)
-
 #endif
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
@@ -791,7 +791,6 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_state_change_map[4];
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
-
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9522669000a7..ca7d2ef739c8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3685,7 +3685,7 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 
 	switch (sa->cmd) {
 	case BTRFS_QUOTA_CTL_ENABLE:
-		ret = btrfs_quota_enable(fs_info);
+		ret = btrfs_quota_enable(fs_info, sa);
 		break;
 	case BTRFS_QUOTA_CTL_DISABLE:
 		ret = btrfs_quota_disable(fs_info);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f41da7ac360d..3c8b296215ee 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2011 STRATO.  All rights reserved.
  */
 
+#include <linux/btrfs.h>
 #include <linux/sched.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
@@ -10,7 +11,6 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
-#include <linux/btrfs.h>
 #include <linux/sched/mm.h>
 
 #include "ctree.h"
@@ -30,6 +30,15 @@
 #include "root-tree.h"
 #include "tree-checker.h"
 
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		return BTRFS_QGROUP_MODE_DISABLED;
+	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
+		return BTRFS_QGROUP_MODE_SIMPLE;
+	return BTRFS_QGROUP_MODE_FULL;
+}
+
 /*
  * Helpers to access qgroup reservation
  *
@@ -340,6 +349,8 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 
 static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
 {
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return;
 	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
 				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
 				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
@@ -412,7 +423,8 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				goto out;
 			}
 			if (btrfs_qgroup_status_generation(l, ptr) !=
-			    fs_info->generation) {
+			    fs_info->generation &&
+			    !btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)) {
 				qgroup_mark_inconsistent(fs_info);
 				btrfs_err(fs_info,
 					"qgroup generation mismatch, marked as inconsistent");
@@ -949,7 +961,8 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
+int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
+		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args)
 {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -961,6 +974,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	struct btrfs_qgroup *qgroup = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	struct ulist *ulist = NULL;
+	bool simple_qgroups = quota_ctl_args->status == 42;
 	int ret = 0;
 	int slot;
 
@@ -1063,8 +1077,9 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				 struct btrfs_qgroup_status_item);
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
-	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
-				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
+	if (!simple_qgroups)
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
 				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
@@ -1180,8 +1195,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	spin_lock(&fs_info->qgroup_lock);
 	fs_info->quota_root = quota_root;
 	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
+	if (simple_qgroups)
+		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 	spin_unlock(&fs_info->qgroup_lock);
 
+	/* Skip rescan for simple qgroups */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		goto out_free_path;
+
 	ret = qgroup_rescan_init(fs_info, 0, 1);
 	if (!ret) {
 	        qgroup_rescan_zero_tracking(fs_info);
@@ -1766,6 +1787,9 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	struct btrfs_qgroup_extent_record *entry;
 	u64 bytenr = record->bytenr;
 
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 0;
+
 	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record);
 
@@ -1798,6 +1822,8 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_walk_ctx ctx = { 0 };
 	int ret;
 
+	if (btrfs_qgroup_mode(trans->fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 0;
 	/*
 	 * We are always called in a context where we are already holding a
 	 * transaction handle. Often we are called when adding a data delayed
@@ -1853,7 +1879,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL
 	    || bytenr == 0 || num_bytes == 0)
 		return 0;
 	record = kzalloc(sizeof(*record), GFP_NOFS);
@@ -1886,7 +1912,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 	u64 bytenr, num_bytes;
 
 	/* We can be called directly from walk_up_proc() */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	for (i = 0; i < nr; i++) {
@@ -2262,7 +2288,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 	int level;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	/* Wrong parameter order */
@@ -2319,7 +2345,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	BUG_ON(root_level < 0 || root_level >= BTRFS_MAX_LEVEL);
 	BUG_ON(root_eb == NULL);
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	spin_lock(&fs_info->qgroup_lock);
@@ -2659,7 +2685,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	 * If quotas get disabled meanwhile, the resources need to be freed and
 	 * we can't just exit here.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL ||
 	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		goto out_free;
 
@@ -2747,6 +2773,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	u64 qgroup_to_skip;
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 0;
+
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
 	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
@@ -2989,11 +3018,10 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		qgroup_dirty(fs_info, dstgroup);
 	}
 
-	if (srcid) {
+	if (srcid && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL) {
 		srcgroup = find_qgroup_rb(fs_info, srcid);
 		if (!srcgroup)
 			goto unlock;
-
 		/*
 		 * We call inherit after we clone the root in order to make sure
 		 * our counts don't go crazy, so at this point the only
@@ -3281,6 +3309,9 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 	int slot;
 	int ret;
 
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 1;
+
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	extent_root = btrfs_extent_root(fs_info,
 				fs_info->qgroup_rescan_progress.objectid);
@@ -3378,6 +3409,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	bool stopped = false;
 	bool did_leaf_rescans = false;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		goto out;
@@ -3481,6 +3515,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 {
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
+		btrfs_warn(fs_info, "qgroup rescan init failed, running in simple mode. mode: %d\n",
+			btrfs_qgroup_mode(fs_info));
+		return -EINVAL;
+	}
+
 	if (!init_flags) {
 		/* we're resuming qgroup rescan at mount time */
 		if (!(fs_info->qgroup_flags &
@@ -4240,7 +4280,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 	int level = btrfs_header_level(subvol_parent) - 1;
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	if (btrfs_node_ptr_generation(subvol_parent, subvol_slot) >
@@ -4350,7 +4390,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int i;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 	if (!is_fstree(root->root_key.objectid) || !root->reloc_root)
 		return 0;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7bffa10589d6..d4c4d039585f 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -249,7 +249,15 @@ enum {
 	ENUM_BIT(QGROUP_FREE),
 };
 
-int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
+enum btrfs_qgroup_mode {
+	BTRFS_QGROUP_MODE_DISABLED,
+	BTRFS_QGROUP_MODE_FULL,
+	BTRFS_QGROUP_MODE_SIMPLE
+};
+
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
+int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
+		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8b6a99b8d7f6..e6d6752c2fca 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1514,11 +1514,11 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	int ret;
 
 	/*
-	 * Save some performance in the case that qgroups are not
+	 * Save some performance in the case that full qgroups are not
 	 * enabled. If this check races with the ioctl, rescan will
 	 * kick in anyway.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	/*
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dbb8b96da50d..957ca4037974 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -333,6 +333,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.40.0

