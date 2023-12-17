Return-Path: <linux-btrfs+bounces-1001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD7816092
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD661C2201B
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72649F7B;
	Sun, 17 Dec 2023 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DXYqZVLT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961648CE8;
	Sun, 17 Dec 2023 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ctU7eNWyO5uU8k+K1R2TcQkMR0gAuYk2v8Yjsja/Y1c=; b=DXYqZVLTY3AXEoBxl64SMyaX8s
	iocWPDWI6wSF+Py9Nzd53oAjEW8s1qbVJSoFuHgjMO7ReyYzIlvWagT4aJ/QmwFjj50jACktmkLZZ
	71o5L28Kq7RX+chawOPRKpL2T53erXPKzIXI2nvXIoChjJLg+xemJqSISQODlbdXJhjhX3utH0SCb
	szSXCMLib0iNpU+rrWEUHdVpkSQBb6SomuF0Kui47LLE3g4uh80BP5X4zJwwPeRq3X5kFrKbtgrF7
	l9Bbdlk6oGly95fNPZZVTL8laT37R0kjKKAPdOWDe6Ywyiy/a+PBeQwlF7aweLD4aibb3mJ7/+CUa
	zv8VYmog==;
Received: from [88.128.92.84] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuPB-0088Od-1n;
	Sun, 17 Dec 2023 16:54:17 +0000
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
Subject: [PATCH 5/5] sd: only call disk_clear_zoned when needed
Date: Sun, 17 Dec 2023 17:53:59 +0100
Message-Id: <20231217165359.604246-6-hch@lst.de>
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

disk_clear_zoned only needs to be called when a device reported zone
managed mode first and we clear it.  Add a check so that disk_clear_zoned
isn't called on devices that were never zoned.

This avoids a fairly expensive queue freezing when revalidating
conventional devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index dbed075cdb981a..8c8ac5cd1833b4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3149,7 +3149,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 		 * the device physical block size.
 		 */
 		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
-	} else {
+	} else if (blk_queue_is_zoned(q)) {
 		/*
 		 * Anything else.  This includes host-aware device that we treat
 		 * as conventional.
-- 
2.39.2


