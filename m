Return-Path: <linux-btrfs+bounces-18692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8EC33076
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E984345451
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C32FE59E;
	Tue,  4 Nov 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDQf46WU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5F1A9F90;
	Tue,  4 Nov 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291603; cv=none; b=CEsvdRyx+DAl8/9PvWnXvqfL1YWy7aFFLni1YnIrGgHfv5Fv68EY6NYyQnJdsBD20/PzkH8ou1n6oaAe/JtbOSKFoEy+Ob8PeSRYDVcQkYmqbbZkKQPJzqxS1yIxF3xFwF6lh66m74nwhep2AAnLa8biq7LPgvF9M8YfQzc/9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291603; c=relaxed/simple;
	bh=goTxUR9sY+5MZ0Lvwe28IT8BAyNBWJDCOxJ6MfQCEWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9F4rWfprecydsBq1L5cmtKod4TQU/j5WPg2VcwT8D8C8WgyhQXukq0F5FL+DWBOupKw3zRWI/VkkBhlYQgv38d/u9mj9ka0l+ikgERhn+35+lLInLqv5oTYs9ado4rcNIzG3vmBcAGR8SzlOz7v+M8VMmIy4HuYKGjRSHP0zIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDQf46WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF15C116C6;
	Tue,  4 Nov 2025 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291603;
	bh=goTxUR9sY+5MZ0Lvwe28IT8BAyNBWJDCOxJ6MfQCEWM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gDQf46WUf84CW33weesHt+zt6u/6rH8erAEFUjOaZ9CGkNJ5FhfjvurhX/aBlX17v
	 R7+uKdgGiEh73ZmnFKAiW7wZikYdrijVP6T7iuXd2Wn4eBSsv2VjjkOq2ZjZUZunII
	 dJJ2UjzXlvYA1IP6llRtVgDVEhia5rdArF6upEYj0qCEvhdMIQHb1yTSJC4CHcO2in
	 BiEhy0EskKoHUIG9shfIw7NghRHIMKJljPUqSh4K9J5Ksh5gAF7HYbdvrv+kB9VCGk
	 C6l6afyKaVcp/ps7hL+pFpZqHWuHsi8kqiQFg8IgfxgBqzPYYKJ0yB8w5WE510bBmw
	 yIqa7kXzITO4w==
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
Subject: [PATCH v4 03/15] block: cleanup blkdev_report_zones()
Date: Wed,  5 Nov 2025 06:22:37 +0900
Message-ID: <20251104212249.1075412-4-dlemoal@kernel.org>
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

The variable capacity is used only in one place and so can be removed
and get_capacity(disk) used directly instead.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


