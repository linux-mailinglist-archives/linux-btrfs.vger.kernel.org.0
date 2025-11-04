Return-Path: <linux-btrfs+bounces-18621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA28C2EDA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4C81883896
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECF25DB1A;
	Tue,  4 Nov 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2JNc3fU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA7225A3D;
	Tue,  4 Nov 2025 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220176; cv=none; b=jWCf1EoRhg2iznCigQwXQMd/6qj0BRdPYIcL7tGnJuPOAlDZ/28hq36OrZtzZMn5F8xnigzOusm8gIg4aanNJS3s5tVdiiLMDL58DUVha29Bwh/d8shvJvuIEFPEfCI0s52zKZbXlQ6n39U4et7mUULXb6h/rji0I7HJaubFxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220176; c=relaxed/simple;
	bh=OQJzlNo20cxcnEk3FJgiDo6Dfxs8oL2XA0KXotU9jrQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGCo2aLfady04WroIuAXI5blBj/bZmT4sCt0DzKhG5Q5Iln1sRVxKStKEkRqz3SlB3LGOjO5pws4dlnEACQYlnLI3pVeBAmOURiO0ZmcSIRLZK385iWMqOrnPg7APpGobOhreJ4SDByL82Z0TiuVg1hsZ1bTn26YnAW1+m05200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2JNc3fU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6738CC4CEFD;
	Tue,  4 Nov 2025 01:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220175;
	bh=OQJzlNo20cxcnEk3FJgiDo6Dfxs8oL2XA0KXotU9jrQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k2JNc3fUlQAm++2dsZAOKRxIOhde2xHUpSndWj6z398/JxPsbMFOybS6ARsEcmRyD
	 YxDMmA/5j+lSviehZwLtJXO6M1X7mYH0YVsseysDy00Z87s9JMeMpchSETSLBHjzLR
	 jZXYZ6GX7OpPtk4X/TFcs3GaOs/OJ82qi0jUrQX1ZOnUleAApzCHCjZfNGNzUy/QOW
	 s9es4oE1mFj3dBydAtIfqWsV2pARuQd08b03eURHHJWJMkwEvXZt7pfjBhRC6X/A5y
	 XvtzOvW6LJxaMOFII4tkPAyM0rL064Xs0eklNOdCdMg/x1EX/X6K2KTEqm+g7PVeCY
	 15JA+MZHTKW+g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v3 14/15] btrfs: use blkdev_report_zones_cached()
Date: Tue,  4 Nov 2025 10:31:46 +0900
Message-ID: <20251104013147.913802-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify btrfs_get_dev_zones() and btrfs_sb_log_location_bdev() to replace
the call to blkdev_report_zones() with blkdev_report_zones_cached() to
speed-up mount operations. btrfs_get_dev_zone_info() is also modified to
take into account the BLK_ZONE_COND_ACTIVE condition, which is
equivalent to either BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN or
BLK_ZONE_COND_CLOSED.

With this change, mounting a freshly formatted large capacity (30 TB)
SMR HDD completes under 100ms compared to over 1.8s before.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0ea0df18a8e4..a16b1a896c78 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -264,8 +264,8 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 		}
 	}
 
-	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
-				  copy_zone_info_cb, zones);
+	ret = blkdev_report_zones_cached(device->bdev, pos >> SECTOR_SHIFT,
+					 *nr_zones, copy_zone_info_cb, zones);
 	if (ret < 0) {
 		btrfs_err(device->fs_info,
 				 "zoned: failed to read zone %llu on %s (devid %llu)",
@@ -494,6 +494,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 			case BLK_ZONE_COND_IMP_OPEN:
 			case BLK_ZONE_COND_EXP_OPEN:
 			case BLK_ZONE_COND_CLOSED:
+			case BLK_ZONE_COND_ACTIVE:
 				__set_bit(nreported, zone_info->active_zones);
 				nactive++;
 				break;
@@ -896,9 +897,9 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
-	ret = blkdev_report_zones(bdev, zone_start_sector(sb_zone, bdev),
-				  BTRFS_NR_SB_LOG_ZONES, copy_zone_info_cb,
-				  zones);
+	ret = blkdev_report_zones_cached(bdev, zone_start_sector(sb_zone, bdev),
+					 BTRFS_NR_SB_LOG_ZONES,
+					 copy_zone_info_cb, zones);
 	if (ret < 0)
 		return ret;
 	if (unlikely(ret != BTRFS_NR_SB_LOG_ZONES))
-- 
2.51.0


