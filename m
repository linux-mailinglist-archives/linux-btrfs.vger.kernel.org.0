Return-Path: <linux-btrfs+bounces-18690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F85C33079
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C80A3AB6A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815E2FDC53;
	Tue,  4 Nov 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuNpFxfP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764941A9F90;
	Tue,  4 Nov 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291599; cv=none; b=RtQU+PWEY+gUrfftuaw3gRsTjp/6BfltfutYP8dbANy05up3joakWyjO06jUelSUaip4QeRpwj9IPLBJffL4f63cPsyMSeXvfl88vkkzfQNQeWYGgY//DD/SIlorSE9XR8oaPfuvCTxtHHigzwZWQh9/7vmmBCJfRHF5AWU66rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291599; c=relaxed/simple;
	bh=Idlqzgy9JjX4UI4gmExbOWnpfo31iXSUEFOP+9p6UgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk0WChjKA5sbWPTd89q3Z4WOk3eVilRsAkQfOwfu9Bmx7DYeGEngHVxV4izS5A1yRPcQ2EvUWBeS8gM+PRMI/gK89vtJOOt4YFBe3sTG/I8TazzU8oeXvMWMi2VqhLgpcwpuW5ef5iSItXz3QwfUbIf/GL017OHmLSOXZe6eMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuNpFxfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA61C4CEF8;
	Tue,  4 Nov 2025 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291599;
	bh=Idlqzgy9JjX4UI4gmExbOWnpfo31iXSUEFOP+9p6UgY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MuNpFxfPnYPV5zeIE65+WM2f26f1u/nK7oT3F8nCoYDYImv6I3ZyUF4+b6UDAcDr7
	 3myvhFdwvluFrRNY4W6j9KYdSI0IB77+lcKXn81hAivDZ5ez5QpSU69AErNHy9BsCT
	 AeDZW3FiW+Yd0dFodH792GPB2ZJ1bZFZNbBPliBF3a2sc7nsp10VKZSX0zmIrJylxb
	 XI7ZAymwt8HgiMVUSPIc5wCAzlXhjYX/5rE5Cs82FpQ4VjEzkaPM9L49olVlDYJIXt
	 TuV+shxMbV7IHzWs352/AA+4XTXT7Ownjtxrf9bkDuK+VtQN69JvTNV3n72dHiYFzL
	 xyzXfdfgupjqA==
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
Subject: [PATCH v4 01/15] block: handle zone management operations completions
Date: Wed,  5 Nov 2025 06:22:35 +0900
Message-ID: <20251104212249.1075412-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions blk_zone_wplug_handle_reset_or_finish() and
blk_zone_wplug_handle_reset_all() both modify the zone write pointer
offset of zone write plugs that are the target of a reset, reset all or
finish zone management operation. However, these functions do this
modification before the BIO is executed. So if the zone operation fails,
the modified zone write pointer offsets become invalid.

Avoid this by modifying the zone write pointer offset of a zone write
plug that is the target of a zone management operation when the
operation completes. To do so, modify blk_zone_bio_endio() to call the
new function blk_zone_mgmt_bio_endio() which in turn calls the functions
blk_zone_reset_all_bio_endio(), blk_zone_reset_bio_endio() or
blk_zone_finish_bio_endio() depending on the operation of the completed
BIO, to modify a zone write plug write pointer offset accordingly.
These functions are called only if the BIO execution was successful.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-zoned.c | 139 ++++++++++++++++++++++++++++++----------------
 block/blk.h       |  14 +++++
 2 files changed, 104 insertions(+), 49 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5e2a5788dc3b..1621e8f78338 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -71,6 +71,11 @@ struct blk_zone_wplug {
 	struct gendisk		*disk;
 };
 
+static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
+{
+	return 1U << disk->zone_wplugs_hash_bits;
+}
+
 /*
  * Zone write plug flags bits:
  *  - BLK_ZONE_WPLUG_PLUGGED: Indicates that the zone write plug is plugged,
@@ -698,71 +703,91 @@ static int disk_zone_sync_wp_offset(struct gendisk *disk, sector_t sector)
 					disk_report_zones_cb, &args);
 }
 
-static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
-						  unsigned int wp_offset)
+static void blk_zone_reset_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	sector_t sector = bio->bi_iter.bi_sector;
 	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
-
-	/* Conventional zones cannot be reset nor finished. */
-	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
-		bio_io_error(bio);
-		return true;
-	}
-
-	/*
-	 * No-wait reset or finish BIOs do not make much sense as the callers
-	 * issue these as blocking operations in most cases. To avoid issues
-	 * the BIO execution potentially failing with BLK_STS_AGAIN, warn about
-	 * REQ_NOWAIT being set and ignore that flag.
-	 */
-	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT))
-		bio->bi_opf &= ~REQ_NOWAIT;
 
 	/*
-	 * If we have a zone write plug, set its write pointer offset to 0
-	 * (reset case) or to the zone size (finish case). This will abort all
-	 * BIOs plugged for the target zone. It is fine as resetting or
-	 * finishing zones while writes are still in-flight will result in the
+	 * If we have a zone write plug, set its write pointer offset to 0.
+	 * This will abort all BIOs plugged for the target zone. It is fine as
+	 * resetting zones while writes are still in-flight will result in the
 	 * writes failing anyway.
 	 */
-	zwplug = disk_get_zone_wplug(disk, sector);
+	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
 	if (zwplug) {
+		unsigned long flags;
+
 		spin_lock_irqsave(&zwplug->lock, flags);
-		disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
+		disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
 	}
-
-	return false;
 }
 
-static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
+static void blk_zone_reset_all_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
-	sector_t sector;
+	unsigned int i;
 
-	/*
-	 * Set the write pointer offset of all zone write plugs to 0. This will
-	 * abort all plugged BIOs. It is fine as resetting zones while writes
-	 * are still in-flight will result in the writes failing anyway.
-	 */
-	for (sector = 0; sector < get_capacity(disk);
-	     sector += disk->queue->limits.chunk_sectors) {
-		zwplug = disk_get_zone_wplug(disk, sector);
-		if (zwplug) {
+	/* Update the condition of all zone write plugs. */
+	rcu_read_lock();
+	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
+		hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[i],
+					 node) {
 			spin_lock_irqsave(&zwplug->lock, flags);
 			disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
 			spin_unlock_irqrestore(&zwplug->lock, flags);
-			disk_put_zone_wplug(zwplug);
 		}
 	}
+	rcu_read_unlock();
+}
 
-	return false;
+static void blk_zone_finish_bio_endio(struct bio *bio)
+{
+	struct block_device *bdev = bio->bi_bdev;
+	struct gendisk *disk = bdev->bd_disk;
+	struct blk_zone_wplug *zwplug;
+
+	/*
+	 * If we have a zone write plug, set its write pointer offset to the
+	 * zone size. This will abort all BIOs plugged for the target zone. It
+	 * is fine as resetting zones while writes are still in-flight will
+	 * result in the writes failing anyway.
+	 */
+	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
+	if (zwplug) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&zwplug->lock, flags);
+		disk_zone_wplug_set_wp_offset(disk, zwplug,
+					      bdev_zone_sectors(bdev));
+		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_put_zone_wplug(zwplug);
+	}
+}
+
+void blk_zone_mgmt_bio_endio(struct bio *bio)
+{
+	/* If the BIO failed, we have nothing to do. */
+	if (bio->bi_status != BLK_STS_OK)
+		return;
+
+	switch (bio_op(bio)) {
+	case REQ_OP_ZONE_RESET:
+		blk_zone_reset_bio_endio(bio);
+		return;
+	case REQ_OP_ZONE_RESET_ALL:
+		blk_zone_reset_all_bio_endio(bio);
+		return;
+	case REQ_OP_ZONE_FINISH:
+		blk_zone_finish_bio_endio(bio);
+		return;
+	default:
+		return;
+	}
 }
 
 static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
@@ -1106,6 +1131,30 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
 	disk_put_zone_wplug(zwplug);
 }
 
+static bool blk_zone_wplug_handle_zone_mgmt(struct bio *bio)
+{
+	if (bio_op(bio) != REQ_OP_ZONE_RESET_ALL &&
+	    !bdev_zone_is_seq(bio->bi_bdev, bio->bi_iter.bi_sector)) {
+		/*
+		 * Zone reset and zone finish operations do not apply to
+		 * conventional zones.
+		 */
+		bio_io_error(bio);
+		return true;
+	}
+
+	/*
+	 * No-wait zone management BIOs do not make much sense as the callers
+	 * issue these as blocking operations in most cases. To avoid issues
+	 * with the BIO execution potentially failing with BLK_STS_AGAIN, warn
+	 * about REQ_NOWAIT being set and ignore that flag.
+	 */
+	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT))
+		bio->bi_opf &= ~REQ_NOWAIT;
+
+	return false;
+}
+
 /**
  * blk_zone_plug_bio - Handle a zone write BIO with zone write plugging
  * @bio: The BIO being submitted
@@ -1153,12 +1202,9 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 	case REQ_OP_WRITE_ZEROES:
 		return blk_zone_wplug_handle_write(bio, nr_segs);
 	case REQ_OP_ZONE_RESET:
-		return blk_zone_wplug_handle_reset_or_finish(bio, 0);
 	case REQ_OP_ZONE_FINISH:
-		return blk_zone_wplug_handle_reset_or_finish(bio,
-						bdev_zone_sectors(bdev));
 	case REQ_OP_ZONE_RESET_ALL:
-		return blk_zone_wplug_handle_reset_all(bio);
+		return blk_zone_wplug_handle_zone_mgmt(bio);
 	default:
 		return false;
 	}
@@ -1332,11 +1378,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	disk_put_zone_wplug(zwplug);
 }
 
-static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
-{
-	return 1U << disk->zone_wplugs_hash_bits;
-}
-
 void disk_init_zone_resources(struct gendisk *disk)
 {
 	spin_lock_init(&disk->zone_wplugs_lock);
diff --git a/block/blk.h b/block/blk.h
index 32a10024efba..4d809588b771 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -489,9 +489,23 @@ static inline bool blk_req_bio_is_zone_append(struct request *rq,
 void blk_zone_write_plug_bio_merged(struct bio *bio);
 void blk_zone_write_plug_init_request(struct request *rq);
 void blk_zone_append_update_request_bio(struct request *rq, struct bio *bio);
+void blk_zone_mgmt_bio_endio(struct bio *bio);
 void blk_zone_write_plug_bio_endio(struct bio *bio);
 static inline void blk_zone_bio_endio(struct bio *bio)
 {
+	/*
+	 * Zone management BIOs may impact zone write plugs (e.g. a zone reset
+	 * changes a zone write plug zone write pointer offset), but these
+	 * operation do not go through zone write plugging as they may operate
+	 * on zones that do not have a zone write
+	 * plug. blk_zone_mgmt_bio_endio() handles the potential changes to zone
+	 * write plugs that are present.
+	 */
+	if (op_is_zone_mgmt(bio_op(bio))) {
+		blk_zone_mgmt_bio_endio(bio);
+		return;
+	}
+
 	/*
 	 * For write BIOs to zoned devices, signal the completion of the BIO so
 	 * that the next write BIO can be submitted by zone write plugging.
-- 
2.51.0


