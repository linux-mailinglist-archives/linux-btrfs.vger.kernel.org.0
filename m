Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DBC1501CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 07:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgBCGqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 01:46:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:36828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgBCGqS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 01:46:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 948D4AD5D
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2020 06:46:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Don't submit any btree write bio after transaction is aborted
Date:   Mon,  3 Feb 2020 14:45:58 +0800
Message-Id: <20200203064558.27064-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a fuzzed image which could cause KASAN report at unmount time.

  ==================================================================
  BUG: KASAN: use-after-free in btrfs_queue_work+0x2c1/0x390
  Read of size 8 at addr ffff888067cf6848 by task umount/1922

  CPU: 0 PID: 1922 Comm: umount Tainted: G        W         5.0.21 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Call Trace:
   dump_stack+0x5b/0x8b
   print_address_description+0x70/0x280
   kasan_report+0x13a/0x19b
   btrfs_queue_work+0x2c1/0x390
   btrfs_wq_submit_bio+0x1cd/0x240
   btree_submit_bio_hook+0x18c/0x2a0
   submit_one_bio+0x1be/0x320
   flush_write_bio.isra.41+0x2c/0x70
   btree_write_cache_pages+0x3bb/0x7f0
   do_writepages+0x5c/0x130
   __writeback_single_inode+0xa3/0x9a0
   writeback_single_inode+0x23d/0x390
   write_inode_now+0x1b5/0x280
   iput+0x2ef/0x600
   close_ctree+0x341/0x750
   generic_shutdown_super+0x126/0x370
   kill_anon_super+0x31/0x50
   btrfs_kill_super+0x36/0x2b0
   deactivate_locked_super+0x80/0xc0
   deactivate_super+0x13c/0x150
   cleanup_mnt+0x9a/0x130
   task_work_run+0x11a/0x1b0
   exit_to_usermode_loop+0x107/0x130
   do_syscall_64+0x1e5/0x280
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

[CAUSE]
The fuzzed image has a corrupted extent tree, which can pass
tree-checker but run_delayed_refs() will still detect such bad extent
tree, and abort transaction.

The problem happens at unmount time, where btrfs will stop all workers
first, then call iput() on the btree inode.

Since btree inode still has some dirty pages, iput() will try to write
back such dirty pages, but all related work queues are already freed,
triggering use-after-free bug.

[FIX]
To fix this problem, make btree_write_cache_pages() to check if the
transaction is aborted before submitting write bio.

If the transaction is already aborted, then just end the write bio
without submitting it. So there is no way to trigger such use-after-free
bug after a transaction is aborted.

Link: https://github.com/bobfuzzer/CVE/tree/master/CVE-2019-19377
CVE: CVE-2019-19377
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2f4802f405a2..0c58c7c230e6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3927,6 +3927,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
+	struct btrfs_fs_info *fs_info = tree->fs_info;
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
@@ -4036,7 +4037,12 @@ int btree_write_cache_pages(struct address_space *mapping,
 		end_write_bio(&epd, ret);
 		return ret;
 	}
-	ret = flush_write_bio(&epd);
+	if (!test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state)) {
+		ret = flush_write_bio(&epd);
+	} else {
+		ret = -EUCLEAN;
+		end_write_bio(&epd, ret);
+	}
 	return ret;
 }
 
-- 
2.25.0

