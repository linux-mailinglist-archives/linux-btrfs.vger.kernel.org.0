Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70B552B3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbiFUGoH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiFUGoG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:44:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FC1B7B3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655793843; x=1687329843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ye5mulVRtQm8sh5Cog5V39eofpB8oOVMFQt6emy1IQ=;
  b=HHCZjpvtQJVnEbCdyqVFwvn9oHA/GZYtot6zA2hrJpiistW6jm02GByU
   y1Y4l36cGCLTDzSj2ryDNkqnjHjpXOpx9LJCBwS4TLNNGYfIMsP23csts
   DkApFm+l5JyxsWLBiLJaIUklf3kXEgmK4aBD2JGYcXJWaRiJGmwNGX3/s
   xkN2v+GJt5d0ev3JnMw95Alf/ufzlRz1YX/kgkwxp0Hxx3XVxCngnFpJn
   rTxzMrgbIho18r1beMr4T3Afv4OxHVZct6pBY4Imd2QlTVcsQ5AF4Ex61
   /COHOd3Isgc7alPpGV2pqBNoCAeUzK7XUw7TKi7k7QX2PJ+EL/jAo4+rd
   w==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="208550409"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 14:44:02 +0800
IronPort-SDR: T2y7C5o1whEkery/Crkjb8QSI6+kCdN+JLqDkj99XW8zm8HH6e5eYrvvQnRflZWOiWVJ5ItKI9
 Y0oxCCfZ2q9CQC/T/cFMs7Zr60TCrFSpO+WIs5ENEznsJ8vVj5QxQgmyztpd8u2qmcam7iONzE
 eZj6lkR1L4HKfw8jeQ/ewRN8aagciulI+iw0S3eQSAOc6eWaz5cpKm4GsvvBgf7y7xtHL57A3G
 B78dBLAIFAOhTZyH3mwB7w6JtFOhHASgLhg9wHXfco1lj4+WUbyxK3lcjACUdmi9D5gjlviCNZ
 ocNMhuEETSJ2LFqR1bVcJn1/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 23:02:11 -0700
IronPort-SDR: 40LYZqPjiQFWaSlqdUZnPKAgFZLJHDbrDcqu7/05YUwQyER/z+S66FY2Gn3C/DuXBi0U2s1CNv
 rwxVqG7LWcadpwtn60eiDLmZ3ok9Dz60q3sG8QnoDeNaBfMuEiYev5egss5C2Brfdq3VJKJ7n7
 eiPtRmp/YlX7RJV099EyzZ2DuXb1ODla1Umz0q4V1P6anUo5okgmPjd7U03tuG4TpErT5poETC
 crUjmpVrojIUrB8UxMgaanrD/iFvVBjRAAQjHXIyx/WebgIDkfDEqs5AKOC/HXvOCeNE6VWPjR
 pb8=
WDCIronportException: Internal
Received: from dtjcyy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jun 2022 23:44:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/4] btrfs: ensure pages are unlocked on cow_file_range() failure
Date:   Tue, 21 Jun 2022 15:40:59 +0900
Message-Id: <3ae46fc143bf820a39e7cf425d675d6825af849d.1655791781.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655791781.git.naohiro.aota@wdc.com>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a hung_task report on zoned btrfs like below.

https://github.com/naota/linux/issues/59

[  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241 seconds.
[  726.329839]       Not tainted 5.16.0-rc1+ #1
[  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid: 11082 flags:0x00000000
[  726.331608] Call Trace:
[  726.331611]  <TASK>
[  726.331614]  __schedule+0x2e5/0x9d0
[  726.331622]  schedule+0x58/0xd0
[  726.331626]  io_schedule+0x3f/0x70
[  726.331629]  __folio_lock+0x125/0x200
[  726.331634]  ? find_get_entries+0x1bc/0x240
[  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
[  726.331642]  truncate_inode_pages_range+0x5b2/0x770
[  726.331649]  truncate_inode_pages_final+0x44/0x50
[  726.331653]  btrfs_evict_inode+0x67/0x480
[  726.331658]  evict+0xd0/0x180
[  726.331661]  iput+0x13f/0x200
[  726.331664]  do_unlinkat+0x1c0/0x2b0
[  726.331668]  __x64_sys_unlink+0x23/0x30
[  726.331670]  do_syscall_64+0x3b/0xc0
[  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  726.331677] RIP: 0033:0x7fb9490a171b
[  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb9490a171b
[  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb94400d300
[  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0000000000000000
[  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb943ffb000
[  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb943ffd260
[  726.331693]  </TASK>

While we debug the issue, we found running fstests generic/551 on 5GB
non-zoned null_blk device in the emulated zoned mode also had a
similar hung issue.

Also, we can reproduce the same symptom with an error injected
cow_file_range() setup.

The hang occurs when cow_file_range() fails in the middle of
allocation. cow_file_range() called from do_allocation_zoned() can
split the give region ([start, end]) for allocation depending on
current block group usages. When btrfs can allocate bytes for one part
of the split regions but fails for the other region (e.g. because of
-ENOSPC), we return the error leaving the pages in the succeeded regions
locked. Technically, this occurs only when @unlock == 0. Otherwise, we
unlock the pages in an allocated region after creating an ordered
extent.

Considering the callers of cow_file_range(unlock=0) won't write out
the pages, we can unlock the pages on error exit from
cow_file_range(). So, we can ensure all the pages except @locked_page
are unlocked on error case.

In summary, cow_file_range now behaves like this:

- page_started == 1 (return value)
  - All the pages are unlocked. IO is started.
- unlock == 1
  - All the pages except @locked_page are unlocked in any case
- unlock == 0
  - On success, all the pages are locked for writing out them
  - On failure, all the pages except @locked_page are unlocked

Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path for zoned filesystems")
CC: stable@vger.kernel.org # 5.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d5351454f11..4f453f6077fe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1133,6 +1133,28 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * *page_started is set to one if we unlock locked_page and do everything
  * required to start IO on it.  It may be clean and already done with
  * IO when we return.
+ *
+ * When unlock == 1, we unlock the pages in successfully allocated regions.
+ * When unlock == 0, we leave them locked for writing them out.
+ *
+ * However, we unlock all the pages except @locked_page in case of failure.
+ *
+ * In summary, page locking state will be as follow:
+ *
+ * - page_started == 1 (return value)
+ *     - All the pages are unlocked. IO is started.
+ *     - Note that this can happen only on success
+ * - unlock == 1
+ *     - All the pages except @locked_page are unlocked in any case
+ * - unlock == 0
+ *     - On success, all the pages are locked for writing out them
+ *     - On failure, all the pages except @locked_page are unlocked
+ *
+ * When a failure happens in the second or later iteration of the
+ * while-loop, the ordered extents created in previous iterations are kept
+ * intact. So, the caller must clean them up by calling
+ * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
+ * example.
  */
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
@@ -1142,6 +1164,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 alloc_hint = 0;
+	u64 orig_start = start;
 	u64 num_bytes;
 	unsigned long ram_size;
 	u64 cur_alloc_size = 0;
@@ -1329,18 +1352,44 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_unlock:
+	/*
+	 * Now, we have three regions to clean up, as shown below.
+	 *
+	 * |-------(1)----|---(2)---|-------------(3)----------|
+	 * `- orig_start  `- start  `- start + cur_alloc_size  `- end
+	 *
+	 * We process each region below.
+	 */
+
 	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
 	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
+
 	/*
-	 * If we reserved an extent for our delalloc range (or a subrange) and
-	 * failed to create the respective ordered extent, then it means that
-	 * when we reserved the extent we decremented the extent's size from
-	 * the data space_info's bytes_may_use counter and incremented the
-	 * space_info's bytes_reserved counter by the same amount. We must make
-	 * sure extent_clear_unlock_delalloc() does not try to decrement again
-	 * the data space_info's bytes_may_use counter, therefore we do not pass
-	 * it the flag EXTENT_CLEAR_DATA_RESV.
+	 * For the range (1). We have already instantiated the ordered extents
+	 * for this region. They are cleaned up by
+	 * btrfs_cleanup_ordered_extents() in e.g,
+	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
+	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
+	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
+	 * function.
+	 *
+	 * However, in case of unlock == 0, we still need to unlock the pages
+	 * (except @locked_page) to ensure all the pages are unlocked.
+	 */
+	if (!unlock && orig_start < start)
+		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
+					     locked_page, 0, page_ops);
+
+	/*
+	 * For the range (2). If we reserved an extent for our delalloc range
+	 * (or a subrange) and failed to create the respective ordered extent,
+	 * then it means that when we reserved the extent we decremented the
+	 * extent's size from the data space_info's bytes_may_use counter and
+	 * incremented the space_info's bytes_reserved counter by the same
+	 * amount. We must make sure extent_clear_unlock_delalloc() does not try
+	 * to decrement again the data space_info's bytes_may_use counter,
+	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
 	 */
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
@@ -1352,6 +1401,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (start >= end)
 			goto out;
 	}
+
+	/*
+	 * For the range (3). We never touched the region. In addition to the
+	 * clear_bits above, we add EXTENT_CLEAR_DATA_RESV to release the data
+	 * space_info's bytes_may_use counter, reserved in
+	 * btrfs_check_data_free_space().
+	 */
 	extent_clear_unlock_delalloc(inode, start, end, locked_page,
 				     clear_bits | EXTENT_CLEAR_DATA_RESV,
 				     page_ops);
-- 
2.35.1

