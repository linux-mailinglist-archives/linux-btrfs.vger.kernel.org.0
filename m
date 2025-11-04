Return-Path: <linux-btrfs+bounces-18691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBBFC3307F
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E254EB801
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09E2FE599;
	Tue,  4 Nov 2025 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrEXXOI6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4C1A9F90;
	Tue,  4 Nov 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291601; cv=none; b=SbNl4YcODVLi6h+aRZT7YauBVzFJqsTyZQdhe/Ej9rux70Bzxq6I4j2svtlzTvkwFRrg90PrPwbyeONebeLbf+EkB6wgiVtbj195y/pXmSKc1w0rs+6sYIs6fQ3xVd+AUdxYK5Iyj/FolT0luryb8p8xlbEf+5g9tU4H9eoIj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291601; c=relaxed/simple;
	bh=/xwxpZoZQdjln8OdRpJCVwfKWlOMbM7aOH51bFYfDDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz/OGJLh7ChF5YeG1+8zrLuOy0BtBx6+qKX0BS3ZEqAIsF3wtfQJgFKz+Ce4hcguHtX1I4NHU2vCmfwjGn2x+Pj7Mxv1pboUQYpMXJZlzy8KN6j2HflPKOCzd4uucrsp/ag3dSpFVI3VoUpeyUESU3WEHhnYdCkVxQDgRGq7Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrEXXOI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A9C116B1;
	Tue,  4 Nov 2025 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291601;
	bh=/xwxpZoZQdjln8OdRpJCVwfKWlOMbM7aOH51bFYfDDM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nrEXXOI6ZyY/LMVGGSxagTPISYLeckUjasIFAg8LpAtDJpYoWnORa2HvYYh/i2lBW
	 aJF71X/Z6TUybZZBKvot1Iv3a0HOJ69quqMP01gfaF21Ba+IirghYDMB3SfBvhQ4wI
	 ejbc7dEv72l/v3lqtH7xk/lP6CDtpZl4BrOdImONyhWnfq78Y2+hUtF9P5awdOcF2M
	 nF6BBm+tRq0coKqLhEAbQXmU7v/XGzQBQbHZdmUMNgIJodzoQR0GF8GdeC4kM/9Q9S
	 zUYZeM+48fRl93je1FZ5RlB6fz3B44badlHJcnpRgOulZsp/T1qyD+PS7UGf0TjXQ7
	 l/kl78/agu5vA==
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
Subject: [PATCH v4 02/15] block: freeze queue when updating zone resources
Date: Wed,  5 Nov 2025 06:22:36 +0900
Message-ID: <20251104212249.1075412-3-dlemoal@kernel.org>
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

Modify disk_update_zone_resources() to freeze the device queue before
updating the number of zones, zone capacity and other zone related
resources. The locking order resulting from the call to
queue_limits_commit_update_frozen() is preserved, that is, the queue
limits lock is first taken by calling queue_limits_start_update() before
freezing the queue, and the queue is unfrozen after executing
queue_limits_commit_update(), which replaces the call to
queue_limits_commit_update_frozen().

This change ensures that there are no in-flights I/Os when the zone
resources are updated due to a zone revalidation. In case of error when
the limits are applied, directly call disk_free_zone_resources() from
disk_update_zone_resources() while the disk queue is still frozen to
avoid needing to freeze & unfreeze the queue again in
blk_revalidate_disk_zones(), thus simplifying that function code a
little.

Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-zoned.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1621e8f78338..39381f2b2e94 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1557,8 +1557,13 @@ static int disk_update_zone_resources(struct gendisk *disk,
 {
 	struct request_queue *q = disk->queue;
 	unsigned int nr_seq_zones, nr_conv_zones;
-	unsigned int pool_size;
+	unsigned int pool_size, memflags;
 	struct queue_limits lim;
+	int ret = 0;
+
+	lim = queue_limits_start_update(q);
+
+	memflags = blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1568,11 +1573,10 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	if (nr_conv_zones >= disk->nr_zones) {
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
 			disk->disk_name, nr_conv_zones, disk->nr_zones);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unfreeze;
 	}
 
-	lim = queue_limits_start_update(q);
-
 	/*
 	 * Some devices can advertize zone resource limits that are larger than
 	 * the number of sequential zones of the zoned block device, e.g. a
@@ -1609,7 +1613,15 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	return queue_limits_commit_update_frozen(q, &lim);
+	ret = queue_limits_commit_update(q, &lim);
+
+unfreeze:
+	if (ret)
+		disk_free_zone_resources(disk);
+
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
@@ -1774,7 +1786,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	sector_t zone_sectors = q->limits.chunk_sectors;
 	sector_t capacity = get_capacity(disk);
 	struct blk_revalidate_zone_args args = { };
-	unsigned int noio_flag;
+	unsigned int memflags, noio_flag;
 	int ret = -ENOMEM;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
@@ -1824,20 +1836,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		ret = -ENODEV;
 	}
 
-	/*
-	 * Set the new disk zone parameters only once the queue is frozen and
-	 * all I/Os are completed.
-	 */
 	if (ret > 0)
-		ret = disk_update_zone_resources(disk, &args);
-	else
-		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-	if (ret) {
-		unsigned int memflags = blk_mq_freeze_queue(q);
+		return disk_update_zone_resources(disk, &args);
 
-		disk_free_zone_resources(disk);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
+	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
+
+	memflags = blk_mq_freeze_queue(q);
+	disk_free_zone_resources(disk);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
 }
-- 
2.51.0


