Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBC310C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEaPBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 11:01:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfEaPBT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 11:01:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDE28AD7B
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 15:01:17 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Introduce btrfs_io_geometry
Date:   Fri, 31 May 2019 18:01:14 +0300
Message-Id: <20190531150115.21003-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

---
 fs/btrfs/volumes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 +
 2 files changed, 100 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 776f5c7ca7c5..b130f465ca6d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5907,6 +5907,104 @@ static bool need_full_stripe(enum btrfs_map_op op)
 	return (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS);
 }
 
+/*
+ * btrfs_io_geometry - calculates the geomery of a particular (address, len)
+ *		       tuple. This information is used to calculate how big a
+ *		       particular bio can get before it straddles a stripe.
+ *
+ * @fs_info - The omnipresent btrfs structure
+ * @logical - Address that we want to figure out the geometry of
+ * @len	    - The length of IO we are going to perform, starting at @logical
+ * @op      - Type of operation - Write or Read
+ * @io_geom - Pointer used to return values
+ *
+ * Returns < 0 in case a chunk for the given logical address cannot be found,
+ * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
+ */
+int btrfs_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		      u64 logical, u64 len, struct btrfs_io_geometry *io_geom)
+{
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 offset;
+	u64 stripe_offset;
+	u64 stripe_nr;
+	u64 stripe_len;
+	u64 raid56_full_stripe_start = (u64)-1;
+	int data_stripes;
+
+	ASSERT(op != BTRFS_MAP_DISCARD);
+
+	em = btrfs_get_chunk_map(fs_info, logical, len);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+
+	map = em->map_lookup;
+	/* Offset of this logical address in the chunk */
+	offset = logical - em->start;
+	/* Len of a stripe in a chunk */
+	stripe_len = map->stripe_len;
+	/* Stripe wher this block falls in */
+	stripe_nr = div64_u64(offset, stripe_len);
+	/* Offset of stripe in the chunk */
+	stripe_offset = stripe_nr * stripe_len;
+	if (offset < stripe_offset) {
+		btrfs_crit(fs_info,
+			   "stripe math has gone wrong, stripe_offset=%llu, offset=%llu, start=%llu, logical=%llu, stripe_len=%llu",
+			   stripe_offset, offset, em->start, logical,
+			   stripe_len);
+		free_extent_map(em);
+		return -EINVAL;
+	}
+
+	/* stripe_offset is the offset of this block in its stripe*/
+	stripe_offset = offset - stripe_offset;
+	data_stripes = nr_data_stripes(map);
+
+
+	if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+		u64 max_len = stripe_len - stripe_offset;
+
+		/*
+		 * In case of raid56, we need to know the stripe aligned start
+		 */
+		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+			unsigned long full_stripe_len = stripe_len * data_stripes;
+			raid56_full_stripe_start = offset;
+
+			/*
+			 * Allow a write of a full stripe, but make sure we
+			 * don't allow straddling of stripes
+			 */
+			raid56_full_stripe_start = div64_u64(raid56_full_stripe_start,
+					full_stripe_len);
+			raid56_full_stripe_start *= full_stripe_len;
+
+			/*
+			 * For writes to RAID[56], allow a full stripeset across
+			 * all disks. For other RAID types and for RAID[56]
+			 * reads, just allow a single stripe (on a single disk).
+			 */
+			if (op == BTRFS_MAP_WRITE) {
+				max_len = stripe_len * data_stripes -
+				(offset - raid56_full_stripe_start);
+			}
+		}
+		len = min_t(u64, em->len - offset, max_len);
+	} else {
+		len = em->len - offset;
+	}
+
+	io_geom->len = len;
+	io_geom->offset = offset;
+	io_geom->stripe_len = stripe_len;
+	io_geom->stripe_nr = stripe_nr;
+	io_geom->stripe_offset = stripe_offset;
+	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
+
+	return 0;
+}
+
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			     enum btrfs_map_op op,
 			     u64 logical, u64 *length,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7c1ddf35b7d4..f3bdf768bbab 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -421,6 +421,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_bio **bbio_ret);
+int btrfs_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		      u64 logical, u64 len, struct btrfs_io_geometry *io_geom);
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
-- 
2.17.1

