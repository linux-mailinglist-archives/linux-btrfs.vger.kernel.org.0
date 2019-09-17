Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7942DB47CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 08:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfIQG5i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 02:57:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727635AbfIQG5h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 02:57:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7744AD29;
        Tue, 17 Sep 2019 06:57:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Lai Wei-Hwa <whlai@robco.com>
Subject: [PATCH RFC] btrfs: volumes: Check if we're hitting sys chunk array size limit before allocating new sys chunks
Date:   Tue, 17 Sep 2019 14:57:30 +0800
Message-Id: <20190917065730.28788-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a user reporting strange EFBIG error causing transaction to be
aborted.

[Sep14 20:02] ------------[ cut here ]------------
[ +0.000042] WARNING: CPU: 18 PID: 28882 at linux-4.4.0/fs/btrfs/extent-tree.c:10046 btrfs_create_pending_block_groups+0x144/0x1f0 [btrfs]()
[ +0.000002] BTRFS: Transaction aborted (error -27)
[ +0.000002] Call Trace:
[ +0.000008] [<ffffffff8140c9a1>] dump_stack+0x63/0x82
[ +0.000007] [<ffffffff810864d2>] warn_slowpath_common+0x82/0xc0
[ +0.000002] [<ffffffff8108656c>] warn_slowpath_fmt+0x5c/0x80
[ +0.000014] [<ffffffffc01f31c4>] ? btrfs_finish_chunk_alloc+0x204/0x5a0 [btrfs]
[ +0.000011] [<ffffffffc01b1d24>] btrfs_create_pending_block_groups+0x144/0x1f0 [btrfs]
[ +0.000012] [<ffffffffc01c7ed3>] __btrfs_end_transaction+0x93/0x340 [btrfs]
[ +0.000013] [<ffffffffc01c8190>] btrfs_end_transaction+0x10/0x20 [btrfs]
[ +0.000010] [<ffffffffc01b5a4d>] btrfs_inc_block_group_ro+0xed/0x1b0 [btrfs]
[ +0.000014] [<ffffffffc02253bf>] scrub_enumerate_chunks+0x21f/0x580 [btrfs]
[ +0.000004] [<ffffffff810cb700>] ? wake_atomic_t_function+0x60/0x60
[ +0.000013] [<ffffffffc0226d0c>] btrfs_scrub_dev+0x1bc/0x530 [btrfs]
[ +0.000004] [<ffffffff8123f306>] ? __mnt_want_write+0x56/0x60
[ +0.000013] [<ffffffffc0202408>] btrfs_ioctl+0x1ac8/0x28c0 [btrfs]
[ +0.000003] [<ffffffff8119a3b9>] ? unlock_page+0x69/0x70
[ +0.000002] [<ffffffff8119a654>] ? filemap_map_pages+0x224/0x230
[ +0.000004] [<ffffffff811cdb77>] ? handle_mm_fault+0x10f7/0x1b80
[ +0.000002] [<ffffffff811fb77b>] ? kmem_cache_alloc_node+0xbb/0x210
[ +0.000003] [<ffffffff813e13e3>] ? create_task_io_context+0x23/0x100
[ +0.000003] [<ffffffff812318ef>] do_vfs_ioctl+0x2af/0x4b0
[ +0.000002] [<ffffffff813e1510>] ? get_task_io_context+0x50/0x90
[ +0.000003] [<ffffffff813f0936>] ? set_task_ioprio+0x86/0xa0
[ +0.000002] [<ffffffff81231b69>] SyS_ioctl+0x79/0x90
[ +0.000004] [<ffffffff81864f1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
[ +0.000002] ---[ end trace 13fce4e84d9b6aed ]---
[ +0.000003] BTRFS: error (device sda1) in btrfs_create_pending_block_groups:10046: errno=-27 unknown
[ +0.003942] BTRFS info (device sda1): forced readonly

[CAUSE]
From the backtrace, the EFBIG is from btrfs_add_system_chunk() where the
new system chunk is unable to be inserted in super block.

Indeed we can't do much to help such problem, but at least we can avoid
such situation when allocating new chunk.

[FIX]
At chunk allocation time, we iterate through the new_bgs list which
records all new chunks allocated in current transaction.

And account all new system chunks and its space to be used in super block,
along with the size of the to-be-allocated chunk to see if it exceeds
the sys chunk size limit.

Such early check will make __btrfs_alloc_chunk() return -EFBIG, and
prevent transaction abort in btrfs_create_pending_block_groups().

Reported-by: Lai Wei-Hwa <whlai@robco.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
This patch is only to provide early graceful exit, the root reason for
the initial report is still not fully discovered.

So I keep the RFC tag until the initial report can be solved.
---
 fs/btrfs/volumes.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a447d3ec48d5..05d328ce229f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4901,6 +4901,51 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID56);
 }
 
+static bool check_syschunk_array_size(struct btrfs_trans_handle *trans,
+				      int num_stripes)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_cache *cache;
+	u32 sb_array_size;
+	u32 needed = 0;
+
+	lockdep_assert_held(&fs_info->chunk_mutex);
+	sb_array_size = btrfs_super_sys_array_size(fs_info->super_copy);
+
+	/*
+	 * Check and calculate all existing sys chunks in new_bgs.
+	 * As new system chunks will take up sys chunk array in super block, we
+	 * want to error out early before we ate up all sys chunk array.
+	 *
+	 * This list is only modified by btrfs_make_block_group() and
+	 * btrfs_create_pending_block_groups().
+	 *
+	 * The former is only called in __btrfs_alloc_chunk() and protected
+	 * by fs_info->chunk_mutex.
+	 * The later is called when the last trans handle get ended in
+	 * __btrfs_end_transaction() or btrfs_commit_transaction(), thus there
+	 * is no race as long as we hold a trans handle.
+	 */
+	list_for_each_entry(cache, &trans->new_bgs, bg_list) {
+		if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
+			struct extent_map *em;
+
+			em = btrfs_get_chunk_map(fs_info, cache->key.objectid,
+						 1);
+			/* Can't get a chunk map? It's a problem by all means */
+			if (IS_ERR(em))
+				return false;
+			needed += btrfs_chunk_item_size(
+					em->map_lookup->num_stripes);
+			needed += sizeof(struct btrfs_disk_key);
+			free_extent_map(em);
+		}
+	}
+	if (sb_array_size + needed > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE)
+		return false;
+	return true;
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -5071,6 +5116,13 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
 	num_stripes = ndevs * dev_stripes;
 
+	if (type & BTRFS_BLOCK_GROUP_SYSTEM &&
+	    !check_syschunk_array_size(trans, num_stripes)) {
+		/* Use the unique errno to distinguish from ordinary ENOSPC */
+		ret = -EFBIG;
+		goto error;
+	}
+
 	/*
 	 * this will have to be fixed for RAID1 and RAID10 over
 	 * more drives
-- 
2.23.0

