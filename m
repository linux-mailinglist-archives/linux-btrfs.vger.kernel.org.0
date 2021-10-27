Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFCC43CFB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbhJ0Rc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 13:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243283AbhJ0Rcx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 13:32:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1DC360E78
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635355828;
        bh=OiXabQGhlaa7taqtlYPJihtgHrd3mTLQZz8jjFbD/WQ=;
        h=From:To:Subject:Date:From;
        b=La1QlWmHSdWucvAcuz0GmAnYl5Q9+c9wvqv0adjeVkx+jWQzA6IRbx/vnU4b7joT5
         /hJZhhro9rI5Kkorx34YBluTxdTS8E4VPMOB5o1n4R1VlSctnJ78VIVEZLucrXcyQz
         CsB9krxPreVqHdQ/psiWgOOwiOIKT4e/Rzi/R4wa2dZsL/6v+vRm2bApAJkbvVrytV
         ZSXj2zEz1JI0k0eJWPTd0VR93V67xYZJM5jQE+52dCb7c7Rxv2JvkdxNP25kHRzaOp
         hZUs7Z69vRS3Kg3b3XN9bakc91gdvz408jWRc+ZaiOnfe8geZQoVv5um5ZJboBZec9
         GRbEgcAAZ1usA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix deadlock between quota enable and other quota operations
Date:   Wed, 27 Oct 2021 18:30:25 +0100
Message-Id: <3df4731012ac6dc17f9f3a33c519735fbe89fc84.1635355240.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When enabling quotas, we attempt to commit a transaction while holding the
mutex fs_info->qgroup_ioctl_lock. This can result on a deadlock with other
quota operations such as:

- qgroup creation and deletion, ioctl BTRFS_IOC_QGROUP_CREATE;

- adding and removing qgroup relations, ioctl BTRFS_IOC_QGROUP_ASSIGN.

This is because these operations join a transaction and after that they
attempt to lock the mutex fs_info->qgroup_ioctl_lock. Acquiring that mutex
after joining or starting a transaction is a pattern followed everywhere
in qgroups, so the quota enablement operation is the one at fault here,
and should not commit a transaction while holding that mutex.

Fix this by making the transaction commit while not holding the mutex.
We are safe from two concurrent tasks trying to enable quotas because
we are serialized by the rw semaphore fs_info->subvol_sem at
btrfs_ioctl_quota_ctl(), which is the only call site for enabling
quotas.

When this deadlock happens, it produces a trace like the following:

  INFO: task syz-executor:25604 blocked for more than 143 seconds.
  Not tainted 5.15.0-rc6 #4
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:syz-executor state:D stack:24800 pid:25604 ppid: 24873 flags:0x00004004
  Call Trace:
  context_switch kernel/sched/core.c:4940 [inline]
  __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
  schedule+0xd3/0x270 kernel/sched/core.c:6366
  btrfs_commit_transaction+0x994/0x2e90 fs/btrfs/transaction.c:2201
  btrfs_quota_enable+0x95c/0x1790 fs/btrfs/qgroup.c:1120
  btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:4229 [inline]
  btrfs_ioctl+0x637e/0x7b70 fs/btrfs/ioctl.c:5010
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:874 [inline]
  __se_sys_ioctl fs/ioctl.c:860 [inline]
  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x7f86920b2c4d
  RSP: 002b:00007f868f61ac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007f86921d90a0 RCX: 00007f86920b2c4d
  RDX: 0000000020005e40 RSI: 00000000c0109428 RDI: 0000000000000008
  RBP: 00007f869212bd80 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 00007f86921d90a0
  R13: 00007fff6d233e4f R14: 00007fff6d233ff0 R15: 00007f868f61adc0
  INFO: task syz-executor:25628 blocked for more than 143 seconds.
  Not tainted 5.15.0-rc6 #4
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:syz-executor state:D stack:29080 pid:25628 ppid: 24873 flags:0x00004004
  Call Trace:
  context_switch kernel/sched/core.c:4940 [inline]
  __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
  schedule+0xd3/0x270 kernel/sched/core.c:6366
  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
  __mutex_lock_common kernel/locking/mutex.c:669 [inline]
  __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
  btrfs_remove_qgroup+0xb7/0x7d0 fs/btrfs/qgroup.c:1548
  btrfs_ioctl_qgroup_create fs/btrfs/ioctl.c:4333 [inline]
  btrfs_ioctl+0x683c/0x7b70 fs/btrfs/ioctl.c:5014
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:874 [inline]
  __se_sys_ioctl fs/ioctl.c:860 [inline]
  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported-by: Hao Sun <sunhao.th@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CACkBjsZQF19bQ1C6=yetF3BvL10OSORpFUcWXTP6HErshDB4dQ@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db680f5be745..7f6a05e670f5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -940,6 +940,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 	int slot;
 
+	/*
+	 * We need to have subvol_sem write locked, to prevent races between
+	 * concurrent tasks trying to enable quotas, because we will unlock
+	 * and relock qgroup_ioctl_lock before setting fs_info->quota_root
+	 * and before setting BTRFS_FS_QUOTA_ENABLED.
+	 */
+	lockdep_assert_held_write(&fs_info->subvol_sem);
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (fs_info->quota_root)
 		goto out;
@@ -1117,8 +1125,19 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		goto out_free_path;
 	}
 
+	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+	/*
+	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
+	 * a deadlock with tasks concurrently doing other qgroup operations, such
+	 * adding/removing qgroups or adding/deleting qgroup relations for example,
+	 * because all qgroup operations first start or join a transaction and then
+	 * lock the qgroup_ioctl_lock mutex.
+	 * We are safe from a concurrent task trying to enable quotas, by calling
+	 * this function, since we are serialized by fs_info->subvol_sem.
+	 */
 	ret = btrfs_commit_transaction(trans);
 	trans = NULL;
+	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (ret)
 		goto out_free_path;
 
-- 
2.33.0

