Return-Path: <linux-btrfs+bounces-15099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976EAAEDD3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2960189C75C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31C28B418;
	Mon, 30 Jun 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9OwXCC9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D928B501
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287153; cv=none; b=bUf5RdwtuU/yyYC/kqZzOmO7psLjUfb6WagvQYIzSZrT2xZkWWf28VaLExFZ2wtQJUdtdcezRllM9sScN8VpJ04Q6/R5amjcGlZUM9aH9DrOpJtiNdH1Z3uTCwaelGe5bGMpV3IwBM3yjc/Rbjn7ZP4To6ccEWxR0XjDLIDsRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287153; c=relaxed/simple;
	bh=N7v3aj9Y2FK1Hz7J2+MyuBN+Bmb99MyViVPUkkNT1Iw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQgZKWQweJ9DJWMrkU+3+HOfU3hm3vvprTvnCRieAZh55f3vCBbgbsEsF7bpf5QZEm9RcpxJ4ZElEHNeRlmh41uUH9cfuZkszYTTYKx4H+9B8OSJ0LpNpEKQb1Ns7uFu5Fw3v0kdiXEiyqt1Yecm9X8O58RPCjVQFfVTehCt7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9OwXCC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC16C19421
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287153;
	bh=N7v3aj9Y2FK1Hz7J2+MyuBN+Bmb99MyViVPUkkNT1Iw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b9OwXCC9RnewtU5wy8kUMYbifNPgPBbStWSn5xHX677clE1XWuVVxEGYDUPkd6Igf
	 LkAcFH/HPBzt4s21bzKaN9aXcl/zb+ETcfd/pO0/RQunuXc25San7UzzCZX7q57OMW
	 MjQVzAdkYyxEIjvFgBcdkv96wyfEtxFB8+xIE2tr5RIfF+JWJDmlAT0uMmyBF/ZIrB
	 bxJUM7ogcsQuEV7CV4T191JW7GvgsJ1dpMSol7qMz29pfIa20tjI21j2yHt5Of/4P/
	 F2NO5CMqs9W4EsLCeEv2fZBs8hQQSzEGvIoFY+KTAPFyKQbj4GjAhudrGAzPLv88Vv
	 8Y5exKsdB1Kbw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: qgroup: remove no longer used fs_info->qgroup_ulist
Date: Mon, 30 Jun 2025 13:39:08 +0100
Message-ID: <3402c8be64ed02849c31cd60e0d950eced90b545.1751286816.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751286816.git.fdmanana@suse.com>
References: <cover.1751286816.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's not used anymore after commit 091344508249 ("btrfs: qgroup: use
qgroup_iterator in qgroup_convert_meta()"), so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c |  1 -
 fs/btrfs/fs.h      |  6 ------
 fs/btrfs/qgroup.c  | 31 +------------------------------
 3 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f6fa951c6be9..ee4911452cfd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1947,7 +1947,6 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_tree = RB_ROOT;
 	INIT_LIST_HEAD(&fs_info->dirty_qgroups);
 	fs_info->qgroup_seq = 1;
-	fs_info->qgroup_ulist = NULL;
 	fs_info->qgroup_rescan_running = false;
 	fs_info->qgroup_drop_subtree_thres = BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT;
 	mutex_init(&fs_info->qgroup_rescan_lock);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b239e4b8421c..a731c883687d 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -740,12 +740,6 @@ struct btrfs_fs_info {
 	struct rb_root qgroup_tree;
 	spinlock_t qgroup_lock;
 
-	/*
-	 * Used to avoid frequently calling ulist_alloc()/ulist_free()
-	 * when doing qgroup accounting, it must be protected by qgroup_lock.
-	 */
-	struct ulist *qgroup_ulist;
-
 	/*
 	 * Protect user change for quota operations. If a transaction is needed,
 	 * it must be started before locking this lock.
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 0b07431963e8..aadd1dbf7fb0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -397,12 +397,6 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	if (!fs_info->quota_root)
 		return 0;
 
-	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
-	if (!fs_info->qgroup_ulist) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
@@ -587,8 +581,6 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
 			ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
 	} else {
-		ulist_free(fs_info->qgroup_ulist);
-		fs_info->qgroup_ulist = NULL;
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 		btrfs_sysfs_del_qgroups(fs_info);
 	}
@@ -660,13 +652,6 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->qgroup_lock);
 
-	/*
-	 * We call btrfs_free_qgroup_config() when unmounting
-	 * filesystem and disabling quota, so we set qgroup_ulist
-	 * to be null here to avoid double free.
-	 */
-	ulist_free(fs_info->qgroup_ulist);
-	fs_info->qgroup_ulist = NULL;
 	btrfs_sysfs_del_qgroups(fs_info);
 }
 
@@ -1012,7 +997,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	struct btrfs_qgroup *qgroup = NULL;
 	struct btrfs_qgroup *prealloc = NULL;
 	struct btrfs_trans_handle *trans = NULL;
-	struct ulist *ulist = NULL;
 	const bool simple = (quota_ctl_args->cmd == BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA);
 	int ret = 0;
 	int slot;
@@ -1035,12 +1019,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	if (fs_info->quota_root)
 		goto out;
 
-	ulist = ulist_alloc(GFP_KERNEL);
-	if (!ulist) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	ret = btrfs_sysfs_add_qgroups(fs_info);
 	if (ret < 0)
 		goto out;
@@ -1080,9 +1058,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	if (fs_info->quota_root)
 		goto out;
 
-	fs_info->qgroup_ulist = ulist;
-	ulist = NULL;
-
 	/*
 	 * initially create the quota tree
 	 */
@@ -1281,17 +1256,13 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	if (ret)
 		btrfs_put_root(quota_root);
 out:
-	if (ret) {
-		ulist_free(fs_info->qgroup_ulist);
-		fs_info->qgroup_ulist = NULL;
+	if (ret)
 		btrfs_sysfs_del_qgroups(fs_info);
-	}
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
-	ulist_free(ulist);
 	kfree(prealloc);
 	return ret;
 }
-- 
2.47.2


