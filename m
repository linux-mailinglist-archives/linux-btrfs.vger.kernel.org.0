Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9C2FFCD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 07:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhAVGaz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 01:30:55 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbhAVG3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 01:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296948; x=1642832948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7WkPOppAzETbSGoiCpo2k0JMaZoq5r7/CbQ0WRHJMvY=;
  b=nPxDM3LojiZpzIcXfyxDx1MwpJpO/Z1d15KiWg8XlTZ/wtgpv7uylsM1
   JG79L+qFhhNHQyQLpO+i0CvM3Ru+9wNFPbgJXXw5Bf4TNSdmhKfry89HT
   dfh7aZnxirmt4ok4Dn/J45sl4cN663kcm3QCU4KpMaoA493NcC0aIBIhD
   y/Rz/GdWiQG7IJx2ZVhkGsD7/Xf/JCNTstZeFwEsXxek3rpifIR57Cq7O
   Xz+zjTEVyGCN01Y932RBEBnULbn4LvP7kVb6nk28CFx2bN3as2BsQeR/5
   H48UtU0BYxs6N/Q4NLXcF4aX7kstqXovkEZjii4aaSxhwEchV7n7S3gmT
   A==;
IronPort-SDR: Uq9aFe8i9vJ/BTuNcML4KAL7drMsCnffQDYD0noi6ZEDM5so9SsznQF7umAYlSLekRPJ+dc7Y5
 m88FM3Sb4FMe2cqvegBbzztakIpeuXi8B6MxQfO/wzlOMxWE4rCAkfD7HRa0znP5pYRfAdwAqh
 fpu3rdm53G/cf6xMg1jx//sBkBuN57KM/1vui+Q1HZCbduiikCyJ6WFFxOa6Tn0s/rJeZSECYB
 TmdFxkxCuifJ029MPsb8M4agPvLMmK7K17UOakRNVl6j2CfigiC9QDyA4VSw7KHToQvj38LaMN
 bWE=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392070"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:19 +0800
IronPort-SDR: S9NxQ2efH+fRY/9PTxMGpztgqKvxzftRDaHgFSkSLgvEVquj45xKnLjCk7YoNy+LNktaejIxxm
 6IVyvAZ3tZ9CvbtGrHUKYbGt5YLi+ouHS0+RpLsA39TJ7wKddyauDmJiTdKKR9DIZN135o1o/F
 7c9RQjN4mZvLgC/azd+u3uOYiTjCDqlp9/EKKtXCmoVfAJeLgSs01hwkTp0bi9RSV+AqOLH0AQ
 1b6L7bC0/wrwXyIXwRR0fzGUx5C3MUt6FO5MdFvewER0IlsnFwDVi2jZg1RbcPANxccW/25a5A
 XqsvPbdUv32ZoWuCvX0hUYmU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:51 -0800
IronPort-SDR: 6OwiKWKx3acz8M+K6qtMVFi+hPcuPai/qRxAF7Pujp46KgDjzwegVRmGVlBOG3QCggCsHTxwuS
 /03/rvrUkwPqnsWddVdueUfQgYyyAJ0hv263A5U/StPznvq0joMngtCx/ntod0m3Zr2ocxI2zT
 Bvh7vHkBxaYZ7IueX28bi/LD4fT82pxckpHV2L+NhK3Ax4fCHuPmXMb1AsinyiJG4U65XB5pZB
 XttRYdsy1aEpTTikv5RG3wntoZ326HRkwwOOSoovEqNGWacOyvYVcP2XGi94rxN+MgZYzMWccP
 gAc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:17 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 35/42] btrfs: implement copying for ZONED device-replace
Date:   Fri, 22 Jan 2021 15:21:35 +0900
Message-Id: <6871488842cd4657fac35246c3f3b79cbbbdbe7c.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is 3/4 patch to implement device-replace on ZONED mode.

This commit implement copying. So, it track the write pointer during device
replace process. Device-replace's copying is smart to copy only used
extents on source device, we have to fill the gap to honor the sequential
write rule in the target device.

Device-replace process in ZONED mode must copy or clone all the extents in
the source device exactly once.  So, we need to use to ensure allocations
started just before the dev-replace process to have their corresponding
extent information in the B-trees. finish_extent_writes_for_zoned()
implements that functionality, which basically is the removed code in the
commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
error during device replace").

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c | 12 +++++++
 fs/btrfs/zoned.h |  8 +++++
 3 files changed, 106 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b57c1184f330..b03c3629fb12 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -166,6 +166,7 @@ struct scrub_ctx {
 	int			pages_per_rd_bio;
 
 	int			is_dev_replace;
+	u64			write_pointer;
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
@@ -1619,6 +1620,25 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
 }
 
+static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
+{
+	int ret = 0;
+	u64 length;
+
+	if (!btrfs_is_zoned(sctx->fs_info))
+		return 0;
+
+	if (sctx->write_pointer < physical) {
+		length = physical - sctx->write_pointer;
+
+		ret = btrfs_zoned_issue_zeroout(sctx->wr_tgtdev,
+						sctx->write_pointer, length);
+		if (!ret)
+			sctx->write_pointer = physical;
+	}
+	return ret;
+}
+
 static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage)
 {
@@ -1641,6 +1661,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	if (sbio->page_count == 0) {
 		struct bio *bio;
 
+		ret = fill_writer_pointer_gap(sctx,
+					      spage->physical_for_dev_replace);
+		if (ret) {
+			mutex_unlock(&sctx->wr_lock);
+			return ret;
+		}
+
 		sbio->physical = spage->physical_for_dev_replace;
 		sbio->logical = spage->logical;
 		sbio->dev = sctx->wr_tgtdev;
@@ -1705,6 +1732,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_is_zoned(sctx->fs_info))
+		sctx->write_pointer = sbio->physical +
+			sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -3028,6 +3059,21 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
+static void sync_replace_for_zoned(struct scrub_ctx *sctx)
+{
+	if (!btrfs_is_zoned(sctx->fs_info))
+		return;
+
+	sctx->flush_all_writes = true;
+	scrub_submit(sctx);
+	mutex_lock(&sctx->wr_lock);
+	scrub_wr_submit(sctx);
+	mutex_unlock(&sctx->wr_lock);
+
+	wait_event(sctx->list_wait,
+		   atomic_read(&sctx->bios_in_flight) == 0);
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3168,6 +3214,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 */
 	blk_start_plug(&plug);
 
+	if (sctx->is_dev_replace &&
+	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
+		mutex_lock(&sctx->wr_lock);
+		sctx->write_pointer = physical;
+		mutex_unlock(&sctx->wr_lock);
+		sctx->flush_all_writes = true;
+	}
+
 	/*
 	 * now find all extents for each stripe and scrub them
 	 */
@@ -3356,6 +3410,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			if (sctx->is_dev_replace)
+				sync_replace_for_zoned(sctx);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3478,6 +3535,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static int finish_extent_writes_for_zoned(struct btrfs_root *root,
+					  struct btrfs_block_group *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_trans_handle *trans;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	btrfs_wait_block_group_reservations(cache);
+	btrfs_wait_nocow_writers(cache);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	return btrfs_commit_transaction(trans);
+}
+
 static noinline_for_stack
 int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
@@ -3633,6 +3709,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * group is not RO.
 		 */
 		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
+		if (!ret && sctx->is_dev_replace) {
+			ret = finish_extent_writes_for_zoned(root, cache);
+			if (ret) {
+				btrfs_dec_block_group_ro(cache);
+				scrub_pause_off(fs_info);
+				btrfs_put_block_group(cache);
+				break;
+			}
+		}
+
 		if (ret == 0) {
 			ro_set = 1;
 		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a9079e267676..360165bd0396 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1386,3 +1386,15 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
 	cache->meta_write_pointer = eb->start;
 }
+
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length)
+{
+	if (!btrfs_dev_is_sequential(device, physical))
+		return -EOPNOTSUPP;
+
+	return blkdev_issue_zeroout(device->bdev,
+				    physical >> SECTOR_SHIFT,
+				    length >> SECTOR_SHIFT,
+				    GFP_NOFS, 0);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index a42e120158ab..a9698470c08e 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -55,6 +55,8 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group **cache_ret);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -169,6 +171,12 @@ static inline void btrfs_revert_meta_write_pointer(
 {
 }
 
+static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
+					    u64 physical, u64 length)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

