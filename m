Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF35236CF18
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhD0XEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235395AbhD0XEy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:04:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SX8zX4QQrbvCf+7uEo22h9kPI09WshHpC0pXWUAtxc=;
        b=rDFBFbU2999yPhL+WUb76Oj/IyvpbDK7gPYoRupWnUoJawitHAGiQOXepOLkhwbYSe9UTZ
        xV3ypGOyftdrurl7SgwmpQuAijj57Y80vfo7HO3dRCrs82037e1KlZNPf1Iws0oygPDJMn
        gpDDWLBrmlJOvC/WHlvpE1ozaen00HA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B65D7AEF5
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 07/42] btrfs: pass btrfs_inode into btrfs_writepage_endio_finish_ordered()
Date:   Wed, 28 Apr 2021 07:03:14 +0800
Message-Id: <20210427230349.369603-8-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a pretty bad abuse of btrfs_writepage_endio_finish_ordered() in
end_compressed_bio_write().

It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
which is only supposed to accept inode pages.

Thankfully the important info here is the inode, so let's pass
btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
make @page parameter optional.

By this, end_compressed_bio_write() can happily pass page=NULL while
still get everything done properly.

Also, to cooperate with such modification, replace @page parameter for
trace_btrfs_writepage_end_io_hook() with btrfs_inode.
Although this removes page_index info, the existing start/len should be
enough for most usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c       |  4 +---
 fs/btrfs/ctree.h             |  3 ++-
 fs/btrfs/extent_io.c         | 16 ++++++++++------
 fs/btrfs/inode.c             |  9 +++++----
 include/trace/events/btrfs.h | 19 ++++++++-----------
 5 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 17f93fd28f7e..47e0d33ea46d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -348,11 +348,9 @@ static void end_compressed_bio_write(struct bio *bio)
 	 * call back into the FS and do all the end_io operations
 	 */
 	inode = cb->inode;
-	cb->compressed_pages[0]->mapping = cb->inode->i_mapping;
-	btrfs_writepage_endio_finish_ordered(cb->compressed_pages[0],
+	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
 			cb->start, cb->start + cb->len - 1,
 			bio->bi_status == BLK_STS_OK);
-	cb->compressed_pages[0]->mapping = NULL;
 
 	end_compressed_writeback(inode, cb);
 	/* note, our inode could be gone now */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b94790583008..23fc9a56da32 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3185,7 +3185,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		u64 start, u64 end, int *page_started, unsigned long *nr_written,
 		struct writeback_control *wbc);
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
-void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
+void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
+					  struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
 extern const struct iomap_ops btrfs_dio_iomap_ops;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13278ee2ad85..e46c32289421 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2714,10 +2714,13 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 {
+	struct btrfs_inode *inode;
 	int uptodate = (err == 0);
 	int ret = 0;
 
-	btrfs_writepage_endio_finish_ordered(page, start, end, uptodate);
+	ASSERT(page && page->mapping);
+	inode = BTRFS_I(page->mapping->host);
+	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodate);
 
 	if (!uptodate) {
 		ClearPageUptodate(page);
@@ -3798,7 +3801,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		u32 iosize;
 
 		if (cur >= i_size) {
-			btrfs_writepage_endio_finish_ordered(page, cur, end, 1);
+			btrfs_writepage_endio_finish_ordered(inode, page, cur,
+							     end, 1);
 			break;
 		}
 		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
@@ -3836,8 +3840,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			if (compressed)
 				nr++;
 			else
-				btrfs_writepage_endio_finish_ordered(page, cur,
-							cur + iosize - 1, 1);
+				btrfs_writepage_endio_finish_ordered(inode,
+						page, cur, cur + iosize - 1, 1);
 			cur += iosize;
 			continue;
 		}
@@ -4902,8 +4906,8 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		if (clear_page_dirty_for_io(page))
 			ret = __extent_writepage(page, &wbc_writepages, &epd);
 		else {
-			btrfs_writepage_endio_finish_ordered(page, start,
-						    start + PAGE_SIZE - 1, 1);
+			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
+					page, start, start + PAGE_SIZE - 1, 1);
 			unlock_page(page);
 		}
 		put_page(page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e4d6502d8977..a1960b086f6b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -951,7 +951,8 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			const u64 end = start + async_extent->ram_size - 1;
 
 			p->mapping = inode->vfs_inode.i_mapping;
-			btrfs_writepage_endio_finish_ordered(p, start, end, 0);
+			btrfs_writepage_endio_finish_ordered(inode, p, start,
+							     end, 0);
 
 			p->mapping = NULL;
 			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
@@ -3031,15 +3032,15 @@ static void finish_ordered_fn(struct btrfs_work *work)
 	btrfs_finish_ordered_io(ordered_extent);
 }
 
-void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
+void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
+					  struct page *page, u64 start,
 					  u64 end, int uptodate)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_extent *ordered_extent = NULL;
 	struct btrfs_workqueue *wq;
 
-	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
+	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
 
 	ClearPagePrivate2(page);
 	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index a41dd8a0c730..472e42b8d8b7 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -654,34 +654,31 @@ DEFINE_EVENT(btrfs__writepage, __extent_writepage,
 
 TRACE_EVENT(btrfs_writepage_end_io_hook,
 
-	TP_PROTO(const struct page *page, u64 start, u64 end, int uptodate),
+	TP_PROTO(const struct btrfs_inode *inode, u64 start, u64 end,
+		 int uptodate),
 
-	TP_ARGS(page, start, end, uptodate),
+	TP_ARGS(inode, start, end, uptodate),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	 ino		)
-		__field(	unsigned long, index	)
 		__field(	u64,	 start		)
 		__field(	u64,	 end		)
 		__field(	int,	 uptodate	)
 		__field(	u64,    root_objectid	)
 	),
 
-	TP_fast_assign_btrfs(btrfs_sb(page->mapping->host->i_sb),
-		__entry->ino	= btrfs_ino(BTRFS_I(page->mapping->host));
-		__entry->index	= page->index;
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->ino	= btrfs_ino(inode);
 		__entry->start	= start;
 		__entry->end	= end;
 		__entry->uptodate = uptodate;
-		__entry->root_objectid	=
-			 BTRFS_I(page->mapping->host)->root->root_key.objectid;
+		__entry->root_objectid = inode->root->root_key.objectid;
 	),
 
-	TP_printk_btrfs("root=%llu(%s) ino=%llu page_index=%lu start=%llu "
+	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu "
 		  "end=%llu uptodate=%d",
 		  show_root_type(__entry->root_objectid),
-		  __entry->ino, __entry->index,
-		  __entry->start,
+		  __entry->ino, __entry->start,
 		  __entry->end, __entry->uptodate)
 );
 
-- 
2.31.1

