Return-Path: <linux-btrfs+bounces-15106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52CAEDEA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B87340186E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E228D8D1;
	Mon, 30 Jun 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSddz7kA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8D28D8C4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288877; cv=none; b=iH/TGrMg26iS19A/kbW1/MANUoSp323MJZxqD+NuFA0/V9fK4Ps5XJCLG8TPjgRGHHjcnnhF5Kje1t7ISqu68eHPIsy9j0KF9izYloQ0oGz/vNsqtL0OMbqKKPagfcIY1buiLcoJdKi9XBXTuBUH/gsL6L+JRUHlkdSJnGIoWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288877; c=relaxed/simple;
	bh=yC9scquLWIGar1yXpjEalSGNdXM7MvKJu6lQUvzL1Ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVMNIrHQhGFJZoIy8AIwSp6wcgfjPqJG79WmsQEtDTm8UxQVWwKtMew5d/pecf2CNPvpCVgVkaPEV6KupQTDB8H68fu3Yp+zrk/2bwODw968GBt8OBO9uyqv8QaA43vArnI6n9YqxXO/sxHbu7zfd9AayY/pu7Sd28aZWaTFPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSddz7kA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3641AC4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751288876;
	bh=yC9scquLWIGar1yXpjEalSGNdXM7MvKJu6lQUvzL1Ck=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nSddz7kA/DJXuW7xh8uCJnejK24EBx02tRYCcy7mSS3/yPiC6bY/xx4/SSE/ue2uC
	 4IkiDP9jay/iUseezfSk0EtH8Ur1xPSbYJix/P7bGGG1ZThtFuVr0N9ynTnGqM9Z5D
	 Y0k4qr4g80kqUKXv69CWBoP7UTiIK1+PIDfd74wg8woeKttnBZvb4ELaorgbSj+Tmw
	 yh2JazOiV61H++kGn4G8GEbRR2q7VRgn3DgDfLc8ETkwKdnpXzFdEeZIJWZUVP8kFc
	 ZYMm5ywScx7+YNwiZnPNRUPn0bv/E69kL9k44XUgMWNIa14m6+Nal37PEspBWUfvTF
	 sd7u5LIX1joJQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: qgroup: remove no longer used fs_info->qgroup_ulist
Date: Mon, 30 Jun 2025 14:07:48 +0100
Message-ID: <6051db0c1a943d7f896fbb5b9cd548908e161ed0.1751288689.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751288689.git.fdmanana@suse.com>
References: <cover.1751288689.git.fdmanana@suse.com>
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
index 8fa874ef80b3..98a53e6edb2c 100644
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


