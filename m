Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629E1471FA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 04:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhLMDno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Dec 2021 22:43:44 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38984 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhLMDno (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Dec 2021 22:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639367023; x=1670903023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UnL2ARUKUZELiR/g/y4b4UydQMuERT/WXTUOO9nrYSU=;
  b=VxQI+/hT35ZVtq+m4iRUFQ1iHUmDMWaDv8Ui20a9+vt/OxeGlhw9xu42
   tbAphPHgTEuvwqgDxyaOCNJO7Pwmwm5k98egZCpQHjoC9wOnpoaf9ry34
   JLizdFJRDYxWUXEdORzeohiYY3hlZjOB+nVBDkqbjQBm0i0NycbT6TpNr
   ibQVO8uqXu/M/5XubAGBwV6V+4bQX+t85NnzFPcz9ivGO86HfPxWej2KF
   PEjETgxRxGW7TyK0HoI8WonkOR17kysVHdNA19BXvue17Er/0/X2fvWVf
   0zwgZBKnSQ4HlGHNmAXgSB7OZ0Av82bEz909nSZhFRITCkN7UpNHZmOUO
   A==;
X-IronPort-AV: E=Sophos;i="5.88,201,1635177600"; 
   d="scan'208";a="192868600"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2021 11:43:42 +0800
IronPort-SDR: Sg47LpC4s+APfPe1/vBPPlWmwhZu68e7w+V3FZsULfnWNOW8k/N5ZtmNnMHJsZVpisQcSoPahK
 sdLQroAU8PjNasxonEc9rzuBVWFPIEvPSL+8CQ0CJBHI9OE1wOLDTQmmVhHM4ZQtyvBRsoddXV
 LWParzIXxWTZQabi1TQbrgeXTvOCM2MqswstR12mOw6XN46QAghdr4Zs+KQJNKNwCDiY07rGPB
 ptQJ0tCbKI5iUGH0MvbUp1MYorHRHR2juN4KI0dFRLG3J7JGBOA6TFYUP7iQYnG13Z7P+IqWQw
 TBO69rIsPEnQdzOwVWCC1mgG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 19:16:42 -0800
IronPort-SDR: isShulqptjWVjJkc9APrFMGyT7O/SSGI+etn1UIPHymZconi+cPptNArqpNh8xTZTBCbrS/hlf
 jz3F6/DD186n35Bsq5yQBx5WpbobSRzHpysVyfdXEnMPin5WX0HnssopgMXdyNRIjte2TnPQIa
 bAsic1rV9B1DpCf59Cfdz3yYqS2ztHFL6f2kpJGCn7XnwN4z/KpDsiabrU5s0w8k/1a/vfIWBV
 h6vPbz9Klws72GhGxJzgiQTSVp+ibjJDPQeDCfXUCQcweOzao0aDs/Q7DmAU73iTuFZxLBjOee
 poc=
WDCIronportException: Internal
Received: from 57k5qf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.16])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2021 19:43:43 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: ensure pages are unlocked on cow_file_range() failure
Date:   Mon, 13 Dec 2021 12:43:38 +0900
Message-Id: <20211213034338.949507-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a hung_task report regarding page lock on zoned btrfs like below.

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

The hang occurs when cow_file_range() fails in the middle of
allocation. cow_file_range() called from do_allocation_zoned() can
split the give region ([start, end]) for allocation depending on
current block group usages. When btrfs can allocate bytes for one part
of the split regions but fails for the other region (e.g. because of
-ENOSPC), we return the error leaving the pages in the succeeded regions
locked. Technically, this occurs only when @unlock == 0. Otherwise, we
unlock the pages in an allocated region after creating an ordered
extent.

Theoretically, the same issue can happen on
submit_uncompressed_range(). However, I could not make it happen even
if I modified the code to go always through
submit_uncompressed_range().

Considering the callers of cow_file_range(unlock=0) won't write out
the pages, we can unlock the pages on error exit from
cow_file_range(). So, we can ensure all the pages except @locked_page
are unlocked on error case.

In summary, cow_file_range now behaves like this:

- page_started == 1 (return value)
  - All the pages are unlocked. IO is started.
- unlock == 0
  - All the pages except @locked_page are unlocked in any case
- unlock == 1
  - On success, all the pages are locked for writing out them
  - On failure, all the pages except @locked_page are unlocked

Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path for zoned filesystems")
CC: stable@vger.kernel.org # 5.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
Theoretically, this can fix a potential issue in
submit_uncompressed_range(). However, I set the stable target only
related to zoned code, because I cannot make compress writes fail on
regular btrfs.
---
 fs/btrfs/inode.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b8c911a4a320..e21c94bbc56c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1109,6 +1109,22 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * *page_started is set to one if we unlock locked_page and do everything
  * required to start IO on it.  It may be clean and already done with
  * IO when we return.
+ *
+ * When unlock == 1, we unlock the pages in successfully allocated regions. We
+ * leave them locked otherwise for writing them out.
+ *
+ * However, we unlock all the pages except @locked_page in case of failure.
+ *
+ * In summary, page locking state will be as follow:
+ *
+ * - page_started == 1 (return value)
+ *     - All the pages are unlocked. IO is started.
+ *     - Note that this can happen only on success
+ * - unlock == 0
+ *     - All the pages except @locked_page are unlocked in any case
+ * - unlock == 1
+ *     - On success, all the pages are locked for writing out them
+ *     - On failure, all the pages except @locked_page are unlocked
  */
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
@@ -1118,6 +1134,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 alloc_hint = 0;
+	u64 orig_start = start;
 	u64 num_bytes;
 	unsigned long ram_size;
 	u64 cur_alloc_size = 0;
@@ -1305,6 +1322,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
 	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
+	/* Ensure we unlock all the pages except @locked_page in the error case */
+	if (!unlock && orig_start < start)
+		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
+					     locked_page, clear_bits, page_ops);
 	/*
 	 * If we reserved an extent for our delalloc range (or a subrange) and
 	 * failed to create the respective ordered extent, then it means that
-- 
2.34.1

