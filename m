Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6636CF17
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhD0XEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:04:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:36762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235395AbhD0XEw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:04:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlne2mkRKIXsJOmy/dg6mVYkKKgDHWkEukSUSrKrBoM=;
        b=rNkjXDQVtMQkMabLhMkDn3jymxNr+HVDi1/4Mzk5f5HerWlwXjuXnLnR/lHIxwOfqMl+Yw
        IsaUicFXRLWVmVC5Cjf8eG86sGdNmevVNg6jlTFQHfgCIfG06e1nILuUlQOPgcHiQo0e8y
        7mYuRN8u1o+ulARJ+6PIxfsqMSlpmDA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F912ABED
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 06/42] btrfs: make subpage metadata write path to call its own endio functions
Date:   Wed, 28 Apr 2021 07:03:13 +0800
Message-Id: <20210427230349.369603-7-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage metadata, we're reusing two functions for subpage metadata
write:
- end_bio_extent_buffer_writepage()
- write_one_eb()

But the truth is, for subpage we just call
end_bio_subpage_eb_writepage() without using any bit in
end_bio_extent_buffer_writepage().

For write_one_eb(), it's pretty similar, but with a small part of code
reused.

There is really no need to pollute the existing code path if we're not
really using most of them.

So this patch will do the following change to separate the subpage
metadata write path from regular write path by:
- Use end_bio_subpage_eb_writepage() directly as endio in
  write_one_subpage_eb()
- Directly call write_one_subpage_eb() in submit_eb_subpage()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 73 ++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 949b603e7aa3..13278ee2ad85 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4172,12 +4172,15 @@ static struct extent_buffer *find_extent_buffer_nolock(
  * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
  * after all extent buffers in the page has finished their writeback.
  */
-static void end_bio_subpage_eb_writepage(struct btrfs_fs_info *fs_info,
-					 struct bio *bio)
+static void end_bio_subpage_eb_writepage(struct bio *bio)
 {
+	struct btrfs_fs_info *fs_info;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
+	ASSERT(fs_info->sectorsize < PAGE_SIZE);
+
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
@@ -4228,16 +4231,11 @@ static void end_bio_subpage_eb_writepage(struct btrfs_fs_info *fs_info,
 
 static void end_bio_extent_buffer_writepage(struct bio *bio)
 {
-	struct btrfs_fs_info *fs_info;
 	struct bio_vec *bvec;
 	struct extent_buffer *eb;
 	int done;
 	struct bvec_iter_all iter_all;
 
-	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
-	if (fs_info->sectorsize < PAGE_SIZE)
-		return end_bio_subpage_eb_writepage(fs_info, bio);
-
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
@@ -4263,12 +4261,35 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 	bio_put(bio);
 }
 
+static void prepare_eb_write(struct extent_buffer *eb)
+{
+	u32 nritems;
+	unsigned long start;
+	unsigned long end;
+
+	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
+	atomic_set(&eb->io_pages, num_extent_pages(eb));
+
+	/* set btree blocks beyond nritems with 0 to avoid stale content. */
+	nritems = btrfs_header_nritems(eb);
+	if (btrfs_header_level(eb) > 0) {
+		end = btrfs_node_key_ptr_offset(nritems);
+
+		memzero_extent_buffer(eb, end, eb->len - end);
+	} else {
+		/*
+		 * leaf:
+		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
+		 */
+		start = btrfs_item_nr_offset(nritems);
+		end = BTRFS_LEAF_DATA_OFFSET + leaf_data_end(eb);
+		memzero_extent_buffer(eb, start, end - start);
+	}
+}
+
 /*
  * Unlike the work in write_one_eb(), we rely completely on extent locking.
  * Page locking is only utilized at minimum to keep the VMM code happy.
- *
- * Caller should still call write_one_eb() other than this function directly.
- * As write_one_eb() has extra preparation before submitting the extent buffer.
  */
 static int write_one_subpage_eb(struct extent_buffer *eb,
 				struct writeback_control *wbc,
@@ -4280,6 +4301,8 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	bool no_dirty_ebs = false;
 	int ret;
 
+	prepare_eb_write(eb);
+
 	/* clear_page_dirty_for_io() in subpage helper needs page locked */
 	lock_page(page);
 	btrfs_subpage_set_writeback(fs_info, page, eb->start, eb->len);
@@ -4293,7 +4316,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 			&epd->bio_ctrl, page, eb->start, eb->len,
 			eb->start - page_offset(page),
-			end_bio_extent_buffer_writepage, 0, 0, false);
+			end_bio_subpage_eb_writepage, 0, 0, false);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
 		set_btree_ioerr(page, eb);
@@ -4318,35 +4341,13 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			struct extent_page_data *epd)
 {
 	u64 disk_bytenr = eb->start;
-	u32 nritems;
 	int i, num_pages;
-	unsigned long start, end;
 	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
 	int ret = 0;
 
-	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
-	num_pages = num_extent_pages(eb);
-	atomic_set(&eb->io_pages, num_pages);
-
-	/* set btree blocks beyond nritems with 0 to avoid stale content. */
-	nritems = btrfs_header_nritems(eb);
-	if (btrfs_header_level(eb) > 0) {
-		end = btrfs_node_key_ptr_offset(nritems);
-
-		memzero_extent_buffer(eb, end, eb->len - end);
-	} else {
-		/*
-		 * leaf:
-		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
-		 */
-		start = btrfs_item_nr_offset(nritems);
-		end = BTRFS_LEAF_DATA_OFFSET + leaf_data_end(eb);
-		memzero_extent_buffer(eb, start, end - start);
-	}
-
-	if (eb->fs_info->sectorsize < PAGE_SIZE)
-		return write_one_subpage_eb(eb, wbc, epd);
+	prepare_eb_write(eb);
 
+	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
@@ -4460,7 +4461,7 @@ static int submit_eb_subpage(struct page *page,
 			free_extent_buffer(eb);
 			goto cleanup;
 		}
-		ret = write_one_eb(eb, wbc, epd);
+		ret = write_one_subpage_eb(eb, wbc, epd);
 		free_extent_buffer(eb);
 		if (ret < 0)
 			goto cleanup;
-- 
2.31.1

