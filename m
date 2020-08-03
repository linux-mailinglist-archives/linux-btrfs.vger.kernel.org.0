Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1E239F95
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 08:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHCGUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 02:20:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgHCGUY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 02:20:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27CAEAF38
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 06:20:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: sysfs: fix NULL pointer dereference at btrfs_sysfs_del_qgroups()
Date:   Mon,  3 Aug 2020 14:20:11 +0800
Message-Id: <20200803062011.17291-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With next-20200731 tag (079ad2fb4bf9eba8a0aaab014b49705cd7f07c66),
unmounting a btrfs with quota disabled will cause the following NULL
pointer dereference:

  BTRFS info (device dm-5): has skinny extents
  BUG: kernel NULL pointer dereference, address: 0000000000000018
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  CPU: 7 PID: 637 Comm: umount Not tainted 5.8.0-rc7-next-20200731-custom #76
  RIP: 0010:kobject_del+0x6/0x20
  Call Trace:
   btrfs_sysfs_del_qgroups+0xac/0xf0 [btrfs]
   btrfs_free_qgroup_config+0x63/0x70 [btrfs]
   close_ctree+0x1f5/0x323 [btrfs]
   btrfs_put_super+0x15/0x17 [btrfs]
   generic_shutdown_super+0x72/0x110
   kill_anon_super+0x18/0x30
   btrfs_kill_super+0x17/0x30 [btrfs]
   deactivate_locked_super+0x3b/0xa0
   deactivate_super+0x40/0x50
   cleanup_mnt+0x135/0x190
   __cleanup_mnt+0x12/0x20
   task_work_run+0x64/0xb0
   exit_to_user_mode_prepare+0x18a/0x190
   syscall_exit_to_user_mode+0x4f/0x270
   do_syscall_64+0x45/0x50
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ---[ end trace 37b7adca5c1d5c5d ]---

[CAUSE]
Commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
kobject_cleanup()") changed kobject_del() that it no longer accepts NULL
pointer.

Before that commit, kobject_del() and kobject_put() all accept NULL
pointers and just ignore such NULL pointers.

But that mentioned commit needs to access the parent node, killing the
old NULL pointer behavior.

Unfortunately btrfs is relying on that hidden feature thus we will
trigger such NULL pointer dereference.

[FIX]
Instead of just saving several lines, do proper fs_info->qgroups_kobj
check before calling kobject_del() and kobject_put().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 104c80caaa74..c8df2edafd85 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1565,9 +1565,11 @@ void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info)
 	rbtree_postorder_for_each_entry_safe(qgroup, next,
 					     &fs_info->qgroup_tree, node)
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
-	kobject_del(fs_info->qgroups_kobj);
-	kobject_put(fs_info->qgroups_kobj);
-	fs_info->qgroups_kobj = NULL;
+	if (fs_info->qgroups_kobj) {
+		kobject_del(fs_info->qgroups_kobj);
+		kobject_put(fs_info->qgroups_kobj);
+		fs_info->qgroups_kobj = NULL;
+	}
 }
 
 /* Called when qgroups get initialized, thus there is no need for locking */
-- 
2.28.0

