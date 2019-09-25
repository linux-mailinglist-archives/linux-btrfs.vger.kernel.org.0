Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D43BDDF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405590AbfIYMOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 08:14:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405481AbfIYMOH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 08:14:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AD94ABCE
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 12:14:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 04/10] btrfs-progs: image: Allow restore to record system chunk ranges for later usage
Date:   Wed, 25 Sep 2019 20:13:50 +0800
Message-Id: <20190925121356.118038-5-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925121356.118038-1-wqu@suse.com>
References: <20190925121356.118038-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we are doing a pretty slow search for system chunks before
restoring real data.
The current behavior is to search all clusters for chunk tree root
first, then search all clusters again and again for every chunk tree
block.

This causes recursive calls and pretty slow start up, the only good news
is since chunk tree are normally small, we don't need to iterate too
many times, thus overall it's acceptable.

To address such bad behavior, we could take usage of system chunk array
in the super block.
By recording all system chunks ranges, we could easily determine if an
extent belongs to chunk tree, thus do one loop simple linear search for
chunk tree leaves.

This patch only introduces the code base for later patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/image/main.c b/image/main.c
index 162a578a3ff8..0a68ea8e70d9 100644
--- a/image/main.c
+++ b/image/main.c
@@ -35,6 +35,7 @@
 #include "common/utils.h"
 #include "volumes.h"
 #include "extent_io.h"
+#include "extent-cache.h"
 #include "common/help.h"
 #include "common/device-utils.h"
 #include "image/metadump.h"
@@ -93,6 +94,11 @@ struct mdrestore_struct {
 	pthread_mutex_t mutex;
 	pthread_cond_t cond;
 
+	/*
+	 * Records system chunk ranges, so restore can use this to determine
+	 * if an item is in chunk tree range.
+	 */
+	struct cache_tree sys_chunks;
 	struct rb_root chunk_tree;
 	struct rb_root physical_tree;
 	struct list_head list;
@@ -102,6 +108,8 @@ struct mdrestore_struct {
 	u64 devid;
 	u64 alloced_chunks;
 	u64 last_physical_offset;
+	/* An quicker checker for if a item is in sys chunk range */
+	u64 sys_chunk_end;
 	u8 uuid[BTRFS_UUID_SIZE];
 	u8 fsid[BTRFS_FSID_SIZE];
 
@@ -1456,6 +1464,7 @@ static void mdrestore_destroy(struct mdrestore_struct *mdres, int num_threads)
 		rb_erase(&entry->p, &mdres->physical_tree);
 		free(entry);
 	}
+	free_extent_cache_tree(&mdres->sys_chunks);
 	pthread_mutex_lock(&mdres->mutex);
 	mdres->done = 1;
 	pthread_cond_broadcast(&mdres->cond);
@@ -1480,6 +1489,7 @@ static int mdrestore_init(struct mdrestore_struct *mdres,
 	pthread_mutex_init(&mdres->mutex, NULL);
 	INIT_LIST_HEAD(&mdres->list);
 	INIT_LIST_HEAD(&mdres->overlapping_chunks);
+	cache_tree_init(&mdres->sys_chunks);
 	mdres->in = in;
 	mdres->out = out;
 	mdres->old_restore = old_restore;
@@ -1903,6 +1913,92 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 	return ret;
 }
 
+/*
+ * Add system chunks in super blocks into mdres->sys_chunks, so later
+ * we can determine if an item is a chunk tree block.
+ */
+static int add_sys_array(struct mdrestore_struct *mdres,
+			 struct btrfs_super_block *sb)
+{
+	struct btrfs_disk_key *disk_key;
+	struct btrfs_key key;
+	struct btrfs_chunk *chunk;
+	struct cache_extent *cache;
+	u32 cur_offset;
+	u32 len = 0;
+	u32 array_size;
+	u8 *array_ptr;
+	int ret = 0;
+
+	array_size = btrfs_super_sys_array_size(sb);
+	array_ptr = sb->sys_chunk_array;
+	cur_offset = 0;
+
+	while (cur_offset < array_size) {
+		u32 num_stripes;
+
+		disk_key = (struct btrfs_disk_key *)array_ptr;
+		len = sizeof(*disk_key);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+		btrfs_disk_key_to_cpu(&key, disk_key);
+
+		array_ptr += len;
+		cur_offset += len;
+
+		if (key.type == BTRFS_CHUNK_ITEM_KEY) {
+			chunk = (struct btrfs_chunk *)array_ptr;
+
+			/*
+			 * At least one btrfs_chunk with one stripe must be
+			 * present, exact stripe count check comes afterwards
+			 */
+			len = btrfs_chunk_item_size(1);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+			num_stripes = btrfs_stack_chunk_num_stripes(chunk);
+			if (!num_stripes) {
+				printk(
+	    "ERROR: invalid number of stripes %u in sys_array at offset %u\n",
+					num_stripes, cur_offset);
+				ret = -EIO;
+				break;
+			}
+			len = btrfs_chunk_item_size(num_stripes);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+			if (btrfs_stack_chunk_type(chunk) &
+			    BTRFS_BLOCK_GROUP_SYSTEM) {
+				ret = add_merge_cache_extent(&mdres->sys_chunks,
+					key.offset,
+					btrfs_stack_chunk_length(chunk));
+				if (ret < 0)
+					break;
+			}
+		} else {
+			error("unexpected item type %u in sys_array offset %u",
+			      key.type, cur_offset);
+			ret = -EUCLEAN;
+			break;
+		}
+		array_ptr += len;
+		cur_offset += len;
+	}
+
+	/* Get the last system chunk end as a quicker check */
+	cache = last_cache_extent(&mdres->sys_chunks);
+	if (!cache) {
+		error("no system chunk found in super block");
+		return -EUCLEAN;
+	}
+	mdres->sys_chunk_end = cache->start + cache->size - 1;
+	return ret;
+out_short_read:
+	error("sys_array too short to read %u bytes at offset %u\n",
+		len, cur_offset);
+	return -EUCLEAN;
+}
+
 static int build_chunk_tree(struct mdrestore_struct *mdres,
 			    struct meta_cluster *cluster)
 {
@@ -1995,6 +2091,13 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 		error("invalid superblock");
 		return ret;
 	}
+	ret = add_sys_array(mdres, super);
+	if (ret < 0) {
+		error("failed to read system chunk array");
+		free(buffer);
+		pthread_mutex_unlock(&mdres->mutex);
+		return ret;
+	}
 	chunk_root_bytenr = btrfs_super_chunk_root(super);
 	mdres->nodesize = btrfs_super_nodesize(super);
 	if (btrfs_super_incompat_flags(super) &
-- 
2.23.0

