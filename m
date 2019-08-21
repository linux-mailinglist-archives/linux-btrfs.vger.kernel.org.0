Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB52973BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 09:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfHUHmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 03:42:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:35394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbfHUHmI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 03:42:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B5E8AFB6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 07:42:06 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/2] btrfs: Refactor run_delalloc_nocow
Date:   Wed, 21 Aug 2019 10:42:03 +0300
Message-Id: <20190821074203.22329-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805144708.5432-2-nborisov@suse.com>
References: <20190805144708.5432-2-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Of the 22 (!!!) local variables declared in this function only 9 have
function-wide context. Of the remaining 13, 12 are needed in the main
while loop of the function and 1 is needed in a tiny if branch, only in
case we have prealloc extent. This commit reduces the lifespan of every
variable to its bare minimum. It also renames the 'nolock'boolean to
freespace_inode to clearly indicate its purpose.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2: 
 * Don't add comment before assignment of prev_check

 fs/btrfs/inode.c | 61 ++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ee582a36653d..fc6a8f9abb40 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1310,30 +1310,18 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
  */
 static noinline int run_delalloc_nocow(struct inode *inode,
 				       struct page *locked_page,
-			      u64 start, u64 end, int *page_started, int force,
-			      unsigned long *nr_written)
+				       const u64 start, const u64 end,
+				       int *page_started, int force,
+				       unsigned long *nr_written)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct extent_buffer *leaf;
 	struct btrfs_path *path;
-	struct btrfs_file_extent_item *fi;
-	struct btrfs_key found_key;
-	struct extent_map *em;
-	u64 cow_start;
-	u64 cur_offset;
-	u64 extent_end;
-	u64 extent_offset;
-	u64 disk_bytenr;
-	u64 num_bytes;
-	u64 disk_num_bytes;
-	u64 ram_bytes;
-	int extent_type;
+	u64 cow_start = (u64)-1;
+	u64 cur_offset = start;
 	int ret;
-	int type;
-	int nocow;
-	int check_prev = 1;
-	bool nolock;
+	bool check_prev = true;
+	bool freespace_inode = btrfs_is_free_space_inode(BTRFS_I(inode));
 	u64 ino = btrfs_ino(BTRFS_I(inode));
 
 	path = btrfs_alloc_path();
@@ -1349,11 +1337,20 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		return -ENOMEM;
 	}
 
-	nolock = btrfs_is_free_space_inode(BTRFS_I(inode));
-
-	cow_start = (u64)-1;
-	cur_offset = start;
 	while (1) {
+		struct btrfs_key found_key;
+		struct btrfs_file_extent_item *fi;
+		struct extent_buffer *leaf;
+		u64 extent_end;
+		u64 extent_offset;
+		u64 disk_bytenr = 0;
+		u64 num_bytes = 0;
+		u64 disk_num_bytes;
+		int type;
+		u64 ram_bytes;
+		int extent_type;
+		bool nocow = false;
+
 		ret = btrfs_lookup_file_extent(NULL, root, path, ino,
 					       cur_offset, 0);
 		if (ret < 0)
@@ -1366,7 +1363,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			    found_key.type == BTRFS_EXTENT_DATA_KEY)
 				path->slots[0]--;
 		}
-		check_prev = 0;
+		check_prev = false;
 next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
@@ -1381,9 +1378,6 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			leaf = path->nodes[0];
 		}
 
-		nocow = 0;
-		disk_bytenr = 0;
-		num_bytes = 0;
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 
 		if (found_key.objectid > ino)
@@ -1430,7 +1424,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			 * Do the same check as in btrfs_cross_ref_exist but
 			 * without the unnecessary search.
 			 */
-			if (!nolock &&
+			if (!freespace_inode &&
 			    btrfs_file_extent_generation(leaf, fi) <=
 			    btrfs_root_last_snapshot(&root->root_item))
 				goto out_check;
@@ -1452,7 +1446,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 					goto error;
 				}
 
-				WARN_ON_ONCE(nolock);
+				WARN_ON_ONCE(freespace_inode);
 				goto out_check;
 			}
 			disk_bytenr += extent_offset;
@@ -1462,7 +1456,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			 * if there are pending snapshots for this root,
 			 * we fall into common COW way.
 			 */
-			if (!nolock && atomic_read(&root->snapshot_force_cow))
+			if (!freespace_inode && atomic_read(&root->snapshot_force_cow))
 				goto out_check;
 			/*
 			 * force cow if csum exists in the range.
@@ -1481,12 +1475,12 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 						cur_offset = cow_start;
 					goto error;
 				}
-				WARN_ON_ONCE(nolock);
+				WARN_ON_ONCE(freespace_inode);
 				goto out_check;
 			}
 			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
 				goto out_check;
-			nocow = 1;
+			nocow = true;
 		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 			extent_end = found_key.offset +
 				btrfs_file_extent_ram_bytes(leaf, fi);
@@ -1529,6 +1523,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 
 		if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 			u64 orig_start = found_key.offset - extent_offset;
+			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset, num_bytes,
 					  orig_start,
@@ -1554,7 +1549,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		}
 
 		ret = btrfs_add_ordered_extent(inode, cur_offset, disk_bytenr,
-					       num_bytes, num_bytes, type);
+					       num_bytes, num_bytes,type);
 		if (nocow)
 			btrfs_dec_nocow_writers(fs_info, disk_bytenr);
 		BUG_ON(ret); /* -ENOMEM */
-- 
2.17.1

