Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2379DBC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 08:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfD2GDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 02:03:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727318AbfD2GDm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 02:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFB6DAF40
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 06:03:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: extent-tree: Add trace events for space info numbers update
Date:   Mon, 29 Apr 2019 14:03:33 +0800
Message-Id: <20190429060333.24172-2-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190429060333.24172-1-wqu@suse.com>
References: <20190429060333.24172-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add trace event for update_bytes_pinned() and update_bytes_may_use() to
detect underflow better.

The output would be something like (only showing data part):

  ## Buffered write start, 16K total ##
  2255.954 xfs_io/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=0 diff=4096
  2257.169 sudo/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=4096 diff=4096
  2257.346 sudo/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=8192 diff=4096
  2257.542 sudo/860 btrfs:update_bytes_may_use:(nil)U: type=DATA old=12288 diff=4096

  ## Delalloc start ##
  3727.853 kworker/u8:3-e/700 btrfs:update_bytes_may_use:(nil)U: type=DATA old=16384 diff=-16384

  ## Space cache update ##
  3733.132 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=0 diff=65536
  3733.169 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=65536 diff=-65536
  3739.868 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=0 diff=65536
  3739.891 sudo/862 btrfs:update_bytes_may_use:(nil)U: type=DATA old=65536 diff=-65536

These two trace events will allow bcc tool to probe btrfs_space_info
changes and detect underflow with more details (e.g. backtrace for each
update).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c       | 36 ++++++++++++++++++---------------
 include/trace/events/btrfs.h | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 54c853ea0585..edaecf755bb7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -55,10 +55,12 @@ enum {
  * Declare a helper function to detect underflow of various space info members
  */
 #define DECLARE_SPACE_INFO_UPDATE(name)					\
-static inline void update_##name(struct btrfs_space_info *sinfo,	\
+static inline void update_##name(struct btrfs_fs_info *fs_info,		\
+				 struct btrfs_space_info *sinfo,	\
 				 s64 bytes)				\
 {									\
 	lockdep_assert_held(&sinfo->lock);				\
+	trace_update_##name(fs_info, sinfo, sinfo->name, bytes);	\
 	if (bytes < 0 && sinfo->name < -bytes) {			\
 		WARN_ON(1);						\
 		sinfo->name = 0;					\
@@ -4283,7 +4285,7 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 					      data_sinfo->flags, bytes, 1);
 		return -ENOSPC;
 	}
-	update_bytes_may_use(data_sinfo, bytes);
+	update_bytes_may_use(fs_info, data_sinfo, bytes);
 	trace_btrfs_space_reservation(fs_info, "space_info",
 				      data_sinfo->flags, bytes, 1);
 	spin_unlock(&data_sinfo->lock);
@@ -4336,7 +4338,7 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 
 	data_sinfo = fs_info->data_sinfo;
 	spin_lock(&data_sinfo->lock);
-	update_bytes_may_use(data_sinfo, -len);
+	update_bytes_may_use(fs_info, data_sinfo, -len);
 	trace_btrfs_space_reservation(fs_info, "space_info",
 				      data_sinfo->flags, len, 0);
 	spin_unlock(&data_sinfo->lock);
@@ -5238,13 +5240,13 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 * If not things get more complicated.
 	 */
 	if (used + orig_bytes <= space_info->total_bytes) {
-		update_bytes_may_use(space_info, orig_bytes);
+		update_bytes_may_use(fs_info, space_info, orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
 		ret = 0;
 	} else if (can_overcommit(fs_info, space_info, orig_bytes, flush,
 				  system_chunk)) {
-		update_bytes_may_use(space_info, orig_bytes);
+		update_bytes_may_use(fs_info, space_info, orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
 		ret = 0;
@@ -5572,7 +5574,7 @@ static void space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 		flush = BTRFS_RESERVE_FLUSH_ALL;
 		goto again;
 	}
-	update_bytes_may_use(space_info, -num_bytes);
+	update_bytes_may_use(fs_info, space_info, -num_bytes);
 	trace_btrfs_space_reservation(fs_info, "space_info",
 				      space_info->flags, num_bytes, 0);
 	spin_unlock(&space_info->lock);
@@ -5600,7 +5602,8 @@ static void space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 						      ticket->bytes, 1);
 			list_del_init(&ticket->list);
 			num_bytes -= ticket->bytes;
-			update_bytes_may_use(space_info, ticket->bytes);
+			update_bytes_may_use(fs_info, space_info,
+					     ticket->bytes);
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
@@ -5608,7 +5611,7 @@ static void space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 			trace_btrfs_space_reservation(fs_info, "space_info",
 						      space_info->flags,
 						      num_bytes, 1);
-			update_bytes_may_use(space_info, num_bytes);
+			update_bytes_may_use(fs_info, space_info, num_bytes);
 			ticket->bytes -= num_bytes;
 			num_bytes = 0;
 		}
@@ -5980,14 +5983,14 @@ static void update_global_block_rsv(struct btrfs_fs_info *fs_info)
 			num_bytes = min(num_bytes,
 					block_rsv->size - block_rsv->reserved);
 			block_rsv->reserved += num_bytes;
-			update_bytes_may_use(sinfo, num_bytes);
+			update_bytes_may_use(fs_info, sinfo, num_bytes);
 			trace_btrfs_space_reservation(fs_info, "space_info",
 						      sinfo->flags, num_bytes,
 						      1);
 		}
 	} else if (block_rsv->reserved > block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
-		update_bytes_may_use(sinfo, -num_bytes);
+		update_bytes_may_use(fs_info, sinfo, -num_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 				      sinfo->flags, num_bytes, 0);
 		block_rsv->reserved = block_rsv->size;
@@ -6411,7 +6414,7 @@ static int update_block_group(struct btrfs_trans_handle *trans,
 			old_val -= num_bytes;
 			btrfs_set_block_group_used(&cache->item, old_val);
 			cache->pinned += num_bytes;
-			update_bytes_pinned(cache->space_info, num_bytes);
+			update_bytes_pinned(info, cache->space_info, num_bytes);
 			cache->space_info->bytes_used -= num_bytes;
 			cache->space_info->disk_used -= num_bytes * factor;
 			spin_unlock(&cache->lock);
@@ -6485,7 +6488,7 @@ static int pin_down_extent(struct btrfs_fs_info *fs_info,
 	spin_lock(&cache->space_info->lock);
 	spin_lock(&cache->lock);
 	cache->pinned += num_bytes;
-	update_bytes_pinned(cache->space_info, num_bytes);
+	update_bytes_pinned(fs_info, cache->space_info, num_bytes);
 	if (reserved) {
 		cache->reserved -= num_bytes;
 		cache->space_info->bytes_reserved -= num_bytes;
@@ -6694,7 +6697,7 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 	} else {
 		cache->reserved += num_bytes;
 		space_info->bytes_reserved += num_bytes;
-		update_bytes_may_use(space_info, -ram_bytes);
+		update_bytes_may_use(cache->fs_info, space_info, -ram_bytes);
 		if (delalloc)
 			cache->delalloc_bytes += num_bytes;
 	}
@@ -6850,7 +6853,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_lock(&space_info->lock);
 		spin_lock(&cache->lock);
 		cache->pinned -= len;
-		update_bytes_pinned(space_info, -len);
+		update_bytes_pinned(fs_info, space_info, -len);
 
 		trace_btrfs_space_reservation(fs_info, "pinned",
 					      space_info->flags, len, 0);
@@ -6871,7 +6874,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				to_add = min(len, global_rsv->size -
 					     global_rsv->reserved);
 				global_rsv->reserved += to_add;
-				update_bytes_may_use(space_info, to_add);
+				update_bytes_may_use(fs_info, space_info,
+						     to_add);
 				if (global_rsv->reserved >= global_rsv->size)
 					global_rsv->full = 1;
 				trace_btrfs_space_reservation(fs_info,
@@ -11144,7 +11148,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
 
-		update_bytes_pinned(space_info, -block_group->pinned);
+		update_bytes_pinned(fs_info, space_info, -block_group->pinned);
 		space_info->bytes_readonly += block_group->pinned;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 				   -block_group->pinned,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8b12753fee78..81544342f89a 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -29,6 +29,7 @@ struct btrfs_qgroup_extent_record;
 struct btrfs_qgroup;
 struct extent_io_tree;
 struct prelim_ref;
+struct btrfs_space_info;
 
 TRACE_DEFINE_ENUM(FLUSH_DELAYED_ITEMS_NR);
 TRACE_DEFINE_ENUM(FLUSH_DELAYED_ITEMS);
@@ -2005,6 +2006,44 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
 );
 
+DECLARE_EVENT_CLASS(btrfs__space_info_update,
+
+	TP_PROTO(struct btrfs_fs_info *fs_info,
+		 struct btrfs_space_info *sinfo, u64 old, s64 diff),
+
+	TP_ARGS(fs_info, sinfo, old, diff),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	type		)
+		__field(	u64,	old		)
+		__field(	s64,	diff		)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->type	= sinfo->flags;
+		__entry->old	= old;
+		__entry->diff	= diff;
+	),
+	TP_printk_btrfs("type=%s old=%llu diff=%lld",
+		__print_flags(__entry->type, "|", BTRFS_GROUP_FLAGS),
+		__entry->old, __entry->diff)
+);
+
+DEFINE_EVENT(btrfs__space_info_update, update_bytes_may_use,
+
+	TP_PROTO(struct btrfs_fs_info *fs_info,
+		 struct btrfs_space_info *sinfo, u64 old, s64 diff),
+
+	TP_ARGS(fs_info, sinfo, old, diff)
+);
+
+DEFINE_EVENT(btrfs__space_info_update, update_bytes_pinned,
+
+	TP_PROTO(struct btrfs_fs_info *fs_info,
+		 struct btrfs_space_info *sinfo, u64 old, s64 diff),
+
+	TP_ARGS(fs_info, sinfo, old, diff)
+);
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.21.0

