Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9152023E7EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Aug 2020 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHGH2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Aug 2020 03:28:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGH2B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Aug 2020 03:28:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E8C5B1D8
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Aug 2020 07:28:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: refactor how we prepare pages for btrfs_buffered_write()
Date:   Fri,  7 Aug 2020 15:27:53 +0800
Message-Id: <20200807072753.68285-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we prepare pages for buffered write, we need to ensure that if
we're partially dirting a page, then it must be uptodate to make sure it
has the old content read from disk.

While for pages that is completely inside the write range, we don't need
to make it uptodate at all, thus we can skip one page read.

The old method uses @force_page_uptodate flag, but in fact it doesn't
make any sense at all.
In parepare_uptodate_page() it has the check to ensure we always force
a paritially written page to be uptodate.

So this patch will refactor the mess, to make it more easier to read by:
- Remove the @force_page_uptodate bit
  It makes no difference at all

- Remove the @pos and @force_uptodate for prepare_uptodate_page()
  Now the caller, parepare_pages() will determine if it's necessary.

- Add more comment for parepare_pages()
  This will explain why we don't need some pages to be uptodate.

- Use page_offset() to be more user-friendly
  After find_or_create_page(), page_offset() will return the offset
  inside the address space, thus can be used directly to be more
  reader-friendly.

The new code uses the following method to do such check:

	full_dirty_page_start = round_up(pos, fs_info->sectorsize);
	full_dirty_page_end = round_down(pos + write_bytes,
					 fs_info->sectorsize) - 1;
	for (i = 0; i < num_pages; i++) {
		...
		if (!err && !(page_offset >= full_dirty_page_start &&
			      page_offset <= full_dirty_page_end))
			err = prepare_uptodate_page(inode, pages[i]);
	}

Which can handle all the possible cases like:
- Dirty range in side a page
  || |///| ||
  Then @full_dirty_page_start > @full_dirty_page_end, and it result will
  always be (!err && !(false))

- Dirty range across one page boundary
  ||   |///||//|     ||
  Then @full_dirty_page_start == @full_dirty_page_end + 1, the same
  as above case.

- Dirty range covers a full page
  ||   |///||////////||//|     ||
  Then only for the 2nd page meet the condition, and skip the
  prepare_uptodate_page() call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 841c516079a9..705ebe709e8d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1378,13 +1378,11 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
  * on success we return a locked page and 0
  */
 static int prepare_uptodate_page(struct inode *inode,
-				 struct page *page, u64 pos,
-				 bool force_uptodate)
+				 struct page *page)
 {
 	int ret = 0;
 
-	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
-	    !PageUptodate(page)) {
+	if (!PageUptodate(page)) {
 		ret = btrfs_readpage(NULL, page);
 		if (ret)
 			return ret;
@@ -1406,14 +1404,29 @@ static int prepare_uptodate_page(struct inode *inode,
  */
 static noinline int prepare_pages(struct inode *inode, struct page **pages,
 				  size_t num_pages, loff_t pos,
-				  size_t write_bytes, bool force_uptodate)
+				  size_t write_bytes)
 {
-	int i;
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
+	u64 full_dirty_page_start;
+	u64 full_dirty_page_end;
 	int err = 0;
 	int faili;
+	int i;
 
+	/*
+	 * || = page boundary
+	 *
+	 *     @pos                   @pos + write_bytes
+	 * ||  |///||//////||/////||//|   ||
+	 *	    \		  /
+	 *           In this range, we don't need to the page to
+	 *           be uptodate at all.
+	 */
+	full_dirty_page_start = round_up(pos, fs_info->sectorsize);
+	full_dirty_page_end = round_down(pos + write_bytes,
+					 fs_info->sectorsize) - 1;
 	for (i = 0; i < num_pages; i++) {
 again:
 		pages[i] = find_or_create_page(inode->i_mapping, index + i,
@@ -1424,12 +1437,9 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 			goto fail;
 		}
 
-		if (i == 0)
-			err = prepare_uptodate_page(inode, pages[i], pos,
-						    force_uptodate);
-		if (!err && i == num_pages - 1)
-			err = prepare_uptodate_page(inode, pages[i],
-						    pos + write_bytes, false);
+		if (!err && !(page_offset(pages[i]) >= full_dirty_page_start &&
+			      page_offset(pages[i]) <= full_dirty_page_end))
+			err = prepare_uptodate_page(inode, pages[i]);
 		if (err) {
 			put_page(pages[i]);
 			if (err == -EAGAIN) {
@@ -1638,7 +1648,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	int nrptrs;
 	int ret = 0;
 	bool only_release_metadata = false;
-	bool force_page_uptodate = false;
 
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
@@ -1727,8 +1736,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 * contents of pages from loop to loop
 		 */
 		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes,
-				    force_page_uptodate);
+				    pos, write_bytes);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -1763,11 +1771,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			nrptrs = 1;
 
 		if (copied == 0) {
-			force_page_uptodate = true;
 			dirty_sectors = 0;
 			dirty_pages = 0;
 		} else {
-			force_page_uptodate = false;
 			dirty_pages = DIV_ROUND_UP(copied + offset,
 						   PAGE_SIZE);
 		}
-- 
2.28.0

