Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB3E9B69
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJ3MWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:22:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbfJ3MWd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:22:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05825B6CC;
        Wed, 30 Oct 2019 12:22:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs-progs: Remove convert param from btrfs_alloc_data_chunk
Date:   Wed, 30 Oct 2019 14:22:27 +0200
Message-Id: <20191030122227.28496-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030122227.28496-1-nborisov@suse.com>
References: <20191030122227.28496-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

convert is always set to true so there's no point in having it as a
function parameter or using it as a predicate inside btrfs_alloc_data_chunk.
Remove it and all relevant code which would have never been executed.
No semantics changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 convert/main.c |  3 +--
 volumes.c      | 44 ++++++++++++++------------------------------
 volumes.h      |  3 +--
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index 9904deafba45..416ab5d264a3 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -942,8 +942,7 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 
 			len = min(max_chunk_size,
 				  cache->start + cache->size - cur);
-			ret = btrfs_alloc_data_chunk(trans, fs_info,
-					&cur_backup, len, 1);
+			ret = btrfs_alloc_data_chunk(trans, fs_info, &cur_backup, len);
 			if (ret < 0)
 				break;
 			ret = btrfs_make_block_group(trans, fs_info, 0,
diff --git a/volumes.c b/volumes.c
index 87315a884b49..39e824a43736 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1238,14 +1238,11 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 /*
  * Alloc a DATA chunk with SINGLE profile.
  *
- * If 'convert' is set, it will alloc a chunk with 1:1 mapping
- * (btrfs logical bytenr == on-disk bytenr)
- * For that case, caller must make sure the chunk and dev_extent are not
- * occupied.
+ * It allocates a chunk with 1:1 mapping (btrfs logical bytenr == on-disk bytenr)
+ * Caller must make sure the chunk and dev_extent are not occupied.
  */
 int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
-			   struct btrfs_fs_info *info, u64 *start,
-			   u64 num_bytes, int convert)
+			   struct btrfs_fs_info *info, u64 *start, u64 num_bytes)
 {
 	u64 dev_offset;
 	struct btrfs_root *extent_root = info->extent_root;
@@ -1264,25 +1261,18 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	int stripe_len = BTRFS_STRIPE_LEN;
 	struct btrfs_key key;
 
-	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
-	key.type = BTRFS_CHUNK_ITEM_KEY;
-	if (convert) {
-		if (*start != round_down(*start, info->sectorsize)) {
-			error("DATA chunk start not sectorsize aligned: %llu",
-					(unsigned long long)*start);
-			return -EINVAL;
-		}
-		key.offset = *start;
-		dev_offset = *start;
-	} else {
-		u64 tmp;
 
-		ret = find_next_chunk(info, &tmp);
-		key.offset = tmp;
-		if (ret)
-			return ret;
+	if (*start != round_down(*start, info->sectorsize)) {
+		error("DATA chunk start not sectorsize aligned: %llu",
+				(unsigned long long)*start);
+		return -EINVAL;
 	}
 
+	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = *start;
+	dev_offset = *start;
+
 	chunk = kmalloc(btrfs_chunk_item_size(num_stripes), GFP_NOFS);
 	if (!chunk)
 		return -ENOMEM;
@@ -1303,12 +1293,8 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	while (index < num_stripes) {
 		struct btrfs_stripe *stripe;
 
-		if (convert)
-			ret = btrfs_insert_dev_extent(trans, device, key.offset,
-					calc_size, dev_offset);
-		else
-			ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-					calc_size, &dev_offset);
+		ret = btrfs_insert_dev_extent(trans, device, key.offset, calc_size,
+				dev_offset);
 		BUG_ON(ret);
 
 		device->bytes_used += calc_size;
@@ -1345,8 +1331,6 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_item(trans, chunk_root, &key, chunk,
 				btrfs_chunk_item_size(num_stripes));
 	BUG_ON(ret);
-	if (!convert)
-		*start = key.offset;
 
 	map->ce.start = key.offset;
 	map->ce.size = num_bytes;
diff --git a/volumes.h b/volumes.h
index 83ba827e422b..f6f05054b5c4 100644
--- a/volumes.h
+++ b/volumes.h
@@ -271,8 +271,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *fs_info, u64 *start,
 		      u64 *num_bytes, u64 type);
 int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
-			   struct btrfs_fs_info *fs_info, u64 *start,
-			   u64 num_bytes, int convert);
+			   struct btrfs_fs_info *fs_info, u64 *start, u64 num_bytes);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       int flags);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-- 
2.7.4

