Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F304015A19C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgBLHRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:17:12 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46465 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgBLHRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581491844; x=1613027844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pY3fJIiL3drIDz7rHvz9Ma6Wjg4HzgFd91S282i+jdA=;
  b=XxeMPIhxv6nN/auHeVEXccaPrFsJ0/5sQ9RLXQHxMZ4Y4eRMtPcOaCkU
   MF6UbqIq4WhCG0/1LUzJUUAnozSWkJElrltA01M6GutABpfCAXiVPJpaI
   OENAXn10ikpN9TauAKJsNBsohkgwiDClsm3Ws/AOe+7vperNqKsyHJEIY
   oy21dVyQ+8VIzI2JTQNonGEM8qWf4qoXgz7FuLD6InqPlVOf7FoLpuYf1
   e8s6bSJpG9JVCc+dJOSMtgr0hA22XOAdmxotR+xVg1u2X8IOZNSvPOskn
   5z9GseO/j+livE15KvvP0d1e2TJ0TJ3CUT5HWIw2xAJKoILq27t7s9kOL
   Q==;
IronPort-SDR: G5dj10IswFZvh6Lg+AkBWU1yIWgJqIgYfwbkDTIJGoULLZ2ZLL0GZFd8g3h+t0H5oFO0n5O1rH
 R2YDkDLfJaHOx2alp29Mv3l0CKGEirciKzVp4TZ//vbzAyn5fzsQ1tz/7AqsJyI2F7bVmH3J0u
 zVOEJ0BOqMSTQTLHnnitIsYSMchqCarUbVXoTdl5hwFrLKx/DTK+Dl9wTjVOzwP11RHW3TsM+C
 qfmjpOcahn272n+01AAgqnwHvQxbHepehDVSylhy6aD50vzJ025OZ+Kq4ED3rd5S4hsKzIQQvV
 F0I=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448461"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:17:24 +0800
IronPort-SDR: 0s/yG8RUbRH9t8DgvPrAxJbLe8P2IwGuGfR5SdVw1IkDggIG/cwjIv7Nhni4bWdXolIkCg3DHV
 gOU7vQs0KUQGQb81KuYvJ885ZFG6Uqpoe2ahLZg62yvpNKCi1V4Wpjzj2+t2LD+cmkpQyDB2ey
 tDbsoKDAhTz3/nuaRWKcjSp7c91fCliZpBVlgpZHWurziW2YR31sCXhSKo092ua/a3csuiiTY/
 raEXJQTQO7hI8PpQvsH/CbKUF2UEf5Mq7a1oSh0Xpeq3WV7ddj8EytgafG4oQpZH5qYf+EzQlM
 ps8Oeq3S9gVMiYx0FA825gDG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:10:00 -0800
IronPort-SDR: IF608znxfcHFFmA1q2Z/mwpXe+uGtDtYXxgi5YoZpKXcyHcQ8g0Q8l1D2yHPUgzATpZIgEc6bI
 R7aVRF+Ke7y6iAjP5HgBAWfunOnPUL3U/CNEj3lw1Z/LC8aEtgvrQ1gEXj6XwzaGtgUuMhhUfz
 hlCg00tO5qxZ4srKvxrMZw/gPVuuc2YjykeeYQXqlImm+4XGYmx1qgQZF6POfdgLgs12VsAh9G
 OsVucaPYTourSRb/Znb3yciAdzNJoe09BrnbWcNPj3QoR5imrM0+LgWU8G+T9NnRTxOj6JyYDQ
 BFI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 23:17:11 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 3/8] btrfs: unexport btrfs_scratch_superblocks
Date:   Wed, 12 Feb 2020 16:16:59 +0900
Message-Id: <20200212071704.17505-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_scratch_superblocks() isn't used anywhere outside volumes.c so
remove it from the header file and mark it as static.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 6 +++++-
 fs/btrfs/volumes.h | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 620794f1ea64..e17d4d7a6eb4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -32,6 +32,9 @@
 #include "block-group.h"
 #include "discard.h"
 
+static void btrfs_scratch_superblocks(struct block_device *bdev,
+				      const char *device_path);
+
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
 		.sub_stripes	= 2,
@@ -7316,7 +7319,8 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
+static void btrfs_scratch_superblocks(struct block_device *bdev,
+				      const char *device_path)
 {
 	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b7f2edbc6581..a3d86ee6a883 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -473,7 +473,6 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle *trans);
 void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev);
 void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev);
 void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev);
-void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path);
 int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
 			   u64 logical, u64 len);
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
-- 
2.24.1

