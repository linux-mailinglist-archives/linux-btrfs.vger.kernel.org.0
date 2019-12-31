Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622A412D6C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 08:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLaHMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 02:12:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfLaHM3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 02:12:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3B55AD12
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:12:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs-progs: check: Populate extent generation correctly for data extents
Date:   Tue, 31 Dec 2019 15:12:17 +0800
Message-Id: <20191231071220.32935-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231071220.32935-1-wqu@suse.com>
References: <20191231071220.32935-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When using `btrfs check --init-extent-tree`, we will create incorrect
generation number for data extents in extent tree:

        item 10 key (13631488 EXTENT_ITEM 1048576) itemoff 15828 itemsize 53
                refs 1 gen 0 flags DATA
                extent data backref root FS_TREE objectid 257 offset 0 count 1

[CAUSE]
Since data extent generation is not as obvious as tree blocks, which has
header containing its generations, so for data extents, its
extent_record::generation is not really updated, resulting such 0
generation.

[FIX]
To get generation of a data extent, there are two sources we can rely:
- EXTENT_ITEM
  There is always a btrfs_extent_item::generation can be utilized.
  Although this is not possible for --init-extent-tree use case.

- EXTENT_DATA
  We have btrfs_file_extent_item::generation for regular and
  preallocated data extents.
  Since --init-extent-tree will go through subvolume trees, this would
  be the main source for extent data generation.

Then we only need to make add_data_backref() to accept @gen parameter,
and pass it down to extent_record structure.

And for the final extent item generation update, here we add extra
fallback values, if we can't find FILE_EXTENT items.
In that case, we just fall back to current transid.

With this modification, recreated data EXTENT_ITEM now has correct
generation number:

        item 10 key (13631488 EXTENT_ITEM 1048576) itemoff 15828 itemsize 53
                refs 1 gen 6 flags DATA
                extent data backref root FS_TREE objectid 257 offset 0 count 1

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/check/main.c b/check/main.c
index 2dbed091..88b174ab 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4810,7 +4810,7 @@ static int add_tree_backref(struct cache_tree *extent_cache, u64 bytenr,
 
 static int add_data_backref(struct cache_tree *extent_cache, u64 bytenr,
 			    u64 parent, u64 root, u64 owner, u64 offset,
-			    u32 num_refs, int found_ref, u64 max_size)
+			    u32 num_refs, u64 gen, int found_ref, u64 max_size)
 {
 	struct extent_record *rec;
 	struct data_backref *back;
@@ -4826,6 +4826,7 @@ static int add_data_backref(struct cache_tree *extent_cache, u64 bytenr,
 		tmpl.start = bytenr;
 		tmpl.nr = 1;
 		tmpl.max_size = max_size;
+		tmpl.generation = gen;
 
 		ret = add_extent_rec_nolookup(extent_cache, &tmpl);
 		if (ret)
@@ -4840,6 +4841,8 @@ static int add_data_backref(struct cache_tree *extent_cache, u64 bytenr,
 	if (rec->max_size < max_size)
 		rec->max_size = max_size;
 
+	if (rec->generation < gen)
+		rec->generation = gen;
 	/*
 	 * If found_ref is set then max_size is the real size and must match the
 	 * existing refs.  So if we have already found a ref then we need to
@@ -5315,6 +5318,7 @@ static int process_extent_item(struct btrfs_root *root,
 	u64 refs = 0;
 	u64 offset;
 	u64 num_bytes;
+	u64 gen;
 	int metadata = 0;
 
 	btrfs_item_key_to_cpu(eb, &key, slot);
@@ -5340,6 +5344,7 @@ static int process_extent_item(struct btrfs_root *root,
 
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
 	refs = btrfs_extent_refs(eb, ei);
+	gen = btrfs_extent_generation(eb, ei);
 	if (btrfs_extent_flags(eb, ei) & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 		metadata = 1;
 	else
@@ -5362,6 +5367,7 @@ static int process_extent_item(struct btrfs_root *root,
 	tmpl.metadata = metadata;
 	tmpl.found_rec = 1;
 	tmpl.max_size = num_bytes;
+	tmpl.generation = gen;
 	add_extent_rec(extent_cache, &tmpl);
 
 	ptr = (unsigned long)(ei + 1);
@@ -5401,14 +5407,14 @@ static int process_extent_item(struct btrfs_root *root,
 								       dref),
 					btrfs_extent_data_ref_offset(eb, dref),
 					btrfs_extent_data_ref_count(eb, dref),
-					0, num_bytes);
+					gen, 0, num_bytes);
 			break;
 		case BTRFS_SHARED_DATA_REF_KEY:
 			sref = (struct btrfs_shared_data_ref *)(iref + 1);
 			add_data_backref(extent_cache, key.objectid, offset,
 					0, 0, 0,
 					btrfs_shared_data_ref_count(eb, sref),
-					0, num_bytes);
+					gen, 0, num_bytes);
 			break;
 		default:
 			fprintf(stderr,
@@ -6352,7 +6358,7 @@ static int run_next_block(struct btrfs_root *root,
 								       ref),
 					btrfs_extent_data_ref_offset(buf, ref),
 					btrfs_extent_data_ref_count(buf, ref),
-					0, root->fs_info->sectorsize);
+					0, 0, root->fs_info->sectorsize);
 				continue;
 			}
 			if (key.type == BTRFS_SHARED_DATA_REF_KEY) {
@@ -6363,7 +6369,7 @@ static int run_next_block(struct btrfs_root *root,
 				add_data_backref(extent_cache,
 					key.objectid, key.offset, 0, 0, 0,
 					btrfs_shared_data_ref_count(buf, ref),
-					0, root->fs_info->sectorsize);
+					0, 0, root->fs_info->sectorsize);
 				continue;
 			}
 			if (key.type == BTRFS_ORPHAN_ITEM_KEY) {
@@ -6403,7 +6409,8 @@ static int run_next_block(struct btrfs_root *root,
 			add_data_backref(extent_cache,
 				btrfs_file_extent_disk_bytenr(buf, fi),
 				parent, owner, key.objectid, key.offset -
-				btrfs_file_extent_offset(buf, fi), 1, 1,
+				btrfs_file_extent_offset(buf, fi), 1,
+				btrfs_file_extent_generation(buf, fi), 1,
 				btrfs_file_extent_disk_num_bytes(buf, fi));
 		}
 	} else {
@@ -6706,7 +6713,10 @@ static int record_extent(struct btrfs_trans_handle *trans,
 				    struct btrfs_extent_item);
 
 		btrfs_set_extent_refs(leaf, ei, 0);
-		btrfs_set_extent_generation(leaf, ei, rec->generation);
+		if (rec->generation)
+			btrfs_set_extent_generation(leaf, ei, rec->generation);
+		else
+			btrfs_set_extent_generation(leaf, ei, trans->transid);
 
 		if (back->is_data) {
 			btrfs_set_extent_flags(leaf, ei,
-- 
2.24.1

