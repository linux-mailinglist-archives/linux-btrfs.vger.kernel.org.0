Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746D82EB76D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbhAFBE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:04:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbhAFBE0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2V1dkXP68zqlWUUJv2gCoMndfOciJHtWeb2y7TocLw=;
        b=TBqLuahrFInvXp7OES/krZ4foPipvJINgBSbdSeTzIvxWey/rPZ8OQboS16crzfMR6qW5q
        9uia7pESa3pxNxpNCojO1Z/2ZfDYzLtMc5clmKBw55zZ2LW9+qO3dYZ9unHXUSyDo4cdjt
        P3uWjnkxgWV73EOcX2SEdAPsi9m2g/U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25765AF72
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 17/22] btrfs: extent_io: introduce read_extent_buffer_subpage()
Date:   Wed,  6 Jan 2021 09:01:56 +0800
Message-Id: <20210106010201.37864-18-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, read_extent_buffer_subpage(), to do the subpage
extent buffer read.

The difference between regular and subpage routines are:
- No page locking
  Here we completely rely on extent locking.
  Page locking can reduce the concurrency greatly, as if we lock one
  page to read one extent buffer, all the other extent buffers in the
  same page will have to wait.

- Extent uptodate condition
  Despite the existing PageUptodate() and EXTENT_BUFFER_UPTODATE check,
  We also need to check btrfs_subpage::uptodate_bitmap.

- No page loop
  Just one page, no need to loop, this greately simplified the subpage
  routine.

This patch only implemented the bio submit part, no endio support yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  1 +
 fs/btrfs/extent_io.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5473bed6a7e8..7440663e8d13 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -602,6 +602,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 	ASSERT(page->private);
 	eb = (struct extent_buffer *)page->private;
 
+
 	/*
 	 * The pending IO might have been the only thing that kept this buffer
 	 * in memory.  Make sure we have a ref for all this other checks
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 792264f5c3c2..b828314bf43a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5641,6 +5641,73 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
+				      int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_io_tree *io_tree;
+	struct page *page = eb->pages[0];
+	struct bio *bio = NULL;
+	int ret = 0;
+
+	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
+	ASSERT(PagePrivate(page));
+	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
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
+	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
+		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		return ret;
+	}
+
+	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
+	eb->read_mirror = 0;
+	atomic_set(&eb->io_pages, 1);
+	check_buffer_tree_ref(eb);
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
@@ -5657,6 +5724,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
 
+	if (eb->fs_info->sectorsize < PAGE_SIZE)
+		return read_extent_buffer_subpage(eb, wait, mirror_num);
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-- 
2.29.2

