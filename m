Return-Path: <linux-btrfs+bounces-18437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF987C23569
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 07:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBCF54ECF86
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66242FF176;
	Fri, 31 Oct 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6DSOOTD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309B2F90C5;
	Fri, 31 Oct 2025 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891419; cv=none; b=JRHHCBJ4AOXwfdcvqeVfP/IW5h3Sk93WW81fpyO5mJshqDuEycCd8hGdWABC8rVLbwW+hhKJyf313O1XQmUEltqSY07bM7OznDVLCE6EMYejnDLAfBKrn956lxoBiRxRU/G6iabGYZMRsIm5NW4ip2GUoueVktEJXQpXybZbqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891419; c=relaxed/simple;
	bh=xwJGKs+ja6Mu5nwgEcOtg9NZDElPFC8sS7FDYIJ5NIQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYDZ/7uGlUwCbQ+FtdLz0haD0Ft5ve19hkUVrt4Gi/b2yzH64XaK+pVZ0eYqMmAwpwhMMbVQFpmdTUzvVuMB1LSE832Zm6I/zmPWG2aQh5/OnPTQ7imu8QkvNJ50R/h7Fh3Hp6j0eDcZfZeE+XNC+WGvCD5A6lRVQoOsU/g+Rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6DSOOTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29851C4CEFB;
	Fri, 31 Oct 2025 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891418;
	bh=xwJGKs+ja6Mu5nwgEcOtg9NZDElPFC8sS7FDYIJ5NIQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V6DSOOTD+Cnpj6XY6hneK8tmeOOrOKZ9EUj/Vj1TD+JAe0Ij9GI48eC9HxHtHucBt
	 cVukCSw28oau3s1oTzNBarL5Si3Aqzhxm8YNnr0IPxQzrYHBQSiWfb1B2Nj8WS9IPI
	 uO7hog2b6GwN4f6w2OFgdSQi1Z9cyng8ih5E557tKay/rj06YpGSeJvgdxOM6kDpgY
	 y7h0HRtGC5H48MxUcHZXPp3sW+4YMHPnxJyzfHgHvqEkrQ/dkhGnepHR8r5Cq5gOTa
	 Ls10oeR0BR9iJUJbhXvRb7TJ/w7fJYA3y0WS/zMWBNItLNPZ60MRNQsX+NdrNzXMHG
	 xSezGolvE1iUQ==
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
Subject: [PATCH 02/13] block: cleanup blkdev_report_zones()
Date: Fri, 31 Oct 2025 15:12:56 +0900
Message-ID: <20251031061307.185513-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f3b371056df4..8d2111879328 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -156,7 +156,6 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	sector_t capacity = get_capacity(disk);
 	struct disk_report_zones_cb_args args = {
 		.disk = disk,
 		.user_cb = cb,
@@ -166,7 +165,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!nr_zones || sector >= capacity)
+	if (!nr_zones || sector >= get_capacity(disk))
 		return 0;
 
 	return disk->fops->report_zones(disk, sector, nr_zones,
-- 
2.51.0


