Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB42F735D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbhAOHAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 02:00:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41680 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbhAOHAl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 02:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694041; x=1642230041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hcObCvZrTFsV8rlbA9jYB27S/5RRD+XCCNFKc01V95M=;
  b=c8HiQcnwt681Uujnf23bK6QBCCW9BaRwQfjGI0QLC+So/UCrsiYgSgTB
   vNBiR47VCS9kFLy0pUC15rcVSRLiDOJTZIUT5veqBz4gwJIazHRY74Mvi
   YXvZS9b8fyuM6uSCC9qicPf0uIOMzN3NmvPOjfnKV7+2tCEjgNbIk47NJ
   UjsMrBdwQ/NYe6w/D4tzoZqMlPu0R8IkYC/0u8C1W07PcraFPWirQ70TJ
   Z7ZPmei4aDq9kaQ8+QM+cUqW/nNbA650/hHoXqng0JPdojbi8L2M1Acnd
   q0Hnl52n+TpJX/D/h8GbiW8jZupKA49/rhHXhqvcA0+QiOpE+eNwYeubP
   w==;
IronPort-SDR: VvPX2N44FHg6qNNn6FGRpn2qb+fVOVY02TNSDDlVKdaKFW7BgLHvHdXVx9UkRhW/WZ01yNhF+W
 IerA143+HtJuSb9wpXjc3kiKhqB+d2qIT9Zstyd7NCBT21HCTI9rUfETurAaSv68ceeA/Z3YgW
 8CE9aB1SoI7sbpojuKxIJ/T2ORgwZCndXBK6OVw/CBSZsBz4Y4krlnZcsPiQ0UOfJtbzNIWOh+
 iWHNDPkiIFeQpFBy4kDLgi4sYZxDIW334UAMwKRpBJYrZ4t/EJulMSr6jgQ3c7ZAw2gd5EzRrH
 cZw=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928310"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:15 +0800
IronPort-SDR: SeRuTmly++h80ycyG2V/NYnh4O3MvZPRqjYvaskcV5cpeZX3EpUgH3N+xE3b409ADOVVrH9LjZ
 zTwT1m6WmWB/U+fgarZQFt2R0UCxV87ApOjO6foX7NfflA01iZ9Pi2NDR+9imY4lo4AUcdE1fK
 Lqpk80CFgoFEkIWzEF4cQlkyo2rN9NITJL+BAcRRmK2Z/S9iafjgni3fMRhSteI0detMK8mHJx
 vyO5Rekp+JmW4NhQji7PlxEN9jjVfZPck6VkYMCef18JRyTrNt0r1Php1l0rFnaKbhUpYZEq9+
 ZqFmOi5/q0VptL3Gevb26l2/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:57 -0800
IronPort-SDR: 8aEt9nvfWxMieP+Hj2z6Dm0GnU76I+mCSfTKyNUa99e1ggCMnlkcruhJi2rMOE7rlX5xq8rblW
 dL8VuGX/h7/ujBOKwX0Ikd7FaCW/ogWERgPt4Tp23EHOiCdCqmHCUwkPVRD4N6trv1Qf3BhbPG
 sQNdxfw/5isFM/HNKgypoTLSUddrxKt7srsZYw/x24EpJWZPNRXJlhIejrCpyT71Dz6QQwOIrH
 QksHQt0UqAzHDEJD6uN2f4Nc8+fKExkpuKrOCuPOWSp1Zo3zvcZZjaJYofs/koMzL8ZJoXvA6r
 MuQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:14 -0800
Received: (nullmailer pid 1916490 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 35/41] btrfs: support dev-replace in ZONED mode
Date:   Fri, 15 Jan 2021 15:53:39 +0900
Message-Id: <30cfb6b35f69048554247f66599e821f769d60a9.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is 4/4 patch to implement device-replace on ZONED mode.

Even after the copying is done, the write pointers of the source device and
the destination device may not be synchronized. For example, when the last
allocated extent is freed before device-replace process, the extent is not
copied, leaving a hole there.

This patch synchronize the write pointers by writing zeros to the
destination device.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 39 +++++++++++++++++++++++++
 fs/btrfs/zoned.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  9 ++++++
 3 files changed, 122 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b03c3629fb12..2f577f3b1c31 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1628,6 +1628,9 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	if (!btrfs_is_zoned(sctx->fs_info))
 		return 0;
 
+	if (!btrfs_dev_is_sequential(sctx->wr_tgtdev, physical))
+		return 0;
+
 	if (sctx->write_pointer < physical) {
 		length = physical - sctx->write_pointer;
 
@@ -3074,6 +3077,31 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
 		   atomic_read(&sctx->bios_in_flight) == 0);
 }
 
+static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
+					u64 physical, u64 physical_end)
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
+			btrfs_err(fs_info, "failed to recover write pointer");
+	}
+	mutex_unlock(&sctx->wr_lock);
+	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
+
+	return ret;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3480,6 +3508,17 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
 	btrfs_free_path(ppath);
+
+	if (sctx->is_dev_replace && ret >= 0) {
+		int ret2;
+
+		ret2 = sync_write_pointer_for_zoned(sctx, base + offset,
+						    map->stripes[num].physical,
+						    physical_end);
+		if (ret2)
+			ret = ret2;
+	}
+
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9344d49f8b56..ecee4a9d2127 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -12,6 +12,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1393,3 +1394,76 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 				    length >> SECTOR_SHIFT,
 				    GFP_NOFS, 0);
 }
+
+static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
+			  struct blk_zone *zone)
+{
+	struct btrfs_bio *bbio = NULL;
+	u64 mapped_length = PAGE_SIZE;
+	unsigned int nofs_flag;
+	int nmirrors;
+	int i, ret;
+
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
+			       &mapped_length, &bbio);
+	if (ret || !bbio || mapped_length < PAGE_SIZE) {
+		btrfs_put_bbio(bbio);
+		return -EIO;
+	}
+
+	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		return -EINVAL;
+
+	nofs_flag = memalloc_nofs_save();
+	nmirrors = (int)bbio->num_stripes;
+	for (i = 0; i < nmirrors; i++) {
+		u64 physical = bbio->stripes[i].physical;
+		struct btrfs_device *dev = bbio->stripes[i].dev;
+
+		/* Missing device */
+		if (!dev->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone(dev, physical, zone);
+		/* Failing device */
+		if (ret == -EIO || ret == -EOPNOTSUPP)
+			continue;
+		break;
+	}
+	memalloc_nofs_restore(nofs_flag);
+
+	return ret;
+}
+
+/*
+ * Synchronize write pointer in a zone at @physical_start on @tgt_dev, by
+ * filling zeros between @physical_pos to a write pointer of dev-replace
+ * source device.
+ */
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				    u64 physical_start, u64 physical_pos)
+{
+	struct btrfs_fs_info *fs_info = tgt_dev->fs_info;
+	struct blk_zone zone;
+	u64 length;
+	u64 wp;
+	int ret;
+
+	if (!btrfs_dev_is_sequential(tgt_dev, physical_pos))
+		return 0;
+
+	ret = read_zone_info(fs_info, logical, &zone);
+	if (ret)
+		return ret;
+
+	wp = physical_start + ((zone.wp - zone.start) << SECTOR_SHIFT);
+
+	if (physical_pos == wp)
+		return 0;
+
+	if (physical_pos > wp)
+		return -EUCLEAN;
+
+	length = wp - physical_pos;
+	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index a9698470c08e..8c203c0425e0 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -57,6 +57,8 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 			      u64 length);
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				  u64 physical_start, u64 physical_pos);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -177,6 +179,13 @@ static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
 	return -EOPNOTSUPP;
 }
 
+static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
+						u64 logical, u64 physical_start,
+						u64 physical_pos)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

