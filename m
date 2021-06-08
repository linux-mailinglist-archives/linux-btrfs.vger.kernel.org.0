Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1062239EC80
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 05:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFHDBg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 23:01:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41362 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFHDBe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 23:01:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 11136219C1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623121182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4RvslrLObo8o1Q7UxH6C6Xkn+7syqZ1DWElieLUmkq0=;
        b=WhNXT9taYx64HGYHMGiEZ+B8vWyvvBizZwoMHsvgl3IJBsMy5thn2yuk4v7552/+A4j/ej
        fwzUFKJjRJE8Vj7o+B9NohgxoTuRYHtMr0FRp3F2mjVdy+TZtXMezir8sioj6pnX79uLBH
        iypp9QFjuhx8em4P1zg0QTvTrib4VdQ=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 0EC16A3B81
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 06/10] btrfs: defrag: introduce a helper to defrag a range
Date:   Tue,  8 Jun 2021 10:59:23 +0800
Message-Id: <20210608025927.119169-7-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608025927.119169-1-wqu@suse.com>
References: <20210608025927.119169-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new helper, defrag_one_range(), is introduced to defrag one range.

This function will mostly prepare the needed pages and extent status for
defrag_one_locked_target().

As we can only have a consistent view of extent map with page and
extent bits locked, we need to re-check the range passed in to get a
real target list for defrag_one_locked_target().

Since defrag_collect_targets() will call defrag_lookup_extent() and lock
extent range, we also need to teach those two functions to skip extent
lock.
Thus new parameter, @locked, is introruced to skip extent lock if the
caller has already locked the range.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 94 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 42e757dfdd7b..8259ad102469 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1033,7 +1033,8 @@ static int find_new_extents(struct btrfs_root *root,
 	return -ENOENT;
 }
 
-static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
+static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
+					       bool locked)
 {
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
@@ -1053,10 +1054,12 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
 		u64 end = start + sectorsize - 1;
 
 		/* get the big lock and read metadata off disk */
-		lock_extent_bits(io_tree, start, end, &cached);
+		if (!locked)
+			lock_extent_bits(io_tree, start, end, &cached);
 		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
 				      sectorsize);
-		unlock_extent_cached(io_tree, start, end, &cached);
+		if (!locked)
+			unlock_extent_cached(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
 			return NULL;
@@ -1074,7 +1077,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em)
 	if (em->start + em->len >= i_size_read(inode))
 		return false;
 
-	next = defrag_lookup_extent(inode, em->start + em->len);
+	next = defrag_lookup_extent(inode, em->start + em->len, false);
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
 		ret = false;
 	else if ((em->block_start + em->block_len == next->block_start) &&
@@ -1103,7 +1106,7 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 
 	*skip = 0;
 
-	em = defrag_lookup_extent(inode, start);
+	em = defrag_lookup_extent(inode, start, false);
 	if (!em)
 		return 0;
 
@@ -1390,12 +1393,13 @@ struct defrag_target_range {
  * @do_compress:   Whether the defrag is doing compression
  * 		   If true, @extent_thresh will be ignored and all regular
  * 		   file extents meeting @newer_than will be targets.
+ * @locked:	   If the range has already hold extent lock
  * @target_list:   The list of targets file extents
  */
 static int defrag_collect_targets(struct btrfs_inode *inode,
 				  u64 start, u64 len, u32 extent_thresh,
 				  u64 newer_than, bool do_compress,
-				  struct list_head *target_list)
+				  bool locked, struct list_head *target_list)
 {
 	u64 cur = start;
 	int ret = 0;
@@ -1406,7 +1410,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		bool next_mergeable = true;
 		u64 range_len;
 
-		em = defrag_lookup_extent(&inode->vfs_inode, cur);
+		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
 		if (!em)
 			break;
 
@@ -1548,6 +1552,82 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	return ret;
 }
 
+static int defrag_one_range(struct btrfs_inode *inode,
+			    u64 start, u32 len,
+			    u32 extent_thresh, u64 newer_than,
+			    bool do_compress)
+{
+	struct extent_state *cached_state = NULL;
+	struct defrag_target_range *entry;
+	struct defrag_target_range *tmp;
+	LIST_HEAD(target_list);
+	struct page **pages;
+	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
+	unsigned long start_index = start >> PAGE_SHIFT;
+	unsigned int nr_pages = last_index - start_index + 1;
+	int ret = 0;
+	int i;
+
+	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
+	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
+
+	pages = kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+
+	/* Prepare all pages */
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = defrag_prepare_one_page(inode, start_index + i);
+		if (IS_ERR(pages[i])) {
+			ret = PTR_ERR(pages[i]);
+			pages[i] = NULL;
+			goto free_pages;
+		}
+	}
+	/* Also lock the pages range */
+	lock_extent_bits(&inode->io_tree, start_index << PAGE_SHIFT,
+			 (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+			 &cached_state);
+	/*
+	 * Now we have a consistent view about the extent map, re-check
+	 * which range really need to be defraged.
+	 *
+	 * And this time we have extent locked already, pass @locked = true
+	 * so that we won't re-lock the extent range and cause deadlock.
+	 */
+	ret = defrag_collect_targets(inode, start, len, extent_thresh,
+				     newer_than, do_compress, true,
+				     &target_list);
+	if (ret < 0)
+		goto unlock_extent;
+
+	list_for_each_entry(entry, &target_list, list) {
+		ret = defrag_one_locked_target(inode, entry, pages, nr_pages,
+					       &cached_state);
+		if (ret < 0)
+			break;
+	}
+
+	list_for_each_entry_safe(entry, tmp, &target_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+unlock_extent:
+	unlock_extent_cached(&inode->io_tree, start_index << PAGE_SHIFT,
+			     (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+			     &cached_state);
+free_pages:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i]) {
+			unlock_page(pages[i]);
+			put_page(pages[i]);
+		}
+	}
+	kfree(pages);
+	return ret;
+}
+
 /*
  * Btrfs entrace for defrag.
  *
-- 
2.31.1

