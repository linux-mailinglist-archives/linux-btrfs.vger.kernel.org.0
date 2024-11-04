Return-Path: <linux-btrfs+bounces-9316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06759BAC8B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637A5282147
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729D1917C4;
	Mon,  4 Nov 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JUw3j8vh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322C18E055;
	Mon,  4 Nov 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701626; cv=none; b=Iyvu3uyvxrQhS52IAHlIcSh+hcj3gBnI+tCGpBqkYX6H1UKc98jg/SUpqvoZq1JFHZtCHusGoZ4fhas8vRGfVnp0h4bt85jiQfogxaijL9lHoQbEE7N2nnd8jKjfDO+ysM7tCTjhfxa6Zixew4Jb1HpI/8QUAUWR1BwOKO3lRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701626; c=relaxed/simple;
	bh=x4pZsqaJSIM08917wBINhJVChtdoCgyHeEtOK+95nO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDYBUFppDJYS491NafFe7Ndbx4T3ZVfvzxABlHyJlT/VcJQy75GNR6Ld9/zgS8D/hB3URD6DUtseH9zKJzgbF/zAbIlJE8uU0Dcvu/VeFjWcoYV1vPVyyo6J1jyWYiOe13aCfnuBCgsYgdZJyW+q+llnjBqN8shZ/dFrLst1vhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JUw3j8vh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1FR35fBVW6o2eMLvhGFCd1yW8PBeRzvCzSaFkrJ5xdg=; b=JUw3j8vh+gCK69iISx/CnaXE6H
	6KaC+OexU3v4NTnd4CMBWUMCkdMM1+X4WL9/ZYbvUXTb82n/57+kKk3Ru9pT1dmg8FkzpccsewvkS
	kv1vOgOSinB9kFfwcmfOJw9plMCcQWNC3gLiqTJ9/XqBZj3bh6yFjpHWW/6/wyDa+K4OJd3cIeAfb
	SSOU45ywlPdc6kbWHcgWRE9NbBgRX2njyKMLxTamIKThhcj0eWNT4GBYcCTD6pXwbsFTwtPgVTjB0
	iG6OB0ICKqGb3B4xSqumHjRw40jXF2vrTCfRuw2xEROWZumbJuYckKkAYaaIZgX1q2ANIte+L1y98
	xeh6QxyA==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qYK-0000000Cl3x-0jm6;
	Mon, 04 Nov 2024 06:27:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 5/5] btrfs: split bios to the fs sector size boundary
Date: Mon,  4 Nov 2024 07:26:33 +0100
Message-ID: <20241104062647.91160-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104062647.91160-1-hch@lst.de>
References: <20241104062647.91160-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


