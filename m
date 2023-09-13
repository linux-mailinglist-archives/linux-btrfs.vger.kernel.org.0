Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6A79DD02
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjIMAMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjIMAMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:12:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBC10F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:12:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id DDB5632005D8;
        Tue, 12 Sep 2023 20:12:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 20:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563967; x=
        1694650367; bh=47ze1KhPk4SZlJDhyLtaEq5gOL/Ejw+EPPnKfI64ulc=; b=I
        i3Ph23aTJbs+sJ275kXFhMvJrnBOZa3A9dYXrAkj4Z/odaii50E40m5lYmFSpt7P
        /mKw6i81nDjhlLB8/y7YNQyxdoDjh2Sp7HgKslST+1I9TJhQeNbi4Y7GqVE1hESM
        4KnWlmBMkYi8tPLyq/J0GES+D+L0/Fv9H1kFr75xBlgZAhjs913+p5MYqU/4pQXu
        UsTI4Og2wuB3879kLZr75mWSjhO6pfFH3dzHi74CgLOmHxF46eTNKIDjcw9aG1Gv
        4LS77/0W8OVcH49D/UuCcCdUxpcxwsK1daBS4BIkpmNvD26SoyyN1TNqBfeXB5KA
        oudMW6XECwFWOxrgdvkPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563967; x=1694650367; bh=4
        7ze1KhPk4SZlJDhyLtaEq5gOL/Ejw+EPPnKfI64ulc=; b=JuDxPjdG0n/UdY73V
        2O6r7aoGZHGk0cKV75SZihJoT3Bwfik2YDyUnf31InukyNYLHK8iusPo8vPyHgKT
        3IlOLqNaEtMWToYYhlAcJvVsLGCiBCzWBDB1qvkJmICHiQ0EoJR4ropU00kUnHAO
        d2bfP1ka/JwfAwINdI/VUgplUPlQgWDrCELcMMxAukIcxDenuSyDraG1T1tYb6Ln
        Z+oHPna/BNqnsUC2n6rZaMwXWDm2h1XOCSqmRu/G8Xz1pM+cHIGJTycdCXYqt3q4
        qtm06QDKY6Gzeiv5KeXRtBlNDb9s04znVQn1jW34S88WrVMePiQuzdpIe7vZhsyS
        JcTIA==
X-ME-Sender: <xms:f_4AZUAVmgmDR1cHYNMR2r_QuADABXcZxw_jKcz3FfkdKbLPdgBKKg>
    <xme:f_4AZWioqOSOkXomiGHjtyRSKNmLI6d7JDzh2gukP8U96p2G3UghMQvOH8WQIomPm
    42FxDEPApY9oZ5JebY>
X-ME-Received: <xmr:f_4AZXl8XUq6QX7h9iC9NrksakURHRnO1162gtqdSa4825Zx3HXBDhLnMkYOwZnMtOzgTMdV9SzbwIS0giAb5UW0SNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:f_4AZawhEpqFfhKktbqtCKJffrwepehcntp5RaJfMq-AQIM68dw_yw>
    <xmx:f_4AZZSizFKtMLWY1kusTumoUucGBTxRRj6-VH3icFgr0R8U_bC4JA>
    <xmx:f_4AZVbNiNRcsfqmyzXCZdkp1mURMlRhZv5gKBBJrqaMQVTvGS6fDQ>
    <xmx:f_4AZa5PJvNzy3G--_VIotgZoRfA0hQ1Vwy-ALdOsIR6zBmoBwmIiw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:12:46 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 02/18] btrfs: add new quota mode for simple quotas
Date:   Tue, 12 Sep 2023 17:13:13 -0700
Message-ID: <ab04fcc9c78a0d76a7309e0e6e8ddfb16c66de49.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new quota mode called "simple quotas". It can be enabled by the
existing quota enable ioctl via a new command, and sets an incompat
bit, as the implementation of simple quotas will make backwards
incompatible changes to the disk format of the extent tree.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-ref.c          |   6 +-
 fs/btrfs/fs.h                   |   3 +-
 fs/btrfs/ioctl.c                |   3 +-
 fs/btrfs/qgroup.c               | 109 +++++++++++++++++++++++---------
 fs/btrfs/qgroup.h               |  17 ++++-
 fs/btrfs/root-tree.c            |   2 +-
 fs/btrfs/transaction.c          |   4 +-
 include/uapi/linux/btrfs.h      |   2 +
 include/uapi/linux/btrfs_tree.h |  10 ++-
 9 files changed, 114 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 25d0cdf85a91..0a80224c8784 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -959,8 +959,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
-	    !generic_ref->skip_qgroup) {
+	if (btrfs_qgroup_enabled(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
@@ -1063,8 +1062,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
-	    !generic_ref->skip_qgroup) {
+	if (btrfs_qgroup_enabled(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d84a390336fc..49fdac7dfd07 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -214,7 +214,8 @@ enum {
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
-	 BTRFS_FEATURE_INCOMPAT_ZONED)
+	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
+	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
 
 #ifdef CONFIG_BTRFS_DEBUG
 	/*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 75ab766fe156..6211bce7f146 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3697,7 +3697,8 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 
 	switch (sa->cmd) {
 	case BTRFS_QUOTA_CTL_ENABLE:
-		ret = btrfs_quota_enable(fs_info);
+	case BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA:
+		ret = btrfs_quota_enable(fs_info, sa);
 		break;
 	case BTRFS_QUOTA_CTL_DISABLE:
 		ret = btrfs_quota_disable(fs_info);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8f8318e0509b..9348529270bf 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -34,9 +34,21 @@ enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
 {
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		return BTRFS_QGROUP_MODE_DISABLED;
+	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE)
+		return BTRFS_QGROUP_MODE_SIMPLE;
 	return BTRFS_QGROUP_MODE_FULL;
 }
 
+bool btrfs_qgroup_enabled(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED;
+}
+
+bool btrfs_qgroup_full_accounting(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL;
+}
+
 /*
  * Helpers to access qgroup reservation
  *
@@ -360,6 +372,8 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 
 static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
 {
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return;
 	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
 				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
 				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
@@ -380,8 +394,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 	u64 flags = 0;
 	u64 rescan_progress = 0;
+	bool simple;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		return 0;
 
 	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
@@ -431,14 +446,14 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				 "old qgroup version, quota disabled");
 				goto out;
 			}
+			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
+			simple = (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE);
 			if (btrfs_qgroup_status_generation(l, ptr) !=
-			    fs_info->generation) {
+			    fs_info->generation && !simple) {
 				qgroup_mark_inconsistent(fs_info);
 				btrfs_err(fs_info,
 					"qgroup generation mismatch, marked as inconsistent");
 			}
-			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l,
-									  ptr);
 			rescan_progress = btrfs_qgroup_status_rescan(l, ptr);
 			goto next1;
 		}
@@ -581,7 +596,7 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
 	struct rb_node *node;
 	bool ret = false;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		return ret;
 	/*
 	 * Since we're unmounting, there is no race and no need to grab qgroup
@@ -980,7 +995,8 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
+int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
+		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args)
 {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -993,6 +1009,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	struct btrfs_qgroup *prealloc = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	struct ulist *ulist = NULL;
+	const bool simple = (quota_ctl_args->cmd == BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA);
 	int ret = 0;
 	int slot;
 
@@ -1095,8 +1112,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				 struct btrfs_qgroup_status_item);
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
-	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
-				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
+	if (simple)
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
+	else
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
 				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
@@ -1224,8 +1244,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	spin_lock(&fs_info->qgroup_lock);
 	fs_info->quota_root = quota_root;
 	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
+	if (simple)
+		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 	spin_unlock(&fs_info->qgroup_lock);
 
+	/* Skip rescan for simple qgroups */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		goto out_free_path;
+
 	ret = qgroup_rescan_init(fs_info, 0, 1);
 	if (!ret) {
 	        qgroup_rescan_zero_tracking(fs_info);
@@ -1340,6 +1366,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	quota_root = fs_info->quota_root;
 	fs_info->quota_root = NULL;
 	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
+	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
 	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
 	spin_unlock(&fs_info->qgroup_lock);
 
@@ -1820,6 +1847,9 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	struct btrfs_qgroup_extent_record *entry;
 	u64 bytenr = record->bytenr;
 
+	if (!btrfs_qgroup_full_accounting(fs_info))
+		return 0;
+
 	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record);
 
@@ -1873,6 +1903,8 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_walk_ctx ctx = { 0 };
 	int ret;
 
+	if (!btrfs_qgroup_full_accounting(trans->fs_info))
+		return 0;
 	/*
 	 * We are always called in a context where we are already holding a
 	 * transaction handle. Often we are called when adding a data delayed
@@ -1941,7 +1973,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
+	if (!btrfs_qgroup_full_accounting(fs_info)
 	    || bytenr == 0 || num_bytes == 0)
 		return 0;
 	record = kzalloc(sizeof(*record), GFP_NOFS);
@@ -1980,7 +2012,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 	u64 bytenr, num_bytes;
 
 	/* We can be called directly from walk_up_proc() */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 
 	for (i = 0; i < nr; i++) {
@@ -2356,7 +2388,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 	int level;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 
 	/* Wrong parameter order */
@@ -2423,7 +2455,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	BUG_ON(root_level < 0 || root_level >= BTRFS_MAX_LEVEL);
 	BUG_ON(root_eb == NULL);
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 
 	spin_lock(&fs_info->qgroup_lock);
@@ -2757,7 +2789,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	 * If quotas get disabled meanwhile, the resources need to be freed and
 	 * we can't just exit here.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (!btrfs_qgroup_full_accounting(fs_info) ||
 	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		goto out_free;
 
@@ -2826,6 +2858,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	u64 qgroup_to_skip;
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return 0;
+
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
 	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
@@ -2941,7 +2976,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 			qgroup_mark_inconsistent(fs_info);
 		spin_lock(&fs_info->qgroup_lock);
 	}
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_enabled(fs_info))
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_ON;
 	else
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
@@ -3000,7 +3035,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 	if (!committing)
 		mutex_lock(&fs_info->qgroup_ioctl_lock);
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!btrfs_qgroup_enabled(fs_info))
 		goto out;
 
 	quota_root = fs_info->quota_root;
@@ -3086,7 +3121,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		qgroup_dirty(fs_info, dstgroup);
 	}
 
-	if (srcid) {
+	if (srcid && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL) {
 		srcgroup = find_qgroup_rb(fs_info, srcid);
 		if (!srcgroup)
 			goto unlock;
@@ -3349,6 +3384,9 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 	int slot;
 	int ret;
 
+	if (!btrfs_qgroup_full_accounting(fs_info))
+		return 1;
+
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	extent_root = btrfs_extent_root(fs_info,
 				fs_info->qgroup_rescan_progress.objectid);
@@ -3429,10 +3467,15 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 
 static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
 {
-	return btrfs_fs_closing(fs_info) ||
-		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state) ||
-		!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
-			  fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
+	if (btrfs_fs_closing(fs_info))
+		return true;
+	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
+		return true;
+	if (!btrfs_qgroup_enabled(fs_info))
+		return true;
+	if (fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN)
+		return true;
+	return false;
 }
 
 static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
@@ -3446,6 +3489,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	bool stopped = false;
 	bool did_leaf_rescans = false;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		goto out;
@@ -3549,6 +3595,11 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 {
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
+		btrfs_warn(fs_info, "qgroup rescan init failed, running in simple mode");
+		return -EINVAL;
+	}
+
 	if (!init_flags) {
 		/* we're resuming qgroup rescan at mount time */
 		if (!(fs_info->qgroup_flags &
@@ -3579,7 +3630,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 			btrfs_warn(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
-		} else if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		} else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
 			/* Quota disable is in progress */
 			ret = -EBUSY;
 		}
@@ -3838,7 +3889,7 @@ static int qgroup_reserve_data(struct btrfs_inode *inode,
 	u64 to_reserve;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &root->fs_info->flags) ||
+	if (btrfs_qgroup_mode(root->fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid) || len == 0)
 		return 0;
 
@@ -3970,7 +4021,7 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	int trace_op = QGROUP_RELEASE;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &inode->root->fs_info->flags))
+	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		return 0;
 
 	/* In release case, we shouldn't have @reserved */
@@ -4081,7 +4132,7 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid) || num_bytes == 0)
 		return 0;
 
@@ -4126,7 +4177,7 @@ void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid))
 		return;
 
@@ -4142,7 +4193,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid))
 		return;
 
@@ -4201,7 +4252,7 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid))
 		return;
 	/* Same as btrfs_qgroup_free_meta_prealloc() */
@@ -4309,7 +4360,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 	int level = btrfs_header_level(subvol_parent) - 1;
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 
 	if (btrfs_node_ptr_generation(subvol_parent, subvol_slot) >
@@ -4419,7 +4470,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int i;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 	if (!is_fstree(root->root_key.objectid) || !root->reloc_root)
 		return 0;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index aed611774047..7fc64d665353 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -101,8 +101,15 @@
  *     subtree rescan for them.
  */
 
-#define BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN		(1UL << 3)
-#define BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING		(1UL << 4)
+/*
+ * These flags share the flags field of the btrfs_qgroup_status_item
+ * with the persisted flags defined in btrfs_tree.h
+ *
+ * To minimize the chance of collision with new persisted status flags,
+ * these count backwards from the MSB.
+ */
+#define BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN		(1ULL << 63)
+#define BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING		(1ULL << 62)
 
 /*
  * Record a dirty extent, and info qgroup to update quota on it
@@ -276,13 +283,17 @@ enum {
 	ENUM_BIT(QGROUP_FREE),
 };
 
-int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
 enum btrfs_qgroup_mode {
 	BTRFS_QGROUP_MODE_DISABLED,
 	BTRFS_QGROUP_MODE_FULL,
+	BTRFS_QGROUP_MODE_SIMPLE
 };
 
 enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
+bool btrfs_qgroup_enabled(struct btrfs_fs_info *fs_info);
+bool btrfs_qgroup_full_accounting(struct btrfs_fs_info *fs_info);
+int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
+		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index db992f7a5d38..8b5942cc13cd 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -510,7 +510,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+	if (btrfs_qgroup_enabled(fs_info)) {
 		/* One for parent inode, two for dir entries */
 		qgroup_num_bytes = 3 * fs_info->nodesize;
 		ret = btrfs_qgroup_reserve_meta_prealloc(root,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3f9f933039c6..12876517c29e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1620,11 +1620,11 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	int ret;
 
 	/*
-	 * Save some performance in the case that qgroups are not
+	 * Save some performance in the case that full qgroups are not
 	 * enabled. If this check races with the ioctl, rescan will
 	 * kick in anyway.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 
 	/*
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dbb8b96da50d..0e42f4a2121d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -333,6 +333,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
@@ -753,6 +754,7 @@ struct btrfs_ioctl_get_dev_stats {
 #define BTRFS_QUOTA_CTL_ENABLE	1
 #define BTRFS_QUOTA_CTL_DISABLE	2
 #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
+#define BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA 4
 struct btrfs_ioctl_quota_ctl_args {
 	__u64 cmd;
 	__u64 status;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc3c32186d7e..a4b44b13fff5 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1204,9 +1204,17 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
 
+/*
+ * Whether or not this filesystem is using simple quotas.
+ * Not exactly the incompat bit, because we support using simple quotas,
+ * disabling it, then going back to full qgroup quotas.
+ */
+#define BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE	(1ULL << 3)
+
 #define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |		\
 					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |	\
-					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |	\
+					 BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE)
 
 #define BTRFS_QGROUP_STATUS_VERSION        1
 
-- 
2.41.0

