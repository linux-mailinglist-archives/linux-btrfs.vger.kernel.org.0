Return-Path: <linux-btrfs+bounces-19523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C0BCA3A5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 13:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E60603091CE7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91146340DA1;
	Thu,  4 Dec 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C7045j1o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AD1337BBD
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852228; cv=none; b=b28joTgK7PWoGYvvkxHbFCFJHqsn9w0Zwwvy06+MqhAqIty1Tll04z6XcYHl0CKv5dWzzHRMUhC+iEzRf59Owpvgk0y7E1jShFM1zdMH7sGrPycOZG6/k3tnwUfndpt9Zk9a4WjXmRTmJJMfbLCFVTdeyYOPUFjpocnBnFn2thM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852228; c=relaxed/simple;
	bh=+3XV3qbBIiLV8SJCoGwyi20kEDR9TX9YqorazLWS0mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWvdltbSowDbwaVB7moLacJjbR6PM/hSHFdkqPSD3SYy92bDonEGBHKSjOg8AQtIvxxlTu0V7UNjUUp+amCFhxQ4pp+LUoFHmuAKiDgXsw+afJ0E2zd3aRvQZbqGK9ANy0kSLbG7PR9ISfnKf7y2uaOLffjDOA2JfMeZQW8lNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C7045j1o; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764852227; x=1796388227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+3XV3qbBIiLV8SJCoGwyi20kEDR9TX9YqorazLWS0mo=;
  b=C7045j1o0GWpcLAeb5ogINQKFD/HbQGF4ZSMHSwWIkqbjR8AnxNXPJT3
   U4pwsiYKWXIrg5939O1ytiwzN2vj0iOfY2Nw3rtRennsQuPaQlQ1/Eb4y
   xhqaBvN+EjZVLtCvSr35Or+C68wy9fPJp+9QXMMMXUzYkvWHZeAmILYkw
   4CKzkgH5QTbxKV34JTd1vpN4+kemLLwyEo4JOslPyqTx05BDsxyXg5JqR
   f4z+8M9PY9ACK2DmH73su8Cy8oXbD7hCvyx/1Qbv8jMNyHD8vNKHC9KVP
   Kh2gGaEE+i8+HWKl+Eb3AaexT/UGEw8U1f0kAuJ+ZT2VXloMIimF942Vz
   Q==;
X-CSE-ConnectionGUID: fl72b1m4RMSSpny1I4gOKg==
X-CSE-MsgGUID: rIqVUpFxRn+tNmSlseYmMw==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="137266136"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2025 20:42:44 +0800
IronPort-SDR: 693181c4_KyRQoO4RBmTsTVgGbLS4OOXhbibzMRbTphp82n+v5HJEkeI
 y1JSWdRdK8Rh7z2nduoDpkW3kUNdpYEnkIrGLjQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 04:42:44 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2025 04:42:42 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 4/5] btrfs: move btrfs_bio::async_csum into flags
Date: Thu,  4 Dec 2025 13:42:26 +0100
Message-ID: <20251204124227.431678-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove struct btrfs_bio's async_csum field and move it as a flag into the
newly introduced flags member of struct btrfs_bio.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/bio.h       | 5 ++---
 fs/btrfs/file-item.c | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 515b801a9c29..a1b0dd8b08f5 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -110,7 +110,7 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	/* Make sure we're already in task context. */
 	ASSERT(in_task());
 
-	if (bbio->async_csum)
+	if (bbio->flags & BTRFS_BIO_ASYNC_CSUM)
 		wait_for_completion(&bbio->csum_done);
 
 	bbio->bio.bi_status = status;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 8183e57725e1..d523929b4538 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -27,6 +27,8 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
  * scrub bios.
  */
 #define BTRFS_BIO_IS_SCRUB			(1 << 1)
+/* Whether the csum generation for data write is async. */
+#define BTRFS_BIO_ASYNC_CSUM			(1 << 2)
 
 /*
  * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
@@ -90,9 +92,6 @@ struct btrfs_bio {
 
 	unsigned int flags;
 
-	/* Whether the csum generation for data write is async. */
-	bool async_csum;
-
 	/* Whether the bio is written using zone append. */
 	bool can_use_append;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 823c063bb4b7..8fa457e1ccd2 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -799,7 +799,7 @@ static void csum_one_bio_work(struct work_struct *work)
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, csum_work);
 
 	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
-	ASSERT(bbio->async_csum == true);
+	ASSERT(bbio->flags & BTRFS_BIO_ASYNC_CSUM);
 	csum_one_bio(bbio, &bbio->csum_saved_iter);
 	complete(&bbio->csum_done);
 }
@@ -835,7 +835,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
 		return 0;
 	}
 	init_completion(&bbio->csum_done);
-	bbio->async_csum = true;
+	bbio->flags |= BTRFS_BIO_ASYNC_CSUM;
 	bbio->csum_saved_iter = bbio->bio.bi_iter;
 	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
 	schedule_work(&bbio->csum_work);
-- 
2.52.0


