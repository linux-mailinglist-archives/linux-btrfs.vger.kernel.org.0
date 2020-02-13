Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F115C632
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbgBMP6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:58:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60885 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBMP6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581609541; x=1613145541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXI3x3SaaDXEeOo7oRhcIQP8lMflANgTphvOQOyVA3k=;
  b=WpNDW72b+wBFgYOh+o4V28IZDrwABwrdDQxqTkXDs3woPb7gBAqE4TRD
   9iA0SCu+VF7t+wHuXMEJi3nrnkJRpNi30pKfUUaWbbjGW7qys2j1SKbSU
   oSwlUhpDVFn2p/+5V9xOyt1oYYn2Mkd6vDqxAnZayrHWrAdECt7F9uAJ3
   HpS1LSeyh3lmhUpU4rlq9wTAndublGIH+vow9QgKgqODqOUcAvpH1dpQ5
   XG64TGMcZcC/Hmlj+6HkdC4QZ0+rxbgKeYFzIpH0qsv+33gRHN39kThlx
   3S8zYa02VSuqy0O9Yi50WRQ+huCee4IS9EuglAKHjpOb0haMHVFRhrxND
   A==;
IronPort-SDR: HF6NxTz+9h8n16+OhAKSrrWpZ+1dymA7kT7lOvgS6p199wkoY96xQfPkbrELyCdwaKNCfZsJLq
 1jMNvrNAf+NU4/VxpMjiMEmd96SzNC/zvMws7s3AJGIXKBfh9M36rtk/eldfnzy/E4T6gZ3Hqf
 b4abQtNp7uHl4MDJvEnAs5PR1qY4fmzNwO0oBufXMmTqSOYcPr8KrtrEqHMHaIAHcJM48imVHw
 p/1+g5Kj4bo8QWQTXqycjA5uL1cpimKqYAsb6+G7cUr6RbVZTb/BCG+7Vwu4NDwWcI71TB5myq
 fao=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="231587562"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:59:01 +0800
IronPort-SDR: wJirmjZIGI1ov/M/XQyAq4dvvLGass54GyOkHhQW9DTQf6DCsuSmtbUZjjgtP4SjsRcnomqkJg
 n9o368sRB3ZJfxEEzcRy04NWv73e+UOZ/1iHT5eNpc2QbPTOmaQ2sUwbrn2k1P99bdXU34w8o5
 mXWAO5W8Y3uSj/wjPN8z1+6rtympptGQu3QJ/evRvgpK5nkJRn/NfZEz49ZpCAqmJi+IzsGW+3
 mjETxU3IlfIQnmzojmRxAVaM3PVsa95ecPkIeoPiXqzzEilOe1y2Yk7MmHaFhFCYjfcbwG+6jU
 HctOl7++5S0HOlc4gbSGRP5L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:51:02 -0800
IronPort-SDR: 3rta8Clgt7AmycDpzslvwwx8LvQK9QfFEh0HgYfTcwvYBnx3X9Gan7KYW1sTg0MXYSc6pOOO79
 7ThzjCg5EsucIn917Amzq0XcJTo9QQD5/Oy70WXMrSxMUoy8FJqD2GTqrgxluHLuj7tMLdj8Us
 jhueZPXJPs1mwaxVhV7jKYfjGoc8WAXZTfmpJxtFEwXIFdROiQOYCe3DQ1tTniBjtvIgAe0qAK
 1mEzmj04JUBJUgCGA8emzCgjMX/02FR54ZgVEF+0k2UJrMAL8vrECGO9/KehUXyRQBfb6XHoOy
 Ekc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:58:14 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/5] btrfs: free allocated pages on failed cache write-out
Date:   Fri, 14 Feb 2020 00:57:59 +0900
Message-Id: <20200213155803.14799-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we fail to write out a dirty block group, we leak the pages allocated
for a block-group's io_ctl. This can be seen with generic/475 and kmemleak
turned on:

unreferenced object 0xffff8882249c9000 (size 128):
  comm "fsstress", pid 1791, jiffies 4294902054 (age 32.100s)
  hex dump (first 32 bytes):
    80 0e 42 08 00 ea ff ff 00 0d 42 08 00 ea ff ff  ..B.......B.....
    00 eb 0e 08 00 ea ff ff 00 e8 0e 08 00 ea ff ff  ................
  backtrace:
    [<00000000cd20c449>] io_ctl_init+0xa2/0x110 [btrfs]
    [<00000000281944cc>] __btrfs_write_out_cache+0x71/0x410 [btrfs]
    [<000000005d518c07>] btrfs_write_out_cache+0x82/0xd0 [btrfs]
    [<000000002bb2675c>] btrfs_start_dirty_block_groups+0x1f6/0x440 [btrfs]
    [<000000004f955ad0>] btrfs_commit_transaction+0xb7/0x970 [btrfs]
    [<00000000a69c8761>] btrfs_sync_file+0x28f/0x390 [btrfs]
    [<00000000fa939e06>] do_fsync+0x33/0x70
    [<000000002ff0388b>] __x64_sys_fdatasync+0xe/0x20
    [<00000000fdbf32d4>] do_syscall_64+0x43/0x120
    [<00000000b782d265>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

When cleaning up a block group release all allocated pages. As the data in
the pages is already lost, we can at least free the memory occupied by
them.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c          | 6 ++++++
 fs/btrfs/free-space-cache.c | 6 ++++++
 fs/btrfs/free-space-cache.h | 1 +
 3 files changed, 13 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 018681ec159b..b79c194b1126 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4460,6 +4460,12 @@ static void btrfs_cleanup_bg_io(struct btrfs_block_group *cache)
 {
 	struct inode *inode;
 
+	/*
+	 * If we end up here, we want the pages to be already released
+	 * otherwise we'll leak them.
+	 */
+	btrfs_drop_dirty_io_ctl(&cache->io_ctl);
+
 	inode = cache->io_ctl.inode;
 	if (inode) {
 		invalidate_inode_pages2(inode->i_mapping);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0598fd3c6e3f..3c7660b04a81 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -371,6 +371,12 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
 	}
 }
 
+void btrfs_drop_dirty_io_ctl(struct btrfs_io_ctl *io_ctl)
+{
+	io_ctl_drop_pages(io_ctl);
+	io_ctl_free(io_ctl);
+}
+
 static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, struct inode *inode,
 				int uptodate)
 {
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 2e0a8077aa74..cbe25c31041d 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -147,6 +147,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
 				   u64 maxlen, bool async);
+void btrfs_drop_dirty_io_ctl(struct btrfs_io_ctl *io_ctl);
 
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.24.1

