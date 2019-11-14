Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D678DFC185
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 09:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfKNIZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 03:25:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:50352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfKNIZx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 03:25:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78290ADBB
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 08:25:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: Don't check free space before marking a block group RO
Date:   Thu, 14 Nov 2019 16:25:47 +0800
Message-Id: <20191114082547.34846-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/072 with only one online CPU, it has a pretty high
chance to fail:

  btrfs/072 12s ... _check_dmesg: something found in dmesg (see xfstests-dev/results//btrfs/072.dmesg)
  - output mismatch (see xfstests-dev/results//btrfs/072.out.bad)
      --- tests/btrfs/072.out     2019-10-22 15:18:14.008965340 +0800
      +++ /xfstests-dev/results//btrfs/072.out.bad      2019-11-14 15:56:45.877152240 +0800
      @@ -1,2 +1,3 @@
       QA output created by 072
       Silence is golden
      +Scrub find errors in "-m dup -d single" test
      ...

And with the following call trace:
  BTRFS info (device dm-5): scrub: started on devid 1
  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -27)
  WARNING: CPU: 0 PID: 55087 at fs/btrfs/block-group.c:1890 btrfs_create_pending_block_groups+0x3e6/0x470 [btrfs]
  CPU: 0 PID: 55087 Comm: btrfs Tainted: G        W  O      5.4.0-rc1-custom+ #13
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:btrfs_create_pending_block_groups+0x3e6/0x470 [btrfs]
  Call Trace:
   __btrfs_end_transaction+0xdb/0x310 [btrfs]
   btrfs_end_transaction+0x10/0x20 [btrfs]
   btrfs_inc_block_group_ro+0x1c9/0x210 [btrfs]
   scrub_enumerate_chunks+0x264/0x940 [btrfs]
   btrfs_scrub_dev+0x45c/0x8f0 [btrfs]
   btrfs_ioctl+0x31a1/0x3fb0 [btrfs]
   do_vfs_ioctl+0x636/0xaa0
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x43/0x50
   do_syscall_64+0x79/0xe0
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  ---[ end trace 166c865cec7688e7 ]---

[CAUSE]
The error number -27 is -EFBIG, returned from the following call chain:
btrfs_end_transaction()
|- __btrfs_end_transaction()
   |- btrfs_create_pending_block_groups()
      |- btrfs_finish_chunk_alloc()
         |- btrfs_add_system_chunk()

This happens because we have used up all space of
btrfs_super_block::sys_chunk_array.

The root cause is, we have the following bad loop of creating tons of
system chunks:
1. The only SYSTEM chunk is being scrubbed
   It's very common to have only one SYSTEM chunk.
2. New SYSTEM bg will be allocated
   As btrfs_inc_block_group_ro() will check if we have enough space
   after marking current bg RO. If not, then allocate a new chunk.
3. New SYSTEM bg is still empty, will be reclaimed
   During the reclaim, we will mark it RO again.
4. That newly allocated empty SYSTEM bg get scrubbed
   We go back to step 2, as the bg is already mark RO but still not
   cleaned up yet.

If the cleaner kthread doesn't get executed fast enough (e.g. only one
CPU), then we will get more and more empty SYSTEM chunks, using up all
the space of btrfs_super_block::sys_chunk_array.

[FIX]
Since scrub/dev-replace doesn't always need to allocate new extent,
especially chunk tree extent, so we don't really need to do chunk
pre-allocation.

So to break above spiral, here we introduce a new variant of
btrfs_inc_block_group_ro(), btrfs_inc_block_group_ro_force(), which
won't do the extra free space check and chunk pre-allocation.

This should keep unnecessary empty chunks from popping up.

Also, since there are two different variants of
btrfs_inc_block_group_ro(), add more comment for both variants.

This patch is only to address the problem of btrfs/072, so here the
code of relocation side is not touched at all.
Completely removing chunk pre-allocation from btrfs_inc_block_group_ro()
will be another patch (and need extra verification).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This version is based on v5.4-rc1, for a commonly known commit hash.
It would cause conflicts due to
btrfs_block_group_cache -> btrfs_block_group refactor.

The conflicts should be easy to solve.
---
 fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++-----
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/scrub.c       | 21 ++++++++++++++++++++-
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bf7e3f23bba7..68790782bb00 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2021,8 +2021,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	return flags;
 }
 
-int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
-
+static int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache, bool force)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_trans_handle *trans;
@@ -2057,7 +2056,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 	 * block group with the new raid level.
 	 */
 	alloc_flags = update_block_group_flags(fs_info, cache->flags);
-	if (alloc_flags != cache->flags) {
+	if (alloc_flags != cache->flags && !force) {
 		ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 		/*
 		 * ENOSPC is allowed here, we may have enough space
@@ -2070,8 +2069,8 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 			goto out;
 	}
 
-	ret = inc_block_group_ro(cache, 0);
-	if (!ret)
+	ret = inc_block_group_ro(cache, force);
+	if (!ret || force)
 		goto out;
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
@@ -2091,6 +2090,30 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 	return ret;
 }
 
+/*
+ * Mark one block group read only so we won't allocate extent from this bg.
+ *
+ * This variant can return -ENOSPC as it will do extra free space check, and
+ * may allocate new chunk if there is not enough free space.
+ * This is normally used by relocation as relocation needs to do new write
+ * immediately after marking a bg RO.
+ */
+int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
+{
+	return __btrfs_inc_block_group_ro(cache, false);
+}
+
+/*
+ * Pretty much the same as btrfs_inc_block_group_ro(), but without the free
+ * space check nor chunk allocation.
+ * This variant is mostly used by scrub/replace, as there is no immediate write
+ * after marking a block group RO.
+ */
+int btrfs_inc_block_group_ro_force(struct btrfs_block_group_cache *cache)
+{
+	return __btrfs_inc_block_group_ro(cache, false);
+}
+
 void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c391800388dd..07b6c1905fef 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -206,6 +206,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 			   u64 type, u64 chunk_offset, u64 size);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
+int btrfs_inc_block_group_ro_force(struct btrfs_block_group_cache *cache);
 void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7d4e03f4c5d..40a0d8b1a602 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3563,7 +3563,26 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * -> btrfs_scrub_pause()
 		 */
 		scrub_pause_on(fs_info);
-		ret = btrfs_inc_block_group_ro(cache);
+
+		/*
+		 * Scrub itself doesn't always cause new write, so we don't need
+		 * to care free space right now.
+		 *
+		 * This forced RO is especially important for SYSTEM bgs, or we
+		 * can hit -EFBIG from btrfs_finish_chunk_alloc():
+		 * 1. The only SYSTEM bg is marked RO.
+		 *    Since SYSTEM bg is small, that's pretty common.
+		 * 2. New SYSTEM bg will be allocated
+		 *    Due to regular version will allocate new chunk.
+		 * 3. New SYSTEM bg is empty and will get cleaned up
+		 *    Before cleanup really happens, it's marked RO again.
+		 * 4. Empty SYSTEM bg get scrubbed
+		 *    We go back to 2.
+		 * This can easily boost the amount of SYSTEM chunks if cleaner
+		 * thread can't be triggered fast enough, and use up all space
+		 * of btrfs_super_block::sys_chunk_array
+		 */
+		ret = btrfs_inc_block_group_ro_force(cache);
 		if (!ret && sctx->is_dev_replace) {
 			/*
 			 * If we are doing a device replace wait for any tasks
-- 
2.24.0

