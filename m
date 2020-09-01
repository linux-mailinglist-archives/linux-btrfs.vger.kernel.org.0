Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E052590E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgIAOlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 10:41:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:55620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgIAOkF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 10:40:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8DE4B5FD;
        Tue,  1 Sep 2020 14:40:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/5] btrfs: Eliminate total_size parameter from setup_items_for_insert
Date:   Tue,  1 Sep 2020 17:39:58 +0300
Message-Id: <20200901144001.4265-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901144001.4265-1-nborisov@suse.com>
References: <20200901144001.4265-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The value of this argument can be derived from the total_data as it's
simply the value of the data size + size of btrfs_items being touched.
Move the parameter calculation inside the function. This results in a
simpler interface and also a minor size reduction:

./scripts/bloat-o-meter ctree.original fs/btrfs/ctree.o
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-34 (-34)
Function                                     old     new   delta
btrfs_duplicate_item                         260     259      -1
setup_items_for_insert                      1200    1190     -10
btrfs_insert_empty_items                     177     154     -23

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c                     | 11 +++++------
 fs/btrfs/ctree.h                     |  2 +-
 fs/btrfs/delayed-inode.c             |  4 ++--
 fs/btrfs/file.c                      |  5 +----
 fs/btrfs/tests/extent-buffer-tests.c |  3 +--
 fs/btrfs/tests/inode-tests.c         |  6 ++----
 6 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0f325aaa5c1c..f14f728c4a5d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4571,9 +4571,7 @@ int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
 		return ret;
 
 	path->slots[0]++;
-	setup_items_for_insert(root, path, new_key, &item_size,
-			       item_size, item_size +
-			       sizeof(struct btrfs_item), 1);
+	setup_items_for_insert(root, path, new_key, &item_size, item_size, 1);
 	leaf = path->nodes[0];
 	memcpy_extent_buffer(leaf,
 			     btrfs_item_ptr_offset(leaf, path->slots[0]),
@@ -4753,7 +4751,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
  */
 void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 			    const struct btrfs_key *cpu_key, u32 *data_size,
-			    u32 total_data, u32 total_size, int nr)
+			    u32 total_data, int nr)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_item *item;
@@ -4764,6 +4762,8 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 	struct extent_buffer *leaf;
 	int slot;
 	struct btrfs_map_token token;
+	const u32 total_size = total_data + (nr * sizeof(struct btrfs_item));
+
 
 	if (path->slots[0] == 0) {
 		btrfs_cpu_key_to_disk(&disk_key, cpu_key);
@@ -4866,8 +4866,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	slot = path->slots[0];
 	BUG_ON(slot < 0);
 
-	setup_items_for_insert(root, path, cpu_key, data_size,
-			       total_data, total_size, nr);
+	setup_items_for_insert(root, path, cpu_key, data_size, total_data, nr);
 	return 0;
 }
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index af2bd059daae..ac53535412a6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2713,7 +2713,7 @@ static inline int btrfs_del_item(struct btrfs_trans_handle *trans,
 
 void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 			    const struct btrfs_key *cpu_key, u32 *data_size,
-			    u32 total_data, u32 total_size, int nr);
+			    u32 total_data, int nr);
 int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key, void *data, u32 data_size);
 int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0727b10a9a89..0360e07d1b0f 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -768,8 +768,8 @@ static int btrfs_batch_insert_items(struct btrfs_root *root,
 	}
 
 	/* insert the keys of the items */
-	setup_items_for_insert(root, path, keys, data_size,
-			       total_data_size, total_size, nitems);
+	setup_items_for_insert(root, path, keys, data_size, total_data_size,
+			       nitems);
 
 	/* insert the dir index items */
 	slot = path->slots[0];
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2cacb4424cd4..82f9bb78b86d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1057,10 +1057,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			if (btrfs_comp_cpu_keys(&key, &slot_key) > 0)
 				path->slots[0]++;
 		}
-		setup_items_for_insert(root, path, &key,
-				       &extent_item_size,
-				       extent_item_size,
-				       sizeof(struct btrfs_item) +
+		setup_items_for_insert(root, path, &key, &extent_item_size,
 				       extent_item_size, 1);
 		*key_inserted = 1;
 	}
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index a1b9f9b5978e..a792a1dfd6dd 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -60,8 +60,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	key.type = BTRFS_EXTENT_CSUM_KEY;
 	key.offset = 0;
 
-	setup_items_for_insert(root, path, &key, &value_len, value_len,
-			       value_len + sizeof(struct btrfs_item), 1);
+	setup_items_for_insert(root, path, &key, &value_len, value_len, 1);
 	item = btrfs_item_nr(0);
 	write_extent_buffer(eb, value, btrfs_item_ptr_offset(eb, 0),
 			    value_len);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 894a63a92236..068b6ef02cec 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -33,8 +33,7 @@ static void insert_extent(struct btrfs_root *root, u64 start, u64 len,
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = start;
 
-	setup_items_for_insert(root, &path, &key, &value_len, value_len,
-			       value_len + sizeof(struct btrfs_item), 1);
+	setup_items_for_insert(root, &path, &key, &value_len, value_len, 1);
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	btrfs_set_file_extent_generation(leaf, fi, 1);
 	btrfs_set_file_extent_type(leaf, fi, type);
@@ -64,8 +63,7 @@ static void insert_inode_item_key(struct btrfs_root *root)
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	setup_items_for_insert(root, &path, &key, &value_len, value_len,
-			       value_len + sizeof(struct btrfs_item), 1);
+	setup_items_for_insert(root, &path, &key, &value_len, value_len, 1);
 }
 
 /*
-- 
2.17.1

