Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F445B77C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhKXJeV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:21 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32189 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhKXJeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746270; x=1669282270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTuGe4lBjgN0TXdQ8GTLGuagnkDOF2eeQeXaYNdBUoE=;
  b=qa5Oz/VTRO5M5IZx8t+NQB8EDRGia2hkDTzrdvK1UxTR+KFHsokJDm6h
   V63L774KEN29D204GMxXYQHNANKM/mog8Vr7jpPwZYmG19cowNCWrDG7d
   3W8NN2Rdg+2nxC8ASy347fsEVqQrhVCqOAArP6JazyJacQ6ieEGTne9Pj
   MoteasivYdKnHNbbeKdV48wVQ4ol4VZifEU5AGzP41NLrhJONtWMSCIPr
   hGb6KjjqsLIbXxtW/iuX/MIdKFDcKy34aqDOKJ+0+XpIfFwciBn17j1VS
   yB5jsqr/BrREVc9RHxR7IpWj2m+7TWCB9KHhXpf8K1rzuvDvlUAcZTyG4
   w==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499390"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:10 +0800
IronPort-SDR: wRSf1sxkWR4gV2tRO+u3X4eZd2iN79b8UmqQ18okMLyWb5eWuanZ/S6xaJmlujCXadi7PqbDyo
 VmUbA20hlT+eg6dM9+HBPZ8xHplNMko8S9wKxDAaz7a6BMELUI6HD6HiB8YE+aIZHUu4Ccld85
 FUi5q0qhqKi4DA7xfa789OJS9ZXGk01Vo0v6IBo7Q4RfZ6l7VO7nC1p1StLEFo00kPXGagaB4c
 SUVnd1idlWj4d9av93zughgLgOY3fOufblxsHfE/A/pqSHWVSL0/Ud5khNjLx08iTHLgld1jNR
 ID5DhWUgUUHLRAl//zF6mgRh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:03 -0800
IronPort-SDR: D/md3Uf7aeyh3PWl/xHFo/uLgUtxn48C8QBMwmoBNBsiHscJ/DMCDWKSOzfbCCT2pcQD1esR55
 PciUrUMBVQqTVxgtNEWKzxR8F9psfxCHAaaYHhqwpfxvm6Vi3IWxDMz+OhPxCaUzV1DkKXsy+i
 UWaZDRYbEk9Ujc6HuAB9jPNXNJtmJ/CtFaGfiKcycmY3nOmDuoZd2Rqtg5OQXXjDjSSrvJM82g
 7G3BfBal2FZHYOm6FWr3Rug6uZzCp7RvvnKQtkRq4V2lzneZzncAyIA1HR2Ib/du1RgZ3kxiWz
 b2c=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:10 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 12/21] btrfs: zoned: sync_write_pointer_for_zoned to zoned code
Date:   Wed, 24 Nov 2021 01:30:38 -0800
Message-Id: <86b1dd2b2353205392b92acf682d983d2f3ac9a5.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sync_write_pointer_for_zoned() is only used on a zoned filesystem, so move
it to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 28 +---------------------------
 fs/btrfs/zoned.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  9 +++++++++
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 64728ca585c52..ccb74f2e75b92 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3071,32 +3071,6 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
 	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
 }
 
-static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
-					u64 physical, u64 physical_end)
-{
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	int ret = 0;
-
-	if (!btrfs_is_zoned(fs_info))
-		return 0;
-
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
-
-	mutex_lock(&sctx->wr_lock);
-	if (sctx->write_pointer < physical_end) {
-		ret = btrfs_sync_zone_write_pointer(sctx->wr_tgtdev, logical,
-						    physical,
-						    sctx->write_pointer);
-		if (ret)
-			btrfs_err(fs_info,
-				  "zoned: failed to recover write pointer");
-	}
-	mutex_unlock(&sctx->wr_lock);
-	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
-
-	return ret;
-}
-
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3502,7 +3476,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
 
-		ret2 = sync_write_pointer_for_zoned(sctx, base + offset,
+		ret2 = btrfs_sync_write_pointer_for_zoned(sctx, base + offset,
 						    map->stripes[num].physical,
 						    physical_end);
 		if (ret2)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8493093aea849..7f3e3e34fd783 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2256,3 +2256,29 @@ int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	}
 	return ret;
 }
+
+int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
+				       u64 physical, u64 physical_end)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	int ret = 0;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
+
+	mutex_lock(&sctx->wr_lock);
+	if (sctx->write_pointer < physical_end) {
+		ret = btrfs_sync_zone_write_pointer(sctx->wr_tgtdev, logical,
+						    physical,
+						    sctx->write_pointer);
+		if (ret)
+			btrfs_err(fs_info,
+				  "zoned: failed to recover write pointer");
+	}
+	mutex_unlock(&sctx->wr_lock);
+	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
+
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 5701f659b1c39..db2baebab8f50 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -86,6 +86,8 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 				      u64 physical);
 bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical);
 int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical);
+int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
+				       u64 physical, u64 physical_end);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -268,6 +270,13 @@ static inline int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx,
 {
 	return 0;
 }
+
+static inline int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx,
+						     u64 logical, u64 physical,
+						     u64 physical_end)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

