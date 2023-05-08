Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798AF6FB4D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjEHQJL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjEHQI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37145243
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=G6OSLjhAGHxVm5H0Yefaz+AZeSy5hynEjm7UlDC6rOg=; b=077Jsq9pw4bCJnLNeXeraZOT5v
        aLcDVszo6qERRqV01jAl0V7kqdXALzzVtihK/ZYHGJ7Dn79k07C6KnSAKh91NRtlQ0h5w4clwZcNj
        0fqGQchRxu8peOPRP/E7h+oiCk/zGYi7UoVzaCOY7f9APFSRDHtMUV8oshSl01g5tjbsBgXKta+5p
        WbaloUOVmkOwc5zTtWf9LLS2c7/FbpeUjUuUwJeTqgrAFDCX5opTFb2Iv+wNm6bPD5h8hOswVv9V2
        Vq265Le4h6w17NtnptBeEpxgCvYC0MktZfwqu6i7ysgk7EOUy3OrVDmY++5KZBcQ5nB/QOql5IDu3
        3etkgmpw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Px-000w3X-1x;
        Mon, 08 May 2023 16:08:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/21] btrfs: factor out a can_finish_ordered_extent helper
Date:   Mon,  8 May 2023 09:08:37 -0700
Message-Id: <20230508160843.133013-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out a helper from btrfs_mark_ordered_io_finished that does the
actual per-ordered_extent work to check if we want to schedule an I/O
completion.  This new helper will later be used complete an
ordered_extent without first doing a lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 103 ++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 0ea4efc1264512..36e4d2517b28fd 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -288,6 +288,63 @@ static void finish_ordered_fn(struct btrfs_work *work)
 	btrfs_finish_ordered_io(ordered_extent);
 }
 
+static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+				      struct page *page, u64 file_offset,
+				      u64 len, bool uptodate)
+{
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	lockdep_assert_held(&inode->ordered_tree.lock);
+
+	if (page) {
+		ASSERT(page->mapping);
+		ASSERT(page_offset(page) <= file_offset);
+		ASSERT(file_offset + len <= page_offset(page) + PAGE_SIZE);
+
+		/*
+		 * Ordered (Private2) bit indicates whether we still
+		 * have pending io unfinished for the ordered extent.
+		 *
+		 * If there's no such bit, we need to skip to next range.
+		 */
+		if (!btrfs_page_test_ordered(fs_info, page, file_offset, len))
+			return false;
+		btrfs_page_clear_ordered(fs_info, page, file_offset, len);
+	}
+
+	/* Now we're fine to update the accounting */
+	if (WARN_ON_ONCE(len > ordered->bytes_left)) {
+		btrfs_crit(fs_info,
+"bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu to_dec=%llu left=%llu",
+			   inode->root->root_key.objectid,
+			   btrfs_ino(inode),
+			   ordered->file_offset,
+			   ordered->num_bytes,
+			   len,
+			   ordered->bytes_left);
+			   ordered->bytes_left = 0;
+	} else {
+		ordered->bytes_left -= len;
+	}
+
+	if (!uptodate)
+		set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
+
+	if (ordered->bytes_left)
+		return false;
+
+	/*
+	 * All the IO of the ordered extent is finished, we need to queue
+	 * the finish_func to be executed.
+	 */
+	set_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags);
+	cond_wake_up(&ordered->wait);
+	refcount_inc(&ordered->refs);
+	trace_btrfs_ordered_extent_mark_finished(inode, ordered);
+	return true;
+}
+
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
@@ -318,10 +375,6 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	else
 		wq = fs_info->endio_write_workers;
 
-	if (page)
-		ASSERT(page->mapping && page_offset(page) <= file_offset &&
-		       file_offset + num_bytes <= page_offset(page) + PAGE_SIZE);
-
 	spin_lock_irqsave(&tree->lock, flags);
 	while (cur < file_offset + num_bytes) {
 		u64 entry_end;
@@ -374,47 +427,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		ASSERT(end + 1 - cur < U32_MAX);
 		len = end + 1 - cur;
 
-		if (page) {
-			/*
-			 * Ordered (Private2) bit indicates whether we still
-			 * have pending io unfinished for the ordered extent.
-			 *
-			 * If there's no such bit, we need to skip to next range.
-			 */
-			if (!btrfs_page_test_ordered(fs_info, page, cur, len)) {
-				cur += len;
-				continue;
-			}
-			btrfs_page_clear_ordered(fs_info, page, cur, len);
-		}
-
-		/* Now we're fine to update the accounting */
-		if (unlikely(len > entry->bytes_left)) {
-			WARN_ON(1);
-			btrfs_crit(fs_info,
-"bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu to_dec=%u left=%llu",
-				   inode->root->root_key.objectid,
-				   btrfs_ino(inode),
-				   entry->file_offset,
-				   entry->num_bytes,
-				   len, entry->bytes_left);
-			entry->bytes_left = 0;
-		} else {
-			entry->bytes_left -= len;
-		}
-
-		if (!uptodate)
-			set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
-
-		/*
-		 * All the IO of the ordered extent is finished, we need to queue
-		 * the finish_func to be executed.
-		 */
-		if (entry->bytes_left == 0) {
-			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
-			cond_wake_up(&entry->wait);
-			refcount_inc(&entry->refs);
-			trace_btrfs_ordered_extent_mark_finished(inode, entry);
+		if (can_finish_ordered_extent(entry, page, cur, len, uptodate)) {
 			spin_unlock_irqrestore(&tree->lock, flags);
 			btrfs_init_work(&entry->work, finish_ordered_fn, NULL, NULL);
 			btrfs_queue_work(wq, &entry->work);
-- 
2.39.2

