Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF51973C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfHUHnG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 03:43:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:35546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbfHUHnG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 03:43:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72699AFB6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 07:43:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/2] btrfs: Improve comments around nocow path
Date:   Wed, 21 Aug 2019 10:42:57 +0300
Message-Id: <20190821074257.22382-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805144708.5432-3-nborisov@suse.com>
References: <20190805144708.5432-3-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

run_delalloc_nocow contains numerous, somewhat subtle, checks when
figuring out whether a particular extent should be CoW'ed or not. This
patch explicitly states the assumptions those checks verify. As a
result also document 2 of the more subtle checks in check_committed_ref
as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2:
 * Use 'shared' instead of 'referenced' when referring to extents 
 * Clarify some comments in run_delalloc_nocow 

 fs/btrfs/extent-tree.c |  3 +++
 fs/btrfs/inode.c       | 50 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d3b58e388535..9895698cbde9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2963,16 +2963,19 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 
+	/* If extent item has more than 1 inline ref then it's shared*/
 	if (item_size != sizeof(*ei) +
 	    btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
 		goto out;
 
+	/* If extent created before last snapshot => it's definitely shared */
 	if (btrfs_extent_generation(leaf, ei) <=
 	    btrfs_root_last_snapshot(&root->root_item))
 		goto out;
 
 	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
 
+	/* If this extent has SHARED_DATA_REF then it's shared */
 	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 	if (type != BTRFS_EXTENT_DATA_REF_KEY)
 		goto out;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fc6a8f9abb40..223d424532fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1355,6 +1355,12 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 					       cur_offset, 0);
 		if (ret < 0)
 			goto error;
+
+		/*
+		 * If there is no extent for our range when doing the initial
+		 * search, then go back to the previous slot as it will be the
+		 * one containing the search offset
+		 */
 		if (ret > 0 && path->slots[0] > 0 && check_prev) {
 			leaf = path->nodes[0];
 			btrfs_item_key_to_cpu(leaf, &found_key,
@@ -1365,6 +1371,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		}
 		check_prev = false;
 next_slot:
+		/* Go to next leaf if we have exhausted the current one */
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
@@ -1380,23 +1387,39 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 
+		/* Didn't find anything for our INO */
 		if (found_key.objectid > ino)
 			break;
+		/*
+		 * Keep searching until we find an EXTENT_ITEM or there are no
+		 * more extents for this inode
+		 */
 		if (WARN_ON_ONCE(found_key.objectid < ino) ||
 		    found_key.type < BTRFS_EXTENT_DATA_KEY) {
 			path->slots[0]++;
 			goto next_slot;
 		}
+
+		/* Found key is not EXTENT_DATA_KEY or starts after req range */
 		if (found_key.type > BTRFS_EXTENT_DATA_KEY ||
 		    found_key.offset > end)
 			break;
 
+		/*
+		 * If the found extent starts after requested offset, then
+		 * adjust extent_end to be right before this extent begins
+		 */
 		if (found_key.offset > cur_offset) {
 			extent_end = found_key.offset;
 			extent_type = 0;
 			goto out_check;
 		}
 
+
+		/*
+		 * Found extent which begins before our range and potentially
+		 * intersect it.
+		 */
 		fi = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_file_extent_item);
 		extent_type = btrfs_file_extent_type(leaf, fi);
@@ -1410,19 +1433,28 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				btrfs_file_extent_num_bytes(leaf, fi);
 			disk_num_bytes =
 				btrfs_file_extent_disk_num_bytes(leaf, fi);
+			/*
+			 * If extent we got ends before our range starts,
+			 * skip to next extent
+			 */
 			if (extent_end <= start) {
 				path->slots[0]++;
 				goto next_slot;
 			}
+			/* skip holes */
 			if (disk_bytenr == 0)
 				goto out_check;
+			/* skip compressed/encrypted/encoded extents */
 			if (btrfs_file_extent_compression(leaf, fi) ||
 			    btrfs_file_extent_encryption(leaf, fi) ||
 			    btrfs_file_extent_other_encoding(leaf, fi))
 				goto out_check;
 			/*
-			 * Do the same check as in btrfs_cross_ref_exist but
-			 * without the unnecessary search.
+			 * If extent is created before the last volume's snapshot
+			 * this implies the extent is shared, hence we can't do
+			 * nocow. This is the same check as in
+			 * btrfs_cross_ref_exist but without calling
+			 * btrfs_search_slot.
 			 */
 			if (!freespace_inode &&
 			    btrfs_file_extent_generation(leaf, fi) <=
@@ -1430,6 +1462,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				goto out_check;
 			if (extent_type == BTRFS_FILE_EXTENT_REG && !force)
 				goto out_check;
+			/* If extent RO, we must CoW it */
 			if (btrfs_extent_readonly(fs_info, disk_bytenr))
 				goto out_check;
 			ret = btrfs_cross_ref_exist(root, ino,
@@ -1453,7 +1486,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			disk_bytenr += cur_offset - found_key.offset;
 			num_bytes = min(end + 1, extent_end) - cur_offset;
 			/*
-			 * if there are pending snapshots for this root,
+			 * If there are pending snapshots for this root,
 			 * we fall into common COW way.
 			 */
 			if (!freespace_inode && atomic_read(&root->snapshot_force_cow))
@@ -1490,12 +1523,17 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			BUG();
 		}
 out_check:
+		/* Skip extents outside of our requested range */
 		if (extent_end <= start) {
 			path->slots[0]++;
 			if (nocow)
 				btrfs_dec_nocow_writers(fs_info, disk_bytenr);
 			goto next_slot;
 		}
+		/*
+		 * If nocow is false then record the beginning of the range
+		 * that needs to be CoWed
+		 */
 		if (!nocow) {
 			if (cow_start == (u64)-1)
 				cow_start = cur_offset;
@@ -1507,6 +1545,12 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		}
 
 		btrfs_release_path(path);
+
+		/*
+		 * CoW range from cow_start to found_key.offset - 1. As the key
+		 * will contains the beginning of the first extent that can be
+		 * NOCOW, following one which needs to be CoW'ed
+		 */
 		if (cow_start != (u64)-1) {
 			ret = cow_file_range(inode, locked_page,
 					     cow_start, found_key.offset - 1,
-- 
2.17.1

