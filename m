Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D3260E8BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiJZTLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiJZTLe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81E13C3E1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hh9so10680018qtb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akiEPNWeC/u9Qov2dUGX/MvZUdG2bMbkBqjP9Q4oHWs=;
        b=Ige7RX+KsDqbFTRcXbAT2Vev9YweoNQPfn2eh5052JuKoXvu87mIFiAAC0mZ45LxFy
         QICn9pRl0c3qR2oMrafHRKP3EoCL3wukE1heGIBtgc4W0/E9Twl7iq8/3kWLM6qU5Hp2
         ffgjNacv6aEkAmCKY0HsyAC8L9sESomBoyo2cWHga5WhL4IBCiMKFfTmFrAhqvA4KlMA
         ct4pR0JailYS7y0SzNVY22pOqLgaFF7I+Nsmf9sMKwQozNFzSxzfmAbOrRBLYxEOKAv4
         QHwHsdZz8A9EPqvL5EUsu7uUNNx4IZD7QOby3bX0vNk+scO2gjF+syZHZ/iE6V0B4tFX
         Awsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akiEPNWeC/u9Qov2dUGX/MvZUdG2bMbkBqjP9Q4oHWs=;
        b=E5OGALQ8fyosakTsxopdDVLfKxGj8CRgGP2oDYkPpHcnOIQyotxiYrp2ZTGe0/rEjZ
         esqxlGkTvm6i3SPy8/7v9IoBToEJvVPHZ5u4mtuAKlHoBmc3Kh2I04r5JMyLBLk2p500
         tTVSmr8YWpZImEizyZY2CUVHEQs7qlI+BriSSPjoDtqent7nxJ9WQyCM23489WsnTvK2
         QewVzw2HDZ0hLMkLicOpmA7UVEguyi0sWL4rufPJH0q0CSuFgfmAWAK2JUPti2Rnud2U
         4CRgmHkPhKl52aljBWAhplrW4hZkrdbRC/6EA0HJKmO9hoRnpVRaWMAloo1NlcynwH0N
         vMnw==
X-Gm-Message-State: ACrzQf33wQegER8qOeMHZ+BgYmTGu/SA3UQgrsydyIOq7FXGa46ObshI
        DKETFqdTiXyZ3RvtV7Vk/Pjr8o/0I8fuqQ==
X-Google-Smtp-Source: AMsMyM5pwfnNYKd2S9TA3xHaHAHLfZGh2Ey87mZzC7ygJu7C1o4969rYoL38bMacRQOGae484HmFAA==
X-Received: by 2002:a05:622a:315:b0:39a:b379:da72 with SMTP id q21-20020a05622a031500b0039ab379da72mr38353000qtw.318.1666811336247;
        Wed, 26 Oct 2022 12:08:56 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g5-20020a05620a40c500b006e07228ed53sm4534481qko.18.2022.10.26.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/26] btrfs: move the file defrag code into defrag.c
Date:   Wed, 26 Oct 2022 15:08:24 -0400
Message-Id: <927a6a7d5a5f77ea1e46e8a17cb0bf3328784588.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the other big portion of defrag code that has existed in
ioctl.c.  Move it to its new home in defrag.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/defrag.c | 905 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ioctl.c  | 902 ---------------------------------------------
 2 files changed, 905 insertions(+), 902 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 7da3f7039dcd..01a8d5ff706b 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -10,6 +10,9 @@
 #include "transaction.h"
 #include "locking.h"
 #include "accessors.h"
+#include "messages.h"
+#include "delalloc-space.h"
+#include "subpage.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
@@ -455,6 +458,908 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * Defrag specific helper to get an extent map.
+ *
+ * Differences between this and btrfs_get_extent() are:
+ *
+ * - No extent_map will be added to inode->extent_tree
+ *   To reduce memory usage in the long run.
+ *
+ * - Extra optimization to skip file extents older than @newer_than
+ *   By using btrfs_search_forward() we can skip entire file ranges that
+ *   have extents created in past transactions, because btrfs_search_forward()
+ *   will not visit leaves and nodes with a generation smaller than given
+ *   minimal generation threshold (@newer_than).
+ *
+ * Return valid em if we find a file extent matching the requirement.
+ * Return NULL if we can not find a file extent matching the requirement.
+ *
+ * Return ERR_PTR() for error.
+ */
+static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
+					    u64 start, u64 newer_than)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_path path = { 0 };
+	struct extent_map *em;
+	struct btrfs_key key;
+	u64 ino = btrfs_ino(inode);
+	int ret;
+
+	em = alloc_extent_map();
+	if (!em) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	key.objectid = ino;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = start;
+
+	if (newer_than) {
+		ret = btrfs_search_forward(root, &key, &path, newer_than);
+		if (ret < 0)
+			goto err;
+		/* Can't find anything newer */
+		if (ret > 0)
+			goto not_found;
+	} else {
+		ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+		if (ret < 0)
+			goto err;
+	}
+	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
+		/*
+		 * If btrfs_search_slot() makes path to point beyond nritems,
+		 * we should not have an empty leaf, as this inode must at
+		 * least have its INODE_ITEM.
+		 */
+		ASSERT(btrfs_header_nritems(path.nodes[0]));
+		path.slots[0] = btrfs_header_nritems(path.nodes[0]) - 1;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	/* Perfect match, no need to go one slot back */
+	if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY &&
+	    key.offset == start)
+		goto iterate;
+
+	/* We didn't find a perfect match, needs to go one slot back */
+	if (path.slots[0] > 0) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
+			path.slots[0]--;
+	}
+
+iterate:
+	/* Iterate through the path to find a file extent covering @start */
+	while (true) {
+		u64 extent_end;
+
+		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
+			goto next;
+
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+
+		/*
+		 * We may go one slot back to INODE_REF/XATTR item, then
+		 * need to go forward until we reach an EXTENT_DATA.
+		 * But we should still has the correct ino as key.objectid.
+		 */
+		if (WARN_ON(key.objectid < ino) || key.type < BTRFS_EXTENT_DATA_KEY)
+			goto next;
+
+		/* It's beyond our target range, definitely not extent found */
+		if (key.objectid > ino || key.type > BTRFS_EXTENT_DATA_KEY)
+			goto not_found;
+
+		/*
+		 *	|	|<- File extent ->|
+		 *	\- start
+		 *
+		 * This means there is a hole between start and key.offset.
+		 */
+		if (key.offset > start) {
+			em->start = start;
+			em->orig_start = start;
+			em->block_start = EXTENT_MAP_HOLE;
+			em->len = key.offset - start;
+			break;
+		}
+
+		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_file_extent_item);
+		extent_end = btrfs_file_extent_end(&path);
+
+		/*
+		 *	|<- file extent ->|	|
+		 *				\- start
+		 *
+		 * We haven't reached start, search next slot.
+		 */
+		if (extent_end <= start)
+			goto next;
+
+		/* Now this extent covers @start, convert it to em */
+		btrfs_extent_item_to_extent_map(inode, &path, fi, em);
+		break;
+next:
+		ret = btrfs_next_item(root, &path);
+		if (ret < 0)
+			goto err;
+		if (ret > 0)
+			goto not_found;
+	}
+	btrfs_release_path(&path);
+	return em;
+
+not_found:
+	btrfs_release_path(&path);
+	free_extent_map(em);
+	return NULL;
+
+err:
+	btrfs_release_path(&path);
+	free_extent_map(em);
+	return ERR_PTR(ret);
+}
+
+static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
+					       u64 newer_than, bool locked)
+{
+	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_map *em;
+	const u32 sectorsize = BTRFS_I(inode)->root->fs_info->sectorsize;
+
+	/*
+	 * hopefully we have this extent in the tree already, try without
+	 * the full extent lock
+	 */
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, start, sectorsize);
+	read_unlock(&em_tree->lock);
+
+	/*
+	 * We can get a merged extent, in that case, we need to re-search
+	 * tree to get the original em for defrag.
+	 *
+	 * If @newer_than is 0 or em::generation < newer_than, we can trust
+	 * this em, as either we don't care about the generation, or the
+	 * merged extent map will be rejected anyway.
+	 */
+	if (em && test_bit(EXTENT_FLAG_MERGED, &em->flags) &&
+	    newer_than && em->generation >= newer_than) {
+		free_extent_map(em);
+		em = NULL;
+	}
+
+	if (!em) {
+		struct extent_state *cached = NULL;
+		u64 end = start + sectorsize - 1;
+
+		/* get the big lock and read metadata off disk */
+		if (!locked)
+			lock_extent(io_tree, start, end, &cached);
+		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
+		if (!locked)
+			unlock_extent(io_tree, start, end, &cached);
+
+		if (IS_ERR(em))
+			return NULL;
+	}
+
+	return em;
+}
+
+static u32 get_extent_max_capacity(const struct btrfs_fs_info *fs_info,
+				   const struct extent_map *em)
+{
+	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
+		return BTRFS_MAX_COMPRESSED;
+	return fs_info->max_extent_size;
+}
+
+static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
+				     u32 extent_thresh, u64 newer_than, bool locked)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct extent_map *next;
+	bool ret = false;
+
+	/* this is the last extent */
+	if (em->start + em->len >= i_size_read(inode))
+		return false;
+
+	/*
+	 * Here we need to pass @newer_then when checking the next extent, or
+	 * we will hit a case we mark current extent for defrag, but the next
+	 * one will not be a target.
+	 * This will just cause extra IO without really reducing the fragments.
+	 */
+	next = defrag_lookup_extent(inode, em->start + em->len, newer_than, locked);
+	/* No more em or hole */
+	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
+		goto out;
+	if (test_bit(EXTENT_FLAG_PREALLOC, &next->flags))
+		goto out;
+	/*
+	 * If the next extent is at its max capacity, defragging current extent
+	 * makes no sense, as the total number of extents won't change.
+	 */
+	if (next->len >= get_extent_max_capacity(fs_info, em))
+		goto out;
+	/* Skip older extent */
+	if (next->generation < newer_than)
+		goto out;
+	/* Also check extent size */
+	if (next->len >= extent_thresh)
+		goto out;
+
+	ret = true;
+out:
+	free_extent_map(next);
+	return ret;
+}
+
+/*
+ * Prepare one page to be defragged.
+ *
+ * This will ensure:
+ *
+ * - Returned page is locked and has been set up properly.
+ * - No ordered extent exists in the page.
+ * - The page is uptodate.
+ *
+ * NOTE: Caller should also wait for page writeback after the cluster is
+ * prepared, here we don't do writeback wait for each page.
+ */
+static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
+					    pgoff_t index)
+{
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	gfp_t mask = btrfs_alloc_write_mask(mapping);
+	u64 page_start = (u64)index << PAGE_SHIFT;
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	struct extent_state *cached_state = NULL;
+	struct page *page;
+	int ret;
+
+again:
+	page = find_or_create_page(mapping, index, mask);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Since we can defragment files opened read-only, we can encounter
+	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS). We
+	 * can't do I/O using huge pages yet, so return an error for now.
+	 * Filesystem transparent huge pages are typically only used for
+	 * executables that explicitly enable them, so this isn't very
+	 * restrictive.
+	 */
+	if (PageCompound(page)) {
+		unlock_page(page);
+		put_page(page);
+		return ERR_PTR(-ETXTBSY);
+	}
+
+	ret = set_page_extent_mapped(page);
+	if (ret < 0) {
+		unlock_page(page);
+		put_page(page);
+		return ERR_PTR(ret);
+	}
+
+	/* Wait for any existing ordered extent in the range */
+	while (1) {
+		struct btrfs_ordered_extent *ordered;
+
+		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
+		unlock_extent(&inode->io_tree, page_start, page_end,
+			      &cached_state);
+		if (!ordered)
+			break;
+
+		unlock_page(page);
+		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_put_ordered_extent(ordered);
+		lock_page(page);
+		/*
+		 * We unlocked the page above, so we need check if it was
+		 * released or not.
+		 */
+		if (page->mapping != mapping || !PagePrivate(page)) {
+			unlock_page(page);
+			put_page(page);
+			goto again;
+		}
+	}
+
+	/*
+	 * Now the page range has no ordered extent any more.  Read the page to
+	 * make it uptodate.
+	 */
+	if (!PageUptodate(page)) {
+		btrfs_read_folio(NULL, page_folio(page));
+		lock_page(page);
+		if (page->mapping != mapping || !PagePrivate(page)) {
+			unlock_page(page);
+			put_page(page);
+			goto again;
+		}
+		if (!PageUptodate(page)) {
+			unlock_page(page);
+			put_page(page);
+			return ERR_PTR(-EIO);
+		}
+	}
+	return page;
+}
+
+struct defrag_target_range {
+	struct list_head list;
+	u64 start;
+	u64 len;
+};
+
+/*
+ * Collect all valid target extents.
+ *
+ * @start:	   file offset to lookup
+ * @len:	   length to lookup
+ * @extent_thresh: file extent size threshold, any extent size >= this value
+ *		   will be ignored
+ * @newer_than:    only defrag extents newer than this value
+ * @do_compress:   whether the defrag is doing compression
+ *		   if true, @extent_thresh will be ignored and all regular
+ *		   file extents meeting @newer_than will be targets.
+ * @locked:	   if the range has already held extent lock
+ * @target_list:   list of targets file extents
+ */
+static int defrag_collect_targets(struct btrfs_inode *inode,
+				  u64 start, u64 len, u32 extent_thresh,
+				  u64 newer_than, bool do_compress,
+				  bool locked, struct list_head *target_list,
+				  u64 *last_scanned_ret)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	bool last_is_target = false;
+	u64 cur = start;
+	int ret = 0;
+
+	while (cur < start + len) {
+		struct extent_map *em;
+		struct defrag_target_range *new;
+		bool next_mergeable = true;
+		u64 range_len;
+
+		last_is_target = false;
+		em = defrag_lookup_extent(&inode->vfs_inode, cur,
+					  newer_than, locked);
+		if (!em)
+			break;
+
+		/*
+		 * If the file extent is an inlined one, we may still want to
+		 * defrag it (fallthrough) if it will cause a regular extent.
+		 * This is for users who want to convert inline extents to
+		 * regular ones through max_inline= mount option.
+		 */
+		if (em->block_start == EXTENT_MAP_INLINE &&
+		    em->len <= inode->root->fs_info->max_inline)
+			goto next;
+
+		/* Skip hole/delalloc/preallocated extents */
+		if (em->block_start == EXTENT_MAP_HOLE ||
+		    em->block_start == EXTENT_MAP_DELALLOC ||
+		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+			goto next;
+
+		/* Skip older extent */
+		if (em->generation < newer_than)
+			goto next;
+
+		/* This em is under writeback, no need to defrag */
+		if (em->generation == (u64)-1)
+			goto next;
+
+		/*
+		 * Our start offset might be in the middle of an existing extent
+		 * map, so take that into account.
+		 */
+		range_len = em->len - (cur - em->start);
+		/*
+		 * If this range of the extent map is already flagged for delalloc,
+		 * skip it, because:
+		 *
+		 * 1) We could deadlock later, when trying to reserve space for
+		 *    delalloc, because in case we can't immediately reserve space
+		 *    the flusher can start delalloc and wait for the respective
+		 *    ordered extents to complete. The deadlock would happen
+		 *    because we do the space reservation while holding the range
+		 *    locked, and starting writeback, or finishing an ordered
+		 *    extent, requires locking the range;
+		 *
+		 * 2) If there's delalloc there, it means there's dirty pages for
+		 *    which writeback has not started yet (we clean the delalloc
+		 *    flag when starting writeback and after creating an ordered
+		 *    extent). If we mark pages in an adjacent range for defrag,
+		 *    then we will have a larger contiguous range for delalloc,
+		 *    very likely resulting in a larger extent after writeback is
+		 *    triggered (except in a case of free space fragmentation).
+		 */
+		if (test_range_bit(&inode->io_tree, cur, cur + range_len - 1,
+				   EXTENT_DELALLOC, 0, NULL))
+			goto next;
+
+		/*
+		 * For do_compress case, we want to compress all valid file
+		 * extents, thus no @extent_thresh or mergeable check.
+		 */
+		if (do_compress)
+			goto add;
+
+		/* Skip too large extent */
+		if (range_len >= extent_thresh)
+			goto next;
+
+		/*
+		 * Skip extents already at its max capacity, this is mostly for
+		 * compressed extents, which max cap is only 128K.
+		 */
+		if (em->len >= get_extent_max_capacity(fs_info, em))
+			goto next;
+
+		/*
+		 * Normally there are no more extents after an inline one, thus
+		 * @next_mergeable will normally be false and not defragged.
+		 * So if an inline extent passed all above checks, just add it
+		 * for defrag, and be converted to regular extents.
+		 */
+		if (em->block_start == EXTENT_MAP_INLINE)
+			goto add;
+
+		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
+						extent_thresh, newer_than, locked);
+		if (!next_mergeable) {
+			struct defrag_target_range *last;
+
+			/* Empty target list, no way to merge with last entry */
+			if (list_empty(target_list))
+				goto next;
+			last = list_entry(target_list->prev,
+					  struct defrag_target_range, list);
+			/* Not mergeable with last entry */
+			if (last->start + last->len != cur)
+				goto next;
+
+			/* Mergeable, fall through to add it to @target_list. */
+		}
+
+add:
+		last_is_target = true;
+		range_len = min(extent_map_end(em), start + len) - cur;
+		/*
+		 * This one is a good target, check if it can be merged into
+		 * last range of the target list.
+		 */
+		if (!list_empty(target_list)) {
+			struct defrag_target_range *last;
+
+			last = list_entry(target_list->prev,
+					  struct defrag_target_range, list);
+			ASSERT(last->start + last->len <= cur);
+			if (last->start + last->len == cur) {
+				/* Mergeable, enlarge the last entry */
+				last->len += range_len;
+				goto next;
+			}
+			/* Fall through to allocate a new entry */
+		}
+
+		/* Allocate new defrag_target_range */
+		new = kmalloc(sizeof(*new), GFP_NOFS);
+		if (!new) {
+			free_extent_map(em);
+			ret = -ENOMEM;
+			break;
+		}
+		new->start = cur;
+		new->len = range_len;
+		list_add_tail(&new->list, target_list);
+
+next:
+		cur = extent_map_end(em);
+		free_extent_map(em);
+	}
+	if (ret < 0) {
+		struct defrag_target_range *entry;
+		struct defrag_target_range *tmp;
+
+		list_for_each_entry_safe(entry, tmp, target_list, list) {
+			list_del_init(&entry->list);
+			kfree(entry);
+		}
+	}
+	if (!ret && last_scanned_ret) {
+		/*
+		 * If the last extent is not a target, the caller can skip to
+		 * the end of that extent.
+		 * Otherwise, we can only go the end of the specified range.
+		 */
+		if (!last_is_target)
+			*last_scanned_ret = max(cur, *last_scanned_ret);
+		else
+			*last_scanned_ret = max(start + len, *last_scanned_ret);
+	}
+	return ret;
+}
+
+#define CLUSTER_SIZE	(SZ_256K)
+static_assert(IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
+
+/*
+ * Defrag one contiguous target range.
+ *
+ * @inode:	target inode
+ * @target:	target range to defrag
+ * @pages:	locked pages covering the defrag range
+ * @nr_pages:	number of locked pages
+ *
+ * Caller should ensure:
+ *
+ * - Pages are prepared
+ *   Pages should be locked, no ordered extent in the pages range,
+ *   no writeback.
+ *
+ * - Extent bits are locked
+ */
+static int defrag_one_locked_target(struct btrfs_inode *inode,
+				    struct defrag_target_range *target,
+				    struct page **pages, int nr_pages,
+				    struct extent_state **cached_state)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_changeset *data_reserved = NULL;
+	const u64 start = target->start;
+	const u64 len = target->len;
+	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
+	unsigned long start_index = start >> PAGE_SHIFT;
+	unsigned long first_index = page_index(pages[0]);
+	int ret = 0;
+	int i;
+
+	ASSERT(last_index - first_index + 1 <= nr_pages);
+
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
+	if (ret < 0)
+		return ret;
+	clear_extent_bit(&inode->io_tree, start, start + len - 1,
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			 EXTENT_DEFRAG, cached_state);
+	set_extent_defrag(&inode->io_tree, start, start + len - 1, cached_state);
+
+	/* Update the page status */
+	for (i = start_index - first_index; i <= last_index - first_index; i++) {
+		ClearPageChecked(pages[i]);
+		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
+	}
+	btrfs_delalloc_release_extents(inode, len);
+	extent_changeset_free(data_reserved);
+
+	return ret;
+}
+
+static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
+			    u32 extent_thresh, u64 newer_than, bool do_compress,
+			    u64 *last_scanned_ret)
+{
+	struct extent_state *cached_state = NULL;
+	struct defrag_target_range *entry;
+	struct defrag_target_range *tmp;
+	LIST_HEAD(target_list);
+	struct page **pages;
+	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
+	u64 start_index = start >> PAGE_SHIFT;
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
+	/* Lock the pages range */
+	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+		    &cached_state);
+	/*
+	 * Now we have a consistent view about the extent map, re-check
+	 * which range really needs to be defragged.
+	 *
+	 * And this time we have extent locked already, pass @locked = true
+	 * so that we won't relock the extent range and cause deadlock.
+	 */
+	ret = defrag_collect_targets(inode, start, len, extent_thresh,
+				     newer_than, do_compress, true,
+				     &target_list, last_scanned_ret);
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
+	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+		      &cached_state);
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
+static int defrag_one_cluster(struct btrfs_inode *inode,
+			      struct file_ra_state *ra,
+			      u64 start, u32 len, u32 extent_thresh,
+			      u64 newer_than, bool do_compress,
+			      unsigned long *sectors_defragged,
+			      unsigned long max_sectors,
+			      u64 *last_scanned_ret)
+{
+	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	struct defrag_target_range *entry;
+	struct defrag_target_range *tmp;
+	LIST_HEAD(target_list);
+	int ret;
+
+	ret = defrag_collect_targets(inode, start, len, extent_thresh,
+				     newer_than, do_compress, false,
+				     &target_list, NULL);
+	if (ret < 0)
+		goto out;
+
+	list_for_each_entry(entry, &target_list, list) {
+		u32 range_len = entry->len;
+
+		/* Reached or beyond the limit */
+		if (max_sectors && *sectors_defragged >= max_sectors) {
+			ret = 1;
+			break;
+		}
+
+		if (max_sectors)
+			range_len = min_t(u32, range_len,
+				(max_sectors - *sectors_defragged) * sectorsize);
+
+		/*
+		 * If defrag_one_range() has updated last_scanned_ret,
+		 * our range may already be invalid (e.g. hole punched).
+		 * Skip if our range is before last_scanned_ret, as there is
+		 * no need to defrag the range anymore.
+		 */
+		if (entry->start + range_len <= *last_scanned_ret)
+			continue;
+
+		if (ra)
+			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
+				ra, NULL, entry->start >> PAGE_SHIFT,
+				((entry->start + range_len - 1) >> PAGE_SHIFT) -
+				(entry->start >> PAGE_SHIFT) + 1);
+		/*
+		 * Here we may not defrag any range if holes are punched before
+		 * we locked the pages.
+		 * But that's fine, it only affects the @sectors_defragged
+		 * accounting.
+		 */
+		ret = defrag_one_range(inode, entry->start, range_len,
+				       extent_thresh, newer_than, do_compress,
+				       last_scanned_ret);
+		if (ret < 0)
+			break;
+		*sectors_defragged += range_len >>
+				      inode->root->fs_info->sectorsize_bits;
+	}
+out:
+	list_for_each_entry_safe(entry, tmp, &target_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	if (ret >= 0)
+		*last_scanned_ret = max(*last_scanned_ret, start + len);
+	return ret;
+}
+
+/*
+ * Entry point to file defragmentation.
+ *
+ * @inode:	   inode to be defragged
+ * @ra:		   readahead state (can be NUL)
+ * @range:	   defrag options including range and flags
+ * @newer_than:	   minimum transid to defrag
+ * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
+ *		   will be defragged.
+ *
+ * Return <0 for error.
+ * Return >=0 for the number of sectors defragged, and range->start will be updated
+ * to indicate the file offset where next defrag should be started at.
+ * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
+ *  defragging all the range).
+ */
+int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
+		      struct btrfs_ioctl_defrag_range_args *range,
+		      u64 newer_than, unsigned long max_to_defrag)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	unsigned long sectors_defragged = 0;
+	u64 isize = i_size_read(inode);
+	u64 cur;
+	u64 last_byte;
+	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
+	bool ra_allocated = false;
+	int compress_type = BTRFS_COMPRESS_ZLIB;
+	int ret = 0;
+	u32 extent_thresh = range->extent_thresh;
+	pgoff_t start_index;
+
+	if (isize == 0)
+		return 0;
+
+	if (range->start >= isize)
+		return -EINVAL;
+
+	if (do_compress) {
+		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
+			return -EINVAL;
+		if (range->compress_type)
+			compress_type = range->compress_type;
+	}
+
+	if (extent_thresh == 0)
+		extent_thresh = SZ_256K;
+
+	if (range->start + range->len > range->start) {
+		/* Got a specific range */
+		last_byte = min(isize, range->start + range->len);
+	} else {
+		/* Defrag until file end */
+		last_byte = isize;
+	}
+
+	/* Align the range */
+	cur = round_down(range->start, fs_info->sectorsize);
+	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
+
+	/*
+	 * If we were not given a ra, allocate a readahead context. As
+	 * readahead is just an optimization, defrag will work without it so
+	 * we don't error out.
+	 */
+	if (!ra) {
+		ra_allocated = true;
+		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
+		if (ra)
+			file_ra_state_init(ra, inode->i_mapping);
+	}
+
+	/*
+	 * Make writeback start from the beginning of the range, so that the
+	 * defrag range can be written sequentially.
+	 */
+	start_index = cur >> PAGE_SHIFT;
+	if (start_index < inode->i_mapping->writeback_index)
+		inode->i_mapping->writeback_index = start_index;
+
+	while (cur < last_byte) {
+		const unsigned long prev_sectors_defragged = sectors_defragged;
+		u64 last_scanned = cur;
+		u64 cluster_end;
+
+		if (btrfs_defrag_cancelled(fs_info)) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		/* We want the cluster end at page boundary when possible */
+		cluster_end = (((cur >> PAGE_SHIFT) +
+			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
+		cluster_end = min(cluster_end, last_byte);
+
+		btrfs_inode_lock(inode, 0);
+		if (IS_SWAPFILE(inode)) {
+			ret = -ETXTBSY;
+			btrfs_inode_unlock(inode, 0);
+			break;
+		}
+		if (!(inode->i_sb->s_flags & SB_ACTIVE)) {
+			btrfs_inode_unlock(inode, 0);
+			break;
+		}
+		if (do_compress)
+			BTRFS_I(inode)->defrag_compress = compress_type;
+		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
+				cluster_end + 1 - cur, extent_thresh,
+				newer_than, do_compress, &sectors_defragged,
+				max_to_defrag, &last_scanned);
+
+		if (sectors_defragged > prev_sectors_defragged)
+			balance_dirty_pages_ratelimited(inode->i_mapping);
+
+		btrfs_inode_unlock(inode, 0);
+		if (ret < 0)
+			break;
+		cur = max(cluster_end + 1, last_scanned);
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+		cond_resched();
+	}
+
+	if (ra_allocated)
+		kfree(ra);
+	/*
+	 * Update range.start for autodefrag, this will indicate where to start
+	 * in next run.
+	 */
+	range->start = cur;
+	if (sectors_defragged) {
+		/*
+		 * We have defragged some sectors, for compression case they
+		 * need to be written back immediately.
+		 */
+		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
+			filemap_flush(inode->i_mapping);
+			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+				     &BTRFS_I(inode)->runtime_flags))
+				filemap_flush(inode->i_mapping);
+		}
+		if (range->compress_type == BTRFS_COMPRESS_LZO)
+			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
+		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
+			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
+		ret = sectors_defragged;
+	}
+	if (do_compress) {
+		btrfs_inode_lock(inode, 0);
+		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
+		btrfs_inode_unlock(inode, 0);
+	}
+	return ret;
+}
+
 void __cold btrfs_auto_defrag_exit(void)
 {
 	kmem_cache_destroy(btrfs_inode_defrag_cachep);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab847c4ffede..0af0596bf127 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1039,908 +1039,6 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 	return ret;
 }
 
-/*
- * Defrag specific helper to get an extent map.
- *
- * Differences between this and btrfs_get_extent() are:
- *
- * - No extent_map will be added to inode->extent_tree
- *   To reduce memory usage in the long run.
- *
- * - Extra optimization to skip file extents older than @newer_than
- *   By using btrfs_search_forward() we can skip entire file ranges that
- *   have extents created in past transactions, because btrfs_search_forward()
- *   will not visit leaves and nodes with a generation smaller than given
- *   minimal generation threshold (@newer_than).
- *
- * Return valid em if we find a file extent matching the requirement.
- * Return NULL if we can not find a file extent matching the requirement.
- *
- * Return ERR_PTR() for error.
- */
-static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
-					    u64 start, u64 newer_than)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_file_extent_item *fi;
-	struct btrfs_path path = { 0 };
-	struct extent_map *em;
-	struct btrfs_key key;
-	u64 ino = btrfs_ino(inode);
-	int ret;
-
-	em = alloc_extent_map();
-	if (!em) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	key.objectid = ino;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = start;
-
-	if (newer_than) {
-		ret = btrfs_search_forward(root, &key, &path, newer_than);
-		if (ret < 0)
-			goto err;
-		/* Can't find anything newer */
-		if (ret > 0)
-			goto not_found;
-	} else {
-		ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-		if (ret < 0)
-			goto err;
-	}
-	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
-		/*
-		 * If btrfs_search_slot() makes path to point beyond nritems,
-		 * we should not have an empty leaf, as this inode must at
-		 * least have its INODE_ITEM.
-		 */
-		ASSERT(btrfs_header_nritems(path.nodes[0]));
-		path.slots[0] = btrfs_header_nritems(path.nodes[0]) - 1;
-	}
-	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-	/* Perfect match, no need to go one slot back */
-	if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY &&
-	    key.offset == start)
-		goto iterate;
-
-	/* We didn't find a perfect match, needs to go one slot back */
-	if (path.slots[0] > 0) {
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
-			path.slots[0]--;
-	}
-
-iterate:
-	/* Iterate through the path to find a file extent covering @start */
-	while (true) {
-		u64 extent_end;
-
-		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
-			goto next;
-
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-
-		/*
-		 * We may go one slot back to INODE_REF/XATTR item, then
-		 * need to go forward until we reach an EXTENT_DATA.
-		 * But we should still has the correct ino as key.objectid.
-		 */
-		if (WARN_ON(key.objectid < ino) || key.type < BTRFS_EXTENT_DATA_KEY)
-			goto next;
-
-		/* It's beyond our target range, definitely not extent found */
-		if (key.objectid > ino || key.type > BTRFS_EXTENT_DATA_KEY)
-			goto not_found;
-
-		/*
-		 *	|	|<- File extent ->|
-		 *	\- start
-		 *
-		 * This means there is a hole between start and key.offset.
-		 */
-		if (key.offset > start) {
-			em->start = start;
-			em->orig_start = start;
-			em->block_start = EXTENT_MAP_HOLE;
-			em->len = key.offset - start;
-			break;
-		}
-
-		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
-				    struct btrfs_file_extent_item);
-		extent_end = btrfs_file_extent_end(&path);
-
-		/*
-		 *	|<- file extent ->|	|
-		 *				\- start
-		 *
-		 * We haven't reached start, search next slot.
-		 */
-		if (extent_end <= start)
-			goto next;
-
-		/* Now this extent covers @start, convert it to em */
-		btrfs_extent_item_to_extent_map(inode, &path, fi, em);
-		break;
-next:
-		ret = btrfs_next_item(root, &path);
-		if (ret < 0)
-			goto err;
-		if (ret > 0)
-			goto not_found;
-	}
-	btrfs_release_path(&path);
-	return em;
-
-not_found:
-	btrfs_release_path(&path);
-	free_extent_map(em);
-	return NULL;
-
-err:
-	btrfs_release_path(&path);
-	free_extent_map(em);
-	return ERR_PTR(ret);
-}
-
-static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
-					       u64 newer_than, bool locked)
-{
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct extent_map *em;
-	const u32 sectorsize = BTRFS_I(inode)->root->fs_info->sectorsize;
-
-	/*
-	 * hopefully we have this extent in the tree already, try without
-	 * the full extent lock
-	 */
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, sectorsize);
-	read_unlock(&em_tree->lock);
-
-	/*
-	 * We can get a merged extent, in that case, we need to re-search
-	 * tree to get the original em for defrag.
-	 *
-	 * If @newer_than is 0 or em::generation < newer_than, we can trust
-	 * this em, as either we don't care about the generation, or the
-	 * merged extent map will be rejected anyway.
-	 */
-	if (em && test_bit(EXTENT_FLAG_MERGED, &em->flags) &&
-	    newer_than && em->generation >= newer_than) {
-		free_extent_map(em);
-		em = NULL;
-	}
-
-	if (!em) {
-		struct extent_state *cached = NULL;
-		u64 end = start + sectorsize - 1;
-
-		/* get the big lock and read metadata off disk */
-		if (!locked)
-			lock_extent(io_tree, start, end, &cached);
-		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
-		if (!locked)
-			unlock_extent(io_tree, start, end, &cached);
-
-		if (IS_ERR(em))
-			return NULL;
-	}
-
-	return em;
-}
-
-static u32 get_extent_max_capacity(const struct btrfs_fs_info *fs_info,
-				   const struct extent_map *em)
-{
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
-		return BTRFS_MAX_COMPRESSED;
-	return fs_info->max_extent_size;
-}
-
-static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
-				     u32 extent_thresh, u64 newer_than, bool locked)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_map *next;
-	bool ret = false;
-
-	/* this is the last extent */
-	if (em->start + em->len >= i_size_read(inode))
-		return false;
-
-	/*
-	 * Here we need to pass @newer_then when checking the next extent, or
-	 * we will hit a case we mark current extent for defrag, but the next
-	 * one will not be a target.
-	 * This will just cause extra IO without really reducing the fragments.
-	 */
-	next = defrag_lookup_extent(inode, em->start + em->len, newer_than, locked);
-	/* No more em or hole */
-	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
-		goto out;
-	if (test_bit(EXTENT_FLAG_PREALLOC, &next->flags))
-		goto out;
-	/*
-	 * If the next extent is at its max capacity, defragging current extent
-	 * makes no sense, as the total number of extents won't change.
-	 */
-	if (next->len >= get_extent_max_capacity(fs_info, em))
-		goto out;
-	/* Skip older extent */
-	if (next->generation < newer_than)
-		goto out;
-	/* Also check extent size */
-	if (next->len >= extent_thresh)
-		goto out;
-
-	ret = true;
-out:
-	free_extent_map(next);
-	return ret;
-}
-
-/*
- * Prepare one page to be defragged.
- *
- * This will ensure:
- *
- * - Returned page is locked and has been set up properly.
- * - No ordered extent exists in the page.
- * - The page is uptodate.
- *
- * NOTE: Caller should also wait for page writeback after the cluster is
- * prepared, here we don't do writeback wait for each page.
- */
-static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
-					    pgoff_t index)
-{
-	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	gfp_t mask = btrfs_alloc_write_mask(mapping);
-	u64 page_start = (u64)index << PAGE_SHIFT;
-	u64 page_end = page_start + PAGE_SIZE - 1;
-	struct extent_state *cached_state = NULL;
-	struct page *page;
-	int ret;
-
-again:
-	page = find_or_create_page(mapping, index, mask);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
-
-	/*
-	 * Since we can defragment files opened read-only, we can encounter
-	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS). We
-	 * can't do I/O using huge pages yet, so return an error for now.
-	 * Filesystem transparent huge pages are typically only used for
-	 * executables that explicitly enable them, so this isn't very
-	 * restrictive.
-	 */
-	if (PageCompound(page)) {
-		unlock_page(page);
-		put_page(page);
-		return ERR_PTR(-ETXTBSY);
-	}
-
-	ret = set_page_extent_mapped(page);
-	if (ret < 0) {
-		unlock_page(page);
-		put_page(page);
-		return ERR_PTR(ret);
-	}
-
-	/* Wait for any existing ordered extent in the range */
-	while (1) {
-		struct btrfs_ordered_extent *ordered;
-
-		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		unlock_extent(&inode->io_tree, page_start, page_end,
-			      &cached_state);
-		if (!ordered)
-			break;
-
-		unlock_page(page);
-		btrfs_start_ordered_extent(ordered, 1);
-		btrfs_put_ordered_extent(ordered);
-		lock_page(page);
-		/*
-		 * We unlocked the page above, so we need check if it was
-		 * released or not.
-		 */
-		if (page->mapping != mapping || !PagePrivate(page)) {
-			unlock_page(page);
-			put_page(page);
-			goto again;
-		}
-	}
-
-	/*
-	 * Now the page range has no ordered extent any more.  Read the page to
-	 * make it uptodate.
-	 */
-	if (!PageUptodate(page)) {
-		btrfs_read_folio(NULL, page_folio(page));
-		lock_page(page);
-		if (page->mapping != mapping || !PagePrivate(page)) {
-			unlock_page(page);
-			put_page(page);
-			goto again;
-		}
-		if (!PageUptodate(page)) {
-			unlock_page(page);
-			put_page(page);
-			return ERR_PTR(-EIO);
-		}
-	}
-	return page;
-}
-
-struct defrag_target_range {
-	struct list_head list;
-	u64 start;
-	u64 len;
-};
-
-/*
- * Collect all valid target extents.
- *
- * @start:	   file offset to lookup
- * @len:	   length to lookup
- * @extent_thresh: file extent size threshold, any extent size >= this value
- *		   will be ignored
- * @newer_than:    only defrag extents newer than this value
- * @do_compress:   whether the defrag is doing compression
- *		   if true, @extent_thresh will be ignored and all regular
- *		   file extents meeting @newer_than will be targets.
- * @locked:	   if the range has already held extent lock
- * @target_list:   list of targets file extents
- */
-static int defrag_collect_targets(struct btrfs_inode *inode,
-				  u64 start, u64 len, u32 extent_thresh,
-				  u64 newer_than, bool do_compress,
-				  bool locked, struct list_head *target_list,
-				  u64 *last_scanned_ret)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	bool last_is_target = false;
-	u64 cur = start;
-	int ret = 0;
-
-	while (cur < start + len) {
-		struct extent_map *em;
-		struct defrag_target_range *new;
-		bool next_mergeable = true;
-		u64 range_len;
-
-		last_is_target = false;
-		em = defrag_lookup_extent(&inode->vfs_inode, cur,
-					  newer_than, locked);
-		if (!em)
-			break;
-
-		/*
-		 * If the file extent is an inlined one, we may still want to
-		 * defrag it (fallthrough) if it will cause a regular extent.
-		 * This is for users who want to convert inline extents to
-		 * regular ones through max_inline= mount option.
-		 */
-		if (em->block_start == EXTENT_MAP_INLINE &&
-		    em->len <= inode->root->fs_info->max_inline)
-			goto next;
-
-		/* Skip hole/delalloc/preallocated extents */
-		if (em->block_start == EXTENT_MAP_HOLE ||
-		    em->block_start == EXTENT_MAP_DELALLOC ||
-		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-			goto next;
-
-		/* Skip older extent */
-		if (em->generation < newer_than)
-			goto next;
-
-		/* This em is under writeback, no need to defrag */
-		if (em->generation == (u64)-1)
-			goto next;
-
-		/*
-		 * Our start offset might be in the middle of an existing extent
-		 * map, so take that into account.
-		 */
-		range_len = em->len - (cur - em->start);
-		/*
-		 * If this range of the extent map is already flagged for delalloc,
-		 * skip it, because:
-		 *
-		 * 1) We could deadlock later, when trying to reserve space for
-		 *    delalloc, because in case we can't immediately reserve space
-		 *    the flusher can start delalloc and wait for the respective
-		 *    ordered extents to complete. The deadlock would happen
-		 *    because we do the space reservation while holding the range
-		 *    locked, and starting writeback, or finishing an ordered
-		 *    extent, requires locking the range;
-		 *
-		 * 2) If there's delalloc there, it means there's dirty pages for
-		 *    which writeback has not started yet (we clean the delalloc
-		 *    flag when starting writeback and after creating an ordered
-		 *    extent). If we mark pages in an adjacent range for defrag,
-		 *    then we will have a larger contiguous range for delalloc,
-		 *    very likely resulting in a larger extent after writeback is
-		 *    triggered (except in a case of free space fragmentation).
-		 */
-		if (test_range_bit(&inode->io_tree, cur, cur + range_len - 1,
-				   EXTENT_DELALLOC, 0, NULL))
-			goto next;
-
-		/*
-		 * For do_compress case, we want to compress all valid file
-		 * extents, thus no @extent_thresh or mergeable check.
-		 */
-		if (do_compress)
-			goto add;
-
-		/* Skip too large extent */
-		if (range_len >= extent_thresh)
-			goto next;
-
-		/*
-		 * Skip extents already at its max capacity, this is mostly for
-		 * compressed extents, which max cap is only 128K.
-		 */
-		if (em->len >= get_extent_max_capacity(fs_info, em))
-			goto next;
-
-		/*
-		 * Normally there are no more extents after an inline one, thus
-		 * @next_mergeable will normally be false and not defragged.
-		 * So if an inline extent passed all above checks, just add it
-		 * for defrag, and be converted to regular extents.
-		 */
-		if (em->block_start == EXTENT_MAP_INLINE)
-			goto add;
-
-		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
-						extent_thresh, newer_than, locked);
-		if (!next_mergeable) {
-			struct defrag_target_range *last;
-
-			/* Empty target list, no way to merge with last entry */
-			if (list_empty(target_list))
-				goto next;
-			last = list_entry(target_list->prev,
-					  struct defrag_target_range, list);
-			/* Not mergeable with last entry */
-			if (last->start + last->len != cur)
-				goto next;
-
-			/* Mergeable, fall through to add it to @target_list. */
-		}
-
-add:
-		last_is_target = true;
-		range_len = min(extent_map_end(em), start + len) - cur;
-		/*
-		 * This one is a good target, check if it can be merged into
-		 * last range of the target list.
-		 */
-		if (!list_empty(target_list)) {
-			struct defrag_target_range *last;
-
-			last = list_entry(target_list->prev,
-					  struct defrag_target_range, list);
-			ASSERT(last->start + last->len <= cur);
-			if (last->start + last->len == cur) {
-				/* Mergeable, enlarge the last entry */
-				last->len += range_len;
-				goto next;
-			}
-			/* Fall through to allocate a new entry */
-		}
-
-		/* Allocate new defrag_target_range */
-		new = kmalloc(sizeof(*new), GFP_NOFS);
-		if (!new) {
-			free_extent_map(em);
-			ret = -ENOMEM;
-			break;
-		}
-		new->start = cur;
-		new->len = range_len;
-		list_add_tail(&new->list, target_list);
-
-next:
-		cur = extent_map_end(em);
-		free_extent_map(em);
-	}
-	if (ret < 0) {
-		struct defrag_target_range *entry;
-		struct defrag_target_range *tmp;
-
-		list_for_each_entry_safe(entry, tmp, target_list, list) {
-			list_del_init(&entry->list);
-			kfree(entry);
-		}
-	}
-	if (!ret && last_scanned_ret) {
-		/*
-		 * If the last extent is not a target, the caller can skip to
-		 * the end of that extent.
-		 * Otherwise, we can only go the end of the specified range.
-		 */
-		if (!last_is_target)
-			*last_scanned_ret = max(cur, *last_scanned_ret);
-		else
-			*last_scanned_ret = max(start + len, *last_scanned_ret);
-	}
-	return ret;
-}
-
-#define CLUSTER_SIZE	(SZ_256K)
-static_assert(IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
-
-/*
- * Defrag one contiguous target range.
- *
- * @inode:	target inode
- * @target:	target range to defrag
- * @pages:	locked pages covering the defrag range
- * @nr_pages:	number of locked pages
- *
- * Caller should ensure:
- *
- * - Pages are prepared
- *   Pages should be locked, no ordered extent in the pages range,
- *   no writeback.
- *
- * - Extent bits are locked
- */
-static int defrag_one_locked_target(struct btrfs_inode *inode,
-				    struct defrag_target_range *target,
-				    struct page **pages, int nr_pages,
-				    struct extent_state **cached_state)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_changeset *data_reserved = NULL;
-	const u64 start = target->start;
-	const u64 len = target->len;
-	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
-	unsigned long start_index = start >> PAGE_SHIFT;
-	unsigned long first_index = page_index(pages[0]);
-	int ret = 0;
-	int i;
-
-	ASSERT(last_index - first_index + 1 <= nr_pages);
-
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
-	if (ret < 0)
-		return ret;
-	clear_extent_bit(&inode->io_tree, start, start + len - 1,
-			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			 EXTENT_DEFRAG, cached_state);
-	set_extent_defrag(&inode->io_tree, start, start + len - 1, cached_state);
-
-	/* Update the page status */
-	for (i = start_index - first_index; i <= last_index - first_index; i++) {
-		ClearPageChecked(pages[i]);
-		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
-	}
-	btrfs_delalloc_release_extents(inode, len);
-	extent_changeset_free(data_reserved);
-
-	return ret;
-}
-
-static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
-			    u32 extent_thresh, u64 newer_than, bool do_compress,
-			    u64 *last_scanned_ret)
-{
-	struct extent_state *cached_state = NULL;
-	struct defrag_target_range *entry;
-	struct defrag_target_range *tmp;
-	LIST_HEAD(target_list);
-	struct page **pages;
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
-	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
-	u64 start_index = start >> PAGE_SHIFT;
-	unsigned int nr_pages = last_index - start_index + 1;
-	int ret = 0;
-	int i;
-
-	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
-	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
-
-	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
-	if (!pages)
-		return -ENOMEM;
-
-	/* Prepare all pages */
-	for (i = 0; i < nr_pages; i++) {
-		pages[i] = defrag_prepare_one_page(inode, start_index + i);
-		if (IS_ERR(pages[i])) {
-			ret = PTR_ERR(pages[i]);
-			pages[i] = NULL;
-			goto free_pages;
-		}
-	}
-	for (i = 0; i < nr_pages; i++)
-		wait_on_page_writeback(pages[i]);
-
-	/* Lock the pages range */
-	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-		    &cached_state);
-	/*
-	 * Now we have a consistent view about the extent map, re-check
-	 * which range really needs to be defragged.
-	 *
-	 * And this time we have extent locked already, pass @locked = true
-	 * so that we won't relock the extent range and cause deadlock.
-	 */
-	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, true,
-				     &target_list, last_scanned_ret);
-	if (ret < 0)
-		goto unlock_extent;
-
-	list_for_each_entry(entry, &target_list, list) {
-		ret = defrag_one_locked_target(inode, entry, pages, nr_pages,
-					       &cached_state);
-		if (ret < 0)
-			break;
-	}
-
-	list_for_each_entry_safe(entry, tmp, &target_list, list) {
-		list_del_init(&entry->list);
-		kfree(entry);
-	}
-unlock_extent:
-	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-		      &cached_state);
-free_pages:
-	for (i = 0; i < nr_pages; i++) {
-		if (pages[i]) {
-			unlock_page(pages[i]);
-			put_page(pages[i]);
-		}
-	}
-	kfree(pages);
-	return ret;
-}
-
-static int defrag_one_cluster(struct btrfs_inode *inode,
-			      struct file_ra_state *ra,
-			      u64 start, u32 len, u32 extent_thresh,
-			      u64 newer_than, bool do_compress,
-			      unsigned long *sectors_defragged,
-			      unsigned long max_sectors,
-			      u64 *last_scanned_ret)
-{
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
-	struct defrag_target_range *entry;
-	struct defrag_target_range *tmp;
-	LIST_HEAD(target_list);
-	int ret;
-
-	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, false,
-				     &target_list, NULL);
-	if (ret < 0)
-		goto out;
-
-	list_for_each_entry(entry, &target_list, list) {
-		u32 range_len = entry->len;
-
-		/* Reached or beyond the limit */
-		if (max_sectors && *sectors_defragged >= max_sectors) {
-			ret = 1;
-			break;
-		}
-
-		if (max_sectors)
-			range_len = min_t(u32, range_len,
-				(max_sectors - *sectors_defragged) * sectorsize);
-
-		/*
-		 * If defrag_one_range() has updated last_scanned_ret,
-		 * our range may already be invalid (e.g. hole punched).
-		 * Skip if our range is before last_scanned_ret, as there is
-		 * no need to defrag the range anymore.
-		 */
-		if (entry->start + range_len <= *last_scanned_ret)
-			continue;
-
-		if (ra)
-			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
-				ra, NULL, entry->start >> PAGE_SHIFT,
-				((entry->start + range_len - 1) >> PAGE_SHIFT) -
-				(entry->start >> PAGE_SHIFT) + 1);
-		/*
-		 * Here we may not defrag any range if holes are punched before
-		 * we locked the pages.
-		 * But that's fine, it only affects the @sectors_defragged
-		 * accounting.
-		 */
-		ret = defrag_one_range(inode, entry->start, range_len,
-				       extent_thresh, newer_than, do_compress,
-				       last_scanned_ret);
-		if (ret < 0)
-			break;
-		*sectors_defragged += range_len >>
-				      inode->root->fs_info->sectorsize_bits;
-	}
-out:
-	list_for_each_entry_safe(entry, tmp, &target_list, list) {
-		list_del_init(&entry->list);
-		kfree(entry);
-	}
-	if (ret >= 0)
-		*last_scanned_ret = max(*last_scanned_ret, start + len);
-	return ret;
-}
-
-/*
- * Entry point to file defragmentation.
- *
- * @inode:	   inode to be defragged
- * @ra:		   readahead state (can be NUL)
- * @range:	   defrag options including range and flags
- * @newer_than:	   minimum transid to defrag
- * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
- *		   will be defragged.
- *
- * Return <0 for error.
- * Return >=0 for the number of sectors defragged, and range->start will be updated
- * to indicate the file offset where next defrag should be started at.
- * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
- *  defragging all the range).
- */
-int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
-		      struct btrfs_ioctl_defrag_range_args *range,
-		      u64 newer_than, unsigned long max_to_defrag)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	unsigned long sectors_defragged = 0;
-	u64 isize = i_size_read(inode);
-	u64 cur;
-	u64 last_byte;
-	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
-	bool ra_allocated = false;
-	int compress_type = BTRFS_COMPRESS_ZLIB;
-	int ret = 0;
-	u32 extent_thresh = range->extent_thresh;
-	pgoff_t start_index;
-
-	if (isize == 0)
-		return 0;
-
-	if (range->start >= isize)
-		return -EINVAL;
-
-	if (do_compress) {
-		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
-			return -EINVAL;
-		if (range->compress_type)
-			compress_type = range->compress_type;
-	}
-
-	if (extent_thresh == 0)
-		extent_thresh = SZ_256K;
-
-	if (range->start + range->len > range->start) {
-		/* Got a specific range */
-		last_byte = min(isize, range->start + range->len);
-	} else {
-		/* Defrag until file end */
-		last_byte = isize;
-	}
-
-	/* Align the range */
-	cur = round_down(range->start, fs_info->sectorsize);
-	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
-
-	/*
-	 * If we were not given a ra, allocate a readahead context. As
-	 * readahead is just an optimization, defrag will work without it so
-	 * we don't error out.
-	 */
-	if (!ra) {
-		ra_allocated = true;
-		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
-		if (ra)
-			file_ra_state_init(ra, inode->i_mapping);
-	}
-
-	/*
-	 * Make writeback start from the beginning of the range, so that the
-	 * defrag range can be written sequentially.
-	 */
-	start_index = cur >> PAGE_SHIFT;
-	if (start_index < inode->i_mapping->writeback_index)
-		inode->i_mapping->writeback_index = start_index;
-
-	while (cur < last_byte) {
-		const unsigned long prev_sectors_defragged = sectors_defragged;
-		u64 last_scanned = cur;
-		u64 cluster_end;
-
-		if (btrfs_defrag_cancelled(fs_info)) {
-			ret = -EAGAIN;
-			break;
-		}
-
-		/* We want the cluster end at page boundary when possible */
-		cluster_end = (((cur >> PAGE_SHIFT) +
-			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
-		cluster_end = min(cluster_end, last_byte);
-
-		btrfs_inode_lock(inode, 0);
-		if (IS_SWAPFILE(inode)) {
-			ret = -ETXTBSY;
-			btrfs_inode_unlock(inode, 0);
-			break;
-		}
-		if (!(inode->i_sb->s_flags & SB_ACTIVE)) {
-			btrfs_inode_unlock(inode, 0);
-			break;
-		}
-		if (do_compress)
-			BTRFS_I(inode)->defrag_compress = compress_type;
-		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
-				cluster_end + 1 - cur, extent_thresh,
-				newer_than, do_compress, &sectors_defragged,
-				max_to_defrag, &last_scanned);
-
-		if (sectors_defragged > prev_sectors_defragged)
-			balance_dirty_pages_ratelimited(inode->i_mapping);
-
-		btrfs_inode_unlock(inode, 0);
-		if (ret < 0)
-			break;
-		cur = max(cluster_end + 1, last_scanned);
-		if (ret > 0) {
-			ret = 0;
-			break;
-		}
-		cond_resched();
-	}
-
-	if (ra_allocated)
-		kfree(ra);
-	/*
-	 * Update range.start for autodefrag, this will indicate where to start
-	 * in next run.
-	 */
-	range->start = cur;
-	if (sectors_defragged) {
-		/*
-		 * We have defragged some sectors, for compression case they
-		 * need to be written back immediately.
-		 */
-		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
-			filemap_flush(inode->i_mapping);
-			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-				     &BTRFS_I(inode)->runtime_flags))
-				filemap_flush(inode->i_mapping);
-		}
-		if (range->compress_type == BTRFS_COMPRESS_LZO)
-			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
-		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
-			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
-		ret = sectors_defragged;
-	}
-	if (do_compress) {
-		btrfs_inode_lock(inode, 0);
-		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
-		btrfs_inode_unlock(inode, 0);
-	}
-	return ret;
-}
-
 /*
  * Try to start exclusive operation @type or cancel it if it's running.
  *
-- 
2.26.3

