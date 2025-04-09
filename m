Return-Path: <linux-btrfs+bounces-12918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB0A8232C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC644A58FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4499225DAFB;
	Wed,  9 Apr 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GJulhvpP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0A25DCE6
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197072; cv=none; b=pEwQR2wCMuas7nrU7PoUFXEiX4jYvbGUywhXzDUYTvnG9UoDKFVuEkocgbKbqeHCLnuDc6ui2I24Ze+HLil++ERhelneCVx+H2DTequgDUugAjfCjouLISDWF/WJGwkj7EQUv4N1l9EELSZ2wJm+gKHuDRHsD6seiKmuGbMi7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197072; c=relaxed/simple;
	bh=HGIE99C9UhYKfnZLn3wfjN5DimvPH0DYtgSPtkUdOfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmQjBoq7R3EEAbfrcNK9xacJfWkg+AGnT6IZpD5CLqBJfyU8+hq7ZoPOghlHQQcexDRyc2sVgbpnaks38alL9WS84E6sf9X5tZXxx1DNIRZsHs4ub3vDEoln7NQmaiip/q5YPxZ+eUNeMJ4o1FigROIEmJFYcdZdjjklvwWU0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GJulhvpP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/YuFN3Gs0BtYvNf8TbZY/we+k3sDSs/LnAuRpjIle94=; b=GJulhvpPo41KxrWAtPM2lGQ6qH
	KOLb6zvz7aPmFQHGSNlG+lxNkyl53waOyhb5SskHp+61BUd/NK7JJFyGtWrFy/MpzUH8RkTiJEevs
	w9gHUjVU/NK/Vuy18tKq1Bn1STEfC8Abaew3PqXcHREoFX4HJu4Z36qX8cpzYuv1iB8E1G7clba/C
	rWkXOXN4+9xgI8zayAvQVuEy9G4a/p2BiYYnVSM1JsjuqFXbpDu/o4u0rDGN+jnrrKVmCHI2LgnCT
	sfuJDuFYv84zYbhi1z3NhQmgCy2XWGUPTssphJcCF1PlYWZnbgPmrjpMadE38hpvATRUvQLvEi6pn
	kp/lAIeQ==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKo-00000006x3J-2Wxx;
	Wed, 09 Apr 2025 11:11:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: simplify bvec iteration in index_one_bio
Date: Wed,  9 Apr 2025 13:10:39 +0200
Message-ID: <20250409111055.3640328-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409111055.3640328-1-hch@lst.de>
References: <20250409111055.3640328-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Flatten the two loops by open coding bio_for_each_segment and advancing
the iterator one sector at a time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 28dbded86cc2..703e713bac03 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1195,23 +1195,20 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct bvec_iter iter = bio->bi_iter;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
 		     rbio->bioc->full_stripe_logical;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		u32 bvec_offset;
+	while (iter.bi_size) {
+		int index = offset / sectorsize;
+		struct sector_ptr *sector = &rbio->bio_sectors[index];
+		struct bio_vec bv = bio_iter_iovec(bio, iter);
 
-		for (bvec_offset = 0; bvec_offset < bvec.bv_len;
-		     bvec_offset += sectorsize, offset += sectorsize) {
-			int index = offset / sectorsize;
-			struct sector_ptr *sector = &rbio->bio_sectors[index];
+		sector->page = bv.bv_page;
+		sector->pgoff = bv.bv_offset;
+		ASSERT(sector->pgoff < PAGE_SIZE);
 
-			sector->page = bvec.bv_page;
-			sector->pgoff = bvec.bv_offset + bvec_offset;
-			ASSERT(sector->pgoff < PAGE_SIZE);
-		}
+		bio_advance_iter_single(bio, &iter, sectorsize);
 	}
 }
 
-- 
2.47.2


