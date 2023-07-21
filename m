Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C18775CD08
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGUQES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGUQEQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:16 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EF12D47
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0EA6932009A7;
        Fri, 21 Jul 2023 12:04:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 12:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955453; x=
        1690041853; bh=jyGb+ozM4A2hMC3YoLXI4a5gKftR63aTiKlYS2GTZcY=; b=c
        676nLmYiwlU6h+YV/ERkQyQhH/4PVuWNaO71oUxCk9y9zJROaQmDhaNx9RNap/Lx
        7hdpY4GN9syUO4Ne3Ija3NtzL0qFSeNO4EDyJNPjOaBfg5/JGG+aQkP8a+dgse4x
        n0X4GzzfPU7xFAHfM6DG3g0FroY7Q7wLwkghYLgZ46fNZuVZXzW0UCA78G992mTv
        Vh3HM+BFqZ5njdcEWvYrN2SMt+plJXsIZPDWtX9qBhPgwgrltLP6FN6vGLU/MZy7
        YYKqh3bZjdpF2LJk/S6Xkxli6kCGe1W9avkzB3Q8KAYQ/MabxVv9UCswH2jW+R2w
        2KmjOXUlSKXGOOr0q2crA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955453; x=1690041853; bh=j
        yGb+ozM4A2hMC3YoLXI4a5gKftR63aTiKlYS2GTZcY=; b=fB1JS6UtN/tfFvEQF
        9IplM84EBrCzRLjgFUbZ8HGR2bWrq+BZ3LSkRRgPpeLi6QsbrzMHld4UFfXFujEA
        HKlgr1XzFA9ZdN+YHmhSycU1AHnoiYa9FPed0XbJqN9ZTV2HU91lKuQhzTGmjhXm
        qEN3UKW06zEEnvqoBi4zJt/AnJdpKN5KNKZloosTMxGsx/WlYTErZOnoso0OgRi7
        nkA2S6kYlFfVdo79GwdEkEI633kCC4d4MM2riQpaDbByGqBWtGNV+x0ZgXPrQfjZ
        +uXZF/doK9HHkZuhva+28IT9Y+gLLdZx5H/Q0zA4mn4Vii+sra2hYwCLC/NViGMa
        8hz0Q==
X-ME-Sender: <xms:fay6ZG50UuSArrSpgZ2Ti8Kcc3ia7dFU2aVpBbqHP7ZTy64r-xxWlw>
    <xme:fay6ZP6CFE3QLsN3DOLfvnzwfFS9e4s6BDPQR07Nwgy5e0BN1MHV9kbvXHbb4vQyW
    35hK3E2b-HazX2SCIM>
X-ME-Received: <xmr:fay6ZFdS9DzbfwLEzE38C_ne2k2TwsMyXldGVGc-DZ2_XzurOkZkdf5XB-jcFaDqtv8WYckiO_ZadqaDCifY2C5JTQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:fay6ZDKlGBWnEu3ak-2vT5eL7njoZUAPXbTphcTf_RTwCMk9XLIEvA>
    <xmx:fay6ZKIGRQIUZOzvZOo_CzpElfuuHjaHhtcipV5nz6pnU_M0uPgGxw>
    <xmx:fay6ZEz7lxWgeziK0UhHYUBrdnt5aLjRsfveCzPBeCRf451gO1krsg>
    <xmx:fay6ZEzDgrKJb9m2vWy73R6NOET3lj7hZne1AhZqMvg7-PI6aaqyjQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 04/20] btrfs: add new quota mode for simple quotas
Date:   Fri, 21 Jul 2023 09:02:09 -0700
Message-ID: <ef5ba76fbb87a3852dacb5dc0cb1c54c16432e7c.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new quota mode called "simple quotas". It can be enabled by the
existing quota enable ioctl via a new command, and sets an incompat
bit, as the implementation of simple quotas will make backwards
incompatible changes to the disk format of the extent tree.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-ref.c          |  4 +-
 fs/btrfs/fs.h                   |  5 +-
 fs/btrfs/ioctl.c                |  3 +-
 fs/btrfs/qgroup.c               | 91 +++++++++++++++++++++++----------
 fs/btrfs/qgroup.h               |  4 +-
 fs/btrfs/root-tree.c            |  2 +-
 fs/btrfs/transaction.c          |  4 +-
 include/uapi/linux/btrfs.h      |  2 +
 include/uapi/linux/btrfs_tree.h | 14 ++++-
 9 files changed, 91 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6a13cf00218b..a9b938d3a531 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -898,7 +898,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&
 	    !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
@@ -1002,7 +1002,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&
 	    !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..f76f450c2abf 100644
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
@@ -790,7 +790,6 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_state_change_map[4];
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
-
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a895d105464b..9b61bc62e439 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3691,7 +3691,8 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 
 	switch (sa->cmd) {
 	case BTRFS_QUOTA_CTL_ENABLE:
-		ret = btrfs_quota_enable(fs_info);
+	case BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA:
+		ret = btrfs_quota_enable(fs_info, sa);
 		break;
 	case BTRFS_QUOTA_CTL_DISABLE:
 		ret = btrfs_quota_disable(fs_info);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 0a2085ae9bcd..558f66994667 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -34,6 +34,8 @@ enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
 {
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		return BTRFS_QGROUP_MODE_DISABLED;
+	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE)
+		return BTRFS_QGROUP_MODE_SIMPLE;
 	return BTRFS_QGROUP_MODE_FULL;
 }
 
@@ -347,6 +349,8 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 
 static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
 {
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return;
 	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
 				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
 				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
@@ -367,8 +371,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 	u64 flags = 0;
 	u64 rescan_progress = 0;
+	bool simple;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		return 0;
 
 	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
@@ -418,14 +423,14 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				 "old qgroup version, quota disabled");
 				goto out;
 			}
+			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
+			simple = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
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
@@ -557,7 +562,7 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
 	struct rb_node *node;
 	bool ret = false;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		return ret;
 	/*
 	 * Since we're unmounting, there is no race and no need to grab qgroup
@@ -956,7 +961,8 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
+int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
+		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args)
 {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -968,6 +974,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	struct btrfs_qgroup *qgroup = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	struct ulist *ulist = NULL;
+	bool simple = quota_ctl_args->cmd == BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA;
 	int ret = 0;
 	int slot;
 
@@ -1070,8 +1077,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				 struct btrfs_qgroup_status_item);
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
-	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
-				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
+	if (simple)
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
+	else
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
 				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
@@ -1187,8 +1197,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
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
@@ -1302,6 +1318,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	quota_root = fs_info->quota_root;
 	fs_info->quota_root = NULL;
 	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
+	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
 	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
 	spin_unlock(&fs_info->qgroup_lock);
 
@@ -1787,6 +1804,9 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	struct btrfs_qgroup_extent_record *entry;
 	u64 bytenr = record->bytenr;
 
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 0;
+
 	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record);
 
@@ -1819,6 +1839,8 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_walk_ctx ctx = { 0 };
 	int ret;
 
+	if (btrfs_qgroup_mode(trans->fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 0;
 	/*
 	 * We are always called in a context where we are already holding a
 	 * transaction handle. Often we are called when adding a data delayed
@@ -1874,7 +1896,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL
 	    || bytenr == 0 || num_bytes == 0)
 		return 0;
 	record = kzalloc(sizeof(*record), GFP_NOFS);
@@ -1907,7 +1929,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 	u64 bytenr, num_bytes;
 
 	/* We can be called directly from walk_up_proc() */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	for (i = 0; i < nr; i++) {
@@ -2283,7 +2305,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 	int level;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	/* Wrong parameter order */
@@ -2340,7 +2362,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	BUG_ON(root_level < 0 || root_level >= BTRFS_MAX_LEVEL);
 	BUG_ON(root_eb == NULL);
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	spin_lock(&fs_info->qgroup_lock);
@@ -2680,7 +2702,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	 * If quotas get disabled meanwhile, the resources need to be freed and
 	 * we can't just exit here.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL ||
 	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		goto out_free;
 
@@ -2768,6 +2790,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	u64 qgroup_to_skip;
 	int ret = 0;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return 0;
+
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
 	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
@@ -2883,7 +2908,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 			qgroup_mark_inconsistent(fs_info);
 		spin_lock(&fs_info->qgroup_lock);
 	}
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED)
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_ON;
 	else
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
@@ -2936,7 +2961,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 	if (!committing)
 		mutex_lock(&fs_info->qgroup_ioctl_lock);
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		goto out;
 
 	quota_root = fs_info->quota_root;
@@ -3010,7 +3035,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		qgroup_dirty(fs_info, dstgroup);
 	}
 
-	if (srcid) {
+	if (srcid && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL) {
 		srcgroup = find_qgroup_rb(fs_info, srcid);
 		if (!srcgroup)
 			goto unlock;
@@ -3302,6 +3327,9 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 	int slot;
 	int ret;
 
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 1;
+
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	extent_root = btrfs_extent_root(fs_info,
 				fs_info->qgroup_rescan_progress.objectid);
@@ -3384,8 +3412,8 @@ static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
 {
 	return btrfs_fs_closing(fs_info) ||
 		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state) ||
-		!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
-			  fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
+		btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
+		fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
 }
 
 static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
@@ -3399,6 +3427,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	bool stopped = false;
 	bool did_leaf_rescans = false;
 
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		goto out;
@@ -3502,6 +3533,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
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
@@ -3532,7 +3569,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 			btrfs_warn(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
-		} else if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		} else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
 			/* Quota disable is in progress */
 			ret = -EBUSY;
 		}
@@ -3788,7 +3825,7 @@ static int qgroup_reserve_data(struct btrfs_inode *inode,
 	u64 to_reserve;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &root->fs_info->flags) ||
+	if (btrfs_qgroup_mode(root->fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid) || len == 0)
 		return 0;
 
@@ -3920,7 +3957,7 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	int trace_op = QGROUP_RELEASE;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &inode->root->fs_info->flags))
+	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED)
 		return 0;
 
 	/* In release case, we shouldn't have @reserved */
@@ -4031,7 +4068,7 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid) || num_bytes == 0)
 		return 0;
 
@@ -4072,7 +4109,7 @@ void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid))
 		return;
 
@@ -4088,7 +4125,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid))
 		return;
 
@@ -4153,7 +4190,7 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
 	    !is_fstree(root->root_key.objectid))
 		return;
 	/* Same as btrfs_qgroup_free_meta_prealloc() */
@@ -4261,7 +4298,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 	int level = btrfs_header_level(subvol_parent) - 1;
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 
 	if (btrfs_node_ptr_generation(subvol_parent, subvol_slot) >
@@ -4371,7 +4408,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int i;
 
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
 		return 0;
 	if (!is_fstree(root->root_key.objectid) || !root->reloc_root)
 		return 0;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index bb15e55f00b8..d4c4d039585f 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -249,13 +249,15 @@ enum {
 	ENUM_BIT(QGROUP_FREE),
 };
 
-int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
 enum btrfs_qgroup_mode {
 	BTRFS_QGROUP_MODE_DISABLED,
 	BTRFS_QGROUP_MODE_FULL,
+	BTRFS_QGROUP_MODE_SIMPLE
 };
 
 enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
+int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
+		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 859874579456..044a8c2710f8 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -508,7 +508,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED) {
 		/* One for parent inode, two for dir entries */
 		qgroup_num_bytes = 3 * fs_info->nodesize;
 		ret = btrfs_qgroup_reserve_meta_prealloc(root,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index bad10712df50..df3db36515eb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1523,11 +1523,11 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
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
index ab38d0f411fa..47aca414a41b 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1200,9 +1200,21 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
 
+/*
+ * 3rd and 4th bits taken by non-persisted status flags in qgroup.h
+ */
+
+/*
+ * Whether or not this filesystem is using simple quotas.
+ * Not exactly the incompat bit, because we support using simple quotas,
+ * disabling it, then going back to full qgroup quotas.
+ */
+#define BTRFS_QGROUP_STATUS_FLAG_SIMPLE	(1ULL << 5)
+
 #define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |		\
 					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |	\
-					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |	\
+					 BTRFS_QGROUP_STATUS_FLAG_SIMPLE)
 
 #define BTRFS_QGROUP_STATUS_VERSION        1
 
-- 
2.41.0

