Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE039EC83
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 05:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhFHDBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 23:01:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFHDBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 23:01:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2FC69219C1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623121188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXY6ZLKmQ38jQhM5NNR4DaE8ZCx2uS6AjLx38ohNeZI=;
        b=BsMoBCIeucBuyu2ja4OeXnKHNy0LonP1yqUWDAxmWzSNSM0o5qa+r3le5f8kL1xCOBBU0U
        ZGaWusFbkIWSa4DwPru4PgWEtdOQR9+WzjnObEWyJaQLensYTtVfHZ53mvgvXVjGbeibdH
        6ieeRQdB/otMh0rgwoAcnaDuRnoKwuY=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 00766A3B8D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 09/10] btrfs: defrag: remove the old infrastructure
Date:   Tue,  8 Jun 2021 10:59:26 +0800
Message-Id: <20210608025927.119169-10-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608025927.119169-1-wqu@suse.com>
References: <20210608025927.119169-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now the old infrastructure can all be removed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 305 -----------------------------------------------
 1 file changed, 305 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 709e2d23b74d..6de1293da45f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -933,106 +933,6 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 	return ret;
 }
 
-/*
- * When we're defragging a range, we don't want to kick it off again
- * if it is really just waiting for delalloc to send it down.
- * If we find a nice big extent or delalloc range for the bytes in the
- * file you want to defrag, we return 0 to let you know to skip this
- * part of the file
- */
-static int check_defrag_in_cache(struct inode *inode, u64 offset, u32 thresh)
-{
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct extent_map *em = NULL;
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
-	u64 end;
-
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, offset, PAGE_SIZE);
-	read_unlock(&em_tree->lock);
-
-	if (em) {
-		end = extent_map_end(em);
-		free_extent_map(em);
-		if (end - offset > thresh)
-			return 0;
-	}
-	/* if we already have a nice delalloc here, just stop */
-	thresh /= 2;
-	end = count_range_bits(io_tree, &offset, offset + thresh,
-			       thresh, EXTENT_DELALLOC, 1);
-	if (end >= thresh)
-		return 0;
-	return 1;
-}
-
-/*
- * helper function to walk through a file and find extents
- * newer than a specific transid, and smaller than thresh.
- *
- * This is used by the defragging code to find new and small
- * extents
- */
-static int find_new_extents(struct btrfs_root *root,
-			    struct inode *inode, u64 newer_than,
-			    u64 *off, u32 thresh)
-{
-	struct btrfs_path *path;
-	struct btrfs_key min_key;
-	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *extent;
-	int type;
-	int ret;
-	u64 ino = btrfs_ino(BTRFS_I(inode));
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	min_key.objectid = ino;
-	min_key.type = BTRFS_EXTENT_DATA_KEY;
-	min_key.offset = *off;
-
-	while (1) {
-		ret = btrfs_search_forward(root, &min_key, path, newer_than);
-		if (ret != 0)
-			goto none;
-process_slot:
-		if (min_key.objectid != ino)
-			goto none;
-		if (min_key.type != BTRFS_EXTENT_DATA_KEY)
-			goto none;
-
-		leaf = path->nodes[0];
-		extent = btrfs_item_ptr(leaf, path->slots[0],
-					struct btrfs_file_extent_item);
-
-		type = btrfs_file_extent_type(leaf, extent);
-		if (type == BTRFS_FILE_EXTENT_REG &&
-		    btrfs_file_extent_num_bytes(leaf, extent) < thresh &&
-		    check_defrag_in_cache(inode, min_key.offset, thresh)) {
-			*off = min_key.offset;
-			btrfs_free_path(path);
-			return 0;
-		}
-
-		path->slots[0]++;
-		if (path->slots[0] < btrfs_header_nritems(leaf)) {
-			btrfs_item_key_to_cpu(leaf, &min_key, path->slots[0]);
-			goto process_slot;
-		}
-
-		if (min_key.offset == (u64)-1)
-			goto none;
-
-		min_key.offset++;
-		btrfs_release_path(path);
-	}
-none:
-	btrfs_free_path(path);
-	return -ENOENT;
-}
-
 static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 					       bool locked)
 {
@@ -1088,66 +988,6 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em)
 	return ret;
 }
 
-static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
-			       u64 *last_len, u64 *skip, u64 *defrag_end,
-			       int compress)
-{
-	struct extent_map *em;
-	int ret = 1;
-	bool next_mergeable = true;
-	bool prev_mergeable = true;
-
-	/*
-	 * make sure that once we start defragging an extent, we keep on
-	 * defragging it
-	 */
-	if (start < *defrag_end)
-		return 1;
-
-	*skip = 0;
-
-	em = defrag_lookup_extent(inode, start, false);
-	if (!em)
-		return 0;
-
-	/* this will cover holes, and inline extents */
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		ret = 0;
-		goto out;
-	}
-
-	if (!*defrag_end)
-		prev_mergeable = false;
-
-	next_mergeable = defrag_check_next_extent(inode, em);
-	/*
-	 * we hit a real extent, if it is big or the next extent is not a
-	 * real extent, don't bother defragging it
-	 */
-	if (!compress && (*last_len == 0 || *last_len >= thresh) &&
-	    (em->len >= thresh || (!next_mergeable && !prev_mergeable)))
-		ret = 0;
-out:
-	/*
-	 * last_len ends up being a counter of how many bytes we've defragged.
-	 * every time we choose not to defrag an extent, we reset *last_len
-	 * so that the next tiny extent will force a defrag.
-	 *
-	 * The end result of this is that tiny extents before a single big
-	 * extent will force at least part of that big extent to be defragged.
-	 */
-	if (ret) {
-		*defrag_end = extent_map_end(em);
-	} else {
-		*last_len = 0;
-		*skip = extent_map_end(em);
-		*defrag_end = 0;
-	}
-
-	free_extent_map(em);
-	return ret;
-}
-
 /*
  * Prepare one page to be defraged.
  *
@@ -1231,151 +1071,6 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
 	return page;
 }
 
-/*
- * it doesn't do much good to defrag one or two pages
- * at a time.  This pulls in a nice chunk of pages
- * to COW and defrag.
- *
- * It also makes sure the delalloc code has enough
- * dirty data to avoid making new small extents as part
- * of the defrag
- *
- * It's a good idea to start RA on this range
- * before calling this.
- */
-static int cluster_pages_for_defrag(struct inode *inode,
-				    struct page **pages,
-				    unsigned long start_index,
-				    unsigned long num_pages)
-{
-	unsigned long file_end;
-	u64 isize = i_size_read(inode);
-	u64 page_start;
-	u64 page_end;
-	u64 page_cnt;
-	u64 start = (u64)start_index << PAGE_SHIFT;
-	u64 search_start;
-	int ret;
-	int i;
-	int i_done;
-	struct extent_state *cached_state = NULL;
-	struct extent_changeset *data_reserved = NULL;
-
-	file_end = (isize - 1) >> PAGE_SHIFT;
-	if (!isize || start_index > file_end)
-		return 0;
-
-	page_cnt = min_t(u64, (u64)num_pages, (u64)file_end - start_index + 1);
-
-	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
-			start, page_cnt << PAGE_SHIFT);
-	if (ret)
-		return ret;
-	i_done = 0;
-
-	/* step one, lock all the pages */
-	for (i = 0; i < page_cnt; i++) {
-		struct page *page;
-
-		page = defrag_prepare_one_page(BTRFS_I(inode), start_index + i);
-		if (IS_ERR(page)) {
-			ret = PTR_ERR(page);
-			break;
-		}
-		pages[i] = page;
-		i_done++;
-	}
-	if (!i_done || ret)
-		goto out;
-
-	if (!(inode->i_sb->s_flags & SB_ACTIVE))
-		goto out;
-
-	page_start = page_offset(pages[0]);
-	page_end = page_offset(pages[i_done - 1]) + PAGE_SIZE;
-
-	lock_extent_bits(&BTRFS_I(inode)->io_tree,
-			 page_start, page_end - 1, &cached_state);
-
-	/*
-	 * When defragmenting we skip ranges that have holes or inline extents,
-	 * (check should_defrag_range()), to avoid unnecessary IO and wasting
-	 * space. At btrfs_defrag_file(), we check if a range should be defragged
-	 * before locking the inode and then, if it should, we trigger a sync
-	 * page cache readahead - we lock the inode only after that to avoid
-	 * blocking for too long other tasks that possibly want to operate on
-	 * other file ranges. But before we were able to get the inode lock,
-	 * some other task may have punched a hole in the range, or we may have
-	 * now an inline extent, in which case we should not defrag. So check
-	 * for that here, where we have the inode and the range locked, and bail
-	 * out if that happened.
-	 */
-	search_start = page_start;
-	while (search_start < page_end) {
-		struct extent_map *em;
-
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, search_start,
-				      page_end - search_start);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
-			goto out_unlock_range;
-		}
-		if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-			free_extent_map(em);
-			/* Ok, 0 means we did not defrag anything */
-			ret = 0;
-			goto out_unlock_range;
-		}
-		search_start = extent_map_end(em);
-		free_extent_map(em);
-	}
-
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start,
-			  page_end - 1, EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			  EXTENT_DEFRAG, 0, 0, &cached_state);
-
-	if (i_done != page_cnt) {
-		spin_lock(&BTRFS_I(inode)->lock);
-		btrfs_mod_outstanding_extents(BTRFS_I(inode), 1);
-		spin_unlock(&BTRFS_I(inode)->lock);
-		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
-				start, (page_cnt - i_done) << PAGE_SHIFT, true);
-	}
-
-
-	set_extent_defrag(&BTRFS_I(inode)->io_tree, page_start, page_end - 1,
-			  &cached_state);
-
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-			     page_start, page_end - 1, &cached_state);
-
-	for (i = 0; i < i_done; i++) {
-		clear_page_dirty_for_io(pages[i]);
-		ClearPageChecked(pages[i]);
-		set_page_dirty(pages[i]);
-		unlock_page(pages[i]);
-		put_page(pages[i]);
-	}
-	btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_SHIFT);
-	extent_changeset_free(data_reserved);
-	return i_done;
-
-out_unlock_range:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-			     page_start, page_end - 1, &cached_state);
-out:
-	for (i = 0; i < i_done; i++) {
-		unlock_page(pages[i]);
-		put_page(pages[i]);
-	}
-	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
-			start, page_cnt << PAGE_SHIFT, true);
-	btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_SHIFT);
-	extent_changeset_free(data_reserved);
-	return ret;
-
-}
-
 struct defrag_target_range {
 	struct list_head list;
 	u64 start;
-- 
2.31.1

