Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB64B2134A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 09:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGCHF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 03:05:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCHF6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 03:05:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFCAAAC67;
        Fri,  3 Jul 2020 07:05:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Subject: [PATCH] btrfs: discard: reduce the block group ref when grabbing from unused block group list
Date:   Fri,  3 Jul 2020 15:05:50 +0800
Message-Id: <20200703070550.39299-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following small test script can trigger ASSERT() at unmount time:

  mkfs.btrfs -f $dev
  mount $dev $mnt
  mount -o remount,discard=async $mnt
  umount $mnt

The call trace:
  assertion failed: atomic_read(&block_group->count) == 1, in fs/btrfs/block-group.c:3431
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3204!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 4 PID: 10389 Comm: umount Tainted: G           O      5.8.0-rc3-custom+ #68
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   btrfs_free_block_groups.cold+0x22/0x55 [btrfs]
   close_ctree+0x2cb/0x323 [btrfs]
   btrfs_put_super+0x15/0x17 [btrfs]
   generic_shutdown_super+0x72/0x110
   kill_anon_super+0x18/0x30
   btrfs_kill_super+0x17/0x30 [btrfs]
   deactivate_locked_super+0x3b/0xa0
   deactivate_super+0x40/0x50
   cleanup_mnt+0x135/0x190
   __cleanup_mnt+0x12/0x20
   task_work_run+0x64/0xb0
   __prepare_exit_to_usermode+0x1bc/0x1c0
   __syscall_return_slowpath+0x47/0x230
   do_syscall_64+0x64/0xb0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

The code:
                ASSERT(atomic_read(&block_group->count) == 1);
                btrfs_put_block_group(block_group);

[CAUSE]
Obviously it's some btrfs_get_block_group() call doesn't get its put
call.

The offending btrfs_get_block_group() happens here:

  void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
  {
  	if (list_empty(&bg->bg_list)) {
  		btrfs_get_block_group(bg);
		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
  	}
  }

So every call sites removing the block group from unused_bgs list should
reduce the ref count of that block group.

However for async discard, it didn't follow the call convention:

  void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
  {
  	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
  				 bg_list) {
  		list_del_init(&block_group->bg_list);
  		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
  	}
  }

And in btrfs_discard_queue_work(), it doesn't call
btrfs_put_block_group() either.

[FIX]
Fix the problem by reducing the reference count when we grab the block
group from unused_bgs list.

Reported-by: Marcos Paulo de Souza <marcos@mpdesouza.com>
Fixes: 6e80d4f8c422 ("btrfs: handle empty block_group removal for async discard")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/discard.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 5615320fa659..741c7e19c32f 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -619,6 +619,7 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
 				 bg_list) {
 		list_del_init(&block_group->bg_list);
+		btrfs_put_block_group(block_group);
 		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
-- 
2.27.0

