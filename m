Return-Path: <linux-btrfs+bounces-998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2F816082
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF3328335B
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4047A57;
	Sun, 17 Dec 2023 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8QiNrYJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D246550;
	Sun, 17 Dec 2023 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KlChkldQeuhwg4sxIRC77ivEjvHivSeAsGBLr02m6Wc=; b=A8QiNrYJJbfUqc7JdOr6skrvzo
	nm5wo6AewBrtor0R3qDFAUAV9HlX1yOpRqpF0O5BlElQumPtwm7vxXmjcOVeBJfYbYbABo1B+oQEd
	BUIGYmNhA2uRPOEAxQp+oZ9kU0g53+ZZD4dU80h5RiQq7EuhD03SHLGJEnAlotzLzOHh9hi6u0h4p
	55oFWl+69jtZntJHoZsIAaGlgHUE7vDrq1ezeAaJwG56gt8dCyY8kjTWRSbUn8A4PMIoQDkhJI65t
	FVb6UG7Iedu5Hn0UBSDfKl543zXrGYnXEQVm72mkFNmGVDW26HfrpJwbzpG3PUnEyj9eRwNPYRLgh
	Cxe/01WA==;
Received: from [88.128.92.84] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuP2-0088Lm-1m;
	Sun, 17 Dec 2023 16:54:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 2/5] virtio_blk: remove the broken zone revalidation support
Date: Sun, 17 Dec 2023 17:53:56 +0100
Message-Id: <20231217165359.604246-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

virtblk_revalidate_zones is called unconditionally from
virtblk_config_changed_work from the virtio config_changed callback.

virtblk_revalidate_zones is a bit odd in that it re-clears the zoned
state for host aware or non-zoned devices, which isn't needed unless the
zoned mode changed - but a zone mode change to a host managed model isn't
handled at all, and virtio_blk also doesn't handle any other config
change except for a capacity change is handled (and even if it was
the upper layers above virtio_blk wouldn't handle it very well).

But even the useful case of a size change that would add or remove
zones isn't handled properly as blk_revalidate_disk_zones expects the
device capacity to cover all zones, but the capacity is only updated
after virtblk_revalidate_zones.

As this code appears to be entirely untested and is getting in the way
remove it for now, but it can be readded in a fixed version with
proper test coverage if needed.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index aeead732a24dc9..a28f1687066bb4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -722,27 +722,6 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 	return ret;
 }
 
-static void virtblk_revalidate_zones(struct virtio_blk *vblk)
-{
-	u8 model;
-
-	virtio_cread(vblk->vdev, struct virtio_blk_config,
-		     zoned.model, &model);
-	switch (model) {
-	default:
-		dev_err(&vblk->vdev->dev, "unknown zone model %d\n", model);
-		fallthrough;
-	case VIRTIO_BLK_Z_NONE:
-	case VIRTIO_BLK_Z_HA:
-		disk_set_zoned(vblk->disk, BLK_ZONED_NONE);
-		return;
-	case VIRTIO_BLK_Z_HM:
-		WARN_ON_ONCE(!vblk->zone_sectors);
-		if (!blk_revalidate_disk_zones(vblk->disk, NULL))
-			set_capacity_and_notify(vblk->disk, 0);
-	}
-}
-
 static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 				       struct virtio_blk *vblk,
 				       struct request_queue *q)
@@ -823,10 +802,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
  */
 #define virtblk_report_zones       NULL
 
-static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
-{
-}
-
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
@@ -982,7 +957,6 @@ static void virtblk_config_changed_work(struct work_struct *work)
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
 
-	virtblk_revalidate_zones(vblk);
 	virtblk_update_capacity(vblk, true);
 }
 
-- 
2.39.2


