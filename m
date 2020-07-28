Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C823059E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgG1Ijg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 04:39:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgG1Ijg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 04:39:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01B3BAC65;
        Tue, 28 Jul 2020 08:39:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Luciano Chavez <chavez@us.ibm.com>
Subject: [PATCH] btrfs: inode: Fix NULL pointer dereference if inode doesn't need compression
Date:   Tue, 28 Jul 2020 16:39:26 +0800
Message-Id: <20200728083926.19518-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report of NULL pointer dereference caused in
compress_file_extent():

  Oops: Kernel access of bad area, sig: 11 [#1]
  LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
  Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
  NIP [c008000006dd4d34] compress_file_range.constprop.41+0x75c/0x8a0 [btrfs]
  LR [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs]
  Call Trace:
  [c000000c69093b00] [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs] (unreliable)
  [c000000c69093bd0] [c008000006dd4ebc] async_cow_start+0x44/0xa0 [btrfs]
  [c000000c69093c10] [c008000006e14824] normal_work_helper+0xdc/0x598 [btrfs]
  [c000000c69093c80] [c0000000001608c0] process_one_work+0x2c0/0x5b0
  [c000000c69093d10] [c000000000160c38] worker_thread+0x88/0x660
  [c000000c69093db0] [c00000000016b55c] kthread+0x1ac/0x1c0
  [c000000c69093e20] [c00000000000b660] ret_from_kernel_thread+0x5c/0x7c
  ---[ end trace f16954aa20d822f6 ]---

[CAUSE]
For the following execution route of compress_file_range(), it's
possible to hit NULL pointer dereference:

 compress_file_extent()
 |- pages = NULL;
 |- start = async_chunk->start = 0;
 |- end = async_chunk = 4095;
 |- nr_pages = 1;
 |- inode_need_compress() == false; <<< Possible, see later explanation
 |  Now, we have nr_pages = 1, pages = NULL
 |- cont:
 |- 		ret = cow_file_range_inline();
 |- 		if (ret <= 0) {
 |-		for (i = 0; i < nr_pages; i++) {
 |-			WARN_ON(pages[i]->mapping);	<<< Crash

To enter above call execution branch, we need the following race:

    Thread 1 (chattr)     |            Thread 2 (writeback)
--------------------------+------------------------------
                          | btrfs_run_delalloc_range
                          | |- inode_need_compress = true
                          | |- cow_file_range_async()
btrfs_ioctl_set_flag()    |
|- binode_flags |=        |
   BTRFS_INODE_NOCOMPRESS |
                          | compress_file_range()
                          | |- inode_need_compress = false
                          | |- nr_page = 1 while pages = NULL
                          | |  Then hit the crash

[FIX]
This patch will fix it by checking @pages before doing accessing it.
This patch is only designed as a hot fix and easy to backport.

More elegant fix may make btrfs only check inode_need_compress() once to
avoid such race, but that would be another story.

Fixes: 4d3a800ebb12 ("btrfs: merge nr_pages input and output parameter in compress_pages")
Reported-by: Luciano Chavez <chavez@us.ibm.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 611b3412fbfd..9988d754e465 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -653,12 +653,18 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 						     page_error_op |
 						     PAGE_END_WRITEBACK);
 
-			for (i = 0; i < nr_pages; i++) {
-				WARN_ON(pages[i]->mapping);
-				put_page(pages[i]);
+			/*
+			 * Ensure we only free the compressed pages if we have
+			 * them allocated, as we can still reach here with
+			 * inode_need_compress() == false.
+			 */
+			if (pages) {
+				for (i = 0; i < nr_pages; i++) {
+					WARN_ON(pages[i]->mapping);
+					put_page(pages[i]);
+				}
+				kfree(pages);
 			}
-			kfree(pages);
-
 			return 0;
 		}
 	}
-- 
2.27.0

