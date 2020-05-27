Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC71E3EC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbgE0KQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387852AbgE0KQH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:16:07 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2F42088E
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590574566;
        bh=vQl6atDbonTYlmerm/lkkD2claKQ1uTR77H9mnV8sos=;
        h=From:To:Subject:Date:From;
        b=Y+tSxzQuI2FQs20Czy6jK5jQ9Ipkqm8iQdvwMyOXktRWBi0p7fcliWMd9ZevKknEH
         l0KiUpgpICbeknpXiaO//s303O4zvyvODSW9I4SZh5JtF98aFjUl2hHo9YvBqRF4rH
         9CrSxoJx0cWmScp3+TgKgijhvDjNOQUhLoRva5as=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] Btrfs: fix space_info bytes_may_use underflow after nocow buffered write
Date:   Wed, 27 May 2020 11:16:07 +0100
Message-Id: <20200527101607.25447-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a buffered write we always try to reserve data space for it,
even when the file has the NOCOW bit set or the write falls into a file
range covered by a prealloc extent. This is done both because it is
expensive to check if we can do a nocow write (checking if an extent is
shared through reflinks or if there's a hole in the range for example),
and because when writeback starts we might actually need to fallback to
COW mode (for example the block group containing the target extents was
turned into RO mode due to a scrub or balance).

When we are unable to reserve data space we check if we can do a nocow
write, and if we can, we proceed with dirtying the pages and setting up
the range for delalloc. In this case the bytes_may_use counter of the
data space_info object is not incremented, unlike in the case where we
are able to reserve data space (done through btrfs_check_data_free_space()
which calls btrfs_alloc_data_chunk_ondemand()).

Later when running delalloc we attempt to start writeback in nocow mode
but we might revert back to cow mode, for example because in the meanwhile
a block group was turned into RO mode by a scrub or relocation. The cow
path after successfully allocating an extent ends up calling
btrfs_add_reserved_bytes(), which expects the bytes_may_use counter of
the data space_info object to have been incremented before - but we did
not do it when the buffered write started, since there was not enough
available data space. So btrfs_add_reserved_bytes() ends up decrementing
the bytes_may_use counter anyway, and when the counter's current value
is smaller then the size of the allocated extent we get a stack trace
like the following:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 20138 at fs/btrfs/space-info.h:115 btrfs_add_reserved_bytes+0x3d6/0x4e0 [btrfs]
 Modules linked in: btrfs blake2b_generic xor raid6_pq libcrc32c (...)
 CPU: 0 PID: 20138 Comm: kworker/u8:15 Not tainted 5.6.0-rc7-btrfs-next-58 #5
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
 Workqueue: writeback wb_workfn (flush-btrfs-1754)
 RIP: 0010:btrfs_add_reserved_bytes+0x3d6/0x4e0 [btrfs]
 Code: ff ff 48 (...)
 RSP: 0018:ffffbda18a4b3568 EFLAGS: 00010287
 RAX: 0000000000000000 RBX: ffff9ca076f5d800 RCX: 0000000000000000
 RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff9ca068470410
 RBP: fffffffffffff000 R08: 0000000000000001 R09: 0000000000000000
 R10: ffff9ca079d58040 R11: 0000000000000000 R12: ffff9ca068470400
 R13: ffff9ca0408b2000 R14: 0000000000001000 R15: ffff9ca076f5d800
 FS:  0000000000000000(0000) GS:ffff9ca07a600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00005605dbfe7048 CR3: 0000000138570006 CR4: 00000000003606f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  find_free_extent+0x4a0/0x16c0 [btrfs]
  btrfs_reserve_extent+0x91/0x180 [btrfs]
  cow_file_range+0x12d/0x490 [btrfs]
  run_delalloc_nocow+0x341/0xa40 [btrfs]
  btrfs_run_delalloc_range+0x1ea/0x6d0 [btrfs]
  ? find_lock_delalloc_range+0x221/0x250 [btrfs]
  writepage_delalloc+0xe8/0x150 [btrfs]
  __extent_writepage+0xe8/0x4c0 [btrfs]
  extent_write_cache_pages+0x237/0x530 [btrfs]
  ? btrfs_wq_submit_bio+0x9f/0xc0 [btrfs]
  extent_writepages+0x44/0xa0 [btrfs]
  do_writepages+0x23/0x80
  __writeback_single_inode+0x59/0x700
  writeback_sb_inodes+0x267/0x5f0
  __writeback_inodes_wb+0x87/0xe0
  wb_writeback+0x382/0x590
  ? wb_workfn+0x4a2/0x6c0
  wb_workfn+0x4a2/0x6c0
  process_one_work+0x26d/0x6a0
  worker_thread+0x4f/0x3e0
  ? process_one_work+0x6a0/0x6a0
  kthread+0x103/0x140
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x3a/0x50
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff94ebdedf>] copy_process+0x74f/0x2020
 softirqs last  enabled at (0): [<ffffffff94ebdedf>] copy_process+0x74f/0x2020
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace f9f6ef8ec4cd8ec9 ]---

So to fix this, when falling back into cow mode check if space was not
reserved, by testing for the bit EXTENT_NORESERVE in the respective file
range, and if not, increment the bytes_may_use counter for the data
space_info object. Also clear the EXTENT_NORESERVE bit from the range, so
that if the cow path fails it decrements the bytes_may_use counter when
clearing the delalloc range (through the btrfs_clear_delalloc_extent()
callback).

Fixes: 7ee9e4405f264e ("Btrfs: check if we can nocow if we don't have data space")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 79f833f920d3..9edfe2453d86 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -49,6 +49,7 @@
 #include "qgroup.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "space-info.h"
 
 struct btrfs_iget_args {
 	struct btrfs_key *location;
@@ -1355,6 +1356,59 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 	return 1;
 }
 
+static int fallback_to_cow(struct inode *inode,
+			   struct page *locked_page,
+			   const u64 start,
+			   const u64 end,
+			   int *page_started,
+			   unsigned long *nr_written)
+{
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	u64 range_start = start;
+	u64 count;
+
+	/*
+	 * If EXTENT_NORESERVE is set it means that when the buffered write was
+	 * made we had not enough available data space and therefore we did not
+	 * reserve data space for it, since we though we could do NOCOW for the
+	 * respective file range (either there is prealloc extent or the inode
+	 * has the NOCOW bit set).
+	 *
+	 * However when we need to fallback to COW mode (because for example the
+	 * block group for the corresponding extent was turned to RO mode by a
+	 * scrub or relocation) we need to do the following:
+	 *
+	 * 1) We increment the bytes_may_use counter of the data space info.
+	 *    If COW succeeds, it allocates a new data extent and after doing
+	 *    that it decrements the space info's bytes_may_use counter and
+	 *    increments its bytes_reserved counter by the same amount (we do
+	 *    this at btrfs_add_reserved_bytes()). So we need to increment the
+	 *    bytes_may_use counter to compensate (when space is reserved at
+	 *    buffered write time, the bytes_may_use counter is incremented);
+	 *
+	 * 2) We clear the EXTENT_NORESERVE bit from the range. We do this so
+	 *    that if the COW path fails for any reason, it decrements (through
+	 *    extent_clear_unlock_delalloc()) the bytes_may_use counter of the
+	 *    data space info, which we incremented in the step above.
+	 */
+	count = count_range_bits(io_tree, &range_start, end, end + 1 - start,
+				 EXTENT_NORESERVE, 0);
+	if (count > 0) {
+		struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+		struct btrfs_space_info *sinfo = fs_info->data_sinfo;
+
+		spin_lock(&sinfo->lock);
+		btrfs_space_info_update_bytes_may_use(fs_info, sinfo, count);
+		spin_unlock(&sinfo->lock);
+
+		clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE, 0, 0,
+				 NULL);
+	}
+
+	return cow_file_range(inode, locked_page, start, end, page_started,
+			      nr_written, 1);
+}
+
 /*
  * when nowcow writeback call back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
@@ -1602,9 +1656,9 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		 * NOCOW, following one which needs to be COW'ed
 		 */
 		if (cow_start != (u64)-1) {
-			ret = cow_file_range(inode, locked_page,
-					     cow_start, found_key.offset - 1,
-					     page_started, nr_written, 1);
+			ret = fallback_to_cow(inode, locked_page, cow_start,
+					      found_key.offset - 1,
+					      page_started, nr_written);
 			if (ret) {
 				if (nocow)
 					btrfs_dec_nocow_writers(fs_info,
@@ -1693,8 +1747,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 
 	if (cow_start != (u64)-1) {
 		cur_offset = end;
-		ret = cow_file_range(inode, locked_page, cow_start, end,
-				     page_started, nr_written, 1);
+		ret = fallback_to_cow(inode, locked_page, cow_start, end,
+				      page_started, nr_written);
 		if (ret)
 			goto error;
 	}
-- 
2.11.0

