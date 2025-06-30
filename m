Return-Path: <linux-btrfs+bounces-15102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC0AEDE75
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475FF170E1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145B22D979D;
	Mon, 30 Jun 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXuzc4Eb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88E2C178D
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288516; cv=none; b=Po3/tz4fnQR6RXYqtPGCXYsZvjg8K8BqfTFlqGvRzVQLLQRKxQZJBRQ/M77JIQqCikSuxWZDDg4lxokqjo73gwrIAGRUP2zOdjjFjlEClQz3qmrFpZl2TxYcsMgVsO0sdePHhR36Aut+VN9KuSybxT8dmlje7zW8Qt+wTYCnsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288516; c=relaxed/simple;
	bh=ngmc2H435i7K0T6elqEurtAGwxB1NCxA2KHoN2AoI4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pygw/LT7ogiODjmAQaryKA2PFaMdRve/m8gDaAljfZeprI6RGgS9GhTC2aw4maPELggH0f+awxywA6jc8AAGomesEzSq0H1LoGl7GTFZupTxCSgwEYTnkW4N4O9BG6VrZ346Yit1ago+fYZtdPARsh5pwd3e+kjGJFpM/+4rwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXuzc4Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD0C4CEF0
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751288515;
	bh=ngmc2H435i7K0T6elqEurtAGwxB1NCxA2KHoN2AoI4w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DXuzc4EbePTWUlDRv5KWNfFzMnEGjFBodDKV9k7GJSfRiHyL2i+XM6VcaRz6rOVgX
	 EMcZq+vPP5FfkMJ7Wkl3qvzlJMYr4BggeTvaHMV0GbCDQSIHqy662rRW2jZyVAlAu8
	 WBB+Sz3vNn7k31zarcl5S2QLBJg7ksD7HAJDf+qQLiLxvBP8cqYxu71NCytiSThfNn
	 B7ryECOpWqcEOQALZ+o23+Hwlpa4PbTUssNnHAXFsbQSsoIyGB7YQOcKfxLMclOAQn
	 aHadDmcsyWYVSff9HeEZCvkPhp8dkRujRAqCQfT53W2PJLqPWVABN2pgCb0BStTYR8
	 hczC/iJXgl7Xw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: qgroup: fix race between quota disable and quota rescan ioctl
Date: Mon, 30 Jun 2025 14:01:50 +0100
Message-ID: <671b49265ecf5c84967ed8be0b3d218e137d8a5a.1751288310.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751288310.git.fdmanana@suse.com>
References: <cover.1751288310.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's a race between a task disabling quotas and another running the
rescan ioctl that can result in a use-after-free of qgroup records from
the fs_info->qgroup_tree rbtree.

This happens as follows:

1) Task A enters btrfs_ioctl_quota_rescan() -> btrfs_qgroup_rescan();

2) Task B enters btrfs_quota_disable() and calls
   btrfs_qgroup_wait_for_completion(), which does nothing because at that
   point fs_info->qgroup_rescan_running is false (it wasn't set yet by
   task A);

3) Task B calls btrfs_free_qgroup_config() which starts freeing qgroups
   from fs_info->qgroup_tree without taking the lock fs_info->qgroup_lock;

4) Task A enters qgroup_rescan_zero_tracking() which starts iterating
   the fs_info->qgroup_tree tree while holding fs_info->qgroup_lock,
   but task B is freeing qgroup records from that tree without holding
   the lock, resulting in a use-after-free.

Fix this by taking fs_info->qgroup_lock at btrfs_free_qgroup_config().
Also at btrfs_qgroup_rescan() don't start the rescan worker if quotas
were already disabled.

Reported-by: cen zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b83d9534adae..b24cb54e4f42 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -636,22 +636,30 @@ bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info)
 
 /*
  * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
- * first two are in single-threaded paths.And for the third one, we have set
- * quota_root to be null with qgroup_lock held before, so it is safe to clean
- * up the in-memory structures without qgroup_lock held.
+ * first two are in single-threaded paths.
  */
 void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *n;
 	struct btrfs_qgroup *qgroup;
 
+	/*
+	 * btrfs_quota_disable() can be called concurrently with
+	 * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so take the
+	 * lock.
+	 */
+	spin_lock(&fs_info->qgroup_lock);
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
 		__del_qgroup_rb(qgroup);
+		spin_unlock(&fs_info->qgroup_lock);
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 		kfree(qgroup);
+		spin_lock(&fs_info->qgroup_lock);
 	}
+	spin_unlock(&fs_info->qgroup_lock);
+
 	/*
 	 * We call btrfs_free_qgroup_config() when unmounting
 	 * filesystem and disabling quota, so we set qgroup_ulist
@@ -4036,9 +4044,13 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	qgroup_rescan_zero_tracking(fs_info);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	fs_info->qgroup_rescan_running = true;
-	btrfs_queue_work(fs_info->qgroup_rescan_workers,
-			 &fs_info->qgroup_rescan_work);
+	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		fs_info->qgroup_rescan_running = true;
+		btrfs_queue_work(fs_info->qgroup_rescan_workers,
+				 &fs_info->qgroup_rescan_work);
+	} else {
+		ret = -ENOTCONN;
+	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	return 0;
-- 
2.47.2


