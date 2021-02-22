Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA843210E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBVGf4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:35:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:48818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhBVGfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:35:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAemwNuTMOLE3xNCcYQwyeX7JZLs7sR5/WFUAAzd4/s=;
        b=KzvvuOJRvJftjIcdXd9BO97dRFTpWULdi0vogrApYSh2+93GYckU+vwC5Te+TRssOeqyTU
        TiDE0AcY/QA/dIaOUFQeo+gf5tCq38qnuSGCZPwkVd3lcR7Bet9+RE1svKNadx90qembvh
        xnj8/wTvCxXoDT9aIhqmtbArZ8mikYA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A58BB128
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/12] btrfs: extent_io: introduce write_one_subpage_eb() function
Date:   Mon, 22 Feb 2021 14:33:55 +0800
Message-Id: <20210222063357.92930-11-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new function, write_one_subpage_eb(), as a subroutine for subpage
metadata write, will handle the extent buffer bio submission.

The main difference between the new write_one_subpage_eb() and
write_one_eb() is:
- No page locking
  When entering write_one_subpage_eb() the page is no longer locked.
  We only lock the page for its status update, and unlock immediately.
  Now we completely rely on extent io tree locking.

- Extra bitmap update along with page status update
  Now page dirty and writeback is controlled by
  btrfs_subpage dirty_bitmap and writeback_bitmap.
  They both follow the schema that any sector is dirty/writeback, then
  the full page get dirty/writeback.

- When to update the nr_written number
  Now we take a short cut, if we have cleared the last dirty bit of the
  page, we update nr_written.
  This is not completely perfect, but should emulate the old behavior
  good enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d0afff0eb252..ea603c1f2994 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4156,6 +4156,58 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 	bio_put(bio);
 }
 
+/*
+ * Unlike the work in write_one_eb(), we rely completely on extent locking.
+ * Page locking is only utizlied at minimal to keep the VM code happy.
+ *
+ * Caller should still call write_one_eb() other than this function directly.
+ * As write_one_eb() has extra prepration before submitting the extent buffer.
+ */
+static int write_one_subpage_eb(struct extent_buffer *eb,
+				struct writeback_control *wbc,
+				struct extent_page_data *epd)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct page *page = eb->pages[0];
+	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	bool no_dirty_ebs = false;
+	int ret;
+
+	/* clear_page_dirty_for_io() in subpage helper need page locked. */
+	lock_page(page);
+	btrfs_subpage_set_writeback(fs_info, page, eb->start, eb->len);
+
+	/* If we're the last dirty bit to update nr_written */
+	no_dirty_ebs = btrfs_subpage_clear_and_test_dirty(fs_info, page,
+							  eb->start, eb->len);
+	if (no_dirty_ebs)
+		clear_page_dirty_for_io(page);
+
+	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc, page,
+			eb->start, eb->len, eb->start - page_offset(page),
+			&epd->bio, end_bio_extent_buffer_writepage, 0, 0, 0,
+			false);
+	if (ret) {
+		btrfs_subpage_clear_writeback(fs_info, page, eb->start,
+					      eb->len);
+		set_btree_ioerr(page, eb);
+		unlock_page(page);
+
+		if (atomic_dec_and_test(&eb->io_pages))
+			end_extent_buffer_writeback(eb);
+		return -EIO;
+	}
+	unlock_page(page);
+	/*
+	 * Submission finishes without problem, if no range of the page is
+	 * dirty anymore, we have submitted a page.
+	 * Update the nr_written in wbc.
+	 */
+	if (no_dirty_ebs)
+		update_nr_written(wbc, 1);
+	return ret;
+}
+
 static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			struct writeback_control *wbc,
 			struct extent_page_data *epd)
@@ -4187,6 +4239,9 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		memzero_extent_buffer(eb, start, end - start);
 	}
 
+	if (eb->fs_info->sectorsize < PAGE_SIZE)
+		return write_one_subpage_eb(eb, wbc, epd);
+
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
-- 
2.30.0

