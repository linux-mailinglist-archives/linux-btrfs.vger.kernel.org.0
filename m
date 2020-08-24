Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8C24F37E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgHXIAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 04:00:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgHXIAN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 04:00:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31FC8AC83
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 08:00:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: remove the again: tag in process_one_batch()
Date:   Mon, 24 Aug 2020 15:59:59 +0800
Message-Id: <20200824075959.85212-4-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824075959.85212-1-wqu@suse.com>
References: <20200824075959.85212-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The again: tag here is for us to retry when we failed to lock extent
range, which is only used once.

Instead of the open tag, integrate prepare_pages() and
lock_and_cleanup_extent_if_need() into lock_pages_and_extent(), and do
the retry inside the function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 183 +++++++++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 81d480b5218d..de829e42410b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1456,83 +1456,6 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 
 }
 
-/*
- * This function locks the extent and properly waits for data=ordered extents
- * to finish before allowing the pages to be modified if need.
- *
- * The return value:
- * 1 - the extent is locked
- * 0 - the extent is not locked, and everything is OK
- * -EAGAIN - need re-prepare the pages
- * the other < 0 number - Something wrong happens
- */
-static noinline int
-lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
-				size_t num_pages, loff_t pos,
-				size_t write_bytes,
-				u64 *lockstart, u64 *lockend,
-				struct extent_state **cached_state)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 start_pos;
-	u64 last_pos;
-	int i;
-	int ret = 0;
-
-	start_pos = round_down(pos, fs_info->sectorsize);
-	last_pos = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
-
-	if (start_pos < inode->vfs_inode.i_size) {
-		struct btrfs_ordered_extent *ordered;
-
-		lock_extent_bits(&inode->io_tree, start_pos, last_pos,
-				cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, start_pos,
-						     last_pos - start_pos + 1);
-		if (ordered &&
-		    ordered->file_offset + ordered->num_bytes > start_pos &&
-		    ordered->file_offset <= last_pos) {
-			unlock_extent_cached(&inode->io_tree, start_pos,
-					last_pos, cached_state);
-			for (i = 0; i < num_pages; i++) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
-			btrfs_start_ordered_extent(&inode->vfs_inode,
-					ordered, 1);
-			btrfs_put_ordered_extent(ordered);
-			return -EAGAIN;
-		}
-		if (ordered)
-			btrfs_put_ordered_extent(ordered);
-
-		*lockstart = start_pos;
-		*lockend = last_pos;
-		ret = 1;
-	}
-
-	/*
-	 * It's possible the pages are dirty right now, but we don't want
-	 * to clean them yet because copy_from_user may catch a page fault
-	 * and we might have to fall back to one page at a time.  If that
-	 * happens, we'll unlock these pages and we'd have a window where
-	 * reclaim could sneak in and drop the once-dirty page on the floor
-	 * without writing it.
-	 *
-	 * We have the pages locked and the extent range locked, so there's
-	 * no way someone can start IO on any dirty pages in this range.
-	 *
-	 * We'll call btrfs_dirty_pages() later on, and that will flip around
-	 * delalloc bits and dirty the pages as required.
-	 */
-	for (i = 0; i < num_pages; i++) {
-		set_page_extent_mapped(pages[i]);
-		WARN_ON(!PageLocked(pages[i]));
-	}
-
-	return ret;
-}
-
 static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait)
 {
@@ -1646,6 +1569,87 @@ static int get_nr_pages(struct btrfs_fs_info *fs_info, loff_t pos,
 	return nr_pages;
 }
 
+/*
+ * The helper to lock both pages and extent bits
+ *
+ * Return 0 if the extent is not locked and everything is OK.
+ * Return 1 if the extent is locked and everything is OK.
+ * Return <0 for error.
+ */
+static int lock_pages_and_extent(struct btrfs_inode *inode, struct page **pages,
+				 int num_pages, loff_t pos, size_t write_bytes,
+				 u64 *lockstart, u64 *lockend,
+				 struct extent_state **cached_state,
+				 bool force_uptodate)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u64 start_pos;
+	u64 last_pos;
+	int ret;
+	int i;
+
+again:
+	/* Lock the pages */
+	ret = prepare_pages(&inode->vfs_inode, pages, num_pages, pos,
+			    write_bytes, force_uptodate);
+	if (ret < 0)
+		return ret;
+
+	start_pos = round_down(pos, fs_info->sectorsize);
+	last_pos = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
+
+	if (start_pos < inode->vfs_inode.i_size) {
+		struct btrfs_ordered_extent *ordered;
+
+		/* Lock the extent range */
+		lock_extent_bits(&inode->io_tree, start_pos, last_pos,
+				cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, start_pos,
+						     last_pos - start_pos + 1);
+		if (ordered &&
+		    ordered->file_offset + ordered->num_bytes > start_pos &&
+		    ordered->file_offset <= last_pos) {
+			unlock_extent_cached(&inode->io_tree, start_pos,
+					last_pos, cached_state);
+			for (i = 0; i < num_pages; i++) {
+				unlock_page(pages[i]);
+				put_page(pages[i]);
+			}
+			btrfs_start_ordered_extent(&inode->vfs_inode,
+					ordered, 1);
+			btrfs_put_ordered_extent(ordered);
+			goto again;
+		}
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
+
+		*lockstart = start_pos;
+		*lockend = last_pos;
+		ret = 1;
+	}
+
+	/*
+	 * It's possible the pages are dirty right now, but we don't want
+	 * to clean them yet because copy_from_user may catch a page fault
+	 * and we might have to fall back to one page at a time.  If that
+	 * happens, we'll unlock these pages and we'd have a window where
+	 * reclaim could sneak in and drop the once-dirty page on the floor
+	 * without writing it.
+	 *
+	 * We have the pages locked and the extent range locked, so there's
+	 * no way someone can start IO on any dirty pages in this range.
+	 *
+	 * We'll call btrfs_dirty_pages() later on, and that will flip around
+	 * delalloc bits and dirty the pages as required.
+	 */
+	for (i = 0; i < num_pages; i++) {
+		set_page_extent_mapped(pages[i]);
+		WARN_ON(!PageLocked(pages[i]));
+	}
+
+	return ret;
+}
+
 /*
  * The helper to copy one batch of data from iov to pages.
  *
@@ -1735,29 +1739,14 @@ static ssize_t process_one_batch(struct inode *inode, struct page **pages,
 	release_bytes = reserve_bytes;
 
 	/* Lock the pages and extent range */
-again:
-	/*
-	 * This is going to setup the pages array with the number of pages we
-	 * want, so we don't really need to worry about the contents of pages
-	 * from loop to loop.
-	 */
-	ret = prepare_pages(inode, pages, num_pages, pos, write_bytes,
-			    force_uptodate);
-	if (ret) {
-		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
-		goto out;
-	}
-
-	extents_locked = lock_and_cleanup_extent_if_need(BTRFS_I(inode), pages,
-			num_pages, pos, write_bytes, &lockstart,
-			&lockend, &cached_state);
-	if (extents_locked < 0) {
-		if (extents_locked == -EAGAIN)
-			goto again;
+	ret = lock_pages_and_extent(BTRFS_I(inode), pages, num_pages, pos,
+			write_bytes, &lockstart, &lockend, &cached_state,
+			force_uptodate);
+	if (ret < 0) {
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
-		ret = extents_locked;
 		goto out;
 	}
+	extents_locked = ret;
 
 	/* Copy the data from iov to pages */
 	copied = btrfs_copy_from_user(pos, write_bytes, pages, iov);
-- 
2.28.0

