Return-Path: <linux-btrfs+bounces-18564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C9C2C248
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9C26348B3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80459311596;
	Mon,  3 Nov 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2oVKNNM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DC30F52B;
	Mon,  3 Nov 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176942; cv=none; b=k5kFwLG0f8Q2dr+1bxGPK4ZNvKQ3KMQhTWyRVacKRnNHH1zOmciEUQEaBWnPINr7OiJSDP4a7YNjsQ7i8TQRHMjuRYUB+JpKkQJEYFo0QVH7bHS/NULu8UuSmyB+GJ0m9mjenBLn/oVyn4n7pHBV1ofBd4e0K3W+xB/FcIPiSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176942; c=relaxed/simple;
	bh=F0Y53yOzQK0GEWQg9LKd5r/CNwpbzxyWp8cxsYd+jOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTH3ZprExOoyC7lBClBR43LibahiLinsSyVEBEvr0xEE8CeOntWuzKYnL+fBPA+k0SyeowgHnxutsBg/3u26i44aK0nzbLmwHC0LYyp28diKmbQ5xx4A2RDSVyDpxff1cPTY8426Q+Z+uDt+QZP9D8aV6ngjUMP6tVfRIJkKsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2oVKNNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738FDC116B1;
	Mon,  3 Nov 2025 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176942;
	bh=F0Y53yOzQK0GEWQg9LKd5r/CNwpbzxyWp8cxsYd+jOA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n2oVKNNMUvJ8cJfbddT5JqfEGnZu+PKOKvlluxoX+09R9bK7871wsXLQXYnjnZ4px
	 a7hSP63D3aEVSbfefzjwWsak9UfZdY1jbiC2+HGoXGnWCzl/fRbaVNKTVs4R5u0Pnn
	 h+ze/ch9odAyItVn0c6oM4DHJbD0vePHeRIFRJ3nt8OLsRCBimBPSUzCUmO4j/GmcN
	 M8YgOZg3nUZbytaO/Tm68Ci66OATX8dDofaRplg1Hfm25qUen8bJzM+srZyr8RdOWN
	 GawMbETQA2Hj/rGfntp2C/QkDOFuNKrUH9MicC8YMNcenIshxjmEhkOLG/Nc/AqX/f
	 Mrl5VoBTxSSVA==
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
Subject: [PATCH v2 14/15] btrfs: use blkdev_report_zones_cached()
Date: Mon,  3 Nov 2025 22:31:22 +0900
Message-ID: <20251103133123.645038-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
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


