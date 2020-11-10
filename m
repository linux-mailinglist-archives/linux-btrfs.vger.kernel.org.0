Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4EC2AD533
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 12:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbgKJLaO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 06:30:14 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11994 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKJL2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007711; x=1636543711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fecS+jxie6mEuhUVqmIiaoaIZxDk4mfkukIWy3O2oZs=;
  b=AJMh8GtqeGRnK5824ULGJNgmnVgWbRcFR48t0NjbeIc8pIMBr0kYC2WM
   ZeW6JTBAwxKWRSuTJf0jKJ6qHeX8xqvJQdisDd9qwmrE6+NAwLnrufwl5
   uZ4rR6V0elb3O7fNv2leuMTpTLQxWYTn46xh1LESHNEcG9+DXXLK8rX5V
   nPcfbXdg9IQL/vFvhaPJ1UsI8bpTRr7YNEKimioUGIGWUW0+irPT1iVJD
   Vf9wXmy9tCWDpvZrA3kzRGjbEyjxis2OG9Q6iORb/uJx9kI75jC9tdtNw
   n8AIpw3j0qup0YSh1Q3iJR6ABLG9KbNqGhiru7BRp1hF7oCZB/goGNhgz
   g==;
IronPort-SDR: CI8aFrAqvqmIndqkVlcZPV2RtIeZpjfw3SIA42p9uf653ZICkNYj8tJ7oxWqp8VATavO4hJY3T
 qessaraI690VTSo/UPvseqryzuj5z0Mdvbldt0rMF4g7opomFG15ueAbRTdt22J3PEn7sdr0BX
 y1ZyRSqWoOxT14GgwStGIVWPBxOJoKctiq2WzjuEWB+issJrhLdZPODx132TQqqKf6w2jxgXJS
 Ksf4LeyR0NqHhI7VgWVsRAstT0gHHZF5e3m5gUEou3j98HnpgbzD/vpP1ZrvB6dUnATCi5Hbk9
 hxc=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376503"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:31 +0800
IronPort-SDR: Kq/lwyFrnHxsFCusIs9l5nW9vFtaXtwA5On4fLkGKrMYilp9b43Lf3+96cZxgVrb5rq3v4I4kS
 QRm74HGwVCxGQxfkSPb9ggSmo1czYTk/J3ZaY515+it/L8bQp2t2vQvqjXJ+aVWbOJ67Kvh+jI
 Rh60PRjGCY5TL23c4GEQa3oHVwh2NY7aQn584G9SxsDN2V95VG2ssATvcCCE0quepIKL616+tx
 hXhROmqNTmfjJPck3vkdpbLQTAqiyJf45J2vlvab7EMIZIxqj8Oi5+T0Wf0+LX10Sq3VjJ4G28
 +hygAldv6L5zSC+Bqt/SuDlE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:32 -0800
IronPort-SDR: tKTOrzlhLhxc9DCwBWX4wIwcM14Bov4ObuKq/qOgi9ujj0Y0JeR6qCZ+Wv1Wzby1ce20sQbo5J
 3PWNW3zRTsAb7u4x/mB/Gr/C1SBn6IwMOlUyHBe/HgZGBZeCsyEtHKL8OMOxfQu6bPwWLfdU7q
 sEwgHTm8VtDEvMyWH+E0vIQV0R097s8I2MXaDh+bdk0RuaDGSc5vHLmCRtV1/W5H7qA3SZt6sK
 4Vho4bs2oAQ7RX7p2OORiDpwkT1QGcoHKB1bN8Yecln630qh0uYGEuPYcR7ji0WOab8Oaoh8gp
 VZQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:30 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 16/41] btrfs: track unusable bytes for zones
Date:   Tue, 10 Nov 2020 20:26:19 +0900
Message-Id: <b3ec6f6a47bdee9030e01f4814bd180632a6c0a8.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In zoned btrfs a region that was once written then freed is not usable
until we reset the underlying zone. So we need to distinguish such
unusable space from usable free space.

Therefore we need to introduce the "zone_unusable" field  to the block
group structure, and "bytes_zone_unusable" to the space_info structure to
track the unusable space.

Pinned bytes are always reclaimed to the unusable space. But, when an
allocated region is returned before using e.g., the block group becomes
read-only between allocation time and reservation time, we can safely
return the region to the block group. For the situation, this commit
introduces "btrfs_add_free_space_unused". This behaves the same as
btrfs_add_free_space() on regular btrfs. On zoned btrfs, it rewinds the
allocation offset.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      | 21 ++++++++++-----
 fs/btrfs/block-group.h      |  1 +
 fs/btrfs/extent-tree.c      | 10 ++++++-
 fs/btrfs/free-space-cache.c | 52 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/space-info.c       | 13 ++++++----
 fs/btrfs/space-info.h       |  4 ++-
 fs/btrfs/sysfs.c            |  2 ++
 fs/btrfs/zoned.c            | 24 +++++++++++++++++
 fs/btrfs/zoned.h            |  3 +++
 10 files changed, 119 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ffc64dfbe09e..723b7c183cd9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1080,12 +1080,17 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		WARN_ON(block_group->space_info->total_bytes
 			< block_group->length);
 		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->length);
+			< block_group->length - block_group->zone_unusable);
+		WARN_ON(block_group->space_info->bytes_zone_unusable
+			< block_group->zone_unusable);
 		WARN_ON(block_group->space_info->disk_total
 			< block_group->length * factor);
 	}
 	block_group->space_info->total_bytes -= block_group->length;
-	block_group->space_info->bytes_readonly -= block_group->length;
+	block_group->space_info->bytes_readonly -=
+		(block_group->length - block_group->zone_unusable);
+	block_group->space_info->bytes_zone_unusable -=
+		block_group->zone_unusable;
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1229,7 +1234,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	}
 
 	num_bytes = cache->length - cache->reserved - cache->pinned -
-		    cache->bytes_super - cache->used;
+		    cache->bytes_super - cache->zone_unusable - cache->used;
 
 	/*
 	 * Data never overcommits, even in mixed mode, so do just the straight
@@ -1973,6 +1978,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_free_excluded_extents(cache);
 	}
 
+	btrfs_calc_zone_unusable(cache);
+
 	ret = btrfs_add_block_group_cache(info, cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
@@ -1980,7 +1987,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super, &space_info);
+				cache->used, cache->bytes_super,
+				cache->zone_unusable, &space_info);
 
 	cache->space_info = space_info;
 
@@ -2217,7 +2225,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+				cache->bytes_super, 0, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -2325,7 +2333,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
 		num_bytes = cache->length - cache->reserved -
-			    cache->pinned - cache->bytes_super - cache->used;
+			    cache->pinned - cache->bytes_super -
+			    cache->zone_unusable - cache->used;
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
 	}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 14e3043c9ce7..5be47f4bfea7 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -189,6 +189,7 @@ struct btrfs_block_group {
 	 * allocation. This is used only with ZONED mode enabled.
 	 */
 	u64 alloc_offset;
+	u64 zone_unusable;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3b21fee13e77..09439782b9a8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -34,6 +34,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "rcu-string.h"
+#include "zoned.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2765,6 +2766,9 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_free_cluster *ret = NULL;
 
+	if (btrfs_is_zoned(fs_info))
+		return NULL;
+
 	*empty_cluster = 0;
 	if (btrfs_mixed_space_info(space_info))
 		return ret;
@@ -2846,7 +2850,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		if (cache->ro) {
+		if (btrfs_is_zoned(fs_info)) {
+			/* Need reset before reusing in a zoned block group */
+			space_info->bytes_zone_unusable += len;
+			readonly = true;
+		} else if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index af0013d3df63..f6434794cb0b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2467,6 +2467,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	u64 filter_bytes = bytes;
 
+	ASSERT(!btrfs_is_zoned(fs_info));
+
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
 		return -ENOMEM;
@@ -2524,11 +2526,44 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
+					u64 bytenr, u64 size, bool used)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 offset = bytenr - block_group->start;
+	u64 to_free, to_unusable;
+
+	spin_lock(&ctl->tree_lock);
+	if (!used)
+		to_free = size;
+	else if (offset >= block_group->alloc_offset)
+		to_free = size;
+	else if (offset + size <= block_group->alloc_offset)
+		to_free = 0;
+	else
+		to_free = offset + size - block_group->alloc_offset;
+	to_unusable = size - to_free;
+
+	ctl->free_space += to_free;
+	block_group->zone_unusable += to_unusable;
+	spin_unlock(&ctl->tree_lock);
+	if (!used) {
+		spin_lock(&block_group->lock);
+		block_group->alloc_offset -= size;
+		spin_unlock(&block_group->lock);
+	}
+	return 0;
+}
+
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size)
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    true);
+
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
 
@@ -2537,6 +2572,16 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
 				      bytenr, size, trim_state);
 }
 
+int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
+				u64 bytenr, u64 size)
+{
+	if (btrfs_is_zoned(block_group->fs_info))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    false);
+
+	return btrfs_add_free_space(block_group, bytenr, size);
+}
+
 /*
  * This is a subtle distinction because when adding free space back in general,
  * we want it to be added as untrimmed for async. But in the case where we add
@@ -2547,6 +2592,10 @@ int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    true);
+
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC) ||
 	    btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
@@ -2564,6 +2613,9 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return 0;
+
 	spin_lock(&ctl->tree_lock);
 
 again:
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..469382529f7e 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -116,6 +116,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   enum btrfs_trim_state trim_state);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
+int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
+				u64 bytenr, u64 size);
 int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 				       u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 64099565ab8f..bbbf3c1412a4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -163,6 +163,7 @@ u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 	ASSERT(s_info);
 	return s_info->bytes_used + s_info->bytes_reserved +
 		s_info->bytes_pinned + s_info->bytes_readonly +
+		s_info->bytes_zone_unusable +
 		(may_use_included ? s_info->bytes_may_use : 0);
 }
 
@@ -257,7 +258,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
@@ -273,6 +274,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_used += bytes_used;
 	found->disk_used += bytes_used * factor;
 	found->bytes_readonly += bytes_readonly;
+	found->bytes_zone_unusable += bytes_zone_unusable;
 	if (total_bytes > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
@@ -422,10 +424,10 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		   info->total_bytes - btrfs_space_info_used(info, true),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
-		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu",
+		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
-		info->bytes_readonly);
+		info->bytes_readonly, info->bytes_zone_unusable);
 
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
@@ -454,9 +456,10 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(cache, &info->block_groups[index], list) {
 		spin_lock(&cache->lock);
 		btrfs_info(fs_info,
-			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
+			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu zone_unusable %s",
 			cache->start, cache->length, cache->used, cache->pinned,
-			cache->reserved, cache->ro ? "[readonly]" : "");
+			cache->reserved, cache->zone_unusable,
+			cache->ro ? "[readonly]" : "");
 		spin_unlock(&cache->lock);
 		btrfs_dump_free_space(cache, bytes);
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 5646393b928c..ee003ffba956 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -17,6 +17,8 @@ struct btrfs_space_info {
 	u64 bytes_may_use;	/* number of bytes that may be used for
 				   delalloc/allocations */
 	u64 bytes_readonly;	/* total bytes that are read only */
+	u64 bytes_zone_unusable;	/* total bytes that are unusable until
+					   resetting the device zone */
 
 	u64 max_extent_size;	/* This will hold the maximum extent size of
 				   the space info if we had an ENOSPC in the
@@ -119,7 +121,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 828006020bbd..ea679803da9b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -635,6 +635,7 @@ SPACE_INFO_ATTR(bytes_pinned);
 SPACE_INFO_ATTR(bytes_reserved);
 SPACE_INFO_ATTR(bytes_may_use);
 SPACE_INFO_ATTR(bytes_readonly);
+SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR(space_info, total_bytes_pinned,
@@ -648,6 +649,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_reserved),
 	BTRFS_ATTR_PTR(space_info, bytes_may_use),
 	BTRFS_ATTR_PTR(space_info, bytes_readonly),
+	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9bf40300e428..5ee26b9fe5b1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -999,3 +999,27 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 
 	return ret;
 }
+
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
+{
+	u64 unusable, free;
+
+	if (!btrfs_is_zoned(cache->fs_info))
+		return;
+
+	WARN_ON(cache->bytes_super != 0);
+	unusable = cache->alloc_offset - cache->used;
+	free = cache->length - cache->alloc_offset;
+
+	/* We only need ->free_space in ALLOC_SEQ BGs */
+	cache->last_byte_to_unpin = (u64)-1;
+	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->free_space_ctl->free_space = free;
+	cache->zone_unusable = unusable;
+
+	/*
+	 * Should not have any excluded extents. Just
+	 * in case, though.
+	 */
+	btrfs_free_excluded_extents(cache);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e3338a2f1be9..c86cde1978cd 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -41,6 +41,7 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -119,6 +120,8 @@ static inline int btrfs_load_block_group_zone_info(
 	return 0;
 }
 
+static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

