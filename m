Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7C3E2732
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbhHFJ1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 05:27:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41460 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbhHFJ13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 05:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628242034; x=1659778034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hzhNlBRIUKQPOqkHdbKHeYS6CDDTsWhMsX3ITN4Z+uQ=;
  b=SXQk3tx8WMQVnLaFGyAfKEaWsaCRH3X2lpfxOycaeXJVhKR4a6yNX+x/
   c70eDlMgXDBVhgtJw5GrZeBkzVpFm1SjFYDtu+Yl1f82gEMt40YZltHBT
   BU3lY95ncGMa3652/MF2LsSSo4ny7XJKCQOA0cr7Ti1aZoZYE/U1BALsJ
   JKg5hwhqUg/PTeMbRK77MELsMO8fD+hr6UrLDYuljlJm96rw2bLGqiDCc
   1LeHgSmces8bXpJZPA6eN7VChG3LPj2BLI38IV77YWWnQSm0Q9oLEPxT7
   MjoGh4u22/KBNdqDl737sNSeWJGduLlEgLQBmoxjO9gaQSDCZB6uuNtXb
   A==;
X-IronPort-AV: E=Sophos;i="5.84,300,1620662400"; 
   d="scan'208";a="175703199"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 17:27:13 +0800
IronPort-SDR: s6zzsd7zW3otbPxcBJEZvDDl8yiZiA0xAv5WOUHXB31tBN+zfUZMqIeleyaHxA6DBg+0ubvE9v
 l6kmBfltY1W5RkXT1UPWZ33gjzoRsRDxZzLfwJS7yPX8aLkUy5GCGYsPB58+cyv/4697wpsysA
 ByqPQx9ln/SAEnaLXt5k0Rp+sZXO2dKy+Cu/y32eO+xGCmTa7qKET1pAJ8FtXHBppbIeJvGA6Q
 Tjrg2/z7pjBGkneDNZJBtgsalLVpgNqrV4gXuOsM4hEGhSgeOr4TJCCBNizeg0dwLPfJoFcBnb
 oDKyjoqxEU1BCDnswjSoJcCn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 02:04:41 -0700
IronPort-SDR: XH6vmznmfmzeZNU3nT8e2E3X8rIBkOTEmQfSZhOavQENq5yjPEwmO9CCCK0M4GiqTXb9H+x3Id
 R8+grQR/1RsXYEtkwEQ9dIC72WjTCwPC0BBxCm7twhnk3q2Yst4cUx5WUXefs/iwB/34n9zCKY
 OhpCrq0K3W9ns8GVZFd6H4qw1aXRZw7CuqFThg1H4sbBk09bJY966uDybXB2uxfvjiIQlJ0Kn3
 QXuJ2wm1HSmHMhp8sk8Hri72QFBlxlMn/USqzsmOcWpf0i5dkOegbNdMNdK9xpru/uR31TyGt/
 nt8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2021 02:27:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: allow disabling of zone auto relcaim
Date:   Fri,  6 Aug 2021 18:27:04 +0900
Message-Id: <fc988b42d58cf2e6b0ae2030fe0e67033ce27eca.1628242009.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Automatically reclaiming dirty zones might not always be desired for all
workloads, especially as there are currently still some rough edges with
the relocation code on zoned filesystems.

Allow disabling zone auto reclaim on a per filesystem basis.

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 3 ++-
 fs/btrfs/sysfs.c            | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8eeb65278ac0..933e9de37802 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2567,7 +2567,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	/* All the region is now unusable. Mark it as unused and reclaim */
 	if (block_group->zone_unusable == block_group->length) {
 		btrfs_mark_bg_unused(block_group);
-	} else if (block_group->zone_unusable >=
+	} else if (fs_info->bg_reclaim_threshold &&
+		   block_group->zone_unusable >=
 		   div_factor_fine(block_group->length,
 				   fs_info->bg_reclaim_threshold)) {
 		btrfs_mark_bg_to_reclaim(block_group);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bfe5e27617b0..5f18c3e3d837 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1001,11 +1001,14 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	if (thresh <= 50 || thresh > 100)
+	if (thresh != 0 && (thresh <= 50 || thresh > 100))
 		return -EINVAL;
 
 	fs_info->bg_reclaim_threshold = thresh;
 
+	if (thresh == 0)
+		btrfs_info(fs_info, "disabling auto reclaim");
+
 	return len;
 }
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
-- 
2.32.0

