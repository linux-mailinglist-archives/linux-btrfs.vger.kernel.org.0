Return-Path: <linux-btrfs+bounces-19453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B7C9B16A
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 11:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235EE3A6BFA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0E30EF96;
	Tue,  2 Dec 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kn1KMIPr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B12FD668
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670671; cv=none; b=e81KEy9wHjOZtFAbdu+125VPMHpgkoUQ8Mwxh2ol3NV1hoLJK/drrlz/G1ZhYRcqdETv3FsuR5H3xvJVj3Rp7SYyRExOCDlS6L+uaikhtRSmlZNjCjaSI6G56U67ZdKoKPX/Q2SnAiNPKt1faDa5HvpzQJf1tgn5Uqs1pxB6cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670671; c=relaxed/simple;
	bh=s6uOG3eOqol0tEyZXtBs949zQydd/DU/RjVciImv6oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAf+HnyQoCW96OTHZ9FhY7B8edr9x/U4fWjsu6cJ8mhWJLEzjT915DPLhqS3W9QUFoN0VTgA1p5pXowVkQt8JMKGUtaF6L/RXoq581vD393nmtsb7mSEMhTXhTxB5rDJlab0RzD583XnPqkt+4IgZQxb8Pu5UNi2sOsQbgemwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kn1KMIPr; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764670669; x=1796206669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s6uOG3eOqol0tEyZXtBs949zQydd/DU/RjVciImv6oY=;
  b=kn1KMIPrTw7oFk+1MiZi6Sjb1jihzmrestzDFIWrcMrbHODHsvhiSuxq
   TvCFw7ZY1bko9va2GmyLoXFk2UuO0JCuKd7I7tAIveiHbRuE1y6CMk/ZQ
   iceaCyBLByaYSEK7Sa8ZqSlrCQ41SNRJfb1Ejtto3bvgRFXwUsrIrzGhD
   r8C/+m+Scw8EN+Qez0p3X7zZCV5+Fect6+xvDxC0pzRFyc0PJ6dPFIJN0
   snEakYIrqAIN0hZ2YBjFahCMBWUAGHQriXza5cUwXp56kRL5tsXwWJb1i
   vo6effU1/JDg+2Qz4I3RSM7EHCiLZxg6W/xtKbDEH5VsPcoFm3FWKso+Z
   w==;
X-CSE-ConnectionGUID: 0KMqv/EGQe2c/QlOHvgq+A==
X-CSE-MsgGUID: FboE+j0fT/+sSPHv4o+3yg==
X-IronPort-AV: E=Sophos;i="6.20,242,1758556800"; 
   d="scan'208";a="137502772"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2025 18:16:39 +0800
IronPort-SDR: 692ebc87_Iu+THZq6TPCVAM45+K3/N3rPwho6C3bvmIr3gOR8odDcWqD
 5I1fBFaoQwc0luT8EhdqNr7m+fMJZzYtn9OpHYg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2025 02:16:40 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Dec 2025 02:16:39 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] btrfs: zoned: don't zone append to conventional zone
Date: Tue,  2 Dec 2025 11:16:31 +0100
Message-ID: <20251202101631.155235-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of a zoned RAID, it can happen that a data write is targeting a
sequential write required zone and a conventional zone. In this case the
bio will be marked as REQ_OP_ZONE_APPEND but for the conventional zone,
this needs to be REQ_OP_WRITE.

This is a partial revert of commit d5e4377d5051 ("btrfs: split zone append
bios in btrfs_submit_bio") which was introduced before zoned RAID.

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: e9b9b911e03c ("btrfs: add raid stripe tree to features enabled with debug config")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4a7bef895b97..bc64faf361c9 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -492,14 +492,25 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 
 	/*
 	 * For zone append writing, bi_sector must point the beginning of the
-	 * zone
+	 * zone.
+	 *
+	 * In case of a zoned RAID, it can happen that a data write is
+	 * targeting a sequential write required zone and a conventional zone.
+	 * In this case the bio will be marked as REQ_OP_ZONE_APPEND but for
+	 * the conventional zone, this needs to be REQ_OP_WRITE.
 	 */
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
 
-		ASSERT(btrfs_dev_is_sequential(dev, physical));
-		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+		if (btrfs_dev_is_sequential(dev, physical)) {
+			u64 zone_start =
+				round_down(physical, dev->fs_info->zone_size);
+
+			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+		} else {
+			bio->bi_opf &= ~REQ_OP_ZONE_APPEND;
+			bio->bi_opf |= REQ_OP_WRITE;
+		}
 	}
 	btrfs_debug(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
-- 
2.51.1


