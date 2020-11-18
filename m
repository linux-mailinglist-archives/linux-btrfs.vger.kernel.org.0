Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5532B7998
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKRIxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYs2DNck8XXzhJBLuS91GlFju/++E1u4OEs4AHhbeNc=;
        b=IE96hKPVlbXkZE3mlBBp6/kr7KWfTQ1ceBLaLhgwOgvJtLLF8czg28t9RuKTxqpeu9K4Fx
        UY2w6t+LVaybf99NKELgzUQ85nysi3xvX0fBFlS88ybhY4Cs/NCArAMg7QDEL9iXuOPyvY
        LFI4j986/IfJvx5oASj+8/7rGwphCSg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A28EABF4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/14] btrfs: extent_io: introduce read_extent_buffer_subpage()
Date:   Wed, 18 Nov 2020 16:53:14 +0800
Message-Id: <20201118085319.56668-10-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
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
 fs/btrfs/extent_io.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8a558a43818d..b395daf62086 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -604,6 +604,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 	ASSERT(page->private);
 	eb = (struct extent_buffer *)page->private;
 
+
 	/*
 	 * The pending IO might have been the only thing that kept this buffer
 	 * in memory.  Make sure we have a ref for all this other checks
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 28f35eb06bf8..35aee688d6c1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5722,6 +5722,75 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
+				      int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_subpage *subpage;
+	struct extent_io_tree *io_tree;
+	struct page *page = eb->pages[0];
+	struct bio *bio = NULL;
+	int start = (eb->start - page_offset(page)) >> fs_info->sectorsize_bits;
+	int ret = 0;
+
+	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
+	ASSERT(PagePrivate(page));
+	subpage = (struct btrfs_subpage *)page->private;
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
+	    PageUptodate(page) || test_bit(start, subpage->uptodate_bitmap)) {
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
@@ -5738,6 +5807,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
 
+	if (btrfs_is_subpage(eb->fs_info))
+		return read_extent_buffer_subpage(eb, wait, mirror_num);
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-- 
2.29.2

