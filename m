Return-Path: <linux-btrfs+bounces-18610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC78C2EC8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18313AF81C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD913238D5A;
	Tue,  4 Nov 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjpmhH30"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D020298C;
	Tue,  4 Nov 2025 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220144; cv=none; b=HS7vk1PxfUI4wz/ibTSWxFwBIgMQms9NlJUE6tScOjXnMjnkpUq6AfMGaL4kk6w9Cwqc4YZ5Sa/DY24ZSP5NiMrCPkRNlfgzsyZQb0cbQII2JN3VA1qkcJbwt1ngi7BbJDNGXxU2ukrv48CfzUDUHxbAVgnFC8QhN0u6kGe/FAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220144; c=relaxed/simple;
	bh=9InpRURhYbB7IrlbGJubi87XDnqd+ozFRAai+B84hx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBNhboJPS85Xbhnxc5tqrMP4Nmg9QbQFSWZYFrrrminDWkJDTYy5uZ78kCM404ulONvmA+72mQ0QFx80MbiKWMkXAlo6+C7Fz4a9W/YO/ChmjSY2G7S8BAlckIi+P1tXz+qKqtOBCNuEJ7D4I83yKDUtWpCt+GwvAq40J6QlJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjpmhH30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D69C4CEE7;
	Tue,  4 Nov 2025 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220144;
	bh=9InpRURhYbB7IrlbGJubi87XDnqd+ozFRAai+B84hx0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EjpmhH30VnLBivCc2tVh6vrvOF2LLaiSVWlByDGxUaGaI6vHURjCtIWhpcTkdaeua
	 JByC5SDjTfF8ZH1ccSBPaY4aGZQyF5iF2cnJ93H0f727EOMbxMINpnJQCdYBdCiNYM
	 Zky/uJnx/130sNM2iLTFQ1EhrwPgznLXCGl3GKGcXdm/lA0mDzklndRgby+8DBOcp4
	 Gps2CiuLInvk3e5pbO0/UNVBIFpiSxeQBXj3oGa9hwsqMo7Jmsasj3Zl1yvImXva3O
	 DbH3wwFitnDeXjz+Kq2BSTjzuHuhDnUe+A/Dbgclk9yesCiZT7vtWEK63uMiRIIqkE
	 VcNH2rBLFG5Mg==
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
Subject: [PATCH v3 03/15] block: cleanup blkdev_report_zones()
Date: Tue,  4 Nov 2025 10:31:35 +0900
Message-ID: <20251104013147.913802-4-dlemoal@kernel.org>
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

The variable capacity is used only in one place and so can be removed
and get_capacity(disk) used directly instead.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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


