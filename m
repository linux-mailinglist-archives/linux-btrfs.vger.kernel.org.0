Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1315BEE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgBMNCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 08:02:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:38032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgBMNCJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 08:02:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13C0FADCC
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 13:02:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.de>
Subject: [PATCH] btrfs: Don't free tree_root when exiting btrfs_ioctl_get_subvol_info()
Date:   Thu, 13 Feb 2020 21:01:57 +0800
Message-Id: <20200213130157.39230-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When calling BTRF_IOC_GET_SUBVOL_INFO ioctl, we can easily hit the
following backtrace:
  BUG: kernel NULL pointer dereference, address: 0000000000000024
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 0 PID: 27421 Comm: python3 Not tainted 5.6.0-rc1+ #539
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
  RIP: 0010:btrfs_root_node+0x7/0x30 [btrfs]
  Call Trace:
   btrfs_read_lock_root_node+0x1f/0x40 [btrfs]
   btrfs_search_slot+0x60f/0xa40 [btrfs]
   btrfs_ioctl+0x11f7/0x30b0 [btrfs]
   ksys_ioctl+0x82/0xc0
   __x64_sys_ioctl+0x11/0x20
   do_syscall_64+0x43/0x130
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7fcb78d43387
  ---[ end trace 1c21a7c6c0523b8c ]---

[CAUSE]
We're abusing local @root, it's originally a subvolume root, but in
root backref search, it's re-assigned to tree_root.

Then we call "btrfs_put_root(root);" when exiting.
If that @root is reassgined to tree-root, we freed the most important
tree, and cause use-after-free.

[FIX]
Don't re-assgiend @root, use fs_info->tree_root directly.

Reported-by: Marcos Paulo de Souza <mpdesouza@suse.de>
Fixes: 8c319b625e0a ("btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info")
[To David: please fold the fix into that commit]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e6b7cf45a066..43195970f70c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2696,17 +2696,16 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	subvol_info->rtime.nsec = btrfs_stack_timespec_nsec(&root_item->rtime);
 
 	if (key.objectid != BTRFS_FS_TREE_OBJECTID) {
-		/* Search root tree for ROOT_BACKREF of this subvolume */
-		root = fs_info->tree_root;
-
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = 0;
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+
+		/* Search root tree for ROOT_BACKREF of this subvolume */
+		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 		if (ret < 0) {
 			goto out;
 		} else if (path->slots[0] >=
 			   btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(root, path);
+			ret = btrfs_next_leaf(fs_info->tree_root, path);
 			if (ret < 0) {
 				goto out;
 			} else if (ret > 0) {
-- 
2.25.0

