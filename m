Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2D1554DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 10:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgBGJjL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 04:39:11 -0500
Received: from mail.synology.com ([211.23.38.101]:60826 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbgBGJjK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 04:39:10 -0500
From:   ethanwu <ethanwu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1581068348; bh=DN6oPp7/qubvcVXENAeo/CY33lD+jUMsajYXbkFyNXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MzYneM3kIqtdhf9HzOO98iogaX8T+yrbR16SqkxXD9iC0tS7WbnQbYFtkFrKbia1/
         yISAoSK8UGrc0aQ0N2kztW+8ZHuYQhEG28MQaHRLkcLtPSiYbMgvRKG9U6VOy+rv/2
         cqaFQQhft9chXKHvmp7ouX5pC7A949LB/fvPczmw=
To:     linux-btrfs@vger.kernel.org
Cc:     ethanwu <ethanwu@synology.com>
Subject: [PATCH 2/4] btrfs: backref, not adding refs from shared block when resolving normal backref
Date:   Fri,  7 Feb 2020 17:38:16 +0800
Message-Id: <20200207093818.23710-3-ethanwu@synology.com>
In-Reply-To: <20200207093818.23710-1-ethanwu@synology.com>
References: <20200207093818.23710-1-ethanwu@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All references from the block of SHARED_DATA_REF belong to that
shared block backref.

For example,
item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 95
    extent refs 24 gen 7302 flags DATA
    extent data backref root 257 objectid 260 offset 65536 count 5
    extent data backref root 258 objectid 265 offset 0 count 9
    shared data backref parent 394985472 count 10

block 394985472 might be leaf from root 257, and the item obejctid and
(file_pos - file_extent_item::offset) in that leaf just happends to be
260 and 65536 which is equal to the first extent data backref entry.

Before this patch, when we resolving backref:
root 257 objectid 260 offset 65536, we will add those refs in block
394985472 and wrongly treat those as the refs we want.

Fix this by checking if the leaf we are processing is shared data backref,
if so, just skip this leaf.

shared data refs added into preftrees.direct have all entry value = 0
(root_id = 0, key = NULL, level = 0) except parent entry.
Other refs from indirect tree will have key value and root id != 0, and
these value won't be changed when their parent is resolved and added to
preftrees.direct. Therefore, we could reuse the preftrees.direct
and search ref with all values = 0 except parent is set to avoid
getting those resolved refs block.

Signed-off-by: ethanwu <ethanwu@synology.com>
---
 fs/btrfs/backref.c | 61 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 1572eab3cc06..b4b68af48726 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -386,8 +386,34 @@ static int add_indirect_ref(const struct btrfs_fs_info *fs_info,
 			      wanted_disk_byte, count, sc, gfp_mask);
 }
 
+static int is_shared_data_backref(struct preftrees *preftrees, u64 bytenr)
+{
+	struct rb_node **p = &preftrees->direct.root.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct prelim_ref *ref = NULL;
+	struct prelim_ref target = {0};
+	int result;
+
+	target.parent = bytenr;
+
+	while (*p) {
+		parent = *p;
+		ref = rb_entry(parent, struct prelim_ref, rbnode);
+		result = prelim_ref_compare(ref, &target);
+
+		if (result < 0)
+			p = &(*p)->rb_left;
+		else if (result > 0)
+			p = &(*p)->rb_right;
+		else
+			return 1;
+	}
+	return 0;
+}
+
 static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
-			   struct ulist *parents, struct prelim_ref *ref,
+			   struct ulist *parents,
+			   struct preftrees *preftrees, struct prelim_ref *ref,
 			   int level, u64 time_seq, const u64 *extent_item_pos,
 			   u64 total_refs, bool ignore_offset)
 {
@@ -412,11 +438,16 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 	}
 
 	/*
-	 * We normally enter this function with the path already pointing to
-	 * the first item to check. But sometimes, we may enter it with
-	 * slot==nritems. In that case, go to the next leaf before we continue.
+	 * 1. We normally enter this function with the path already pointing to
+	 *    the first item to check. But sometimes, we may enter it with
+	 *    slot==nritems.
+	 * 2. We are searching for normal backref but bytenr of this leaf
+	 *    matches shared data backref
+	 * For these cases, go to the next leaf before we continue.
 	 */
-	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+	eb = path->nodes[0];
+	if (path->slots[0] >= btrfs_header_nritems(eb) ||
+		is_shared_data_backref(preftrees, eb->start)) {
 		if (time_seq == SEQ_LAST)
 			ret = btrfs_next_leaf(root, path);
 		else
@@ -433,6 +464,17 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 		    key.type != BTRFS_EXTENT_DATA_KEY)
 			break;
 
+		/*
+		 * We are searching for normal backref but bytenr of this
+		 * leaf matches shared data backref.
+		 */
+		if (slot == 0 && is_shared_data_backref(preftrees, eb->start)) {
+			if (time_seq == SEQ_LAST)
+				ret = btrfs_next_leaf(root, path);
+			else
+				ret = btrfs_next_old_leaf(root, path, time_seq);
+			continue;
+		}
 		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
 		data_offset = btrfs_file_extent_offset(eb, fi);
@@ -484,6 +526,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
  */
 static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, u64 time_seq,
+				struct preftrees *preftrees,
 				struct prelim_ref *ref, struct ulist *parents,
 				const u64 *extent_item_pos, u64 total_refs,
 				bool ignore_offset)
@@ -577,8 +620,8 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		eb = path->nodes[level];
 	}
 
-	ret = add_all_parents(root, path, parents, ref, level, time_seq,
-			      extent_item_pos, total_refs, ignore_offset);
+	ret = add_all_parents(root, path, parents, preftrees, ref, level,
+			      time_seq, extent_item_pos, total_refs, ignore_offset);
 out:
 	path->lowest_level = 0;
 	btrfs_release_path(path);
@@ -656,8 +699,8 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 			ret = BACKREF_FOUND_SHARED;
 			goto out;
 		}
-		err = resolve_indirect_ref(fs_info, path, time_seq, ref,
-					   parents, extent_item_pos,
+		err = resolve_indirect_ref(fs_info, path, time_seq, preftrees,
+					   ref, parents, extent_item_pos,
 					   total_refs, ignore_offset);
 		/*
 		 * we can only tolerate ENOENT,otherwise,we should catch error
-- 
2.17.1

