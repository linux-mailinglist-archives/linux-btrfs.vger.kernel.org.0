Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DD1554DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 10:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGJjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 04:39:10 -0500
Received: from mail.synology.com ([211.23.38.101]:60722 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbgBGJjJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 04:39:09 -0500
From:   ethanwu <ethanwu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1581068347; bh=h8uXtPYS6sUt5T5icoksnayKUL2jbL9d1RE/0ZidOZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Pw7KXGPUDotrM9IWhHH5uHmmrCCYlzDMR++96OvfvGCZGE7JFY4E2jf1czqbKoir/
         6wfD9/O9+zLHWK9KZZryez3fhWwqwujIwuF+8WExM94BuxQ10n8q+7Gv6E4bPFTr3T
         cbkvVZteV5rjFFGomABCCzj70+gw62blbNDPp9Q4=
To:     linux-btrfs@vger.kernel.org
Cc:     ethanwu <ethanwu@synology.com>
Subject: [PATCH 1/4] btrfs: backref, only collect file extent items matching backref offset
Date:   Fri,  7 Feb 2020 17:38:15 +0800
Message-Id: <20200207093818.23710-2-ethanwu@synology.com>
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

When resolving one backref of type EXTENT_DATA_REF, we collect all
references that simply references the EXTENT_ITEM even though
their (file_pos- file_extent_item::offset) are not the same as the
btrfs_extent_data_ref::offset we are searching.

This patch add additional check so that we only collect references whose
(file_pos- file_extent_item::offset) == btrfs_extent_data_ref::offset.

Signed-off-by: ethanwu <ethanwu@synology.com>
---
 fs/btrfs/backref.c | 63 ++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e5d85311d5d5..1572eab3cc06 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -347,33 +347,10 @@ static int add_prelim_ref(const struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	ref->root_id = root_id;
-	if (key) {
+	if (key)
 		ref->key_for_search = *key;
-		/*
-		 * We can often find data backrefs with an offset that is too
-		 * large (>= LLONG_MAX, maximum allowed file offset) due to
-		 * underflows when subtracting a file's offset with the data
-		 * offset of its corresponding extent data item. This can
-		 * happen for example in the clone ioctl.
-		 * So if we detect such case we set the search key's offset to
-		 * zero to make sure we will find the matching file extent item
-		 * at add_all_parents(), otherwise we will miss it because the
-		 * offset taken form the backref is much larger then the offset
-		 * of the file extent item. This can make us scan a very large
-		 * number of file extent items, but at least it will not make
-		 * us miss any.
-		 * This is an ugly workaround for a behaviour that should have
-		 * never existed, but it does and a fix for the clone ioctl
-		 * would touch a lot of places, cause backwards incompatibility
-		 * and would not fix the problem for extents cloned with older
-		 * kernels.
-		 */
-		if (ref->key_for_search.type == BTRFS_EXTENT_DATA_KEY &&
-		    ref->key_for_search.offset >= LLONG_MAX)
-			ref->key_for_search.offset = 0;
-	} else {
+	else
 		memset(&ref->key_for_search, 0, sizeof(ref->key_for_search));
-	}
 
 	ref->inode_list = NULL;
 	ref->level = level;
@@ -424,6 +401,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 	u64 disk_byte;
 	u64 wanted_disk_byte = ref->wanted_disk_byte;
 	u64 count = 0;
+	u64 data_offset;
 
 	if (level != 0) {
 		eb = path->nodes[level];
@@ -457,11 +435,15 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 
 		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
+		data_offset = btrfs_file_extent_offset(eb, fi);
 
 		if (disk_byte == wanted_disk_byte) {
 			eie = NULL;
 			old = NULL;
-			count++;
+			if (ref->key_for_search.offset == key.offset - data_offset)
+				count++;
+			else
+				goto next;
 			if (extent_item_pos) {
 				ret = check_extent_in_eb(&key, eb, fi,
 						*extent_item_pos,
@@ -513,6 +495,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	int root_level;
 	int level = ref->level;
 	int index;
+	struct btrfs_key search_key = ref->key_for_search;
 
 	root_key.objectid = ref->root_id;
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
@@ -545,13 +528,33 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
+	/*
+	 * We can often find data backrefs with an offset that is too
+	 * large (>= LLONG_MAX, maximum allowed file offset) due to
+	 * underflows when subtracting a file's offset with the data
+	 * offset of its corresponding extent data item. This can
+	 * happen for example in the clone ioctl.
+	 * So if we detect such case we set the search key's offset to
+	 * zero to make sure we will find the matching file extent item
+	 * at add_all_parents(), otherwise we will miss it because the
+	 * offset taken form the backref is much larger then the offset
+	 * of the file extent item. This can make us scan a very large
+	 * number of file extent items, but at least it will not make
+	 * us miss any.
+	 * This is an ugly workaround for a behaviour that should have
+	 * never existed, but it does and a fix for the clone ioctl
+	 * would touch a lot of places, cause backwards incompatibility
+	 * and would not fix the problem for extents cloned with older
+	 * kernels.
+	 */
+	if (search_key.type == BTRFS_EXTENT_DATA_KEY &&
+	    search_key.offset >= LLONG_MAX)
+		search_key.offset = 0;
 	path->lowest_level = level;
 	if (time_seq == SEQ_LAST)
-		ret = btrfs_search_slot(NULL, root, &ref->key_for_search, path,
-					0, 0);
+		ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	else
-		ret = btrfs_search_old_slot(root, &ref->key_for_search, path,
-					    time_seq);
+		ret = btrfs_search_old_slot(root, &search_key, path, time_seq);
 
 	/* root node has been locked, we can release @subvol_srcu safely here */
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
-- 
2.17.1

