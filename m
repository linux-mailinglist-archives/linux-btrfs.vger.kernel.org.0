Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20800360157
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhDOFFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhDOFFb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTHwlJEYneWhgrYjf1yUpmitfQemkE2ABZY2HzPY950=;
        b=ofJngOqEmlqR0ukrX+l15bGmBUfpgSTzBSZZF7oXu5DMiJKQPSyE1wuYX+OqhRmz412ggg
        o4hHZkP4E1bAPtKv7wuPtisfmF3tWA72uxVUOVO2NOs6xGrjR1rsdDNJY9Y/5WVEs5k6Vf
        JekZFpmRgGk93JGqm0Zk9dli4XMoFPw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE0DEAFC9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/42] btrfs: pass btrfs_inode into btrfs_writepage_endio_finish_ordered()
Date:   Thu, 15 Apr 2021 13:04:14 +0800
Message-Id: <20210415050448.267306-9-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
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
index 2600703fab83..4fbe3e12be71 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -343,11 +343,9 @@ static void end_compressed_bio_write(struct bio *bio)
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
index 2c858d5349c8..505bc6674bcc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3175,7 +3175,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
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
index 7d1fca9b87f0..6d712418b67b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2711,10 +2711,13 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 
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
@@ -3739,7 +3742,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		u32 iosize;
 
 		if (cur >= i_size) {
-			btrfs_writepage_endio_finish_ordered(page, cur, end, 1);
+			btrfs_writepage_endio_finish_ordered(inode, page, cur,
+							     end, 1);
 			break;
 		}
 		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
@@ -3777,8 +3781,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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
@@ -4842,8 +4846,8 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
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
index 554effbf307e..752f0c78e1df 100644
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
@@ -3058,16 +3059,16 @@ static void finish_ordered_fn(struct btrfs_work *work)
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
 
 	ASSERT(end + 1 - start < U32_MAX);
-	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
+	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
 
 	ClearPagePrivate2(page);
 	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0551ea65374f..556967cb9688 100644
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

