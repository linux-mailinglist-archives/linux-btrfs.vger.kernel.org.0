Return-Path: <linux-btrfs+bounces-18615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D6C2ED74
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F99A1893B53
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096702459ED;
	Tue,  4 Nov 2025 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2QF/tZ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA021885A;
	Tue,  4 Nov 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220159; cv=none; b=uwW9vCEFT+nJDvjZElySK7HeBFS/dx5WCrJORjlUWCfepR/7taPp5ImTHyZDimnlLUUx8MTXeZSvETj4EvZD4TrYPiJJhe4UhI5yUk9rdGOmPp7pSfyjCfh5FQCYuenfHttutvOVa3FVZfzgKvhRf/QjCNoegB4giGcxeoSL9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220159; c=relaxed/simple;
	bh=jkUl4ViBNC1pK98r3zSHyTQiSlOqISQSn9wsaobDJ84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCzaLhyVwBs3Hr3yn6LDyDjhsRidWCNrcey2zzeJNuFnaIh+gG+hOJbLXNTtkyWTcY0tNqiK9iolGoB9h64+xpGBC42J+2OGv3GOVgYVZVr7qzrnUqUAZ653AvO3tasch5eBx1t1kgeL0qA1CAYKPr+08wLNbVMU/sGDq6HPDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2QF/tZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A58C116D0;
	Tue,  4 Nov 2025 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220158;
	bh=jkUl4ViBNC1pK98r3zSHyTQiSlOqISQSn9wsaobDJ84=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I2QF/tZ4+sqWQYEa/TO3+5KqFqsr/9ZvkLVyYkfsQcutBLQgMTZ2Nt5B+0g5u6J1O
	 p5xwVSkHF0Jmr7PwoRi8UWSE5XPsxKXmOhFT0JfEgsrlZa1LJb470qUEotevzPZOfw
	 NGrID2YKPfj1MdJOlvHD1zI0dcrXSSQNUKmLmVbMG5FhJJfshYvevXDZzBWb21dHZk
	 FksxN+cwB06Tz8FrZYooFkoNir5SPE31tVWlrLrEd1hiiwJHEQtIL2Su/PH+KL5PBr
	 P5xwV1rIivMPkNbIoMtQvf7Weead9xiBxB4EPoU0kAcbs4RqxV8OGv9X7kRbGzhV8M
	 r+YBMlhB//jpA==
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
Subject: [PATCH v3 08/15] block: refactor blkdev_report_zones() code
Date: Tue,  4 Nov 2025 10:31:40 +0900
Message-ID: <20251104013147.913802-9-dlemoal@kernel.org>
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

In preparation for implementing cached report zone, split the main part
of the code of blkdev_report_zones() into the helper function
blkdev_do_report_zones(), with this new helper taking as argument a
struct blk_report_zones_args pointer instead of a report callback
function and its private argument.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 37a52de866d6..0d1065c1e598 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -205,6 +205,21 @@ struct blk_report_zones_args {
 	void		*data;
 };
 
+static int blkdev_do_report_zones(struct block_device *bdev, sector_t sector,
+				  unsigned int nr_zones,
+				  struct blk_report_zones_args *args)
+{
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
+		return -EOPNOTSUPP;
+
+	if (!nr_zones || sector >= get_capacity(disk))
+		return 0;
+
+	return disk->fops->report_zones(disk, sector, nr_zones, args);
+}
+
 /**
  * blkdev_report_zones - Get zones information
  * @bdev:	Target block device
@@ -227,19 +242,12 @@ struct blk_report_zones_args {
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
-	struct gendisk *disk = bdev->bd_disk;
 	struct blk_report_zones_args args = {
 		.cb = cb,
 		.data = data,
 	};
 
-	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
-		return -EOPNOTSUPP;
-
-	if (!nr_zones || sector >= get_capacity(disk))
-		return 0;
-
-	return disk->fops->report_zones(disk, sector, nr_zones, &args);
+	return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
-- 
2.51.0


