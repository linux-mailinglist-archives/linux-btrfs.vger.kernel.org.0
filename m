Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204745B77E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhKXJe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32191 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbhKXJeW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746273; x=1669282273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3rebnCrYtXdEFqZRYOSFTiBaprzOsQ6+v75pqy+nwB8=;
  b=i/aopnB7lAM1+qaiQVhSqjeYM5kHVeqWp3HgDv0nhxBlIErdSCHV6fl+
   uZ4TF3BTVzyNcgAm6X0+MOZv96rq+8lX/g9bH1U3ACHTqKCFC7h1LFw6b
   K7K+1cJ1cQKgon34aVVgP3GwAMBspcQQgXL63PId2a8xYsgDzEv5Bxmsa
   TttNjigcktLFPDBReKGPy6/zX42Ji6SH+TqUpuIYVfRC8y6qA0QMgoZO1
   NJzxSXvUlzOKbe5wsMRrNiWBdV3tEyb4/osu0UChHUaL7zPbCGF8AeLHc
   xmsDYBkzVZeO1rcNVMWv5uZi2LQWMyH5afJy0INhAqcm/AV87n1nLKzWb
   g==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499394"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:12 +0800
IronPort-SDR: +yc8RCUsdU9+CssXlf2jSiTLUC4sxjOIMDTLGGN18EMXCVCRqNDPViZwX3XdBkzEppmxU3wdUy
 c7li5JnxKDb6GyRIX9RxRQxi347Mk6zOx5FSoc/mEiaMIR+0Q4gNy3HTGT1Eyw1okNNYqefQDa
 nrPgyf217iVq+MwrfeSV/M4RDr5T+tGewDktGHa0NmHY6aYrAeBgqKR80SjJZ02NqZUVXhVwSV
 ukfP8+TAvQk1T8Jln5SY5P/BO0PZXavMEibB/Mnf0lI4jeTd6743vEFKU+X1rqj975IzhdMCi1
 Q+iETRSkwYS/x1ndxLO/I25Q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:05 -0800
IronPort-SDR: YjOSS1cclQohypWXz6k1wcCX0XAx21hEvd2ojQbYWNa6FEznIoUesTq4U/5xcsvJb3Rg+56Z8j
 BLBVSkB5mCXsI3V2sg7ZG7nTyPcLWdJLEF6KxIiSAajk25qBuGYm/hdiYHxapl0r39OPAfCMy7
 GmlAieINEYKLkt9ZWiQbF3Q5wS/pLTUf0gXwcCnNYzFoOOw9Rk8ydckr3SubXsn8Q5EAuKcfBv
 YMexFKYAXBaFi6Fd/1vT61sRoWhttxz1Wwcwez7KgtrB5mHR2dynGfkJb3q+vgy4d2mk0G4JFX
 1rM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:12 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 14/21] btrfs: zoned: move sync_replace_for_zoned to zoned code
Date:   Wed, 24 Nov 2021 01:30:40 -0800
Message-Id: <ef89c7f0a54b941455d6fd8be2de834f7388d6fc.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sync_replace_for_zoned(  is only used on a zoned filesystem, so move it
to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 16 +---------------
 fs/btrfs/zoned.c | 14 ++++++++++++++
 fs/btrfs/zoned.h |  3 +++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e8fa305f71a10..2e3ad26d30e30 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3056,20 +3056,6 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
-static void sync_replace_for_zoned(struct scrub_ctx *sctx)
-{
-	if (!btrfs_is_zoned(sctx->fs_info))
-		return;
-
-	sctx->flush_all_writes = true;
-	btrfs_scrub_submit(sctx);
-	mutex_lock(&sctx->wr_lock);
-	btrfs_scrub_wr_submit(sctx);
-	mutex_unlock(&sctx->wr_lock);
-
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
-}
-
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3402,7 +3388,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 				goto out;
 
 			if (sctx->is_dev_replace)
-				sync_replace_for_zoned(sctx);
+				btrfs_sync_replace_for_zoned(sctx);
 
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7f3e3e34fd783..bf0837e46592f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2282,3 +2282,17 @@ int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 
 	return ret;
 }
+
+void btrfs_sync_replace_for_zoned(struct scrub_ctx *sctx)
+{
+	if (!btrfs_is_zoned(sctx->fs_info))
+		return;
+
+	sctx->flush_all_writes = true;
+	btrfs_scrub_submit(sctx);
+	mutex_lock(&sctx->wr_lock);
+	btrfs_scrub_wr_submit(sctx);
+	mutex_unlock(&sctx->wr_lock);
+
+	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index db2baebab8f50..53bf05be143a4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -88,6 +88,7 @@ bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical);
 int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical);
 int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 				       u64 physical, u64 physical_end);
+void btrfs_sync_replace_for_zoned(struct scrub_ctx *sctx);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -277,6 +278,8 @@ static inline int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx,
 {
 	return 0;
 }
+
+static inline void btrfs_sync_replace_for_zoned(struct scrub_ctx *sctx) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

