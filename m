Return-Path: <linux-btrfs+bounces-18557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC7C2C203
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD359189803F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126E314B6F;
	Mon,  3 Nov 2025 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjZORO+0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EF2D7DE9;
	Mon,  3 Nov 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176927; cv=none; b=laO6S26j39G2tLU1PHnD7nKvvTBiXfJxSSwNjxgfYRuppjT0SI1u10+k8KPvL9EpCFMHl2HCB6Xrsl4r+oy3CMWD31R/ZgJJmznkC0JqkBa2UNeJ+QXaSJ4RpQ4HzS5N/hnsPoHq2wYjComvK56BsNsVnRnzZmKYm0RqDzoSHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176927; c=relaxed/simple;
	bh=QDMzAYXb9XLZTQC80wgGI4cmnleJTgOhuQQPc5QZGik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX7KESF//lU2Ap8rsQTPwpX076a51tdeFRVFJegXTJc7f/rOTUMzt8yjg7u9xWKWn4BveqlEKFPsbD5QefkvytImizn8kHwfxsuD6Js66cw52qFckKZJemK3OEc8QDy81l03hry4gXznr+xBHDDfFmOdI6rbhgdsNHKUqN85Z9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjZORO+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E19C116B1;
	Mon,  3 Nov 2025 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176926;
	bh=QDMzAYXb9XLZTQC80wgGI4cmnleJTgOhuQQPc5QZGik=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UjZORO+0QCLRsTjf3nGA2f+YYhrt9URjwW9HS5ZquFHFRSDEaBnD6dzGWNBuYtALU
	 f562fZHp+VrRcqJ/4s0gaqFSple4hmgT5Xb/QyuBJGgx3eaPGWYcgJv0lC+n9wJtL7
	 dYj4/JCbVFOamHT/vR7zwLCEYayyupn3V9khc8zyVooVzlCKiWWS/XJO6i/JM+ynWd
	 JoYO9l9C0h6Qqhm3MZd1VUwpbCELhrfHn3f0nwtzjZ+KGiwx+SrTupygi9gdyJ+Esi
	 DOczX++sUaq8j/+Pi/g0azHf5fdr9EMNiBEzQAsnFWSwZohLn8Db31zK42P3c/XcMJ
	 1talx4QKtpt5A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 07/15] block: track zone conditions
Date: Mon,  3 Nov 2025 22:31:15 +0900
Message-ID: <20251103133123.645038-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function blk_revalidate_zone_cond() already caches the condition of
all zones of a zoned block device in the zones_cond array of a gendisk.
However, the zone conditions are updated only when the device is scanned
or revalidated.

Implement tracking of the runtime changes to zone conditions using
the new cond field in struct blk_zone_wplug. The size of this structure
remains 112 Bytes as the new field replaces the 4 Bytes padding at the
end of the structure.

Beause zones that do not have a zone write plug can be in the empty,
implicit open, explicit open or full condition, the zones_cond array of
a disk is used to track the conditions, of zones that do not have a zone
write plug. The condition of such zone is updated in the disk zones_cond
array when a zone reset, reset all or finish operation is executed, and
also when a zone write plug is removed from the disk hash table when the
zone becomes full.

Since a device may automatically close an implicitly open zone when
writing to an empty or closed zone, if the total number of open zones
has reached the device limit, the BLK_ZONE_COND_IMP_OPEN and
BLK_ZONE_COND_CLOSED zone conditions cannot be precisely tracked. To
overcome this, the zone condition BLK_ZONE_COND_ACTIVE is introduced to
represent a zone that has the condition BLK_ZONE_COND_IMP_OPEN,
BLK_ZONE_COND_EXP_OPEN or BLK_ZONE_COND_CLOSED.  This follows the
definition of an active zone as defined in the NVMe Zoned Namespace
specifications. As such, for a zoned device that has a limit on the
maximum number of open zones, we will never have more zones in the
BLK_ZONE_COND_ACTIVE condition than the device limit. This is compatible
with the SCSI ZBC and ATA ZAC specifications for SMR HDDs as these
devices do not have a limit on the number of active zones.

The function disk_zone_wplug_set_wp_offset() is modified to use the new
helper disk_zone_wplug_update_cond() to update a zone write plug
condition whenever a zone write plug write offset is updated on
submission or merging of write BIOs to a zone.

The functions blk_zone_reset_bio_endio(), blk_zone_reset_all_bio_endio()
and blk_zone_finish_bio_endio() are modified to update the condition of
the zones targeted by reset, reset_all and finish operations, either
using though disk_zone_wplug_set_wp_offset() for zones that have a
zone write plug, or using the disk_zone_set_cond() helper to update the
zones_cond array of the disk for zones that do not have a zone write
plug.

When a zone write plug is removed from the disk hash table (when the
zone becomes empty or full), the condition of struct blk_zone_wplug is
used to update the disk zones_cond array. Conversely, when a zone write
plug is added to the disk hash table, the zones_cond array is used to
initialize the zone write plug condition.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c             | 110 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/blkzoned.h |   9 +++
 2 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f62862274f9a..e43ae56b19c3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -57,6 +57,7 @@ static const char *const zone_cond_name[] = {
  * @zone_no: The number of the zone the plug is managing.
  * @wp_offset: The zone write pointer location relative to the start of the zone
  *             as a number of 512B sectors.
+ * @cond: Condition of the zone
  */
 struct blk_zone_wplug {
 	struct hlist_node	node;
@@ -69,6 +70,7 @@ struct blk_zone_wplug {
 	unsigned int		flags;
 	unsigned int		zone_no;
 	unsigned int		wp_offset;
+	enum blk_zone_cond	cond;
 };
 
 static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
@@ -114,6 +116,57 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
+static void blk_zone_set_cond(u8 *zones_cond, unsigned int zno,
+			      enum blk_zone_cond cond)
+{
+	if (!zones_cond)
+		return;
+
+	switch (cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+		zones_cond[zno] = BLK_ZONE_COND_ACTIVE;
+		return;
+	case BLK_ZONE_COND_NOT_WP:
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_FULL:
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+	default:
+		zones_cond[zno] = cond;
+		return;
+	}
+}
+
+static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
+			       enum blk_zone_cond cond)
+{
+	u8 *zones_cond;
+
+	rcu_read_lock();
+	zones_cond = rcu_dereference(disk->zones_cond);
+	if (zones_cond) {
+		unsigned int zno = disk_zone_no(disk, sector);
+
+		/*
+		 * The condition of a conventional, readonly and offline zones
+		 * never changes, so do nothing if the target zone is in one of
+		 * these conditions.
+		 */
+		switch (zones_cond[zno]) {
+		case BLK_ZONE_COND_NOT_WP:
+		case BLK_ZONE_COND_READONLY:
+		case BLK_ZONE_COND_OFFLINE:
+			break;
+		default:
+			blk_zone_set_cond(zones_cond, zno, cond);
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+
 /**
  * bdev_zone_is_seq - check if a sector belongs to a sequential write zone
  * @bdev:       block device to check
@@ -416,6 +469,7 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 {
 	struct blk_zone_wplug *zwplg;
 	unsigned long flags;
+	u8 *zones_cond;
 	unsigned int idx =
 		hash_32(zwplug->zone_no, disk->zone_wplugs_hash_bits);
 
@@ -431,6 +485,12 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 			return false;
 		}
 	}
+	zones_cond = rcu_dereference_check(disk->zones_cond,
+				lockdep_is_held(&disk->zone_wplugs_lock));
+	if (zones_cond)
+		zwplug->cond = zones_cond[zwplug->zone_no];
+	else
+		zwplug->cond = BLK_ZONE_COND_NOT_WP;
 	hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
 	atomic_inc(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
@@ -530,10 +590,15 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 
 	/*
 	 * Mark the zone write plug as unhashed and drop the extra reference we
-	 * took when the plug was inserted in the hash table.
+	 * took when the plug was inserted in the hash table. Also update the
+	 * disk zone condition array with the current condition of the zone
+	 * write plug.
 	 */
 	zwplug->flags |= BLK_ZONE_WPLUG_UNHASHED;
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	blk_zone_set_cond(rcu_dereference_check(disk->zones_cond,
+				lockdep_is_held(&disk->zone_wplugs_lock)),
+			  zwplug->zone_no, zwplug->cond);
 	hlist_del_init_rcu(&zwplug->node);
 	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
@@ -635,6 +700,22 @@ static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 }
 
+/*
+ * Update a zone write plug condition based on the write pointer offset.
+ */
+static void disk_zone_wplug_update_cond(struct gendisk *disk,
+					struct blk_zone_wplug *zwplug)
+{
+	lockdep_assert_held(&zwplug->lock);
+
+	if (disk_zone_wplug_is_full(disk, zwplug))
+		zwplug->cond = BLK_ZONE_COND_FULL;
+	else if (!zwplug->wp_offset)
+		zwplug->cond = BLK_ZONE_COND_EMPTY;
+	else
+		zwplug->cond = BLK_ZONE_COND_ACTIVE;
+}
+
 /*
  * Set a zone write plug write pointer offset to the specified value.
  * This aborts all plugged BIOs, which is fine as this function is called for
@@ -650,6 +731,8 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 	/* Update the zone write pointer and abort all plugged BIOs. */
 	zwplug->flags &= ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 	zwplug->wp_offset = wp_offset;
+	disk_zone_wplug_update_cond(disk, zwplug);
+
 	disk_zone_wplug_abort(zwplug);
 
 	/*
@@ -733,6 +816,7 @@ EXPORT_SYMBOL_GPL(disk_report_zone);
 static void blk_zone_reset_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	sector_t sector = bio->bi_iter.bi_sector;
 	struct blk_zone_wplug *zwplug;
 
 	/*
@@ -741,7 +825,7 @@ static void blk_zone_reset_bio_endio(struct bio *bio)
 	 * resetting zones while writes are still in-flight will result in the
 	 * writes failing anyway.
 	 */
-	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
+	zwplug = disk_get_zone_wplug(disk, sector);
 	if (zwplug) {
 		unsigned long flags;
 
@@ -749,6 +833,8 @@ static void blk_zone_reset_bio_endio(struct bio *bio)
 		disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
+	} else {
+		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
 	}
 }
 
@@ -757,6 +843,7 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
+	sector_t sector;
 	unsigned int i;
 
 	/* Update the condition of all zone write plugs. */
@@ -770,12 +857,18 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 		}
 	}
 	rcu_read_unlock();
+
+	/* Update the cached zone conditions. */
+	for (sector = 0; sector < get_capacity(disk);
+	     sector += bdev_zone_sectors(bio->bi_bdev))
+		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
 }
 
 static void blk_zone_finish_bio_endio(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 	struct gendisk *disk = bdev->bd_disk;
+	sector_t sector = bio->bi_iter.bi_sector;
 	struct blk_zone_wplug *zwplug;
 
 	/*
@@ -784,7 +877,7 @@ static void blk_zone_finish_bio_endio(struct bio *bio)
 	 * is fine as resetting zones while writes are still in-flight will
 	 * result in the writes failing anyway.
 	 */
-	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
+	zwplug = disk_get_zone_wplug(disk, sector);
 	if (zwplug) {
 		unsigned long flags;
 
@@ -793,6 +886,8 @@ static void blk_zone_finish_bio_endio(struct bio *bio)
 					      bdev_zone_sectors(bdev));
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
+	} else {
+		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_FULL);
 	}
 }
 
@@ -888,6 +983,7 @@ static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
  */
 void blk_zone_write_plug_bio_merged(struct bio *bio)
 {
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
 
@@ -909,13 +1005,13 @@ void blk_zone_write_plug_bio_merged(struct bio *bio)
 	 * have at least one request and one BIO referencing the zone write
 	 * plug. So this should not fail.
 	 */
-	zwplug = disk_get_zone_wplug(bio->bi_bdev->bd_disk,
-				     bio->bi_iter.bi_sector);
+	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
 	if (WARN_ON_ONCE(!zwplug))
 		return;
 
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwplug->wp_offset += bio_sectors(bio);
+	disk_zone_wplug_update_cond(disk, zwplug);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 }
 
@@ -974,6 +1070,7 @@ void blk_zone_write_plug_init_request(struct request *req)
 		/* Drop the reference taken by disk_zone_wplug_add_bio(). */
 		blk_queue_exit(q);
 		zwplug->wp_offset += bio_sectors(bio);
+		disk_zone_wplug_update_cond(disk, zwplug);
 
 		req_back_sector += bio_sectors(bio);
 	}
@@ -1037,6 +1134,7 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zone_wplug *zwplug,
 
 	/* Advance the zone write pointer offset. */
 	zwplug->wp_offset += bio_sectors(bio);
+	disk_zone_wplug_update_cond(disk, zwplug);
 
 	return true;
 }
@@ -1683,7 +1781,7 @@ static int blk_revalidate_zone_cond(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
-	args->zones_cond[idx] = cond;
+	blk_zone_set_cond(args->zones_cond, idx, cond);
 
 	return 0;
 
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index f85743ef6e7d..1b9599411f71 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -61,6 +61,13 @@ enum blk_zone_type {
  *
  * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
  * be considered invalid.
+ *
+ * For a cached zone report, the condition BLK_ZONE_COND_ACTIVE is used to
+ * report any of the BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN and
+ * BLK_ZONE_COND_CLOSED conditions. Conversely, a regular zone report will neve
+ * report a zone condition using BLK_ZONE_COND_ACTIVE and instead use the
+ * conditions BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN or
+ * BLK_ZONE_COND_CLOSED as reported by the device.
  */
 enum blk_zone_cond {
 	BLK_ZONE_COND_NOT_WP	= 0x0,
@@ -71,6 +78,8 @@ enum blk_zone_cond {
 	BLK_ZONE_COND_READONLY	= 0xD,
 	BLK_ZONE_COND_FULL	= 0xE,
 	BLK_ZONE_COND_OFFLINE	= 0xF,
+
+	BLK_ZONE_COND_ACTIVE	= 0xFF,
 };
 
 /**
-- 
2.51.0


