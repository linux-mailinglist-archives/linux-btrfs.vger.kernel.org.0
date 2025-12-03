Return-Path: <linux-btrfs+bounces-19485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3D5C9F230
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 14:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07F86348101
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6DC2FB0A1;
	Wed,  3 Dec 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NVZV7ReG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CB2FB08F
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768710; cv=none; b=D6Kc8ZMQ7owhLXtPYw8rjVEZHtTlD/c48LNW9xCsVxvIWFMJ33I6UdORDVmt/neYMW3RL7n4zlLZykdEN2Hsvea2cQv8tk44RhnQn4jU2g2q3p+jwhuJBrmvwYCJXPGx6fC7r/lpxjN8AHTBb8Ms1fTyG2mlHwPWTQkESN+GJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768710; c=relaxed/simple;
	bh=0VEPmQjkX/eHz1lf1VCE3HNAryeRMb1lE9t3Lb/tarc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwOwCt1gYa5DGOWL8ufVwdR1ccYAmNyWe06RcoAeB+KQQyYbW2qytsyzQFhQfS5VWxFSdd0S81XbfVI2hA1W6O4/64Lp03GoJXbAhkZB9FO8SXMGS7L4lnkgJKqbbODq1KZJ/uGZg6j7dWNAflktMfYCrEjBpar68LbsfGKRnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NVZV7ReG; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764768707; x=1796304707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0VEPmQjkX/eHz1lf1VCE3HNAryeRMb1lE9t3Lb/tarc=;
  b=NVZV7ReGYFG+BYQF1uXqXraP7HIM1BK6QWPXe1d/fF94nvgHjzc7/iPU
   9ToAvvmYPHkaUluSGtVy05NRr4KOq1QjnzdbJUQNDG7gXjEIRQrpK5PwR
   oZbT2tMUpW4p2b1T6PIayntjyVpJoSNUjs9elcDZLAmsuFs76JGnQlDdw
   Az1neGqse2ObT29VJH/keuj+PaatXosCgYSzGt3dtTCLobVerg+4ZhMYs
   31+EncJNpLXEfTsLrsbs9lj5WWp3P0RJ7M2L2ZxvB37+MjF/E80s9H1IF
   QngDcEPGUxg056qVMfIQkLM20NLQqeXmA1G0jmhKS5doM5szOpC/cuYFN
   w==;
X-CSE-ConnectionGUID: 34gdVL3gQbS6kwt7YnqLZw==
X-CSE-MsgGUID: TYHluQ8EQXaZdQkFVnRgng==
X-IronPort-AV: E=Sophos;i="6.20,246,1758556800"; 
   d="scan'208";a="135832412"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2025 21:31:40 +0800
IronPort-SDR: 69303bbd_FOtkQ86C8P6gL9eZHiO82cZzCMAw8mS7rrzmBfcbunoCtmW
 Y2NBwZw8jfkOM8Mq3eQgsAPFo2LZBCG9mSyDLUA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Dec 2025 05:31:41 -0800
WDCIronportException: Internal
Received: from wdap-fejaxhfdkv.ad.shared (HELO neo.wdc.com) ([10.224.28.99])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2025 05:31:39 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] btrfs: zoned: don't zone append to conventional zone
Date: Wed,  3 Dec 2025 14:31:32 +0100
Message-ID: <20251203133132.274038-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of a zoned RAID, it can happen that a data write is targeting a
sequential write required zone and a conventional zone. In this case the
bio will be marked as REQ_OP_ZONE_APPEND but for the conventional zone,
this needs to be REQ_OP_WRITE.

The setting of REQ_OP_ZONE_APPEND is deferred to the last possible time in
btrfs_submit_dev_bio(), but the decision if we can use zone append is
cached in btrfs_bio.

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: e9b9b911e03c ("btrfs: add raid stripe tree to features enabled with debug config")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 20 ++++++++++----------
 fs/btrfs/bio.h |  3 +++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4a7bef895b97..0e52cc8e860e 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -480,6 +480,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 
 static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 {
+	u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
 	if (!dev || !dev->bdev ||
 	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
 	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
@@ -494,12 +496,14 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	 * For zone append writing, bi_sector must point the beginning of the
 	 * zone
 	 */
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	if (btrfs_bio(bio)->use_append &&
+	    btrfs_dev_is_sequential(dev, physical)) {
 		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
 
 		ASSERT(btrfs_dev_is_sequential(dev, physical));
 		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+		bio->bi_opf &= ~REQ_OP_WRITE;
+		bio->bi_opf |= REQ_OP_ZONE_APPEND;
 	}
 	btrfs_debug(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
@@ -747,7 +751,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
-	bool use_append = btrfs_use_zone_append(bbio);
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
 	blk_status_t status;
@@ -775,8 +778,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
 		bbio->orig_logical = logical;
 
+	bbio->use_append = btrfs_use_zone_append(bbio);
+
 	map_length = min(map_length, length);
-	if (use_append)
+	if (bbio->use_append)
 		map_length = btrfs_append_map_length(bbio, map_length);
 
 	if (map_length < length) {
@@ -805,11 +810,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		if (use_append) {
-			bio->bi_opf &= ~REQ_OP_WRITE;
-			bio->bi_opf |= REQ_OP_ZONE_APPEND;
-		}
-
 		if (is_data_bbio(bbio) && bioc && bioc->use_rst) {
 			/*
 			 * No locking for the list update, as we only add to
@@ -836,7 +836,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			status = errno_to_blk_status(ret);
 			if (status)
 				goto fail;
-		} else if (use_append ||
+		} else if (bbio->use_append ||
 			   (btrfs_is_zoned(fs_info) && inode &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
 			ret = btrfs_alloc_dummy_sum(bbio);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 56279b7f3b2a..a057b9e2b383 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -92,6 +92,9 @@ struct btrfs_bio {
 	/* Whether the csum generation for data write is async. */
 	bool async_csum;
 
+	/* Whether the bio is written using zone append. */
+	bool use_append;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
-- 
2.52.0


