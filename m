Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F56C123C5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLRBT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:19:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:49776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfLRBT7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:19:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8088CABCD
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 01:19:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs-progs: extent-tree: Kill the BUG_ON() in btrfs_chunk_readonly()
Date:   Wed, 18 Dec 2019 09:19:41 +0800
Message-Id: <20191218011942.9830-6-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218011942.9830-1-wqu@suse.com>
References: <20191218011942.9830-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For a fuzzed image, `btrfs check` both modes trigger BUG_ON():

  Opening filesystem to check...
  volumes.c:1795: btrfs_chunk_readonly: BUG_ON `!ce` triggered, value 1
  btrfs(+0x2f712)[0x557beff3b712]
  btrfs(+0x32059)[0x557beff3e059]
  btrfs(btrfs_read_block_groups+0x282)[0x557beff30972]
  btrfs(btrfs_setup_all_roots+0x3f3)[0x557beff2ab23]
  btrfs(+0x1ef53)[0x557beff2af53]
  btrfs(open_ctree_fs_info+0x90)[0x557beff2b1a0]
  btrfs(+0x6d3f9)[0x557beff793f9]
  btrfs(main+0x94)[0x557beff200c4]
  /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f623ac97ee3]
  btrfs(_start+0x2e)[0x557beff2035e]

[CAUSE]
The fuzzed image has a bad extent tree:

        item 0 key (288230376165343232 BLOCK_GROUP_ITEM 8388608) itemoff 16259 itemsize 24
                block group used 0 chunk_objectid 256 flags DATA

There is no corresponding chunk for the block group.

In then we hit the BUG_ON(), which expects chunk mapping for
btrfs_chunk_readonly().

[FIX]
Remove that BUG_ON() with proper error handling, and make
btrfs_read_block_groups() handle the -ENOENT error from
read_one_block_group() to continue.

So one corrupted block group item won't screw up the remaining block
group items.

Issue: #209
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c |  9 +++++++--
 volumes.c     | 14 ++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 53be4f4c..6288c8a3 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2708,7 +2708,12 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 		bit = BLOCK_GROUP_METADATA;
 	}
 	set_avail_alloc_bits(fs_info, cache->flags);
-	if (btrfs_chunk_readonly(fs_info, cache->key.objectid))
+	ret = btrfs_chunk_readonly(fs_info, cache->key.objectid);
+	if (ret < 0) {
+		free(cache);
+		return ret;
+	}
+	if (ret)
 		cache->ro = 1;
 	exclude_super_stripes(fs_info, cache);
 
@@ -2753,7 +2758,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 
 		ret = read_one_block_group(fs_info, &path);
-		if (ret < 0)
+		if (ret < 0 && ret != -ENOENT)
 			goto error;
 
 		if (key.offset == 0)
diff --git a/volumes.c b/volumes.c
index 0f618978..6c22c742 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1802,6 +1802,11 @@ btrfs_find_device_by_devid(struct btrfs_fs_devices *fs_devices,
 	return NULL;
 }
 
+/*
+ * Return 0 if the chunk at @chunk_offset exists and is not read-only.
+ * Return 1 if the chunk at @chunk_offset exists and is read-only.
+ * Return <0 if we can't find chunk at @chunk_offset.
+ */
 int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 {
 	struct cache_extent *ce;
@@ -1814,12 +1819,13 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * During chunk recovering, we may fail to find block group's
 	 * corresponding chunk, we will rebuild it later
 	 */
-	ce = search_cache_extent(&map_tree->cache_tree, chunk_offset);
-	if (!fs_info->is_chunk_recover)
-		BUG_ON(!ce);
-	else
+	if (fs_info->is_chunk_recover)
 		return 0;
 
+	ce = search_cache_extent(&map_tree->cache_tree, chunk_offset);
+	if (!ce)
+		return -ENOENT;
+
 	map = container_of(ce, struct map_lookup, ce);
 	for (i = 0; i < map->num_stripes; i++) {
 		if (!map->stripes[i].dev->writeable) {
-- 
2.24.1

