Return-Path: <linux-btrfs+bounces-997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15481607E
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B741F22A76
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D046B84;
	Sun, 17 Dec 2023 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FUbbpnZX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD544C88;
	Sun, 17 Dec 2023 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=enCDnmquPxgkKwyC2qR+XvLDdfSg3i0fs7qLsP5yxNo=; b=FUbbpnZXpZXYkogFygGqF1CsxS
	3q0u0AVgQRMNtArBU8J1RTa8Clyr56ma9xu9AFpzqJ3BeVlkU51f5V36bFr4h2qEBS0xYIuCBQr6q
	a0pLswR6pP7xGDEP9ezgXNYTsNUAzluP5cnFcXZB2YG4c9X7CEHhgjvk6f+Z71cUG4Adpwn4pOfpq
	SQXhD0/QUDfaxd15cALzv4KRsTDHHHhmaO5kmK04P/g7wTzP8wjksPRC6rPwTzoht7Q8NZLVDOpY5
	oMSHLyR27nAxUua10tl/v37Y8KyrUiPzs6LqQJeRl15W0RAu4YCpQkgE+Pr1+aElgXgihdYnuTrkH
	kdufIV4Q==;
Received: from [88.128.92.84] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuOz-0088LO-2C;
	Sun, 17 Dec 2023 16:54:06 +0000
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
Subject: [PATCH 1/5] virtio_blk: cleanup zoned device probing
Date: Sun, 17 Dec 2023 17:53:55 +0100
Message-Id: <20231217165359.604246-2-hch@lst.de>
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

Move reading and checking the zoned model from virtblk_probe_zoned_device
into the caller, leaving only the code to perform the actual setup for
host managed zoned devices in virtblk_probe_zoned_device.

This allows to share the model reading and sharing between builds with
and without CONFIG_BLK_DEV_ZONED, and improve it for the
!CONFIG_BLK_DEV_ZONED case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 50 +++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69a4..aeead732a24dc9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -748,22 +748,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 				       struct request_queue *q)
 {
 	u32 v, wg;
-	u8 model;
-
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.model, &model);
-
-	switch (model) {
-	case VIRTIO_BLK_Z_NONE:
-	case VIRTIO_BLK_Z_HA:
-		/* Present the host-aware device as non-zoned */
-		return 0;
-	case VIRTIO_BLK_Z_HM:
-		break;
-	default:
-		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
-		return -EINVAL;
-	}
 
 	dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
 
@@ -846,16 +830,9 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
-	u8 model;
-
-	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
-	if (model == VIRTIO_BLK_Z_HM) {
-		dev_err(&vdev->dev,
-			"virtio_blk: zoned devices are not supported");
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	dev_err(&vdev->dev,
+		"virtio_blk: zoned devices are not supported");
+	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
@@ -1570,9 +1547,26 @@ static int virtblk_probe(struct virtio_device *vdev)
 	 * placed after the virtio_device_ready() call above.
 	 */
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
-		err = virtblk_probe_zoned_device(vdev, vblk, q);
-		if (err)
+		u8 model;
+
+		virtio_cread(vdev, struct virtio_blk_config, zoned.model,
+				&model);
+		switch (model) {
+		case VIRTIO_BLK_Z_NONE:
+		case VIRTIO_BLK_Z_HA:
+			/* Present the host-aware device as non-zoned */
+			break;
+		case VIRTIO_BLK_Z_HM:
+			err = virtblk_probe_zoned_device(vdev, vblk, q);
+			if (err)
+				goto out_cleanup_disk;
+			break;
+		default:
+			dev_err(&vdev->dev, "unsupported zone model %d\n",
+				model);
+			err = -EINVAL;
 			goto out_cleanup_disk;
+		}
 	}
 
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
-- 
2.39.2


