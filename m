Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E2F2C1328
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 19:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgKWSbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 13:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbgKWSbH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 13:31:07 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06C12078E
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Nov 2020 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606156265;
        bh=wzByhbRjvFYDWwwsBbYdh/qQ4vyZ+kEokIbwEwzh6uo=;
        h=From:To:Subject:Date:From;
        b=lobfTiKMQEZiYqKgGiZu9jnNQpUh0xgDyATpDJ/e1BueO1mC3WAazd1vBKhszpIbe
         6lZ2JUJVV/8nPs1Z/GmPW8ETt29a3dIRrf/eG73VYUJIHC2f+ZA/0Iq0IIpywTrni3
         ddayo0Z8yxtMySmWCr+girHzyfDRZgq2vuhsORyI=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix lockdep splat when enabling and disabling qgroups
Date:   Mon, 23 Nov 2020 18:31:02 +0000
Message-Id: <e26aefdd189167c2743692ad9da83d893c943525.1606152355.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When running test case btrfs/017 from fstests, lockdep reported the
following splat:

[ 1297.067385] ======================================================
[ 1297.067708] WARNING: possible circular locking dependency detected
[ 1297.068022] 5.10.0-rc4-btrfs-next-73 #1 Not tainted
[ 1297.068322] ------------------------------------------------------
[ 1297.068629] btrfs/189080 is trying to acquire lock:
[ 1297.068929] ffff9f2725731690 (sb_internal#2){.+.+}-{0:0}, at: btrfs_quota_enable+0xaf/0xa70 [btrfs]
[ 1297.069274]
               but task is already holding lock:
[ 1297.069868] ffff9f2702b61a08 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_quota_enable+0x3b/0xa70 [btrfs]
[ 1297.070219]
               which lock already depends on the new lock.

[ 1297.071131]
               the existing dependency chain (in reverse order) is:
[ 1297.071721]
               -> #1 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}:
[ 1297.072375]        lock_acquire+0xd8/0x490
[ 1297.072710]        __mutex_lock+0xa3/0xb30
[ 1297.073061]        btrfs_qgroup_inherit+0x59/0x6a0 [btrfs]
[ 1297.073421]        create_subvol+0x194/0x990 [btrfs]
[ 1297.073780]        btrfs_mksubvol+0x3fb/0x4a0 [btrfs]
[ 1297.074133]        __btrfs_ioctl_snap_create+0x119/0x1a0 [btrfs]
[ 1297.074498]        btrfs_ioctl_snap_create+0x58/0x80 [btrfs]
[ 1297.074872]        btrfs_ioctl+0x1a90/0x36f0 [btrfs]
[ 1297.075245]        __x64_sys_ioctl+0x83/0xb0
[ 1297.075617]        do_syscall_64+0x33/0x80
[ 1297.075993]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1297.076380]
               -> #0 (sb_internal#2){.+.+}-{0:0}:
[ 1297.077166]        check_prev_add+0x91/0xc60
[ 1297.077572]        __lock_acquire+0x1740/0x3110
[ 1297.077984]        lock_acquire+0xd8/0x490
[ 1297.078411]        start_transaction+0x3c5/0x760 [btrfs]
[ 1297.078853]        btrfs_quota_enable+0xaf/0xa70 [btrfs]
[ 1297.079323]        btrfs_ioctl+0x2c60/0x36f0 [btrfs]
[ 1297.079789]        __x64_sys_ioctl+0x83/0xb0
[ 1297.080232]        do_syscall_64+0x33/0x80
[ 1297.080680]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1297.081139]
               other info that might help us debug this:

[ 1297.082536]  Possible unsafe locking scenario:

[ 1297.083510]        CPU0                    CPU1
[ 1297.084005]        ----                    ----
[ 1297.084500]   lock(&fs_info->qgroup_ioctl_lock);
[ 1297.084994]                                lock(sb_internal#2);
[ 1297.085485]                                lock(&fs_info->qgroup_ioctl_lock);
[ 1297.085974]   lock(sb_internal#2);
[ 1297.086454]
                *** DEADLOCK ***
[ 1297.087880] 3 locks held by btrfs/189080:
[ 1297.088324]  #0: ffff9f2725731470 (sb_writers#14){.+.+}-{0:0}, at: btrfs_ioctl+0xa73/0x36f0 [btrfs]
[ 1297.088799]  #1: ffff9f2702b60cc0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl+0x1f4d/0x36f0 [btrfs]
[ 1297.089284]  #2: ffff9f2702b61a08 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_quota_enable+0x3b/0xa70 [btrfs]
[ 1297.089771]
               stack backtrace:
[ 1297.090662] CPU: 5 PID: 189080 Comm: btrfs Not tainted 5.10.0-rc4-btrfs-next-73 #1
[ 1297.091132] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[ 1297.092123] Call Trace:
[ 1297.092629]  dump_stack+0x8d/0xb5
[ 1297.093115]  check_noncircular+0xff/0x110
[ 1297.093596]  check_prev_add+0x91/0xc60
[ 1297.094076]  ? kvm_clock_read+0x14/0x30
[ 1297.094553]  ? kvm_sched_clock_read+0x5/0x10
[ 1297.095029]  __lock_acquire+0x1740/0x3110
[ 1297.095510]  lock_acquire+0xd8/0x490
[ 1297.095993]  ? btrfs_quota_enable+0xaf/0xa70 [btrfs]
[ 1297.096476]  start_transaction+0x3c5/0x760 [btrfs]
[ 1297.096962]  ? btrfs_quota_enable+0xaf/0xa70 [btrfs]
[ 1297.097451]  btrfs_quota_enable+0xaf/0xa70 [btrfs]
[ 1297.097941]  ? btrfs_ioctl+0x1f4d/0x36f0 [btrfs]
[ 1297.098429]  btrfs_ioctl+0x2c60/0x36f0 [btrfs]
[ 1297.098904]  ? do_user_addr_fault+0x20c/0x430
[ 1297.099382]  ? kvm_clock_read+0x14/0x30
[ 1297.099854]  ? kvm_sched_clock_read+0x5/0x10
[ 1297.100328]  ? sched_clock+0x5/0x10
[ 1297.100801]  ? sched_clock_cpu+0x12/0x180
[ 1297.101272]  ? __x64_sys_ioctl+0x83/0xb0
[ 1297.101739]  __x64_sys_ioctl+0x83/0xb0
[ 1297.102207]  do_syscall_64+0x33/0x80
[ 1297.102673]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1297.103148] RIP: 0033:0x7f773ff65d87

This is because during the quota enable ioctl we lock first the mutex
qgroup_ioctl_lock and then start a transaction, and starting a transaction
acquires a fs freeze semaphore (at the vfs level). However, every other
code path, except for the quota disable ioctl path, we do the opposite:
we start a transaction and then lock the mutex.

So fix this by making the quota enable and disable paths to start the
transaction without having the mutex locked, and then, after starting the
transaction, lock the mutex and check if some other task already enabled
or disabled the quotas, bailing with success if that was the case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h  |  5 ++++-
 fs/btrfs/qgroup.c | 57 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0ffb8a53e87e..7185384f475a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -878,7 +878,10 @@ struct btrfs_fs_info {
 	 */
 	struct ulist *qgroup_ulist;
 
-	/* protect user change for quota operations */
+	/*
+	 * Protect user change for quota operations. If a transaction is needed,
+	 * it must be started before locking this lock.
+	 */
 	struct mutex qgroup_ioctl_lock;
 
 	/* list of dirty qgroups to be written at next commit */
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 25c07ea5c8b5..cbc0266af001 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -934,6 +934,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	struct btrfs_key found_key;
 	struct btrfs_qgroup *qgroup = NULL;
 	struct btrfs_trans_handle *trans = NULL;
+	struct ulist *ulist = NULL;
 	int ret = 0;
 	int slot;
 
@@ -941,8 +942,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	if (fs_info->quota_root)
 		goto out;
 
-	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
-	if (!fs_info->qgroup_ulist) {
+	ulist = ulist_alloc(GFP_KERNEL);
+	if (!ulist) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -950,6 +951,22 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	ret = btrfs_sysfs_add_qgroups(fs_info);
 	if (ret < 0)
 		goto out;
+
+	/*
+	 * Unlock qgroup_ioctl_lock before starting the transaction. This is to
+	 * avoid lock acquisiton inversion problems (reported by lockdep) between
+	 * qgroup_ioctl_lock and the vfs freeze semaphores, acquired when we
+	 * start a transaction.
+	 * After we started the transaction lock qgroup_ioctl_lock again and
+	 * check if someone else created the quota root in the meanwhile. If so,
+	 * just return success and release the transaction handle.
+	 *
+	 * Also we don't need to worry about someone else calling
+	 * btrfs_sysfs_add_qgroups() after we unlock and getting an error because
+	 * that function returns 0 (success) when the sysfs entries already exist.
+	 */
+	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+
 	/*
 	 * 1 for quota root item
 	 * 1 for BTRFS_QGROUP_STATUS item
@@ -959,12 +976,20 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	 * would be a lot of overkill.
 	 */
 	trans = btrfs_start_transaction(tree_root, 2);
+
+	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
 		goto out;
 	}
 
+	if (fs_info->quota_root)
+		goto out;
+
+	fs_info->qgroup_ulist = ulist;
+	ulist = NULL;
+
 	/*
 	 * initially create the quota tree
 	 */
@@ -1122,11 +1147,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	if (ret) {
 		ulist_free(fs_info->qgroup_ulist);
 		fs_info->qgroup_ulist = NULL;
-		if (trans)
-			btrfs_end_transaction(trans);
 		btrfs_sysfs_del_qgroups(fs_info);
 	}
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+	if (ret && trans)
+		btrfs_end_transaction(trans);
+	else if (trans)
+		ret = btrfs_end_transaction(trans);
+	ulist_free(ulist);
 	return ret;
 }
 
@@ -1139,19 +1167,29 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root)
 		goto out;
+	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 
 	/*
 	 * 1 For the root item
 	 *
 	 * We should also reserve enough items for the quota tree deletion in
 	 * btrfs_clean_quota_tree but this is not done.
+	 *
+	 * Also, we must always start a transaction without holding the mutex
+	 * qgroup_ioctl_lock, see btrfs_quota_enable().
 	 */
 	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+
+	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
+		trans = NULL;
 		goto out;
 	}
 
+	if (!fs_info->quota_root)
+		goto out;
+
 	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 	spin_lock(&fs_info->qgroup_lock);
@@ -1165,13 +1203,13 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	ret = btrfs_clean_quota_tree(trans, quota_root);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto end_trans;
+		goto out;
 	}
 
 	ret = btrfs_del_root(trans, &quota_root->root_key);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto end_trans;
+		goto out;
 	}
 
 	list_del(&quota_root->dirty_list);
@@ -1183,10 +1221,13 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 
 	btrfs_put_root(quota_root);
 
-end_trans:
-	ret = btrfs_end_transaction(trans);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+	if (trans && ret)
+		btrfs_end_transaction(trans);
+	else if (trans)
+		ret = btrfs_end_transaction(trans);
+
 	return ret;
 }
 
-- 
2.28.0

