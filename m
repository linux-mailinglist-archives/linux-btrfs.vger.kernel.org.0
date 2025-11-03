Return-Path: <linux-btrfs+bounces-18553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A491C2C2E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FE1D4F6760
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96B313E37;
	Mon,  3 Nov 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAlIW2Q3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D50306B06;
	Mon,  3 Nov 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176918; cv=none; b=GPxgVXHm327cZXB+r1Ma6rcELKgT+32ehAVPvdJqKsEbkjgOodJTbF/MX3F7qHfzTnGb3HKuNzuWHU8HuAQrzZQe2cKAaHGq10N6tYuTAoE1VsJzjVbr6EBEu+XRPqbyVxZD1olIOLUj5lp4xxiyj42+ozZTk1iVfxauFmHxv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176918; c=relaxed/simple;
	bh=LTm6BRN1/E0TEs1v3UQpAGeeBxcejN2EF7uTV0DB94E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM6pqafqKGZP9a8EjWyQ1IieKWFK/j/Avy+jDlnmv6PlihKb9pfPV4PWsaTRkpQoWmv4eidL86S0JVkFGcLzqQTItV83sPTtMhdMVxi+ESrvWHa5vOqWwovWWro0Pnx2q6f355vn8mbREYgiOp9VH4mn3QrC9C3h+V4koX9pzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAlIW2Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A1CC4CEE7;
	Mon,  3 Nov 2025 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176917;
	bh=LTm6BRN1/E0TEs1v3UQpAGeeBxcejN2EF7uTV0DB94E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sAlIW2Q3lRNjeb0v041b0CkVfOh6vOlPGFyD9NmqMjrLnO1bd7FEYSN1X+BEab+AM
	 tKKGbLPuXoq+sK9wuF+VD8PqgCM48MWd6aYrO+YZyQ4l/rUiwgt5DbBw1pr4rNWvq6
	 zJ+kQBGOMPeGblC5axF4kigfMGGSpl2I5YcLfwmrEDqb6m/qnvbCAQPpZrr1Qzmwip
	 ZaJHNzbnb3dgwiv6RwnBur06R8du0Ivkf3ht/uShIkmR55YOLQgS1NzCea7hSspubp
	 Z0bo9qHFrXdQKVGBFE//q8J2mwyviG/Zgx4XdCHHshfDuqmqh1pwAsgFUnMw8MiU1X
	 OUoSDzM8pxGUA==
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
Subject: [PATCH v2 03/15] block: cleanup blkdev_report_zones()
Date: Mon,  3 Nov 2025 22:31:11 +0900
Message-ID: <20251103133123.645038-4-dlemoal@kernel.org>
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

The variable capacity is used only in one place and so can be removed
and get_capacity(disk) used directly instead.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 39381f2b2e94..345a99c0b031 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -161,7 +161,6 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	sector_t capacity = get_capacity(disk);
 	struct disk_report_zones_cb_args args = {
 		.disk = disk,
 		.user_cb = cb,
@@ -171,7 +170,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!nr_zones || sector >= capacity)
+	if (!nr_zones || sector >= get_capacity(disk))
 		return 0;
 
 	return disk->fops->report_zones(disk, sector, nr_zones,
-- 
2.51.0


