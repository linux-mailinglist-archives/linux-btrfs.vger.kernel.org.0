Return-Path: <linux-btrfs+bounces-19520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DCCA3A51
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 13:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CE93073FE1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7DA33C1A8;
	Thu,  4 Dec 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MqaoUa9z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478652FDC29
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852226; cv=none; b=SSA2Snoh2KYF8GF7tob34k0d7iczQ6nFk+otR9nWOx7jm6T+sutRjtAs9WdLZ5K8HmJ81ruUp8N3m0VYbznVFALxurg4WbHbf2vXjkp2BL9o4L3RL5eQBEhIqChCu3vIRLxD/ZI6sMrn080tTo1v+/5WMn8rsO2l7cdx6gCtufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852226; c=relaxed/simple;
	bh=XfztaHbyhYLcxIsqXtgMrjcLT0rEaXDnR2ipViRZ8E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2TkNlvIklxQgSllR0i9CbSKJdYpGp/HmvQ4SPb75L9GjOUjiEA8Qj6979sHAuYvFKmVx+rqUiwqOJBhA534lgByJNreInhkTh1cUiJasNtSDSC4cqOHPYzRsFbDwNPPpF5JBJCYpS6KT4bRpex3HHkubgE0fMoVOwhNqxWScPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MqaoUa9z; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764852225; x=1796388225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XfztaHbyhYLcxIsqXtgMrjcLT0rEaXDnR2ipViRZ8E8=;
  b=MqaoUa9zo9Zn12aHDhNSBDShIWKKDJKssjmuFjivZ0JUL7nw9MzR729B
   bFRq1mFRkbmPCxi5wntvpFl2vkNKVSIkzddrqTRmi1wlcwPjM4UuKlrlH
   +D6OX/ZWrBDy8dLQy3095A0HpeFtGBLxkgtVQD1G+DX6Kr6xnHcwHZbLz
   FPENLU0DBuOnYVSJs2tQ88WNjf7lnvlIybQFtYjFcfvUKwXGNwPTDurYd
   OUCDgPGYqCYlYrE60kmYx6D4hql8fQZm3tDy6wmRrP4RC4J+PLXfuTWO2
   mFvJt8qSpMwtSc3YBI2Rq1jXHaYpmHHeIuOcY7ipB4Lheq3aJEKg/C6Xm
   A==;
X-CSE-ConnectionGUID: 1+xLXa/fSzS8kdjiP1MGWw==
X-CSE-MsgGUID: 6DLhLbANSnmF0OB8+koI2A==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="137266127"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2025 20:42:37 +0800
IronPort-SDR: 693181bd_PAmHyB5mubXllQgKkpVoA1sm3VUVrmW0p1NviuQqfk4yJMp
 EfnHdmT1YE08Ef0B/FS0wrQL9ikS6X70hNoXzOQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 04:42:37 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2025 04:42:35 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional zone
Date: Thu,  4 Dec 2025 13:42:23 +0100
Message-ID: <20251204124227.431678-2-johannes.thumshirn@wdc.com>
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
index 4a7bef895b97..33149f07e62d 100644
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
+	if (btrfs_bio(bio)->can_use_append &&
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
 
+	bbio->can_use_append = btrfs_use_zone_append(bbio);
+
 	map_length = min(map_length, length);
-	if (use_append)
+	if (bbio->can_use_append)
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
+		} else if (bbio->can_use_append ||
 			   (btrfs_is_zoned(fs_info) && inode &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
 			ret = btrfs_alloc_dummy_sum(bbio);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 56279b7f3b2a..d6da9ed08bfa 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -92,6 +92,9 @@ struct btrfs_bio {
 	/* Whether the csum generation for data write is async. */
 	bool async_csum;
 
+	/* Whether the bio is written using zone append. */
+	bool can_use_append;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
-- 
2.52.0


