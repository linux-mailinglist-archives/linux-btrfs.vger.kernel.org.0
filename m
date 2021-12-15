Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C02475691
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbhLOKip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 05:38:45 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27127 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhLOKip (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 05:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639564725; x=1671100725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XCWCp0brAnq7261kZWgNKU7eMMrUZrtjAZwCegz/GaU=;
  b=HVxxBBq+ieSXqbi/zLjkDXI8A2Muij2slDSzh37NTIhltrTQ6GpaL4IP
   NOVB0f5egFtHeI0dohUNSRzyikQWABOtVPdB1WTJhjQEZS1LKa2FW7qoR
   H5mcThU2RFN8hz6ZPXhiLBsRn4UCePtd40jWXU7FTExpqjuogW7aoGaNX
   LRAaUWCfiRUNbjQ0z61lBCFBqFbFnB0dDcgJ5SmkQxT/c4F6IGOpJHpZk
   i7LoaIGkPa5PIU1N77jryKz1aHLvobsH53Y0GCc8qyNdEAGtogs0Ksgqq
   pdERjKjPcaFBzWs+B4Tl5RAU7MRwrtA27d1FF7gpSR+BIqn6L4TTOzyh0
   w==;
X-IronPort-AV: E=Sophos;i="5.88,207,1635177600"; 
   d="scan'208";a="300152403"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2021 18:38:44 +0800
IronPort-SDR: 3WJYQ8BHjE7o+3YLrB+XQSLBBsiai3o4SimTfX4w5thvZAID7SUlv+okEeE1XP+ZF44Vq2u7cl
 itw47XjwSykdYSgrF5hDWoYJEeN93D9XiXjab8Fg1G/RZ8Lwig8fYhSselbkd9z5nGaWpKd16R
 qqayoPYKiuUcYDiY4+HwWrFqmziJk0PN/SkbMHSIN/7jUaTWB3/B7DwXBL5iqIQkLXG83GPd+S
 R/7nwFKBwZu3UrlFjvWgUgb1uLc0OEDPaALCzdtbIULfB64s9PwQvXtJe0aBLWdEWdpOqk5y4N
 KxC+93+FDpSKLmvt2zeTfD7c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 02:13:09 -0800
IronPort-SDR: S4b+0LBlBEP7GTufQGttlZSFd0xpiOswxkKzLd3Ubaiammi/GkkFyX4qmFRxAzwubPbinM/Lhm
 kRaCA5GxI6gWgHJXyqIO7+rbEmZT/MP7VThNLEGf66xwJwgmPNrnFjyCsPuoPoo15Pd4y4w2P0
 wJLFIte3nG7Nflsm//KWpDQ3JGkS/qdq9QqF+qX+9zdfGQ5HTXQTOLBT1Wo3Duoy9G71bfJZuT
 kMDzOUAwV5QNE4DwEmclMAbCqNq7ZhL5PpLcF3c0PH7OpeFvFTCy5a7EFaxWNX2FPZ9eaXOZlZ
 6HE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Dec 2021 02:38:44 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs: Fix missing blkdev_put() call in btrfs_scan_one_device()
Date:   Wed, 15 Dec 2021 19:38:43 +0900
Message-Id: <20211215103843.331630-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_scan_one_device() calls blkdev_get_by_path() and
blkdev_put() to get and release its target block device. However, when
btrfs_sb_log_location_bdev() fails, blkdev_put() is not called and the
block device is left without clean up. This triggered failure of fstests
generic/085. Fix the failure path of btrfs_sb_log_location_bdev() to
call blkdev_put().

Fixes: 12659251ca5df ("btrfs: implement log-structured superblock for ZONED mode")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # 5.15+
---
 fs/btrfs/volumes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0997e3cd74e9..fd0ced829edb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1370,8 +1370,10 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 
 	bytenr_orig = btrfs_sb_offset(0);
 	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
-	if (ret)
-		return ERR_PTR(ret);
+	if (ret) {
+		device = ERR_PTR(ret);
+		goto error_bdev_put;
+	}
 
 	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr_orig);
 	if (IS_ERR(disk_super)) {
-- 
2.33.1

