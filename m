Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81E823B573
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 09:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHDHPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 03:15:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHDHPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Aug 2020 03:15:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75F1EAC85
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Aug 2020 07:16:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: sysfs: fix NULL pointer dereference at btrfs_sysfs_del_qgroups()
Date:   Tue,  4 Aug 2020 15:15:42 +0800
Message-Id: <20200804071543.33411-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804071543.33411-1-wqu@suse.com>
References: <20200804071543.33411-1-wqu@suse.com>
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
 fs/btrfs/compression.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1ab56a734e70..17c27edd804b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -115,10 +115,14 @@ static int compression_compress_pages(int type, struct list_head *ws,
 	case BTRFS_COMPRESS_NONE:
 	default:
 		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here. As a sane fallback, return what the
-		 * callers will understand as 'no compression happened'.
+		 * This happens when compression races with remount to no
+		 * compress, while caller doesn't call inode_need_compress()
+		 * to check if we really need to compress.
+		 *
+		 * Not a big deal, just need to inform caller that we
+		 * haven't allocated any pages yet.
 		 */
+		*out_pages = 0;
 		return -E2BIG;
 	}
 }
-- 
2.28.0

