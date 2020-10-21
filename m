Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B39294841
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440802AbgJUG1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440805AbgJUG1U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6+Z4XnRVG2xQngEzqbT8NgtEb3+oT44JPfM1xSLBaQ=;
        b=qtPb46ylD/UZu9Ca2fyQoAd/JuGq38NmDUqxl7EOL5fjH/p4shXt8w3fAV2t/ygciCcv+w
        MgZHUOooFzX3OB1NroDMoQWQ7RC6tQ0W4rFY3NAwXg49s0p29DvkT7JW8B3SZFG5tr3l2e
        oZlFEx6igTy7BZdIJjroim8iVRiq4M4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A81C2AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 37/68] btrfs: extent_io: implement subpage metadata read and its endio function
Date:   Wed, 21 Oct 2020 14:25:23 +0800
Message-Id: <20201021062554.68132-38-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage metadata read, since we're completely relying on io tree
other than page bits, its read submission and endio function is
different from the regular page size.

For submission part:
- Do extent locking/waiting
  Instead of page locking, we do extent io tree locking, which provides
  subpage granularity locking.

  And since we're no longer relying on full page locking, which means in
  theory we can submit parallel metadata read even they are in the same
  page.

- Submit extent page directly
  To simply the process, as all the metadata read is always contained in
  one page.

For endio part:
- Do extent locking
  The same as submission part, instead of page locking, only reply on
  extent io tree locking.

This behavior has a small problem that, extent locking/waiting are all
going to allocate memory, thus they can all fail.

Currently we're relying on the BUG_ON() in various set_extent_bits()
calls. But when we're going to handle the error from them, this way
would make it more complex to pass all the ENOMEM error upwards.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.c | 74 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 10bdb0a8a92f..89021e552da0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -651,6 +651,84 @@ static int btrfs_check_extent_buffer(struct extent_buffer *eb)
 	return ret;
 }
 
+static int btree_read_subpage_endio_hook(struct page *page, u64 start, u64 end,
+					 int mirror)
+{
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+	struct extent_buffer *eb;
+	int reads_done;
+	int ret = 0;
+
+	if (!IS_ALIGNED(start, fs_info->sectorsize) ||
+	    !IS_ALIGNED(end - start + 1, fs_info->sectorsize) ||
+	    !IS_ALIGNED(end - start + 1, fs_info->nodesize)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info, "invalid tree read bytenr");
+		return -EUCLEAN;
+	}
+
+	/*
+	 * We don't allow bio merge for subpage metadata read, so we should
+	 * only get one eb for each endio hook.
+	 */
+	ASSERT(end == start + fs_info->nodesize - 1);
+	ASSERT(PagePrivate(page));
+
+	rcu_read_lock();
+	eb = radix_tree_lookup(&fs_info->buffer_radix,
+			       start / fs_info->sectorsize);
+	rcu_read_unlock();
+
+	/*
+	 * When we are reading one tree block, eb must have been
+	 * inserted into the radix tree. If not something is wrong.
+	 */
+	if (!eb) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info,
+			"can't find extent buffer for bytenr %llu",
+			start);
+		return -EUCLEAN;
+	}
+	/*
+	 * The pending IO might have been the only thing that kept
+	 * this buffer in memory.  Make sure we have a ref for all
+	 * this other checks
+	 */
+	atomic_inc(&eb->refs);
+
+	reads_done = atomic_dec_and_test(&eb->io_pages);
+	/* Subpage read must finish in page read */
+	ASSERT(reads_done);
+
+	eb->read_mirror= mirror;
+	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
+		ret = -EIO;
+		goto err;
+	}
+	ret = btrfs_check_extent_buffer(eb);
+	if (ret < 0)
+		goto err;
+
+	if (test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
+		btree_readahead_hook(eb, ret);
+
+	set_extent_buffer_uptodate(eb);
+
+	free_extent_buffer(eb);
+	return ret;
+err:
+	/*
+	 * our io error hook is going to dec the io pages
+	 * again, we have to make sure it has something to
+	 * decrement
+	 */
+	atomic_inc(&eb->io_pages);
+	clear_extent_buffer_uptodate(eb);
+	free_extent_buffer(eb);
+	return ret;
+}
+
 static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 				      u64 phy_offset, struct page *page,
 				      u64 start, u64 end, int mirror)
@@ -659,6 +737,9 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	int ret = 0;
 	bool reads_done;
 
+	if (btrfs_is_subpage(page_to_fs_info(page)))
+		return btree_read_subpage_endio_hook(page, start, end, mirror);
+
 	/* Metadata pages that goes through IO should all have private set */
 	ASSERT(PagePrivate(page) && page->private);
 	eb = (struct extent_buffer *)page->private;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dcc7d4602cea..2f9609d35f0c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3111,6 +3111,15 @@ static int submit_extent_page(unsigned int opf,
 		else
 			contig = bio_end_sector(bio) == sector;
 
+		/*
+		 * For subpage metadata read, never merge request, so that
+		 * we get endio hook called on each metadata read.
+		 */
+		if (btrfs_is_subpage(page_to_fs_info(page)) &&
+		    tree->owner == IO_TREE_BTREE_INODE_IO &&
+		    (opf & REQ_OP_READ))
+			ASSERT(force_bio_submit);
+
 		ASSERT(tree->ops);
 		if (btrfs_bio_fits_in_stripe(page, io_size, bio, bio_flags))
 			can_merge = false;
@@ -5681,6 +5690,68 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
+				      int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	struct page *page = eb->pages[0];
+	struct bio *bio = NULL;
+	int ret = 0;
+
+	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
+
+	if (wait == WAIT_NONE) {
+		ret = try_lock_extent(io_tree, eb->start,
+				      eb->start + eb->len - 1);
+		if (ret <= 0)
+			return ret;
+	} else {
+		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = 0;
+	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
+	    PageUptodate(page) ||
+	    test_range_bit(io_tree, eb->start, eb->start + eb->len - 1,
+			   EXTENT_UPTODATE, 1, NULL)) {
+		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		return ret;
+	}
+	atomic_set(&eb->io_pages, 1);
+
+	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, page, eb->start,
+				 eb->len, eb->start - page_offset(page), &bio,
+				 end_bio_extent_readpage, mirror_num, 0, 0,
+				 true);
+	if (ret) {
+		/*
+		 * In the endio function, if we hit something wrong we will
+		 * increase the io_pages, so here we need to decrease it for error
+		 * path.
+		 */
+		atomic_dec(&eb->io_pages);
+	}
+	if (bio) {
+		int tmp;
+
+		tmp = submit_one_bio(bio, mirror_num, 0);
+		if (tmp < 0)
+			return tmp;
+	}
+	if (ret || wait != WAIT_COMPLETE)
+		return ret;
+
+	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+			EXTENT_LOCKED);
+	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+		ret = -EIO;
+	return ret;
+}
+
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 {
 	int i;
@@ -5697,6 +5768,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
 
+	if (btrfs_is_subpage(eb->fs_info))
+		return read_extent_buffer_subpage(eb, wait, mirror_num);
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-- 
2.28.0

