Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB33E24D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbhHFINM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41124 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbhHFINL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61EF120264
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPrEJ/Xuq6q8WDFh0+63GD9vtBTxqY6/Nd3TzLQQDms=;
        b=AIzCYNIhxPkxUQeisa78WsBCM0T7JTfbb8hbBjMogt/WbrjTAvMjuz2wjvjcyv5Rnd15dF
        hQLRXrY9Wbv9HMJegaqkzKYSSfMYWhIVj052JlaPA5MMsxwrXIUo56vuHSna7S1sNYudyu
        0jQuAhdZrQqxHwG7u5/28PoIpvU/HQ8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9D4ED1399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eKR7FwbvDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 07/11] btrfs: defrag: introduce a helper to defrag a range
Date:   Fri,  6 Aug 2021 16:12:38 +0800
Message-Id: <20210806081242.257996-8-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
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
 fs/btrfs/ioctl.c | 105 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a21c4c09269a..2f7196f9bd65 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1081,7 +1081,8 @@ static int find_new_extents(struct btrfs_root *root,
 	return -ENOENT;
 }
 
-static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
+static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
+					       bool locked)
 {
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
@@ -1101,10 +1102,12 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
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
@@ -1113,7 +1116,8 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
 	return em;
 }
 
-static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em)
+static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
+				     bool locked)
 {
 	struct extent_map *next;
 	bool ret = true;
@@ -1122,7 +1126,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em)
 	if (em->start + em->len >= i_size_read(inode))
 		return false;
 
-	next = defrag_lookup_extent(inode, em->start + em->len);
+	next = defrag_lookup_extent(inode, em->start + em->len, locked);
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
 		ret = false;
 	else if ((em->block_start + em->block_len == next->block_start) &&
@@ -1151,7 +1155,7 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 
 	*skip = 0;
 
-	em = defrag_lookup_extent(inode, start);
+	em = defrag_lookup_extent(inode, start, false);
 	if (!em)
 		return 0;
 
@@ -1164,7 +1168,7 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 	if (!*defrag_end)
 		prev_mergeable = false;
 
-	next_mergeable = defrag_check_next_extent(inode, em);
+	next_mergeable = defrag_check_next_extent(inode, em, false);
 	/*
 	 * we hit a real extent, if it is big or the next extent is not a
 	 * real extent, don't bother defragging it
@@ -1445,12 +1449,13 @@ struct defrag_target_range {
  * @do_compress:   Whether the defrag is doing compression
  *		   If true, @extent_thresh will be ignored and all regular
  *		   file extents meeting @newer_than will be targets.
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
@@ -1461,7 +1466,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		bool next_mergeable = true;
 		u64 range_len;
 
-		em = defrag_lookup_extent(&inode->vfs_inode, cur);
+		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
 		if (!em)
 			break;
 
@@ -1485,7 +1490,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (em->len >= extent_thresh)
 			goto next;
 
-		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em);
+		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
+							  locked);
 		if (!next_mergeable) {
 			struct defrag_target_range *last;
 
@@ -1603,6 +1609,85 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
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
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
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
+	for (i = 0; i < nr_pages; i++)
+		wait_on_page_writeback(pages[i]);
+
+	/* Also lock the pages range */
+	lock_extent_bits(&inode->io_tree, start_index << PAGE_SHIFT,
+			 (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+			 &cached_state);
+	/*
+	 * Now we have a consistent view about the extent map, re-check
+	 * which range really needs to be defragged.
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
2.32.0

