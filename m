Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78D215C665
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBMQAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 11:00:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43900 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgBMPYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581607489; x=1613143489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX/uUxZ/HGtxEWFTBh8wXf8Z714XLMpbfm7PHCdgo/k=;
  b=DGyIswtj74MFJ9+aFN4aKXjNLVvIQs6mGqOkFra79KKUW94meOUtvNVk
   y6GDJDynJedoxrIkhRRCw/X85cuOZnhy2SlcORyI8Mkm7b5tz7VzPuRmd
   oKv1ov+lt9ZZOMOK+6oWYjPbWpe1Q/WGU/VaCKuGAjrjUOEhM4L1Je/ZX
   X8HKICR+FZCQLVFCMvKFAQ3l+/rNMH3xlUYBX7PV0EvWz7+ezQBKmem0J
   SCNFKu1MYI2RFsH9zDd1AvuHZIJiVQkPgoJMKzbKMq55nHRRarsMoNmRC
   /cd43p0N4TOaCIyY+nmfAt8J60yVrGIXrWLl82/Y4Qdvni4jbDRLjZUA2
   g==;
IronPort-SDR: OUBna9y+40mK5ycOXP22A0cIFTMOPLe7yqGC+ZEw0paVKwh4WefEW0ZXvjjALbJWCa/LrPONfH
 040pCOJMxJUAGKG76L7vcdNfrQbDVjY5osiYL23MDrDfPwXkYu0ME9sTSjtO4toKoJgSunuALY
 ej1ez3FZ7NzC0CpkwReKn8oLRoLlz/cQMPyPp621IaDHo+5F51siEcafrO0a42uVDib9inykE2
 NJ8VXXj6u6pSiflPW3xajN3GSBPbtryWQdjV1c/AklSkFpdLsWX4jxUOhSvWPlHozG/rtE82fZ
 aUA=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="131227886"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:24:48 +0800
IronPort-SDR: knDBsoQAyPOW4NNHSx369OaZgRY8XW5Wr63UZzl1IygPZoFyPYKJ18+DqycLX11KzsLDAWcfUd
 ixxcrD5ms/xhsV9230KlgmwhNupArQln7+AWTh6AzMbW+ao1mP5VehjaTL8sBeB4UX/HYbNCIO
 pUeW+2eQLbqjFRpAlBDqf84CR+Baykz8iQm85LT/gUIm251slsehdfn90Xs+eeMOWbVfSyNBot
 RjEGueA6fqSSKzbJvLw6SAK2fLrQUd3ZIbAqziN9key9yxQVXhKCrluQp84LK264eoj0en5iwD
 6lKBCg8jKMfZfUmAzfSXJrYv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:17:35 -0800
IronPort-SDR: PApH0gWMRuWF4ePqWnpIg0HUrwg04dF0bb2dRlLhuvoY1HgyHTxymivO4kwzQA+5q07AuQt3xS
 U7oRHdPb3VGZXujGROJfYzNp/THCucbkewUECTucFNwlYo5LqyROKObzsIrJwsUED8/LVHgBzf
 I62qyph8AcEja9LAW4IgA7QV72RkIwJ2Mf4/6JsuiKDHdpuYEHB9HIPWLljxlT2jr4n+TdQzen
 e1EVrcaSWP8IadpZQlHb09dvYvi1AxX24F+PSXyZhinlhbSDHVfDgbuMTptyHMVjg8rv8hv0sa
 Dm0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:24:46 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 3/8] btrfs: reduce scope of btrfs_scratch_superblocks()
Date:   Fri, 14 Feb 2020 00:24:31 +0900
Message-Id: <20200213152436.13276-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_scratch_superblocks() isn't used anywhere outside volumes.c so
remove it from the header file and mark it as static.

Also move it above it's callers so we don't need a forward declaration.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---

Changes to v7:
- Remove forward declaration of btrfs_scratch_superblocks() (Nikolay)
- Reword subject (hch)
---
 fs/btrfs/volumes.c | 61 +++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h |  1 -
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 620794f1ea64..461196b03b6c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1948,6 +1948,37 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 	return num_devices;
 }
 
+static void btrfs_scratch_superblocks(struct block_device *bdev,
+				      const char *device_path)
+{
+	struct buffer_head *bh;
+	struct btrfs_super_block *disk_super;
+	int copy_num;
+
+	if (!bdev)
+		return;
+
+	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
+		copy_num++) {
+
+		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
+			continue;
+
+		disk_super = (struct btrfs_super_block *)bh->b_data;
+
+		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
+		set_buffer_dirty(bh);
+		sync_dirty_buffer(bh);
+		brelse(bh);
+	}
+
+	/* Notify udev that device has changed */
+	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
+
+	/* Update ctime/mtime for device path for libblkid */
+	update_dev_time(device_path);
+}
+
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 		u64 devid)
 {
@@ -7316,36 +7347,6 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
-{
-	struct buffer_head *bh;
-	struct btrfs_super_block *disk_super;
-	int copy_num;
-
-	if (!bdev)
-		return;
-
-	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
-		copy_num++) {
-
-		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
-			continue;
-
-		disk_super = (struct btrfs_super_block *)bh->b_data;
-
-		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-		set_buffer_dirty(bh);
-		sync_dirty_buffer(bh);
-		brelse(bh);
-	}
-
-	/* Notify udev that device has changed */
-	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
-
-	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device_path);
-}
-
 /*
  * Update the size and bytes used for each device where it changed.  This is
  * delayed since we would otherwise get errors while writing out the
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

