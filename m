Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8A45B77B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhKXJeU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhKXJeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746269; x=1669282269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4hY8jbfXQslKD7lX4Qh0KbUxOhO6E5hGGNMbQHxGUQ=;
  b=Eu2QFUjR2SVVVPVFdzyXBOZCmk7aa+xwHqhCn5CJq/h9oJwjh5VHu2CU
   KN+hFgn1IhItC77jZsSyT6HzdsK2r2GkQ6W30yb7UrfxOc5CSgiHMYoIa
   Dzf9w136c5aOQhdNPA4vAyM793FheXjjZoHdHFM0LjgLO+EDqC/B/9W4l
   OLfTwJqlv/qx39LaCgjFrxl8A7gqUP3CG2V6RCWYTl0dNlchN/WXLvIt3
   v5QdtBRvHmA8KqdQGAwf7MPkBl7MREj8cGxwxxMN0u9+oFByWc1f4Q3Sa
   6Jil+kokTIjx8viyg5MtWnBN1BPbA3EKXXUTuzelZDUuEQtGR5/Ha1l3j
   g==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499387"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:09 +0800
IronPort-SDR: 1E/GV8aSGVBZfnv6gHvlR1bI8XmCSLKbtFPOjFw4TERGeel9zdTVuKNkdqZCX0A4/LYDdBB6xk
 MCh2XA8lX3M3ukHJj9znC7Rq0x5sYW5krzdSdvW2S873lrn+EQ1BM7hJ4vTpDwSMX1D0p9GasI
 SkNp/kR1BMqUMs8xd2+8T8HtUfy5oflPFw2hsnoo5kYfIOHXVrryQnQFAoYEs6r2blHs0K+fyV
 Y+4PsamOEPEGNHop/CcbV0mKtYgg8hVJ9MNlOqP40gR28iT5bVJlO4vRAyc9PZfhtL7wzdCLbB
 yWArx0FEFaHYhBur847KspUl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:02 -0800
IronPort-SDR: MnbnYvE1Zz25BbAA72agQmUPq5oYmavyxKqbJUt1GpCw50YrVCEgJywIfXUgSM1wWyTA1t45JQ
 MblegT+w6QnB+smR9mdchLXalmX9dp9jiy6CEnvvL8aAmw3CbKs3y7pYHQvhKpj/d0ST0e6ORn
 5el0CDoGPTEbtBYxvVbYH4qcvkNy4TalRce9Dv6yEG6yS70Y/U9ECOh2u88eawspNNGMAX+JpE
 VBGRUuouPQ2prxlXFvlLysam4NbgSP3tVJlrytH0e/LvWz33j0pJTzClB4m5attPZ2EQP79c+v
 5lA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:08 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 11/21] btrfs: zoned: move fill_writer_pointer_gap to zoned code
Date:   Wed, 24 Nov 2021 01:30:37 -0800
Message-Id: <bb53a2e4f86d9737f96d7b9c4857630ea569fdc9.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fill_writer_pointer_gap() is only used in a zoned filesystem, so move it
to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 23 +----------------------
 fs/btrfs/zoned.c | 23 +++++++++++++++++++++++
 fs/btrfs/zoned.h |  6 ++++++
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a2c42ff544701..64728ca585c52 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1576,27 +1576,6 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
 }
 
-static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
-{
-	int ret = 0;
-	u64 length;
-
-	if (!btrfs_is_zoned(sctx->fs_info))
-		return 0;
-
-	if (!btrfs_dev_is_sequential(sctx->wr_tgtdev, physical))
-		return 0;
-
-	if (sctx->write_pointer < physical) {
-		length = physical - sctx->write_pointer;
-
-		ret = btrfs_zoned_issue_zeroout(sctx->wr_tgtdev,
-						sctx->write_pointer, length);
-		if (!ret)
-			sctx->write_pointer = physical;
-	}
-	return ret;
-}
 
 static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage)
@@ -1621,7 +1600,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	if (sbio->page_count == 0) {
 		struct bio *bio;
 
-		ret = fill_writer_pointer_gap(sctx,
+		ret = btrfs_fill_writer_pointer_gap(sctx,
 					      spage->physical_for_dev_replace);
 		if (ret) {
 			mutex_unlock(&sctx->wr_lock);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 61d1e1c67a742..8493093aea849 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "dev-replace.h"
 #include "space-info.h"
+#include "scrub.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2233,3 +2234,25 @@ bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 	btrfs_put_block_group(cache);
 	return ret;
 }
+
+int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
+{
+	int ret = 0;
+	u64 length;
+
+	if (!btrfs_is_zoned(sctx->fs_info))
+		return 0;
+
+	if (!btrfs_dev_is_sequential(sctx->wr_tgtdev, physical))
+		return 0;
+
+	if (sctx->write_pointer < physical) {
+		length = physical - sctx->write_pointer;
+
+		ret = btrfs_zoned_issue_zeroout(sctx->wr_tgtdev,
+						sctx->write_pointer, length);
+		if (!ret)
+			sctx->write_pointer = physical;
+	}
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 487c699f152d4..5701f659b1c39 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -85,6 +85,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 				      struct btrfs_block_group *cache,
 				      u64 physical);
 bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical);
+int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -262,6 +263,11 @@ static bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info,
 {
 	return false;
 }
+static inline int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx,
+						    u64 physical)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

