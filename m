Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D152F1C4ACF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEEACh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgEEACh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5326AF01
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 01/11] btrfs-progs: check/lowmem: Lookup block group item in a seperate function
Date:   Tue,  5 May 2020 08:02:20 +0800
Message-Id: <20200505000230.4454-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In check_chunk_item() we search extent tree for block group item.

Refactor this part into a separate function, find_block_group_item(),
so that later skinny-bg-tree feature can reuse it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 74 ++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 821ebc57c8ed..dbb90895127d 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4499,6 +4499,50 @@ next:
 	return 0;
 }
 
+/*
+ * Find the block group item with @bytenr, @len and @type
+ *
+ * Return 0 if found.
+ * Return -ENOENT if not found.
+ * Return <0 for fatal error.
+ */
+static int find_block_group_item(struct btrfs_fs_info *fs_info,
+				 struct btrfs_path *path, u64 bytenr, u64 len,
+				 u64 type)
+{
+	struct btrfs_block_group_item bgi;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = bytenr;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = len;
+
+	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		ret = -ENOENT;
+		error("chunk [%llu %llu) doesn't have related block group item",
+		      bytenr, bytenr + len);
+		goto out;
+	}
+	read_extent_buffer(path->nodes[0], &bgi,
+			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+			sizeof(bgi));
+	if (btrfs_stack_block_group_flags(&bgi) != type) {
+		error(
+"chunk [%llu %llu) type mismatch with block group, block group has 0x%llx chunk has %llx",
+		      bytenr, bytenr + len, btrfs_stack_block_group_flags(&bgi),
+		      type);
+		ret = -EUCLEAN;
+	}
+
+out:
+	btrfs_release_path(path);
+	return ret;
+}
+
 /*
  * Check a chunk item.
  * Including checking all referred dev_extents and block group
@@ -4506,16 +4550,12 @@ next:
 static int check_chunk_item(struct btrfs_fs_info *fs_info,
 			    struct extent_buffer *eb, int slot)
 {
-	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_root *dev_root = fs_info->dev_root;
 	struct btrfs_path path;
 	struct btrfs_key chunk_key;
-	struct btrfs_key bg_key;
 	struct btrfs_key devext_key;
 	struct btrfs_chunk *chunk;
 	struct extent_buffer *leaf;
-	struct btrfs_block_group_item *bi;
-	struct btrfs_block_group_item bg_item;
 	struct btrfs_dev_extent *ptr;
 	u64 length;
 	u64 chunk_end;
@@ -4542,31 +4582,11 @@ static int check_chunk_item(struct btrfs_fs_info *fs_info,
 	}
 	type = btrfs_chunk_type(eb, chunk);
 
-	bg_key.objectid = chunk_key.offset;
-	bg_key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	bg_key.offset = length;
-
 	btrfs_init_path(&path);
-	ret = btrfs_search_slot(NULL, extent_root, &bg_key, &path, 0, 0);
-	if (ret) {
-		error(
-		"chunk[%llu %llu) did not find the related block group item",
-			chunk_key.offset, chunk_end);
+	ret = find_block_group_item(fs_info, &path, chunk_key.offset, length,
+				    type);
+	if (ret < 0)
 		err |= REFERENCER_MISSING;
-	} else{
-		leaf = path.nodes[0];
-		bi = btrfs_item_ptr(leaf, path.slots[0],
-				    struct btrfs_block_group_item);
-		read_extent_buffer(leaf, &bg_item, (unsigned long)bi,
-				   sizeof(bg_item));
-		if (btrfs_stack_block_group_flags(&bg_item) != type) {
-			error(
-"chunk[%llu %llu) related block group item flags mismatch, wanted: %llu, have: %llu",
-				chunk_key.offset, chunk_end, type,
-				btrfs_stack_block_group_flags(&bg_item));
-			err |= REFERENCER_MISSING;
-		}
-	}
 
 	num_stripes = btrfs_chunk_num_stripes(eb, chunk);
 	stripe_len = btrfs_stripe_length(fs_info, eb, chunk);
-- 
2.26.2

