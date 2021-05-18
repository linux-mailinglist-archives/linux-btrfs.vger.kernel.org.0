Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4926387CA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350280AbhERPmX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 11:42:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32432 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbhERPmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 11:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621352457; x=1652888457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQ2HviOEV+zSWnvccLMOeDEvNhPrdDSjyAsCKLw1EJI=;
  b=MT0/pgohMvJywAuAcvnzoy32JXnmPO+uWzK3u97+xGbMEvfuhvOF7ho/
   DcSnjG87E0hu92yWwqN484kOJmzTI1HX91l0sZhCt06dHe7LlbrPml5F3
   utbW7ExUu0r6qYylIJhiYHynQqLk//zNKXBBwUSi4tM+b6mn4tfJpQNxZ
   3Fb+aq7kPhYr+po9DvSC12FsRThbW3WsrykVAhN0F393KzbRLUNn9RxaE
   QpJZ7KulQPQeiRcv1+QGEdTS8VY2IyoK8+uAWvdWDtIPzYAALBsZUOpHz
   7UNbgUlC9RRkUSft4HmSaqsyU5azamk9UnNOW7KG8klZolAmERHclsOna
   A==;
IronPort-SDR: C8wld5qkR5EgtSEYBqQpMfAMoj9LRk5OEQLJDIZzMFmw4jqqLEZO609FVIbdFiPTu432kFk5wR
 od2uUAlE93uczEtMU7+2wcmlqadz4FDTkNtDsaSos60b4MqwFT40zyIkVZ/ZH1YoGDUE3G5JIP
 AMZ9Lo+IDJyA5ugGEA+DB8KRN5TQRlmuVC2ksrZ942U3pmZRF2XnpchBxwbCHtY1i8zuNwc8n4
 /EPI/8tySPzsZrUncdVxiEp1I2+EJA++MpkG/Rn4eBC5u/qfEwq63XGtfyw/ts6t1CMPoeAROj
 0No=
X-IronPort-AV: E=Sophos;i="5.82,310,1613404800"; 
   d="scan'208";a="279802256"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 23:40:57 +0800
IronPort-SDR: O22FpmWe7nK3w3WCmrK/YOEZ3JMCgJZRXeTI0FEFHCu0O29KdErATKKf4hhCxnH49JknYPjMOg
 Aqd+n3/Nl3ok3bn8tJ+fRouPGJ+LXX/VH3y4cqGKuB7VaFqoZjd67enQROlYOTdWGNCtFbk/XZ
 rNTy8TpshZqPY3hSDh8PuNxkvHcoL7N/Ce6BGMV6CVYt02mpFV16/NW2tPkYkAejLyVHDMx4TP
 kVJGBuxGgVY/JkqORd39zXys656hveRRYYgCm1tPK5MsecZrsZHyoIlrgIX1uZsTMZXT9gLOxv
 DKhk8llWTFm5vbgqdJWErgU1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:20:36 -0700
IronPort-SDR: z342fczJLNZYWcNVFuaRQNB63TW1HRe0UDHCBZSQAabrLeUqI/OYJ3SETgRX0HxDEIgBifJhLu
 XvBmjU9ju64cZCWidsajM21KujK8Numwq5Rjhbt1GgGlOBVQ4a858IKm5M3sUbgYDLKSL/18m4
 7/UV+qFo3KUJyXb1td9B+wtUN9VUcFvbnMxdrGuFMVfP35m4gQLj/7yWbVSShrnKkslQUkvsv4
 lNJfGv60HhRiWhNUwCN5LBfc2b4vD+iAcNUfIWWe0w9zQicWm0EHxhsqErA+u17oMg2xeGy7S0
 Koc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 08:40:56 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/3] btrfs: zoned: factor out zoned device lookup
Date:   Wed, 19 May 2021 00:40:29 +0900
Message-Id: <0177d54fd7d5d9e96ee0bcdc29facd1324149a0e.1621351444.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621351444.git.johannes.thumshirn@wdc.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To be able to construct a zone append bio we need to look up the
btrfs_device. The code doing the chunk map lookup to get the device is
present in btrfs_submit_compressed_write and submit_extent_page.

Factor out the lookup calls into a helper and use it in the submission
paths.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 16 ++++------------
 fs/btrfs/extent_io.c   | 16 +++++-----------
 fs/btrfs/zoned.c       | 21 +++++++++++++++++++++
 fs/btrfs/zoned.h       |  9 +++++++++
 4 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f224c35de5d8..b101bc483e40 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -428,24 +428,16 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	bio->bi_end_io = end_compressed_bio_write;
 
 	if (use_append) {
-		struct extent_map *em;
-		struct map_lookup *map;
-		struct block_device *bdev;
+		struct btrfs_device *device;
 
-		em = btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
-		if (IS_ERR(em)) {
+		device = btrfs_zoned_get_device(fs_info, disk_start, PAGE_SIZE);
+		if (IS_ERR(device)) {
 			kfree(cb);
 			bio_put(bio);
 			return BLK_STS_NOTSUPP;
 		}
 
-		map = em->map_lookup;
-		/* We only support single profile for now */
-		ASSERT(map->num_stripes == 1);
-		bdev = map->stripes[0].dev->bdev;
-
-		bio_set_dev(bio, bdev);
-		free_extent_map(em);
+		bio_set_dev(bio, device->bdev);
 	}
 
 	if (blkcg_css) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ce6364dd1517..2b250c610562 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3266,19 +3266,13 @@ static int submit_extent_page(unsigned int opf,
 		wbc_account_cgroup_owner(wbc, page, io_size);
 	}
 	if (btrfs_is_zoned(fs_info) && bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct extent_map *em;
-		struct map_lookup *map;
+		struct btrfs_device *device;
 
-		em = btrfs_get_chunk_map(fs_info, disk_bytenr, io_size);
-		if (IS_ERR(em))
-			return PTR_ERR(em);
+		device = btrfs_zoned_get_device(fs_info, disk_bytenr, io_size);
+		if (IS_ERR(device))
+			return PTR_ERR(device);
 
-		map = em->map_lookup;
-		/* We only support single profile for now */
-		ASSERT(map->num_stripes == 1);
-		btrfs_io_bio(bio)->device = map->stripes[0].dev;
-
-		free_extent_map(em);
+		btrfs_io_bio(bio)->device = device;
 	}
 
 	*bio_ret = bio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b9d5579a578d..15843a858bf6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1520,3 +1520,24 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 	length = wp - physical_pos;
 	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
 }
+
+struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
+					    u64 logical, u64 length)
+{
+	struct btrfs_device *device;
+	struct extent_map *em;
+	struct map_lookup *map;
+
+	em = btrfs_get_chunk_map(fs_info, logical, length);
+	if (IS_ERR(em))
+		return ERR_CAST(em);
+
+	map = em->map_lookup;
+	/* We only support single profile for now */
+	ASSERT(map->num_stripes == 1);
+	device = map->stripes[0].dev;
+
+	free_extent_map(em);
+
+	return device;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e55d32595c2c..b0ae2608cb6b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -65,6 +65,8 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
 int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 				  u64 physical_start, u64 physical_pos);
+struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
+					    u64 logical, u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -191,6 +193,13 @@ static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
 	return -EOPNOTSUPP;
 }
 
+static inline struct btrfs_device *btrfs_zoned_get_device(
+						  struct btrfs_fs_info *fs_info,
+						  u64 logical, u64 length)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

