Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83E5159294
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgBKPKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 10:10:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35881 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgBKPKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 10:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581433834; x=1612969834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNpMIlpEif353iFcRYUIxrnCxXy8pTlGKLytGvY+s2M=;
  b=lVcU+zh8aju5xXzN8JNCX4atUYSKTKRn7nlbB/TOc3PrFyzz03enf+UO
   uZk50BAeXdzo1KiG3YUiVu93Nigjwrk5NlTrDcgFGB8GXUJVqbVysktHx
   tgSZ/HNlwsE8e0vSq8k296jgPD2xa1wDxdv9ASb+RHmWYkrAXfNOUPM4i
   iO78hVD+yKbjvYu7dEXRkQn5p2lQ0fhUfiNGQT+rVhul3lhtd/exZvaCC
   uQ7F+quXSdpQRJkkUpBOUsBAE/7EVpTq4DuPUsn6otLsioM1aFUzHBypn
   BO/a0Tnq0mANghNwO/YGfb85TMF+pydqLfdBJXhcoP9altoqAs6Gv1uup
   Q==;
IronPort-SDR: TDHlgPGIffMVigRKkI4XoWfJwYtWmJd/PRkw+/cq4jFkYRm/Yi/H1gCsAdyCyckn6dmVw1rZqV
 2CfhJnlZYOnoRQgKBIplsi778SJ5dFO+szcdIXUX5Aacc8d7Bv16exQjkWa1nrO89Qxs7PJFwy
 2bb83tXNQOIS4flMFy3xJa4S0tEdiUqykWL8PT2TXZoDhPvLvvI7WU48/vNplj6csVu9ZQZVD9
 0UGxLYlhSuplV1Na4nxjwBdRR224dPNExwVsX858sZ53eArZ40FWEK1+q4w8a9NgatZGZoRss8
 t+Y=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130128678"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 23:10:33 +0800
IronPort-SDR: dyP+MhU3MleSwW++hk+5VF8SWBuZobTfVbpb8Hb4c/QzC0PWguTQfbb31CFfg/0n49JNCk18p9
 ogsYI5EXoG8zZ2ywaBUaZXls4rKEjSpF/sISzqDtmLg4I/arWIC9n27whVNDp6SXyPrQn11gK/
 hgY0k7i8B0FCPPNmeVN6mUNhO0HtTSNY1lCW1Lnk8PfT2Uy6ePOiHlUZbIDhu+hQevQyC/jq7H
 1eqnZpTJ/TdQFx9/2jPZT2GQ5NOSsc3HDPSWzmaiVtX7n4x9g2O0DFn44AB71RUwrfyNz+KdHG
 r+6wEvr1tautwvatPc7C4onQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 07:03:23 -0800
IronPort-SDR: vKE29oDZ6LiHof3qpJmuWkJ6KA9bBRaXkoGe7JyOmWtijA2rGCBJVFMauTgKyHYdnP+i8y8IJj
 6BQAaeMJpruMtZU1/v8S0vxd388LCQkT7S899kR//p8r2fIJRwpHhyX2ApN2zzsri1SBSyQ/pE
 aPchb+1u9VCGIFThqGgNc7u59SgPU/mO5N4AkfCX43KXKDPWP4t/4Cd07VUtzIZzg967ccC8KG
 Awa7zUr9cVsW4hHKsbk4UpOJxVok9fqcN/QIH0DNAckOloZIri2kJ2vpCTDpl9QFNPmOT7te5D
 aOM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 07:10:32 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/5] btrfs: free allocated pages jon failed cache write-out
Date:   Wed, 12 Feb 2020 00:10:23 +0900
Message-Id: <20200211151023.16060-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
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
index 705589daeffa..c7ba2b393b33 100644
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
 static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 {
 	struct page *page;
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
2.16.4

