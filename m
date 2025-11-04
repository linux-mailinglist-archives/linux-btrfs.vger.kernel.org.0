Return-Path: <linux-btrfs+bounces-18697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD9C330A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 959593484BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5FE3016F2;
	Tue,  4 Nov 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObOrRvoq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEB2FC89C;
	Tue,  4 Nov 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291614; cv=none; b=F14vdDGFcL/xddDojVfAnXdaWc/21KfFEtsHeGFiI6+9tnPW9j0jB8MPLnQtAVLqOUXjs82ZjN9OoXm0SszUR/xhX9NDuiyFvkdwQ13ug4zXUIMpU2R6m0sOF2iaR7d5Q/U8AnBt1FmKyBb/DOdDuC2jm4+Lz8qqrWW0a68++BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291614; c=relaxed/simple;
	bh=4q4p+IFe5Iy7QQe7jIRJcL0InLZzcorfJ3Z8S4gSK0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/11F3O6FnmnWtZjNFMYEI7NLQgkMpbDGYqgXOayujQQ9cqVcnqpr12lCYEJ5gCThkxeC8YbfozGfOSV8AZR7n6LnK0KCH9v/+dmcjeXo7S2d5AjZ1kEPuP6vUWax5dgPibnaUV8eO4oYd2/nx/rpkqZBg2JGZY0haunaB5ya7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObOrRvoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D1BC2BC87;
	Tue,  4 Nov 2025 21:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291613;
	bh=4q4p+IFe5Iy7QQe7jIRJcL0InLZzcorfJ3Z8S4gSK0M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ObOrRvoqXHYVp3vmEVXkBvslTW+QQRffkWq2pT8X22vy1qUtTFW9g4HggqgYHVi8T
	 De/0fAQhxBvOTlLij820n/gbaEI/FqLeoq6aDQSHGnUsOU7QJmjz4zfJmbwOcgUpNT
	 /tdfyqDvI3a19hpXN4xH14haULuxld9rjmPHNqakfrl0f5og1kVjz397IE/qFFpCou
	 vkwBfrH8RmNgUq68qLRXOyKEb/CmjqUoAjI01ka2n1QGUrjLL/q2w4J9xZ8Ig+q0Xq
	 lIgegcDSywX36VFBAilb86stAz+VckkDvcYSqKF35U28wivCcLAI6EQhpgn81Trb+f
	 P3YYLsrbFrQRw==
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
Subject: [PATCH v4 08/15] block: refactor blkdev_report_zones() code
Date: Wed,  5 Nov 2025 06:22:42 +0900
Message-ID: <20251104212249.1075412-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-zoned.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c5fa303093a9..9ce7570c91e1 100644
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


