Return-Path: <linux-btrfs+bounces-9284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45009B8A67
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9601F22B26
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865A14B96E;
	Fri,  1 Nov 2024 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2vrkgonL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A61148833;
	Fri,  1 Nov 2024 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730438544; cv=none; b=VHlPxDeDTrTweYB9zuORSLnxwuplXT4nNpb4hYWhA7u5DuwxooII/BlN/dIwfDUdfH856clwsf9+mgawM8kf33t7UjK639M69f0GqibCHqJjicAbgxqb5VoAx/EpxCW4UQjFX8SRUnXrA0pEYBeBhNRPs6rLyGMAC72i+B2qV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730438544; c=relaxed/simple;
	bh=vU82TCo/QxS1LB29en1h62ORa9cEBpHnZIQoL6RsBH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSBkzr4zXv8hBx9+a70y6OF9Ce46oPyw1Uj5Pi23T/zUURRb0IvTWa98QDHvKqxER1/4VwKkx2yyhq33Zvg7IpuBHBPbCNgZiNHNq3bMths5BcFaDMRkgVbWs02ZnB9s0Mj2OMOPqyF9Es6Qdi75M2o1DOXU3pgVHlD51NREkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2vrkgonL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n6iYwR+va9aUImMwmsfXGV0Qu2Qx4DaWLQ9hhemGQHM=; b=2vrkgonL/mCaSodPqL6wZFCgxo
	MeHw3q4noJJnJQPgYCIFcWDyiGN+wnpeBX57GPJwMSPdfSd2UIr6VGe2PAdtFFZ1V42YPRi3L6LYG
	C8fJ7kz/LS6GEvWuXmCKtCx4V6dfStMp6Kg3Y8wM+nt9G5VLqVrkkHlqkQBHRyAoqBQEZav3fkTr8
	O+KYME1tQ3iM4MW5Z/JtHK+PrPPL8atJ857rD0IBd4kYUVBazJHXr60H6vWJwsRvQ7+5+nBFlV08q
	/g5T/yYIn8J3tfHrIdBJbfWSKGAAQeONbhSwKYxt5b9vYsRtvzHy+6diFRK0ysdt57Y15++a3jTO/
	NzupJAbg==;
Received: from 2a02-8389-2341-5b80-5ae8-ad80-e9c6-3f1e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ae8:ad80:e9c6:3f1e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6k72-00000005pHe-3cKT;
	Fri, 01 Nov 2024 05:22:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: split bios to the fs sector size boundary
Date: Fri,  1 Nov 2024 06:21:47 +0100
Message-ID: <20241101052206.437530-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101052206.437530-1-hch@lst.de>
References: <20241101052206.437530-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Btrfs like other file systems can't really deal with I/O not aligned to
it's internal block size (which strangely is called sector size in
btrfs), but the block layer split helper doesn't even know about that.

Round down the split boundary so that all I/Os are aligned.

Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 0f096e226908..299b9a0ed68b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -660,8 +660,15 @@ static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
 	map_length = min(map_length, bbio->fs_info->max_zone_append_size);
 	sector_offset = bio_split_rw_at(&bbio->bio, &bbio->fs_info->limits,
 					&nr_segs, map_length);
-	if (sector_offset)
-		return sector_offset << SECTOR_SHIFT;
+	if (sector_offset) {
+		/*
+		 * bio_split_rw_at could split at a size smaller than the
+		 * file system sector size and thus cause unaligned I/Os.
+		 * Fix that by always rounding down to the nearest boundary.
+		 */
+		return ALIGN_DOWN(sector_offset << SECTOR_SHIFT,
+				  bbio->fs_info->sectorsize);
+	}
 	return map_length;
 }
 
-- 
2.45.2


